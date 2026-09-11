#!/usr/bin/env sage-python
"""Exact generic cyclic anisotropy and unequal-exponent length checks.

The all-order length proof is in Solutions/Sol_abelian_defect_flags.md. These finite
checks verify the algebra used there, not a geometric common-cover claim.
"""
import argparse
import itertools
import json
from pathlib import Path
import time

from sage.all import GF, PolynomialRing, matrix


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output', required=True)
    args = ap.parse_args()
    start = time.monotonic()
    prime = GF(5)
    zz = PolynomialRing(prime,'z')
    k = GF(25,name='a',modulus=zz([3,0,1]))
    a = k.gen()
    ring = PolynomialRing(k,'t')
    t = ring.gen()
    field = ring.fraction_field()
    aa,bb,cc,dd,ee = map(field,[3*t*t+4*t+1,3*t+3,
                               3*t*t+3*t,t*t+4*t+3,t*t+2*t+3])
    c = field(a)/(t+1)
    assert 3*c*c+4/(t+1)**2 == 0
    s5 = (ee**5*c-aa**5*c**5)/bb**5
    s = (cc**5*c**5+dd**5*s5)/ee**5
    obstruction = s**5-s5
    numerator,denominator = obstruction.numerator(),obstruction.denominator()
    assert numerator and numerator.degree() == 76
    assert (denominator % (t+1)) == 0
    # Every denominator factor lies on the already excluded ordinary domain.
    allowed = (t+1)*(t*t+2*t+3)
    assert all(allowed % factor == 0 for factor,multiplicity in denominator.factor())
    coefficient_conjugate = ring([x**5 for x in numerator.list()])
    norm = numerator*coefficient_conjugate
    assert norm.degree() == 152 and all(x**5 == x for x in norm.list())
    assert numerator % (t**3+t+1)
    generic = dict(degree_over_F25=76,norm_degree_over_F5=152,
                   numerator=[[int(x.polynomial()[i]) for i in range(2)] for x in numerator],
                   denominator=[[int(x.polynomial()[i]) for i in range(2)] for x in denominator],
                   norm_polynomial=[int(x) for x in norm],
                   backup_remainder=str(numerator % (t**3+t+1)))
    print('GENERIC CYCLIC ANISOTROPY IDENTITY PASSED',flush=True)

    # The 20 rational fractional-linear maps fixing the missing F5 point 4
    # preserve the five constant branch points and carry the two base bad
    # pairs onto all ten branch-support bad pairs.
    points = (0,1,2,3,None)
    base_pairs = ({0,3},{1,2})
    orbit = set()
    single_orbit = set()
    maps = set()
    for aa0,bb0,cc0,dd0 in itertools.product(range(5),repeat=4):
        if (aa0*dd0-bb0*cc0)%5 == 0:
            continue
        coeff = [aa0,bb0,cc0,dd0]
        first = next(x for x in coeff if x)
        coeff = tuple((x*pow(first,-1,5))%5 for x in coeff)
        if coeff in maps:
            continue
        a0,b0,c0,d0 = coeff
        def mobius(x):
            num,den = (a0,c0) if x is None else ((a0*x+b0)%5,(c0*x+d0)%5)
            return None if den == 0 else (num*pow(den,-1,5))%5
        if mobius(4) != 4:
            continue
        maps.add(coeff)
        assert set(map(mobius,points)) == set(points)
        for pair in base_pairs:
            image = frozenset(mobius(x) for x in pair)
            orbit.add((mobius(None),image))
        single_orbit.add((mobius(None),frozenset(mobius(x) for x in {0,3})))
    expected = { (None,frozenset(pair)) for pair in ({0,3},{1,2}) }
    for branch,pairs in [(0,({2,None},{1,3})),(1,({0,None},{2,3})),
                         (2,({3,None},{0,1})),(3,({1,None},{0,2}))]:
        expected |= {(branch,frozenset(pair)) for pair in pairs}
    assert len(maps) == 20 and orbit == single_orbit == expected
    print('ALL TEN BRANCH PAIRS FORM ONE VERIFIED FAMILY ORBIT',flush=True)

    # Tests retain the unequal-power ideal in the ACTUAL coordinate order.
    pol = PolynomialRing(prime,names=('x','y','z'))
    x,y,z = pol.gens()
    cases = []
    for q,r in [(5,1),(25,1),(25,5),(125,5),(125,25)]:
        examples = [
            ('A1_transverse',x*x+y*y+z*z+x*y*z+x**3,2*q*r-(r*r+1)//2),
            ('A3_transverse',x*x+y*y+z**4+x*z**3+y*z**3,2*q*r-(r*r+3)//4),
            ('A3_degenerate',x*x+z*z+y**4+x*y**3+y*z*z,2*q*r),
            ('rank_one_plane_cubic',x*x+y*z+y**3+z**3,2*q*r),
        ]
        for label,f,expected in examples:
            actual = int(pol.ideal([f,x**q,y**q,z**r]).vector_space_dimension())
            assert actual == expected,(label,q,r,actual,expected)
            cases.append(dict(label=label,q=q,r=r,length=actual))
    for q1,q2,q3 in [(5,1,1),(25,5,1),(25,5,5),(125,25,5),(125,25,25)]:
        for f in [x*x+y*z+y**3+z**5,x*x+y*y+z*z+x*y*z+y**5]:
            actual = int(pol.ideal([f,x**q1,y**q2,z**q3]).vector_space_dimension())
            assert actual == 2*q2*q3
            cases.append(dict(label='unique_largest',q1=q1,q2=q2,q3=q3,length=actual))
    print('ALL THIRTY UNEQUAL-POWER QUOTIENT LENGTH CHECKS PASSED',flush=True)
    result = dict(status='PASS',generic_cyclic_test=generic,
                  fractional_linear_family_maps=[list(v) for v in sorted(maps)],
                  quotient_length_checks=cases,seconds=time.monotonic()-start)
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(dict(status='PASS',seconds=result['seconds'])),flush=True)


if __name__ == '__main__':
    main()
