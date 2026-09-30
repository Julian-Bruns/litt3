#!/usr/bin/env sage-python
"""All dihedral-profile genus-two degree-five maps from the fixed T.

Move each source branch point to infinity. In each chart enumerate the
two unramified five-point fibers. This covers the profile (5,5,1,1,1,1)
over every algebraic field extension, but not either other profile.
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
    path = Path(args.model)
    data = json.loads(path.read_text())
    assert data['label'] == 'pair_4_5'
    k = GF(5**20, 'a')
    r = PolynomialRing(k, 'x')
    x = r.gen()
    key = lambda a: tuple(int(c) for c in a.polynomial())
    tau = sorted(r(data['field_modulus']).roots(multiplicities=False), key=key)[0]
    dec = lambda v: sum(k(c)*tau**i for i, c in enumerate(v))
    f0 = r([dec(c) for c in data['hyperelliptic_polynomial']])
    n0 = r([dec(c) for c in data['numerator']])
    d0 = r([dec(c) for c in data['denominator']])
    branch = sorted(f0.roots(multiplicities=False), key=key)
    assert len(branch) == 13
    encode = lambda a: [int(a.polynomial()[i]) for i in range(20)]

    def square_quartic(v):
        if len(v) != 5 or v[4] == 0:
            return False
        a, b = 4*v[4]*v[2]-v[3]**2, 8*v[4]**2
        return v[1]*b == v[3]*a and v[0]*b*b == v[4]*a*a

    def change(p, c, degree):
        return sum(p[i]*x**(degree-i)*(c*x+1)**i for i in range(p.degree()+1))

    start = time.monotonic()
    charts, planes = [], set()
    for chart, c in enumerate([None]+branch):
        if c is None:
            f, n, d, roots = f0, n0, d0, branch
        else:
            f, n, d = change(f0, c, 14), change(n0, c, 5), change(d0, c, 5)
            roots = sorted([k(0)]+[1/(a-c) for a in branch if a != c], key=key)
        assert f.degree() == 13 and all(f(a) == 0 for a in roots)
        entries = []
        for indices in itertools.combinations(range(13), 5):
            p = r.one()
            for i in indices:
                p *= x-roots[i]
            entries.append((sum(1 << i for i in indices), p, p.list()[:5]))
        tested, first, hits = 0, 0, []
        for i, (am, a, av) in enumerate(entries):
            for bm, b, bv in entries[i+1:]:
                if am & bm:
                    continue
                tested += 1
                if not square_quartic([av[j]-bv[j] for j in range(5)]):
                    continue
                first += 1
                singles = [j for j in range(13) if not ((am | bm) >> j) & 1]
                values, valid = [k(1)], True
                for j in singles:
                    v = roots[j]
                    lam = a(v)/b(v)
                    if lam == 0 or lam in values:
                        valid = False
                        break
                    q, rem = (a-lam*b).quo_rem(x-v)
                    assert rem == 0
                    if q(v) == 0 or not square_quartic(q.list()):
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
                known = matrix(k, [[p[j] for j in range(6)] for p in (a,b,n,d)]).rank() == 2
                # Convert back to the original source coordinate before deduplication.
                if c is None:
                    aa, bb = a, b
                else:
                    aa = sum(a[j]*(x-c)**(5-j) for j in range(6))
                    bb = sum(b[j]*(x-c)**(5-j) for j in range(6))
                reduced = matrix(k, [[p[j] for j in range(6)] for p in (aa,bb)]).echelon_form()
                plane = tuple(tuple(encode(v)) for v in reduced.list())
                planes.add(plane)
                hits.append({'first_fiber_mask': am, 'second_fiber_mask': bm,
                             'identity_constant': encode(constant),
                             'original_coordinate_plane': list(plane),
                             'equivalent_to_original_map': bool(known)})
        assert tested == 36036
        charts.append({'chart': chart, 'old_point_at_new_infinity': None if c is None else encode(c),
                       'pairs': tested, 'first_square_passes': first, 'maps': hits})
        print('chart', chart, 'first tests', first, 'maps', len(hits), flush=True)
    assert sum(len(c['maps']) for c in charts) == 4*len(planes)
    result = {'status': 'PASS complete dihedral-profile search',
              'scope': __doc__, 'model_sha256': hashlib.sha256(path.read_bytes()).hexdigest(),
              'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
              'field_modulus': [int(v) for v in k.modulus()], 'tau': encode(tau),
              'charts': charts, 'unique_map_planes': len(planes),
              'seconds': time.monotonic()-start}
    Path(args.output).write_text(json.dumps(result, indent=2)+'\n')
    print('PASS unique map planes:',len(planes), flush=True)


if __name__ == '__main__':
    main()
