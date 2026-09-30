#!/usr/bin/env python3
"""Verification entry point. All mathematical checks are exact; no network access.
--full (default): also recompute all 42 residual resultant/norm certificates.
--quick: do not recompute residual norms; check their stored coefficients and
all square and elimination identities. This is deliberately a weaker audit.
"""
from pathlib import Path
import argparse,hashlib,json,sys,subprocess,concurrent.futures,os,time
ROOT=Path(__file__).resolve().parent

def check_manifest():
    f=ROOT/'SHA256SUMS.txt'
    if not f.exists():raise FileNotFoundError('SHA256SUMS.txt is missing')
    n=0
    for line in f.read_text().splitlines():
        sha,name=line.split('  ',1);p=ROOT/name
        assert p.is_file() and hashlib.sha256(p.read_bytes()).hexdigest()==sha, name
        n+=1
    print('SHA-256 manifest:',n,'files PASS',flush=True)

def run(args):
    p=subprocess.run([sys.executable]+list(map(str,args)),cwd=ROOT,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    if p.returncode:
        print(p.stdout,flush=True);raise RuntimeError('Verification subprocess failed: '+' '.join(map(str,args)))
    return p.stdout

def main():
    ap=argparse.ArgumentParser();g=ap.add_mutually_exclusive_group();g.add_argument('--full',action='store_true');g.add_argument('--quick',action='store_true');ap.add_argument('--workers',type=int,default=4);ap.add_argument('--skip-manifest',action='store_true',help='packaging-only option, not recommended for downloaded archives');args=ap.parse_args()
    start=time.monotonic();full=not args.quick
    if not args.skip_manifest:check_manifest()
    else:print('Manifest check skipped for pre-packaging execution.',flush=True)
    print('Mode:', 'FULL' if full else 'QUICK (residual norms not independently recomputed)',flush=True)
    print(run([ROOT/'src/check_identities.py']),end='',flush=True)
    jobs=[[ROOT/'src/verify_square_certificate.py','--constant']]
    for i in range(1,11):
        j=json.loads((ROOT/'data'/f'linear_138_shape_{i}.json').read_text())
        jobs += [[ROOT/'src/verify_square_certificate.py','--index',i,'--factor',k] for k in range(len(j['factors']))]
    if full:
        for job in jobs:job.append('--full')
    with concurrent.futures.ThreadPoolExecutor(max_workers=args.workers) as pool:
        fut=[pool.submit(run,job) for job in jobs]
        for f in concurrent.futures.as_completed(fut):print(f.result(),end='',flush=True)
    print('PASS:',len(jobs),'geometric square-obstruction certificates;',round(time.monotonic()-start,3),'elapsed seconds.',flush=True)
    print('VERIFIED SCOPE: all lower degrees below 138 excluded; degree 138 square locus empty in all eleven spaces. Degrees 140 and 142 remain unresolved.',flush=True)

if __name__=='__main__':main()
