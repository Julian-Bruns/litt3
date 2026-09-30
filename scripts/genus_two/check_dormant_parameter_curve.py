#!/usr/bin/env sage -python
"""The dormant family has a genus-one normalization and A5 monodromy.

Certifies the birational polynomial identities, finite branch factors,
the exact discriminant, and small-field Frobenius cycle distributions.
Outputs belong outside the research workspace.
"""
import argparse
import hashlib
import json
from collections import Counter
from pathlib import Path
from sage.all import GF, PolynomialRing


def dormant_polynomial(t, T):
    W = T**2-3*(t+1)*T+3*(t+1)
    V = t+1+(-t-1+2*T)*W
    return 2*(-2*t*T-(t+1)*W-V*W)


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output', type=Path, required=True)
    ap.add_argument('--max-field-degree', type=int, default=3)
    args = ap.parse_args()
    root = Path(__file__).resolve().parents[2]
    assert not args.output.resolve().is_relative_to(root)
    R = PolynomialRing(GF(5), names=['t','T','s','w'])
    t,T,s,w = R.gens()
    P = dormant_polynomial(t,T)
    G = t*(t-1)*(t-2)*(t-3)
    assert P.resultant(P.derivative(T),T) == -G**2
    shifted = R(P(t,3*t-1+s,s,w))
    aa = -s**3
    bb = s**4-2*s**3+1
    cc = s**5+s**4-s**3-s+1
    assert shifted == aa*t**2+bb*t+cc
    assert bb**2-4*aa*cc == 1+3*s**4
    assert (2*aa*t+bb)**2-(1+3*s**4) == 4*aa*shifted
    finite_branches = []
    S = PolynomialRing(GF(5),'z'); z = S.gen()
    for a in range(4):
        f = S(dormant_polynomial(GF(5)(a),z))
        facts = list(f.factor())
        triple = next(g for g,e in facts if e == 3)
        simple = next(g for g,e in facts if e == 1)
        b = -triple[0]/triple[1]
        assert triple.degree() == 1 and simple.degree() == 2
        assert simple.is_irreducible()
        assert P.derivative(t)(a,b,0,0) != 0
        finite_branches.append(dict(parameter=a, factorization=str(f.factor()),
                                    triple_root=int(b),
                                    parameter_partial=int(P.derivative(t)(a,b,0,0))))
    assert S(dormant_polynomial(GF(5)(4),z)) == z**5-z
    # The quartic is smooth, including its two geometric infinity points.
    quartic = 1+3*z**4
    assert quartic.gcd(quartic.derivative()) == 1
    assert not GF(5)(3).is_square()
    counts = []
    for d in range(1,args.max_field_degree+1):
        k = GF(5**d,'b'); U = PolynomialRing(k,'z'); zz = U.gen()
        distribution = Counter()
        for a in k:
            if a in [k(0),k(1),k(2),k(3)]:
                continue
            f = U(dormant_polynomial(a,zz))
            factors = list(f.factor())
            assert all(e == 1 for g,e in factors)
            kind = tuple(sorted(int(g.degree()) for g,e in factors))
            assert kind in [(1,1,1,1,1),(1,2,2),(1,1,3),(5,)]
            distribution[kind] += 1
        counts.append(dict(field_degree=d,q=int(k.order()),
                           factor_types={','.join(map(str,key)):n
                                         for key,n in sorted(distribution.items())}))
        print('degree',d,counts[-1]['factor_types'],flush=True)
    receipt = dict(
        kind='dormant_genus_one_parameter_curve',
        polynomial=str(P), shifted_polynomial=str(shifted),
        quadratic_coefficients=list(map(str,[aa,bb,cc])),
        discriminant=str(bb**2-4*aa*cc),
        resultant=str(P.resultant(P.derivative(T),T)),
        finite_branches=finite_branches,
        smooth_quartic=True,leading_coefficient_nonsquare_over_F5=True,
        small_field_distributions=counts,
        source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        status='exact_arithmetic_inputs; geometric proof recorded separately')
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('PASS exact quartic normalization and branch inputs.',flush=True)


if __name__ == '__main__':
    main()
