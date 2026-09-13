#!/usr/bin/env python3
"""Preserve and replay the returned cyclic-five certificate in separate outputs.

This verifies provenance and exact computed identities. The full geometric
comparison and whole-plane constancy have a separately scoped prose audit.
"""
import argparse
from concurrent.futures import ThreadPoolExecutor
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('certificate', type=Path)
    ap.add_argument('output_directory', type=Path)
    ap.add_argument('--receipt', type=Path, required=True)
    args = ap.parse_args(); start = time.monotonic()
    source = args.certificate.resolve(); out = args.output_directory.resolve()
    assert source.is_dir() and source != out
    manifest = json.loads((source/'MANIFEST.json').read_text())
    digest = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
    for name,record in manifest['files'].items():
        path = source/name
        assert path.is_file() and path.stat().st_size == record['bytes']
        assert digest(path) == record['sha256'], name
    root = Path(__file__).resolve().parents[3]
    assert (source/'inputs/cyclic5_small_field_fourth_inputs.json').read_bytes() == (
        root/'Research/computations/cyclic5_small_field_fourth_inputs.json').read_bytes()
    assert not out.exists(), 'Choose a new output directory; original evidence is retained.'
    out.mkdir(parents=True)
    env = dict(os.environ, OPENBLAS_NUM_THREADS='1', OMP_NUM_THREADS='1',
               MKL_NUM_THREADS='1')
    fil = subprocess.run([sys.executable,str(source/'scripts/check_filtration.py')],
                         capture_output=True,text=True,check=True,env=env)
    (out/'filtration.log').write_text(fil.stdout)
    cases = [('p1200',['--precision','1200']),('p1500',['--precision','1500']),
             ('p1800',['--precision','1800']),
             ('frobenius_variant',['--precision','1500','--frobenius-variant','1']),
             ('parameter_t',['--precision','1500','--parameter-d','0,1,0,0',
                             '--parameter-b','0,0,1,0']),
             ('fourth_digit_sign',['--precision','1500','--fourth-index','12',
                                  '--fourth-coeff','0,1,0,0'])]
    def run(case):
        name,params = case
        cmd = [sys.executable,str(source/'scripts/compute_fourth.py'),*params,
               '--output',str(out/(name+'.json'))]
        with (out/(name+'.log')).open('w') as log:
            proc = subprocess.run(cmd,stdout=log,stderr=subprocess.STDOUT,env=env)
        assert proc.returncode == 0, (name,proc.returncode)
        result = json.loads((out/(name+'.json')).read_text())
        shipped = json.loads((source/'receipts'/(name+'.json')).read_text())
        assert {k:v for k,v in result.items() if k != 'seconds'} == {
            k:v for k,v in shipped.items() if k != 'seconds'}, name
        for filename,sha in result['source_sha256'].items():
            assert digest(source/'scripts'/filename) == sha
        print(name,result['obstruction_coordinates'],
              'precision',result['rho4_certified_precision'],flush=True)
        return name,result
    with ThreadPoolExecutor(max_workers=2) as pool:
        results = dict(pool.map(run,cases))
    ref = results['p1500']
    for name in ('p1200','p1800','frobenius_variant'):
        assert results[name]['rho4_coordinates'] == ref['rho4_coordinates']
    assert ref['obstruction_coordinates'] == [[4,2,2,4],[0,0,0,0]]
    assert all(r['obstruction_coordinates'][0] == [4,2,2,4] for r in results.values())
    # An independent scalar polynomial calculation, with no producer import.
    def mul(a,b):
        c = [0]*7
        for i in range(4):
            for j in range(4): c[i+j] += a[i]*b[j]
        for i in range(6,3,-1):
            for j,q in enumerate((3,4,1,4)): c[i-4+j] -= c[i]*q
        return [x%5 for x in c[:4]]
    e0 = [4,2,2,4]
    assert mul(e0,[4,4,0,0]) == [3,0,0,0]
    assert mul(e0,[3,3,0,0]) == [1,0,0,0]
    H = [3,1,3,0]
    lam = [[1,1,3,0],[4,3,0,0],[3,0,0,0]]
    top = ref['rho4_coordinates'][12:]
    paired = [sum(c[i] for c in [mul(a,b) for a,b in zip(lam,top)])%5
              for i in range(4)]
    assert mul([(-x)%5 for x in H],paired) == e0
    assert [sum(v[i] for v in ref['trace_decomposition'].values())%5
            for i in range(4)] == e0
    for name,record in manifest['files'].items():
        assert digest(source/name) == record['sha256'], 'Original archive mutated'
    receipt = dict(status='PASS six fresh complete replays, exact scalar audit, and immutable provenance',
                   scope='Fresh execution and independent finite-field identities; whole-plane constancy and geometric construction are audited separately.',
                   original_directory=str(source),fresh_directory=str(out),
                   original_manifest_sha256=digest(source/'MANIFEST.json'),
                   original_files_checked=len(manifest['files']),
                   original_input_unchanged=True,
                   result=[4,2,2,4],inverse=[3,3,0,0],
                   cases=[dict(name=n,seconds=r['seconds'],
                               rho_precision=r['rho4_certified_precision'],
                               obstruction=r['obstruction_coordinates'],
                               receipt_sha256=digest(out/(n+'.json')))
                          for n,r in results.items()],
                   source_sha256=digest(Path(__file__)),seconds=time.monotonic()-start)
    args.receipt.write_text(json.dumps(receipt,indent=2)+'\n')
    print(json.dumps(receipt,indent=2),flush=True)


if __name__ == '__main__': main()
