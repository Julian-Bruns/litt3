#!/usr/bin/env python3
"""Replay a retained shifted-Frobenius polynomial system in a selected order.

Only the specified prepared chart is tested. A generic-parameter test,
when requested, does not decide its exceptional parameter fibers.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, TermOrder


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('input', type=Path)
    ap.add_argument('--output', type=Path, required=True)
    ap.add_argument('--cyclic-weights', action='store_true')
    ap.add_argument('--generic-parameter')
    ap.add_argument('--skip-dimension', action='store_true',
                    help='Retain the ordinary basis without a separate dimension computation.')
    args = ap.parse_args()
    data = json.loads(args.input.read_text())
    k = GF(25, 'a', modulus=PolynomialRing(GF(5), 'v')([2, 4, 1]))
    names = list(data['variables'])
    base = k
    if args.generic_parameter:
        assert args.generic_parameter in names
        names.remove(args.generic_parameter)
        # Keep the quadratic constant generator as an explicit variable.
        # A fraction field over GF(25) becomes a Singular qring, unsupported
        # by slimgb; GF(5)(parameter) with a^2-a+2 is an exact replacement.
        base = PolynomialRing(GF(5), args.generic_parameter).fraction_field()
        names = ['a'] + names
    weights = tuple(1 if n == 'p2' else 3 if n.startswith('p') else 6
                    for n in names)
    order = TermOrder('wdegrevlex', weights) if args.cyclic_weights else 'degrevlex'
    R = PolynomialRing(base, names, order=order)
    equations = [R(s) for s in data['equations']]
    if args.generic_parameter:
        a = R.gen(0)
        equations.append(a*a-a+2)
    receipt = {'status': 'PREPARED',
               'input_sha256': hashlib.sha256(args.input.read_bytes()).hexdigest(),
               'scope': data.get('scope'), 'variables': names,
               'generic_parameter': args.generic_parameter,
               'weights': weights if args.cyclic_weights else None,
               'equations': [str(f) for f in equations]}
    args.output.write_text(json.dumps(receipt, indent=2) + '\n')
    print('PREPARED', len(names), 'variables,', len(equations), 'equations', flush=True)
    start = time.time()
    I = R.ideal(equations)
    try:
        gb = I.groebner_basis(algorithm='singular:slimgb')
    except Exception as exc:
        receipt.update(status='ERROR', error=str(exc), seconds=time.time()-start)
        args.output.write_text(json.dumps(receipt, indent=2) + '\n')
        raise
    empty = list(gb) == [R.one()]
    receipt.update(status='COMPLETE', empty=empty,
                   dimension=-1 if empty else None if args.skip_dimension else int(I.dimension()),
                   seconds=time.time()-start,
                   groebner_basis=[str(f) for f in gb])
    args.output.write_text(json.dumps(receipt, indent=2) + '\n')
    print('COMPLETE empty', empty, 'dimension', receipt['dimension'],
          'seconds', receipt['seconds'], flush=True)


if __name__ == '__main__':
    main()
