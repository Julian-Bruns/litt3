#!/usr/bin/env sage-python
"""Enumerate one bounded degree-five hyperelliptic quotient profile.

Profile: two full five-point branch fibers and four singleton branch
fibers, one containing the chosen source infinity. This is not all maps.
Every returned map is checked by a complete polynomial identity.
"""
import argparse
import hashlib
import itertools
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('model')
    ap.add_argument('--output', required=True)
    args = ap.parse_args()
    source = Path(args.model)
    data = json.loads(source.read_text())
    assert data['label'] == 'pair_4_5'
    k = GF(5**20, 'a')
    r = PolynomialRing(k, 'x')
    x = r.gen()
    tau = sorted(r(data['field_modulus']).roots(multiplicities=False),
                 key=lambda a: tuple(int(c) for c in a.polynomial()))[0]
    dec = lambda c: sum(k(a)*tau**i for i, a in enumerate(c))
    f = r([dec(c) for c in data['hyperelliptic_polynomial']])
    n0 = r([dec(c) for c in data['numerator']])
    d0 = r([dec(c) for c in data['denominator']])
    roots = sorted(f.roots(multiplicities=False),
                   key=lambda a: tuple(int(c) for c in a.polynomial()))
    assert len(roots) == 13
    start = time.monotonic()
    entries = []
    for indices in itertools.combinations(range(13), 5):
        p = r.one()
        for i in indices:
            p *= x-roots[i]
        entries.append((sum(1 << i for i in indices), p, p.list()[:5]))

    def square_quartic(v):
        if len(v) != 5 or v[4] == 0:
            return False
        a, b = 4*v[4]*v[2]-v[3]**2, 8*v[4]**2
        return v[1]*b == v[3]*a and v[0]*b*b == v[4]*a*a

    enc = lambda a: [int(a.polynomial()[i]) for i in range(20)]
    pe = lambda p: [enc(a) for a in p.list()]
    tested, first_pass, hits = 0, 0, []
    for i, (am, a, av) in enumerate(entries):
        for bm, b, bv in entries[i+1:]:
            if am & bm:
                continue
            tested += 1
            if not square_quartic([av[j]-bv[j] for j in range(5)]):
                continue
            first_pass += 1
            singles = [j for j in range(13) if not ((am | bm) >> j) & 1]
            values = [k(1)]
            valid = True
            for j in singles:
                c = roots[j]
                lam = a(c)/b(c)
                if lam == 0 or lam in values:
                    valid = False
                    break
                quotient, rem = (a-lam*b).quo_rem(x-c)
                assert rem == 0
                if quotient(c) == 0 or not square_quartic(quotient.list()):
                    valid = False
                    break
                values.append(lam)
            if not valid:
                continue
            w = a.derivative()*b-a*b.derivative()
            left = a*b
            for lam in values:
                left *= a-lam*b
            right = f*w*w
            constant = left.leading_coefficient()/right.leading_coefficient()
            assert left == constant*right
            # Square roots exist in the algebraic closure; the identity gives
            # v=sqrt(constant)*w*y/b^3, u=a/b. Riemann--Hurwitz then proves
            # the separable degree-five map genus6->genus2 is etale.
            rows = [[p[j] for j in range(6)] for p in (a, b, n0, d0)]
            known = matrix(k, rows).rank() == 2
            hits.append({'first_fiber_mask': am, 'second_fiber_mask': bm,
                         'numerator': pe(a), 'denominator': pe(b),
                         'finite_target_branches': [enc(k(0))]+[enc(v) for v in values],
                         'identity_constant': enc(constant),
                         'equivalent_to_original_map': bool(known)})
            print('certified map; equivalent to original:', known, flush=True)
    result = {'status': 'PASS bounded profile enumeration',
              'scope': __doc__,
              'model_sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
              'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
              'field_modulus': [int(a) for a in k.modulus()],
              'tau': enc(tau), 'finite_branch_points': [enc(a) for a in roots],
              'disjoint_fiber_pairs_tested': tested,
              'infinity_square_tests_passed': first_pass,
              'maps': hits, 'seconds': time.monotonic()-start}
    assert tested == 36036
    assert any(h['equivalent_to_original_map'] for h in hits)
    Path(args.output).write_text(json.dumps(result, indent=2)+'\n')
    print('DONE:', tested, 'pairs;', first_pass, 'first tests;', len(hits), 'maps.', flush=True)


if __name__ == '__main__':
    main()
