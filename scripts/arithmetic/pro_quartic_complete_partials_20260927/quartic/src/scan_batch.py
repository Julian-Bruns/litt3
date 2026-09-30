"""Restartable exact endpoint-transform searches; NOT the arbitrary-pair search.

Each inversion chunk is a complete normalized-Q search for one (delta,b,sign).
The supplied symmetries reduce b to 0,1,2,4,8. A timeout is explicitly recorded
and is never counted as a completed exclusion. Candidate records are streamed
into gzip after the process exits, and the temporary uncompressed file removed.
"""
import argparse, concurrent.futures, gzip, hashlib, json, os, pathlib, shutil, subprocess, time


def run_one(binary, out, params, timeout):
    d,b,s=params
    name=f'inverse_d{d}_b{b}_t{s}'
    summary=out/(name+'_summary.json')
    binary_hash=hashlib.sha256(binary.read_bytes()).hexdigest()
    execution=out/(name+'_execution.json')
    if summary.exists() and execution.exists() and (out/(name+'.jsonl.gz')).exists():
        try:
            old=json.loads(summary.read_text())
            prior=json.loads(execution.read_text())
            if old.get('total')==266916 and 'unresolved_planes' in old and prior.get('binary_sha256')==binary_hash and prior.get('status')=='completed':
                return {'name':name,'status':'already_complete','summary':old}
        except (ValueError,OSError):pass
    cmd=[str(binary),str(d),'0','1','-1',str(b),str(s)]
    tmp=out/(name+'.jsonl.part');err=out/(name+'_stderr.part')
    t=time.monotonic();status='completed';returncode=None
    with tmp.open('wb') as stdout,err.open('wb') as stderr:
        try:returncode=subprocess.run(cmd,stdout=stdout,stderr=stderr,timeout=timeout,check=False).returncode
        except subprocess.TimeoutExpired:status='TIMEOUT_NOT_EXHAUSTIVE'
    if returncode not in [0,None]:status='FAILED_NOT_EXHAUSTIVE'
    result={'name':name,'command':cmd,'binary_sha256':binary_hash,'status':status,'returncode':returncode,'elapsed_seconds':round(time.monotonic()-t,3)}
    if status=='completed':
        try:
            result['summary']=json.loads(err.read_text())
            summary.write_text(json.dumps(result['summary'],sort_keys=True)+'\n')
        except ValueError:result['status']='INVALID_OUTPUT_NOT_EXHAUSTIVE'
    if result['status']=='completed':err.unlink()
    with tmp.open('rb') as src,gzip.open(out/(name+'.jsonl.gz'),'wb',compresslevel=9) as dst:
        shutil.copyfileobj(src,dst,1024*1024)
    tmp.unlink()
    (out/(name+'_execution.json')).write_text(json.dumps(result,indent=2)+'\n')
    return result

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('binary',type=pathlib.Path);p.add_argument('output',type=pathlib.Path)
    p.add_argument('--jobs',type=int,default=2);p.add_argument('--timeout',type=int,default=120)
    a=p.parse_args();a.binary=a.binary.resolve();a.output.mkdir(parents=True,exist_ok=True)
    tasks=[(d,b,s) for s in [1,-1] for b in [0,1,2,4,8] for d in range(4)]
    results=[]
    with concurrent.futures.ThreadPoolExecutor(max_workers=a.jobs) as pool:
        fs=[pool.submit(run_one,a.binary,a.output,t,a.timeout) for t in tasks]
        for f in concurrent.futures.as_completed(fs):
            r=f.result();results.append(r);print(r['name'],r['status'],flush=True)
    (a.output/'inversion_batch.json').write_text(json.dumps(sorted(results,key=lambda r:r['name']),indent=2)+'\n')
