#!/usr/bin/env python3
"""Characteristic-five identities for the first Newton layers of a square root.
No coefficients from numerical validation fibers are used in these identities.
"""
from __future__ import annotations
import argparse, json, math
from pathlib import Path
import sympy as sp

def main() -> None:
    ap=argparse.ArgumentParser();ap.add_argument('output',type=Path);args=ap.parse_args()
    a,b,k,l,s=sp.symbols('a b k l s')
    def zero(p):
        assert sp.Poly(sp.expand(p),a,b,k,l,s,modulus=5).is_zero
    # For s-degree < 25, the formal square root of 1+u is (1+u)^13.
    j18=sum(math.comb(13,i)*math.comb(13,18-i)*a**i*b**(18-i)
            for i in range(5,14))
    zero(j18-2*a**5*b**5*(a+b)**6*(a-b)**2)
    # The anti-diagonal a+b=0 is retained: its degree-20 term is nonzero.
    assert math.comb(13,10)%5==1
    # When a=b, compare epsilon^2 in the exact square-root expansion.
    # Phi1=(k+l)(1+as), Phi2=L(1+as)/s+kl.
    # After subtracting the square of the first correction the remaining
    # numerator is -(k-l)^2/4 = (k-l)^2 in characteristic five.
    zero(k*l-4*(k+l)**2-(k-l)**2)
    # At x-reversal degree 74 and scale degree 55 this is s^17.
    zero(3*(k-l)**2*(-a)**17-2*a**17*(k-l)**2)
    # Universal cubic norm: coefficient lambda^2 xi^9 is 3 gamma^2 beta
    # when the coefficient lambda xi^5 vanishes. Verify phases over F25.
    def plus(x,y):return ((x%5+y%5)%5)+5*((x//5+y//5)%5)
    def times(x,y):
        a0,a1=x%5,x//5;b0,b1=y%5,y//5
        return (a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5)
    def power(x,n):
        v=1
        for _ in range(n):v=times(v,x)
        return v
    zeta=11
    assert power(zeta,3)==1 and zeta!=1
    phases=0
    for i in range(3):
        j,k0=[j for j in range(3) if j!=i]
        phases=plus(phases,power(zeta,4*j+4*k0+i))
    assert phases==3
    result={
      'status':'passed','characteristic':5,'sympy_version':sp.__version__,
      'universal_formulas':{
        'j72_scale54':'2*a^5*b^5*(a+b)^6*(a-b)^2',
        'j80_scale60_on_b_minus_a':'a^20',
        'j74_scale55_on_b_a':'2*a^17*(k_big-k_small)^2',
        'cubic_norm_lambda2_T3':'3*gamma^2*beta'},
      'scope':'universal coefficient identities; the application to the complete residual also uses the critical-value expansion proof in REPORT.md'
    }
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2,sort_keys=True)+'\n')
    print('PASS four universal characteristic-five Newton-edge identities')
if __name__=='__main__':main()
