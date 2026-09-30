#!/usr/bin/env python3
"""Independently check a prepared F25 chart with prime-field Singular std.

This uses Buchberger's std rather than msolve's F4. If requested, retain
an exact identity for 1 in the input ideal, not the intermediate basis.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing


def encode(f):
    return [[list(e), int(c)] for e, c in sorted(f.dict().items())]


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('input', type=Path)
    ap.add_argument('--output', type=Path, required=True)
    ap.add_argument('--certificate', action='store_true')
    ap.add_argument('--constant-first', action='store_true')
    args = ap.parse_args()
    data = json.loads(args.input.read_text())
    names = list(data['variables'])
    names = ['a'] + names if args.constant_first else names + ['a']
    R = PolynomialRing(GF(5), names, order='degrevlex')
    a = R('a')
    equations = [R(s) for s in data['equations']] + [a*a-a+2]
    receipt = {'status': 'RUNNING', 'method': 'Singular std over F5',
               'input_sha256': hashlib.sha256(args.input.read_bytes()).hexdigest(),
               'variables': names, 'equations': [encode(f) for f in equations]}
    args.output.write_text(json.dumps(receipt, separators=(',', ':'))+'\n')
    start = time.time()
    print('START independent std', len(names), 'variables', flush=True)
    I = R.ideal(equations)
    basis = I.groebner_basis(algorithm='singular:std')
    empty = list(basis) == [R.one()]
    receipt.update(status='COMPLETE', empty=empty, seconds=time.time()-start,
                   basis=[encode(f) for f in basis])
    args.output.write_text(json.dumps(receipt, separators=(',', ':'))+'\n')
    print('COMPLETE empty', empty, 'seconds', receipt['seconds'], flush=True)
    if empty and args.certificate:
        witness = R.one().lift(I)
        assert sum(h*f for h, f in zip(witness, equations)) == 1
        receipt.update(multipliers=[encode(h) for h in witness],
                       witness_terms=sum(len(h.dict()) for h in witness),
                       certificate_seconds=time.time()-start)
        args.output.write_text(json.dumps(receipt, separators=(',', ':'))+'\n')
        print('CERTIFIED terms', receipt['witness_terms'], flush=True)


if __name__ == '__main__':
    main()
