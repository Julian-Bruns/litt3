#!/usr/bin/env python3
"""Extract a small identity over F25, then expand it back to literal F5.

The already completed prime-field ideal computation is not replaced.
This changes only certificate extraction, avoiding an unnecessary
polynomial variable for the constant-field generator during the lift.
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
    args = ap.parse_args()
    source = json.loads(args.input.read_text())
    k = GF(25, 'a', modulus=PolynomialRing(GF(5), 'v')([2, 4, 1]))
    R = PolynomialRing(k, source['variables'], order='degrevlex')
    equations = [R(s) for s in source['equations']]
    receipt = {'status': 'RUNNING', 'method': 'F25 identity extraction, expanded to F5',
               'input_sha256': hashlib.sha256(args.input.read_bytes()).hexdigest()}
    args.output.write_text(json.dumps(receipt)+'\n')
    start = time.time()
    print('START extension-field identity', flush=True)
    witness = R.one().lift(R.ideal(equations))
    assert sum(h*f for h, f in zip(witness, equations)) == 1
    S = PolynomialRing(GF(5), source['variables']+['a'], order='degrevlex')
    a = S.gens()[-1]
    original = [S(s) for s in source['equations']]
    def expand(f):
        terms = {}
        for exponents, coefficient in f.dict().items():
            for j in range(2):
                value = int(coefficient.polynomial()[j])
                if value:
                    terms[tuple(exponents)+(j,)] = value
        return S(terms)
    expanded = [expand(h) for h in witness]
    field_relation = a*a-a+2
    residual = 1-sum(h*f for h, f in zip(expanded, original))
    last, remainder = residual.quo_rem(field_relation)
    assert not remainder
    expanded.append(last)
    original.append(field_relation)
    assert sum(h*f for h, f in zip(expanded, original)) == 1
    receipt.update(status='COMPLETE', empty=True,
                   variables=list(S.variable_names()),
                   equations=[encode(f) for f in original],
                   multipliers=[encode(h) for h in expanded],
                   witness_terms=sum(len(h.dict()) for h in expanded),
                   seconds=time.time()-start)
    args.output.write_text(json.dumps(receipt, separators=(',', ':'))+'\n')
    print('CERTIFIED', receipt['witness_terms'], 'terms', receipt['seconds'], flush=True)


if __name__ == '__main__':
    main()
