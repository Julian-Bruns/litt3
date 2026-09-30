"""The q-polynomial product whose factors are all prior proved ratio units.
No new divisor is inverted by this declaration; see REPORT Sections 7, 21.
"""
from ff import Poly,X
from residual import RATIO

def known_q_units():
    a,b,c,e,d=[Poly(RATIO[k]) for k in ('a0','b','c','e','d')]
    dd2=c*c-4*b*e
    dd3=b*b*c*c+a*c**3+b**3*e+3*a*a*e*e+3*a*b*c*e
    return X*b*c*e*d*dd2*dd3*Poly(RATIO['C'])*(X-10149)*(X-64426)
