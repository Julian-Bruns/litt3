"""Run compact replay checks, optionally regenerate every exhaustive search.

--full re-enumerates ONLY the two endpoint-relation families in REPORT.md.
It is not an exhaustive search of arbitrary independent endpoint pairs.
"""
import argparse,concurrent.futures,gzip,json,pathlib,subprocess,sys,time
ROOT=pathlib.Path(__file__).resolve().parents[1]


def read_records(path):
    if not path.exists():return []
    if path.suffix=='.gz':
        with gzip.open(path,'rt') as f:return [json.loads(x) for x in f if x.strip()]
    return [json.loads(x) for x in path.read_text().splitlines() if x.strip()]


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--full',action='store_true');parser.add_argument('--jobs',type=int,default=2)
    args=parser.parse_args();build=ROOT/'build';build.mkdir(exist_ok=True)
    log=[]
    def run(cmd,json_output=False):
        t=time.monotonic();p=subprocess.run(cmd,cwd=ROOT,text=True,capture_output=True,check=True)
        r={'command':[str(x) for x in cmd],'status':'PASS','seconds':round(time.monotonic()-t,3)}
        if json_output:r['result']=json.loads(p.stdout)
        log.append(r);print('PASS',str(cmd[0]),' '.join(map(str,cmd[1:3])),flush=True)
        return r.get('result'),p.stdout
    for name in ['diagonal_scan','twisted_diagonal_scan','field_dump']:
        run(['g++','-O3','-std=c++17','-Wall','-Wextra',str(ROOT/'src'/f'{name}.cpp'),'-o',str(build/name)])
    run([sys.executable,'src/exact_fields.py'],True)
    for script,file in [('export_basis.py','compatible_basis.json'),('export_constants.py','kummer_basis.json')]:
        data,_=run([sys.executable,'src/'+script],True)
        assert data==json.loads((ROOT/'evidence'/file).read_text())
    run([sys.executable,'src/crosscheck.py',str(build/'field_dump')],True)
    run([sys.executable,'src/check_weights.py'],True)
    run([sys.executable,'src/replay_candidates.py'],True)
    expected=json.loads((ROOT/'evidence/expected_counts.json').read_text())
    if args.full:
        fresh=build/'recheck';fresh.mkdir(exist_ok=True)
        def one(name,cmd):
            t=time.monotonic()
            with (fresh/(name+'.jsonl')).open('w') as out,(fresh/(name+'_summary.json')).open('w') as err:
                subprocess.run(cmd,cwd=ROOT,stdout=out,stderr=err,check=True)
            got=json.loads((fresh/(name+'_summary.json')).read_text())
            for key,value in expected[name].items():assert got[key]==value,(name,key,got[key],value)
            if name=='twist2':
                assert read_records(fresh/'twist2.jsonl')==read_records(ROOT/'evidence/twist2_full.jsonl.gz')
            else:assert not read_records(fresh/(name+'.jsonl'))
            result={'command':[str(x)for x in cmd],'status':'PASS_EXHAUSTIVE_STATED_SUBFAMILY',
                    'seconds':round(time.monotonic()-t,3),'result':got}
            print('PASS full',name,flush=True);return result
        def inversions():
            cmd=[sys.executable,'src/scan_batch.py',str(build/'twisted_diagonal_scan'),str(fresh/'inversions'),'--jobs',str(args.jobs),'--timeout','120']
            with (fresh/'inversions_execution.log').open('w') as f:subprocess.run(cmd,cwd=ROOT,stdout=f,stderr=subprocess.STDOUT,check=True)
            batch=json.loads((fresh/'inversions/inversion_batch.json').read_text())
            assert len(batch)==40
            assert all(r['status'] in ['completed','already_complete'] for r in batch),batch
            for wanted in expected['inversions']:
                d,b,s=wanted['delta'],wanted['phase_shift'],wanted['type_sign'];name=f'inverse_d{d}_b{b}_t{s}'
                got=json.loads((fresh/'inversions'/(name+'_summary.json')).read_text())
                for key,value in wanted.items():assert got[key]==value,(name,key,got[key],value)
                assert read_records(fresh/'inversions'/(name+'.jsonl.gz'))==read_records(ROOT/'evidence'/(name+'.jsonl.gz'))
            print('PASS full inversions: all 40 chunks',flush=True)
            return {'command':cmd,'status':'PASS_EXHAUSTIVE_STATED_SUBFAMILY','chunks':40}
        with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
            fs=[pool.submit(one,'diagonal',[str(build/'diagonal_scan'),'0','116']),
                pool.submit(one,'twist1',[str(build/'twisted_diagonal_scan'),'1','0','116']),
                pool.submit(one,'twist2',[str(build/'twisted_diagonal_scan'),'2','0','116']),
                pool.submit(inversions)]
            log += [f.result() for f in fs]
    result={'status':'PASS','mode':'full_stated_subfamilies' if args.full else 'compact_replay_only',
            'global_existence_decision':'UNRESOLVED','checks':log}
    (build/'verification_results.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({'status':'PASS','mode':result['mode'],'global_existence_decision':'UNRESOLVED'}))
if __name__=='__main__':main()
