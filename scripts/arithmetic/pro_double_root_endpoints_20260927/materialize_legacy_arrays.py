"""Regenerate deliberately omitted legacy expansions, and check their hashes.

The three arrays are not essential witnesses for the new results. Their exact
source, old metadata and raw SHA-256 hashes remain in the ZIP. This program
recreates the old paths for historical audit scripts, without changing any
archived metadata. Prefix sampling is compressed and restartable in work/.
"""
import argparse,gzip,hashlib,json,pathlib,subprocess,sys,time
ROOT=pathlib.Path(__file__).resolve().parent.parent
spec=json.loads((ROOT/'inputs/regenerable_evidence.json').read_text())['entries']
entries={pathlib.Path(e['path']).name:e for e in spec}


def check(name):
    e=entries[name];p=ROOT/e['path']
    if not p.exists():return False
    h=hashlib.sha256();n=0
    with gzip.open(p,'rb') as f:
        for b in iter(lambda:f.read(1024*1024),b''):h.update(b);n+=len(b)
    assert h.hexdigest()==e['raw_sha256'] and n==e['raw_bytes'],('regenerated expansion hash',name)
    return True


def main():
    if sys.flags.optimize:raise RuntimeError('Do not disable assertions')
    ap=argparse.ArgumentParser();ap.add_argument('target',choices=['jets','full','prefix','all']);ap.add_argument('--fresh',action='store_true')
    args=ap.parse_args();start=time.time();commands=[];fresh=[]
    metadata=[ROOT/e['metadata'] for e in spec]+[ROOT/'evidence/prefix_samples.json']
    saved={p:p.read_bytes() for p in metadata}
    def run(script,*argv):
        cmd=[sys.executable,'src/'+script+'.py',*map(str,argv)];t=time.time()
        p=subprocess.run(cmd,cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True)
        row={'command':cmd,'returncode':p.returncode,'seconds':round(time.time()-t,3),'output_excerpt':p.stdout[-10000:]}
        commands.append(row);print(('PASS' if p.returncode==0 else 'FAIL'),script,row['seconds'],flush=True)
        if p.returncode:raise RuntimeError(script+' failed:\n'+p.stdout)
    try:
        if args.fresh or not check('normalized_jets.json.gz'):
            run('normalize_jets');assert check('normalized_jets.json.gz');fresh.append('normalized_jets.json.gz')
            assert json.loads((ROOT/'evidence/normalized_jets.json').read_text())==json.loads(saved[ROOT/'evidence/normalized_jets.json'])
        if args.target in ('full','all') and (args.fresh or not check('normalized_full_jets.json.gz')):
            run('normalize_full_jets');assert check('normalized_full_jets.json.gz');fresh.append('normalized_full_jets.json.gz')
            assert json.loads((ROOT/'evidence/normalized_full_jets.json').read_text())==json.loads(saved[ROOT/'evidence/normalized_full_jets.json'])
        if args.target in ('prefix','all') and (args.fresh or not check('global_prefix.bin.gz')):
            run('prefix_samples',1375,*(['--fresh'] if args.fresh else []))
            old=json.loads(saved[ROOT/'evidence/prefix_samples.json']);new=json.loads((ROOT/'evidence/prefix_samples.json').read_text())
            assert old['sample_count']==new['sample_count']==1375
            assert [(r['u_code'],r['sha256'],r['scale_degrees']) for r in old['samples']]==[(r['u_code'],r['sha256'],r['scale_degrees']) for r in new['samples']]
            # Interpolation uses only the checked raw sample hashes, not timings.
            (ROOT/'evidence/prefix_samples.json').write_bytes(saved[ROOT/'evidence/prefix_samples.json'])
            run('interpolate_prefix');assert check('global_prefix.bin.gz');fresh.append('global_prefix.bin.gz')
            old=json.loads(saved[ROOT/'evidence/global_prefix.json']);new=json.loads((ROOT/'evidence/global_prefix.json').read_text())
            assert {k:v for k,v in old.items() if k!='seconds'}=={k:v for k,v in new.items() if k!='seconds'}
    finally:
        for p,b in saved.items():p.write_bytes(b)
    result={'status':'passed','target':args.target,'commands':commands,'fresh_expansions':fresh,
            'raw_hashes_checked':[e['path'] for e in spec if (ROOT/e['path']).exists() and check(pathlib.Path(e['path']).name)],
            'all_archived_metadata_restored_byte_identically':True,'seconds':round(time.time()-start,3),
            'scope':'exact regeneration of omitted arrays, not a search for square parameters'}
    (ROOT/'logs'/('legacy_materialization_'+args.target+'.json')).write_text(json.dumps(result,indent=2)+'\n')
    print('LEGACY ARRAYS MATERIALIZED AND HASH-CHECKED',json.dumps({k:v for k,v in result.items() if k!='commands'}),flush=True)
if __name__=='__main__':main()
