#!/usr/bin/env python3
"""Regenerate exact per-layout witnesses and independently verify them."""
from __future__ import annotations
import argparse
from concurrent.futures import ThreadPoolExecutor,as_completed
import json,os,shlex,subprocess,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parent

def main()->None:
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output',type=Path,required=True,help='new output directory, separate from the supplied archive')
    p.add_argument('--n',nargs='+',type=int,default=list(range(7,27)))
    p.add_argument('--jobs',type=int,default=min(4,os.cpu_count() or 1))
    args=p.parse_args();ns=sorted(set(args.n))
    if args.jobs<1 or any(n<7 or n>26 for n in ns):p.error('invalid jobs/degrees')
    out=args.output.resolve()
    if out==ROOT or ROOT in out.parents:p.error('choose an output directory outside the delivered archive')
    out.mkdir(parents=True,exist_ok=True)
    certs=out/'certificates';logs=out/'logs';certs.mkdir(exist_ok=True);logs.mkdir(exist_ok=True)
    if any((certs/f'n{n:02}.rrc').exists() for n in ns):p.error('refusing to overwrite an existing certificate')
    exe=out/'certificate';compiler=shlex.split(os.environ.get('CXX','g++'))
    with (logs/'compile.log').open('w') as f:
        subprocess.run(compiler+['-O3','-std=c++17',str(ROOT/'src/certificate.cpp'),'-o',str(exe)],stdout=f,stderr=subprocess.STDOUT,check=True)
    expected=json.loads((ROOT/'inputs/expected_counts.json').read_text())['degrees']
    def one(n:int)->None:
        path=certs/f'n{n:02}.rrc'
        for mode,basis in [('generate','polynomial'),('verify','fractions')]:
            with (logs/f'{mode}_n{n:02}.stderr.log').open('w') as err:
                q=subprocess.run([str(exe),mode,str(n-3),str(path),basis],capture_output=False,stdout=subprocess.PIPE,stderr=err,text=True,check=True)
            (logs/f'{mode}_n{n:02}.json').write_text(q.stdout);r=json.loads(q.stdout)
            for key in ['layouts','phase_cases','covered_subsets','power_exclusions','open_exclusions','degree_exclusions','reason_counts']:
                if r[key]!=expected[str(n)][key]:raise RuntimeError(f'count mismatch for n={n}: {key}')
            if r['fingerprint']!=expected[str(n)][basis+'_fingerprint']:raise RuntimeError(f'fingerprint mismatch n={n}')
            print(f'{mode} n={n} {basis}: PASS',flush=True)
        # This confirms byte-identical deterministic reconstruction, not only matching counts.
        if path.read_bytes()!=(ROOT/'certificates'/f'n{n:02}.rrc').read_bytes():raise RuntimeError(f'regenerated certificate differs for n={n}')
    ordered=sorted(ns,key=lambda n:abs((n-3)-14.5))
    with ThreadPoolExecutor(max_workers=args.jobs) as pool:
        for f in as_completed([pool.submit(one,n) for n in ordered]):f.result()
    print('PASS: regenerated certificates are byte-identical and independently verified.')

if __name__=='__main__':
    try:main()
    except Exception as exc:print(f'FAIL: {exc}',file=sys.stderr);sys.exit(1)
