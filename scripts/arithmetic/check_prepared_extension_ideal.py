#!/usr/bin/env python3
"""Independent Singular std computation over the actual coefficient field.

The coefficient field is represented algebraically, not by extra geometric
variables. This has the same geometric scope as the prime-field ideal
with a^2-a+2. Save the latter exact equations for independent input checks.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('input', type=Path)
    ap.add_argument('--output', type=Path, required=True)
    ap.add_argument('--algorithm', choices=('std','slimgb'), default='std')
    args = ap.parse_args()
    source = json.loads(args.input.read_text())
    k = GF(25,'a',modulus=PolynomialRing(GF(5),'t')([2,4,1]))
    R = PolynomialRing(k,source['variables'],order='degrevlex')
    equations = [R(s) for s in source['equations']]
    S = PolynomialRing(GF(5),source['variables']+['a'],order='degrevlex')
    a = S.gens()[-1]
    prime = [S(s) for s in source['equations']]+[a*a-a+2]
    receipt={'status':'RUNNING','method':f'Independent Singular {args.algorithm} over F25',
             'input_sha256':hashlib.sha256(args.input.read_bytes()).hexdigest(),
             'variables':list(S.variable_names()),
             'equations':[[[list(e),int(c)] for e,c in sorted(f.dict().items())] for f in prime]}
    args.output.write_text(json.dumps(receipt,separators=(',',':'))+'\n')
    start=time.time()
    print('START F25',args.algorithm,R.ngens(),'variables',len(equations),'equations',flush=True)
    basis=R.ideal(equations).groebner_basis(algorithm='singular:'+args.algorithm)
    receipt.update(status='COMPLETE',empty=list(basis)==[R.one()],
                   seconds=time.time()-start,basis=[str(f) for f in basis])
    args.output.write_text(json.dumps(receipt,separators=(',',':'))+'\n')
    print('COMPLETE empty',receipt['empty'],'seconds',receipt['seconds'],flush=True)


if __name__=='__main__':
    main()
