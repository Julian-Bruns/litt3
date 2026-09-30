#!/usr/bin/env sage-python
"""Bounded Jacobian check for the exceptional genus-six BT repair.

This does not enumerate maps or prove a common-cover exclusion for refinements.
The supplied model is the actual genus-six source, not an arbitrary isogeny.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path

from sage.all import GF, PolynomialRing, QQ, ZZ, pari
from sage.env import SAGE_VERSION


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('model')
    ap.add_argument('--output', required=True)
    args = ap.parse_args()
    path = Path(args.model)
    data = json.loads(path.read_text())
    assert data['label'] == 'pair_4_5' and data['genus'] == 6
    r0 = PolynomialRing(GF(5), 't')
    k = GF(625, 't', modulus=r0(data['field_modulus']))
    r = PolynomialRing(k, 'x')
    x, t = r.gen(), k.gen()
    ft = r([k(c) for c in data['hyperelliptic_polynomial']])
    fc = x*(x-1)*(x-2)*(x-3)*(x-t)
    assert ft.degree() == 13 and ft.gcd(ft.derivative()) == 1
    pol = PolynomialRing(QQ, 'X')
    X = pol.gen()
    start = time.monotonic()
    pc = pol(pari(fc).hyperellcharpoly())
    pt = pol(pari(ft).hyperellcharpoly())
    pp, rem = pt.quo_rem(pc)
    assert rem == 0 and pc.is_irreducible() and pp.is_irreducible()
    assert pt[6] % 5 != 0  # the actual genus-six Jacobian is ordinary

    # Independent direct F625 point counts, without the cohomology algorithm.
    counts = {}
    for label, f, p in [('base', fc, pc), ('source', ft, pt)]:
        count = 1  # the unique odd-degree point at infinity
        for a in k:
            b = f(a)
            count += 1 if b == 0 else (2 if b.is_square() else 0)
        assert count == 626 + p[p.degree()-1]
        counts[label] = int(count)

    s = PolynomialRing(QQ, ['x', 'z'])
    xx, z = s.gens()

    def univariate(f):
        return pol([f.monomial_coefficient(z**i)
                    for i in range(f.degree(z)+1)])

    def power_poly(f, n):
        return univariate(s(f(xx)).resultant(z-xx**n, xx))

    def ratio_poly(f, g):
        return univariate(s(f(xx)).resultant(
            sum(s(g[i])*xx**i*z**(g.degree()-i)
                for i in range(g.degree()+1)), xx)).monic()

    def cyclotomic_factors(f):
        return [(a, int(e)) for a, e in f.factor() if a.is_cyclotomic()]

    qa = X**4+7*X**3-639*X**2+4375*X+390625
    assert qa.is_irreducible() and qa[2] % 5 != 0
    pc5, qa5 = power_poly(pc, 5), power_poly(qa, 5)
    assert power_poly(pp, 5) == qa5**2
    assert power_poly(pt, 5) == pc5*qa5**2
    for f in (pc, qa):
        assert cyclotomic_factors(ratio_poly(f, f)) == [(X-1, 4)]
    assert not cyclotomic_factors(ratio_poly(pc, qa))

    # Both geometrically simple surface types have real multiplication by
    # Q(sqrt(5)); the selected backup has real multiplication by Q(sqrt(21)).
    real_discriminants = []
    for f in (pc, qa):
        a, b = -ZZ(f[3]), ZZ(f[2])
        disc = a*a-4*(b-1250)
        assert disc/5 in ZZ and ZZ(disc/5).is_square()
        real_discriminants.append(int(disc))

    def encode(f):
        assert all(c in ZZ for c in f.list())
        return [int(c) for c in f.list()]

    rational_encode = lambda f: [str(c) for c in f.list()]
    result = {
        'status': 'PASS',
        'scope': 'Jacobian arithmetic of the fixed genus-six repair only; '
                 'no additional map is produced and no refinement is excluded.',
        'model_sha256': hashlib.sha256(path.read_bytes()).hexdigest(),
        'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'sage_version': SAGE_VERSION,
        'pari_version': str(pari.version()),
        'base_field_size': 625,
        'independent_point_counts': counts,
        'base_frobenius': encode(pc),
        'source_frobenius': encode(pt),
        'prym_frobenius': encode(pp),
        'second_surface_frobenius': encode(qa),
        'base_fifth_power': encode(pc5),
        'second_surface_fifth_power': encode(qa5),
        'self_ratio_polynomials': [rational_encode(ratio_poly(f, f)) for f in (pc, qa)],
        'cross_ratio_polynomial': rational_encode(ratio_poly(pc, qa)),
        'prym_cyclotomic_ratio_factors': [
            {'factor': encode(f), 'multiplicity': e}
            for f, e in cyclotomic_factors(ratio_poly(pp, pp))],
        'real_discriminants': real_discriminants,
        'seconds': time.monotonic()-start,
    }
    Path(args.output).write_text(json.dumps(result, indent=2)+'\n')
    print('PASS: J(T) becomes J(C) times A^2 after degree-five scalar extension.')
    print('Both surface types are absolutely simple, mutually nonisogenous,')
    print('and have Rosati-fixed field Q(sqrt(5)). This excludes a map from T')
    print('to the selected backup, but does not exclude maps from refinements.')


if __name__ == '__main__':
    main()
