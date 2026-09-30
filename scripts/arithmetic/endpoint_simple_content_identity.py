#!/usr/bin/env python3
"""Universal characteristic-five endpoint-content identity (not a fixture).

Requires SymPy. All seven variables are independent. No curve coefficients
or geometric parameter specializations are used. Output goes to stdout.
"""
from sympy import Poly, expand, symbols


def verify():
    tau, a, b, c, d, m, ell = symbols('tau a b c d m ell')
    variables = (tau, a, b, c, d, m, ell)

    def cut(expr):
        p = Poly(expand(expr), *variables, modulus=5)
        return sum(int(co) * tau**ex[0] * a**ex[1] * b**ex[2]
                   * c**ex[3] * d**ex[4] * m**ex[5] * ell**ex[6]
                   for ex, co in p.terms() if ex[0] <= 5)

    cc = tau*c
    q = tau**3*m
    # Md+N=tau^2 ell. No unit assumption on a or c.
    k = -tau**3*m*d + tau**5*ell
    delta = b*b+a*cc
    j = b**3-a*b*cc+2*a*a*d
    aa = cc**5-b**5*q+a**5*q*q
    kk = a**3*q*j-d*b**5-2*cc*cc*delta*delta+a*b*b*cc**3
    ss = 2*b*b*cc*cc+a*cc**3+d*j-a*a*d*d
    ee = -b**5+2*a**5*q
    coeffs = [a**3*(aa*ss+k*(ee*j-a*a*kk))+a**10*k*k,
              aa*kk+k*(ee*ee-2*a**5*aa), aa*aa]
    jnum = b**5*ell-d*c**5+2*m*b**4*c**2
    expected = [tau**5*jnum*(-a**3*b**3-a**5*d),
                tau**5*jnum*b**5, 0]
    for i, (expr, want) in enumerate(zip(coeffs, expected)):
        assert Poly(expand(cut(expr)-want), *variables, modulus=5).is_zero
        print(f'PASS exact scale coefficient {i} modulo tau^6')
    print('PASS universal content numerator J=b^5*ell-d*c^5+2*m*b^4*c^2')
    print('Proof for varying DVR coefficients uses the small critical root;')
    print('this identity is an exact symbolic cross-check, not a parameter search.')


if __name__ == '__main__':
    verify()
