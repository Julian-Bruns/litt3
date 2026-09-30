#!/usr/bin/env python3
"""Single entry point for the complete geometric rank-window certificate."""
from pathlib import Path
import hashlib
import importlib.metadata
import platform
import subprocess
import sys
import os
ROOT=Path(__file__).resolve().parent

def run(args):
    print('$ '+' '.join(map(str,args)),flush=True)
    subprocess.run([str(x) for x in args],cwd=ROOT,check=True)

def main():
    if not __debug__:
        raise RuntimeError('Run without -O: assertion checking must be enabled.')
    print('GEOMETRIC RANK-WINDOW VERIFICATION',flush=True)
    print('Python:',sys.version.replace('\n',' '),flush=True)
    print('Platform:',platform.platform(),flush=True)
    for package in ['numpy','numba','llvmlite']:
        print(package+':',importlib.metadata.version(package),flush=True)
    compiler=os.environ.get('CXX','g++')
    run([compiler,'--version'])
    manifest=ROOT/'MANIFEST.sha256'
    if manifest.exists():
        count=0
        for line in manifest.read_text().splitlines():
            h,name=line.split('  ',1)
            file=ROOT/name
            assert file.is_file() and hashlib.sha256(file.read_bytes()).hexdigest()==h,name
            count+=1
        print('PASS: SHA-256 manifest,',count,'payload files.',flush=True)
    else:
        print('NOTICE: pre-manifest development run; no manifest was present.',flush=True)
    build=ROOT/'build';build.mkdir(exist_ok=True)
    run([sys.executable,'-B',ROOT/'input/verify_input.py'])
    run([sys.executable,'-B',ROOT/'src/rebuild_matrices.py'])
    run([sys.executable,'-B',ROOT/'src/verify_geometry.py'])
    executable=build/'verify_module_certificate'
    run([compiler,'-O3','-std=c++17',ROOT/'src/verify_module_certificate.cpp','-o',executable])
    for ch in range(5):
        run([executable,ROOT,ch])
    print('PASS ALL: complete six-stratum geometric support certificate.',flush=True)
    print('RESULT: rank(T)<15 has support equal to the quartic scroll plus 45 reduced isolated geometric points.',flush=True)
    print('RESULT: rank(T)=14 consists exactly of those 45 points; rank(Q)=8 at every one.',flush=True)
    print('RESULT: all ten strictly semistable points have rank(T)=15. U IS EMPTY.',flush=True)

if __name__=='__main__':main()
