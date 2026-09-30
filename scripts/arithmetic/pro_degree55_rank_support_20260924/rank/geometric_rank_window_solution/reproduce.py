#!/usr/bin/env python3
"""Optional discovery replay, with exact comparison against retained traces.

This is not needed to verify the proof: verify.py checks certificate identities
without relying on the discovery algorithm's standard-basis claims.
"""
from pathlib import Path
import subprocess
import os
import hashlib
ROOT=Path(__file__).resolve().parent

def run(args):
    print('$ '+' '.join(map(str,args)),flush=True)
    subprocess.run(list(map(str,args)),cwd=ROOT,check=True)

def same(a,b):
    assert a.read_bytes()==b.read_bytes(), (a,b)

def main():
    if not __debug__:
        raise RuntimeError('Run without -O: exact comparison assertions must be enabled.')
    out=ROOT/'build/discovery';out.mkdir(parents=True,exist_ok=True)
    compiler=os.environ.get('CXX','g++')
    basis=out/'discover_module_basis';shape=out/'discover_shape'
    run([compiler,'-O3','-std=c++17',ROOT/'src/discover_module_basis.cpp','-o',basis])
    run([compiler,'-O3','-std=c++17',ROOT/'src/discover_shape.cpp','-o',shape])
    for ch in range(5):
        source=ROOT/f'data/modules/chart{ch}'
        prefix=out/f'chart{ch}'
        run([basis,source/'input.txt',prefix,600])
        same(prefix.with_suffix('.history'),source/'history.txt')
        same(prefix.with_suffix('.ids'),source/'basis_ids.txt')
        print(f'PASS: chart {ch} discovery history and reducer IDs reproduce byte-for-byte.',flush=True)
    file=out/'shape.txt'
    run([shape,out/'chart0.gb',ROOT/'data/modules/chart0/annihilators.txt',file,0])
    same(file,ROOT/'data/shape.txt')
    same(Path(str(file)+'.containment'),ROOT/'data/chart0_containment.txt')
    print('PASS: degree-44 shape representation and all 45 containment rows reproduce byte-for-byte.',flush=True)
    print('PASS ALL DISCOVERY REPLAY. Run verify.py for the independent algebraic-certificate checks.',flush=True)

if __name__=='__main__':main()
