"""Independently verify a frozen release, with branch checks in parallel.

This checks all supplied exact certificates, all support fibres, and the file
manifest before and after verification. It does not regenerate tail polynomials
from Ehat; replay_foundation.py, solve_branch.py, and replay_branch.py supply that
separately documented provenance. Reports and logs go only under build/ by default.
"""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
import argparse, hashlib, json, platform, subprocess, sys, time
ROOT=Path(__file__).resolve().parents[1]

def sha(path):
    h=hashlib.sha256()
    with Path(path).open('rb') as f:
        while block:=f.read(1<<20): h.update(block)
    return h.hexdigest()

def check_manifest():
    expected={}
    for line in (ROOT/'SHA256SUMS').read_text().splitlines():
        digest,name=line.split('  ',1)
        assert not Path(name).is_absolute() and '..' not in Path(name).parts
        assert name not in expected,('duplicate manifest entry',name)
        expected[name]=digest
        assert sha(ROOT/name)==digest,('manifest mismatch',name)
    return expected

def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('--workers',type=int,default=4)
    ap.add_argument('--output',type=Path)
    args=ap.parse_args();assert args.workers>=1
    started=time.monotonic();inventory=check_manifest()
    print('MANIFEST_BEFORE=PASS',len(inventory),flush=True)
    logs=ROOT/'build/release_verification';logs.mkdir(parents=True,exist_ok=True)
    def execute(command,label):
        command=list(map(str,command));begin=time.monotonic()
        with (logs/(label+'.log')).open('w') as f:
            p=subprocess.run(command,cwd=ROOT,stdout=f,stderr=subprocess.STDOUT)
        excerpt='\n'.join((logs/(label+'.log')).read_text().splitlines()[-8:])
        result={'label':label,'command':command,'exit_code':p.returncode,
                'elapsed_seconds':round(time.monotonic()-begin,3),
                'log_excerpt':excerpt,'log_sha256':sha(logs/(label+'.log'))}
        assert p.returncode==0,(label,p.returncode,excerpt)
        print('CHECK=PASS',label,flush=True)
        return result
    compile_record=execute(['g++','-O3','-std=c++17',ROOT/'src/verify_global.cpp','-lgmp','-o',ROOT/'build/verify_global'],'compile_global')
    boundaries=[execute([sys.executable,ROOT/'src'/script],script.removesuffix('.py'))
                for script in ['verify_boundary.py','verify_J.py']]
    names=sorted(p.parent.name for p in (ROOT/'data/branches').glob('*/descriptor.json'))
    records=[]
    with ThreadPoolExecutor(max_workers=args.workers) as pool:
        futures={pool.submit(execute,[sys.executable,ROOT/'src/verify_branch.py',name,'--no-compile'],name):name for name in names}
        for future in as_completed(futures): records.append(future.result())
    cases=[]
    for name in names:
        q=json.loads((ROOT/'evidence/branches'/name/'verification.json').read_text())
        assert q['status']=='PASS'
        cases.append({'name':name,'r':q['r'],'branch':q['branch'],
                      'support_degree':q['support_degree'],
                      'factor_count':len(q['factor_degrees']),
                      'retained_algebra_dimension':q['retained_algebra_dimension']})
    got={(x['r'],x['branch']) for x in cases}
    expected={(r,b) for r in [145049,211895,211959] for b in range(4)}
    complete=got==expected
    assert len(got)==len(cases)
    claimed=json.loads((ROOT/'claims.json').read_text())['overall_status']
    assert claimed!='complete' or complete,'Complete conclusion requires all twelve branches'
    catalogue=json.loads((ROOT/'evidence/complete_case_catalogue.json').read_text())
    assert {x['name'] for x in catalogue['completed']}==set(names)
    assert check_manifest()==inventory,'Verification altered an archived input'
    print('MANIFEST_AFTER=PASS',len(inventory),flush=True)
    result={'status':'PASS','complete_positive_content_exclusion':complete,
            'scope':'Independent exact certificate and coverage verification from a frozen release; no regeneration of tail polynomials in this command.',
            'software':{'python':sys.version,'platform':platform.platform(),
                        'g++':subprocess.check_output(['g++','--version'],text=True).splitlines()[0]},
            'manifest_sha256':sha(ROOT/'SHA256SUMS'),'manifest_file_count':len(inventory),
            'manifest_before_and_after':'PASS; all archived bytes unchanged',
            'verified_cases':cases,'boundary_records':boundaries,
            'compile_record':compile_record,'branch_records':sorted(records,key=lambda z:z['label']),
            'elapsed_seconds':round(time.monotonic()-started,3),
            'mathematical_input_hashes':{k:v for k,v in inventory.items() if k.startswith(('data/','evidence/branches/','evidence/tails_','evidence/J_tails_','src/'))}}
    output=args.output or logs/'summary.json';output.parent.mkdir(parents=True,exist_ok=True)
    output.write_text(json.dumps(result,indent=2)+'\n')
    print('RELEASE_CERTIFICATES=PASS COMPLETE_POSITIVE_CONTENT_EXCLUSION='+str(complete),flush=True)

if __name__=='__main__': main()
