#!/usr/bin/env python3
"""Exact identities used in first_cartier_full_monodromy.

This checks polynomial identities, not the geometric torsor argument.
Write the generated receipt outside the research workspace.
"""
import argparse
import hashlib
import json
from pathlib import Path

import sympy as s


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    t = s.Symbol('t')
    a, A, x, X, y, Y, z, Z = s.symbols('a A x X y Y z Z')
    variables = (a, A, x, X, y, Y, z, Z)

    def trunc(expr):
        return s.Poly(s.expand(expr), t).rem(s.Poly(t**5, t)).as_expr()

    def equal(left, right, vs=variables, prime=5):
        num, _ = s.fraction(s.cancel(left-right))
        if not s.Poly(num, *vs, modulus=prime).is_zero:
            raise AssertionError(s.expand(num))

    phi = a*(t+x*t**2+(y+x**2)*t**3+(z+x**3)*t**4)
    psi = A*(t+X*t**2+(Y+X**2)*t**3+(Z+X**3)*t**4)
    comp = s.Poly(trunc(phi.subs(t, psi)), t)
    ca = comp.nth(1)
    cx = s.cancel(comp.nth(2)/ca)
    cy = s.cancel(comp.nth(3)/ca-cx**2)
    cz = s.cancel(comp.nth(4)/ca-cx**3)
    equal(ca, a*A)
    equal(cx, X+A*x)
    equal(cy, Y+A**2*y)
    equal(cz.subs({a:1, A:1}), Z+z+2*x*Y-2*y*X)
    equal(s.diff(phi,t,2).subs(t,0)/a, 2*x)
    equal(s.diff(phi,t,3).subs(t,0)/a
          -s.Rational(3,2)*(s.diff(phi,t,2).subs(t,0)/a)**2, 6*y)

    # Projective substitution h=(a*t+b)/(c*t+1), Delta=a-b*c.
    # Under h, the vector fields 1,t,t^2 become quadratic again:
    # h'=Delta/(1+c*t)^2, so h^i/h' is quadratic for i=0,1,2.
    b, c = s.symbols('b c')
    h = (a*t+b)/(c*t+1)
    delta = a-b*c
    expected = ((c*t+1)**2/delta,
                (a*t+b)*(c*t+1)/delta,
                (a*t+b)**2/delta)
    for i in range(3):
        equal(h**i/s.diff(h,t), expected[i], (a,b,c,t))
        if s.Poly(s.together(expected[i]*delta),t).degree()>2:
            raise AssertionError('not quadratic')
    # h^5=b^5 modulo t^5, up to the unit denominator.
    equal((a*t+b)**5-b**5*(c*t+1)**5,
          (a**5-b**5*c**5)*t**5, (a,b,c,t))

    # The proof for arbitrary p uses e1,e2 generating the positive
    # jet Lie algebra. These finite checks supplement that proof.
    for prime in (5,7,11,13,17,19):
        for height in range(1,4):
            q = prime**height
            generated = {1,2}
            for n in range(3,q-1):
                i,j = (1,n-1) if (n-2)%prime else (2,n-2)
                if i not in generated or j not in generated or (j-i)%prime==0:
                    raise AssertionError(('Lie generation',prime,height,n))
                generated.add(n)
            if len(generated)!=q-2:
                raise AssertionError('incomplete positive jet algebra')
        equal(cx, X+A*x, prime=prime)
        equal(cy, Y+A**2*y, prime=prime)
        equal((a*t+b)**prime-b**prime*(c*t+1)**prime,
              (a**prime-b**prime*c**prime)*t**prime,
              (a,b,c,t),prime=prime)

    receipt = {
        'status':'PASS',
        'characteristics_checked':[5,7,11,13,17,19],
        'checks':[
            'fourth jet composition: weights1,2 affine cocycles',
            'unipotent central cross term2*x*Y-2*y*X',
            'connection coefficient2*x and Schwarzian6*y',
            'fractional-linear substitutions preserve all3 projective vector fields',
            'truncation condition b^p=0',
            'resonance-safe Lie generation by e1,e2 through e_(p^r-2), r=1,2,3'
        ],
        'scope':'Polynomial identities only; subgroup and actual torsor arguments are in the proof.',
        'source_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    }
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print(json.dumps(receipt,indent=2))


if __name__=='__main__':
    main()
