#!/usr/bin/env python3
"""Run both exhaustive methods and compare every determinant remainder.
No downloaded packages or software services are used. Temporary large streams
and the executable are deleted automatically. Stored evidence is not modified.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import shlex
import subprocess
import sys
import tempfile

ROOT=Path(__file__).resolve().parent.parent
EXPECTED='cc71a39fc72326d0db4391e84f87c4fe4ca7bb28b4bb33b5d1a13d0a97b198c4'


def run(command):
    print('$ '+' '.join(shlex.quote(str(x)) for x in command),flush=True)
    result=subprocess.run(command,cwd=ROOT,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    print(result.stdout,end='' if result.stdout.endswith('\n') else '\n',flush=True)
    if result.returncode:
        raise RuntimeError('Command failed with exit code '+str(result.returncode))
    return result.stdout


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--python-only',action='store_true',help='verify the full classification using only the sparse Python method')
    args=parser.parse_args()
    print('Python:',platform.python_version())
    print('Platform:',platform.system(),platform.machine())
    run([sys.executable,'-B','src/verify_constants.py'])
    cert=json.loads((ROOT/'evidence/sparse_classification.json').read_text())
    assert cert['ordered_remainder_stream_sha256']==EXPECTED
    if args.python_only:
        run([sys.executable,'-B','src/verify_sparse.py'])
        print('PASS: full Python verification; C++ cross-check intentionally not run in this mode.')
        return
    compiler=shlex.split(os.environ.get('CXX','g++'))
    version=subprocess.run(compiler+['--version'],text=True,stdout=subprocess.PIPE,check=True).stdout.splitlines()[0]
    print('Compiler:',version)
    with tempfile.TemporaryDirectory(prefix='quadratic_trace_') as temp:
        temp=Path(temp);exe=temp/'endpoint_scan'
        sparse_stream=temp/'sparse_remainders.bin'
        run([sys.executable,'-B','src/verify_sparse.py','--stream',str(sparse_stream)])
        run(compiler+['-std=c++17','-O3','-Wall','-Wextra','-pedantic','src/endpoint_scan.cpp','-o',str(exe)])
        survivor=temp/'survivors.tsv';stream=temp/'remainders.bin'
        output=run([str(exe),str(survivor),str(stream)])
        assert 'total=266916 determinant_zero=62 both_characters_zero=58 only_p_zero=2 only_r_zero=2 nondegenerate=0' in output
        assert survivor.read_text()=='a\tb\tc\td\n'
        assert stream.stat().st_size==sparse_stream.stat().st_size==266916*7
        digest=hashlib.sha256()
        with stream.open('rb') as source, sparse_stream.open('rb') as reference:
            while True:
                chunk=source.read(1<<20)
                other=reference.read(1<<20)
                assert chunk==other, 'Exact remainder streams differ'
                if not chunk:break
                digest.update(chunk)
        assert digest.hexdigest()==EXPECTED
        print('PASS: DIRECT BYTE COMPARISON: C++ and Python agree on all 266916 complete seven-coordinate remainders.')
        print('Shared stream SHA-256:',digest.hexdigest())
        print('Temporary remainder bytes per implementation:',stream.stat().st_size,'(both streams deleted on completion)')
    print('PASS: ALL EXECUTED VERIFICATION CHECKS.')
    print('The supplied invariant-pair exclusion is a declared mathematical input, not re-proved by this verifier.')

if __name__=='__main__':main()
