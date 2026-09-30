"""Exact top-weight coefficients and the now-controlled monic scale equation.
No division by an unproved slope is used by top_coefficients itself.
"""
from ff import mul, power, div
from residual import peval, RATIO
from reconstruct import epsilon

GAMMA = mul(2,power(epsilon,6))
DELTA = power(24,6)
S_CUBE = div(DELTA,GAMMA)


def top_coefficients(q,u):
    """Return A,B,D with top a(T)=1+A*mu^3*T^4+B*mu^6*T^8.
    D=A^2+B. All denominators are original chart units.
    """
    a0,b,c,e,d=[peval(RATIO[k],q) for k in ['a0','b','c','e','d']]
    V=a0*u**3+b*u*u+c*u+e
    aa=q**7*(GAMMA*u**-9+DELTA*d**3*V**-3)
    bb=q**14*GAMMA*DELTA*d**3*u**-9*V**-3
    return aa,bb,aa*aa+bb


def c72_leading(q,u):
    aa,bb,dd=top_coefficients(q,u)
    return 2*aa**6*bb**5*dd
