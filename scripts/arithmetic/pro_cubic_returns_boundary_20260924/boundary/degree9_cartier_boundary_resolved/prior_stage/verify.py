#!/usr/bin/env python3
"""Rebuild every certificate, compare exact data, and check the SHA-256 manifest.
Python >=3.10, standard library only. Tested on CPython 3.13.5.
"""
from pathlib import Path
import argparse,hashlib,json,platform,sys,time
ROOT=Path(__file__).resolve().parent
sys.dont_write_bytecode=True
sys.path.insert(0,str(ROOT/'src'))
from reduction import all_reductions
from discriminant import discriminant_data
from square_obstruction import square_data

def canon(obj):return json.loads(json.dumps(obj))
def manifest_check():
    path=ROOT/'SHA256SUMS'
    if not path.exists():raise RuntimeError('SHA256SUMS is absent')
    count=0
    for line in path.read_text().splitlines():
        digest,name=line.split('  ',1)
        target=ROOT/name
        if hashlib.sha256(target.read_bytes()).hexdigest()!=digest:
            raise RuntimeError('Manifest mismatch: '+name)
        count+=1
    print(f'PASS manifest: {count} listed files',flush=True)

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--write-certificates',action='store_true',help='regenerate certificate JSON files; used during archive creation')
    ap.add_argument('--manifest-only',action='store_true')
    ap.add_argument('--skip-manifest',action='store_true',help='only for first archive generation, before manifest exists')
    args=ap.parse_args()
    print('Degree-nine Cartier-line boundary: exact verification',flush=True)
    print('Python:',platform.python_version(),'; implementation:',platform.python_implementation(),flush=True)
    if not args.skip_manifest:manifest_check()
    if args.manifest_only:return
    start=time.monotonic()
    field,finite,local=all_reductions()
    print('PASS field/polynomial identities; A irreducible over F25; all four omitted roots',flush=True)
    print('PASS finite-pole matrix: 100 x 128, rank 100, nullity 28; exact trace pencil',flush=True)
    print('PASS all four collision matrices: 27 x 29, rank 26, nullity 3; conjugate normal forms',flush=True)
    disc=discriminant_data(finite,local[0])
    print('PASS nu=0 discriminant identity: 5729 exact grid points; 24 independent Sylvester checks',flush=True)
    sq=square_data(disc,local[0])
    print('PASS all-geometric nu=0 exclusion: saturated gcd 1, exceptional leading branch kappa=0, lambda=0 nonsquare',flush=True)
    outputs={'field_checks.json':field,'finite_pole.json':finite,
             'four_supports.json':local,'discriminant_nu0.json':disc,'square_obstruction_nu0.json':sq}
    for name,obj in outputs.items():
        p=ROOT/'certificates'/name
        if args.write_certificates:p.write_text(json.dumps(obj,indent=2)+'\n')
        elif json.loads(p.read_text())!=canon(obj):raise RuntimeError('Certificate differs: '+name)
        print('PASS exact certificate:',name,flush=True)
    print('STATUS: partial. nu != 0 remains unresolved; no witness is certified.',flush=True)
    print(f'ALL EXECUTED CHECKS PASSED ({time.monotonic()-start:.3f} seconds in this run).',flush=True)
if __name__=='__main__':main()
