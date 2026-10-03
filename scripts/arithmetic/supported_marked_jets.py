#!/usr/bin/env python3
"""Marked cubic-curve jets over F_(5^8), without support enumeration.

All columns of character j are divided by the same y0^j. The actual
marked points lie in F_(5^24); rank over the geometric coefficient field
is preserved by this nonzero column scaling.
"""
from math import comb
from sage.all import GF, PolynomialRing

def compositions(n,r):
    if r==1:yield (n,);return
    for i in range(n+1):
        for tail in compositions(n-i,r-1):yield (i,)+tail

def field_and_jets(pole, characters=(0,1,2)):
    K=GF(5**8,'z');R=PolynomialRing(K,'x');x=R.gen()
    beta=(x*x-x-3).roots(multiplicities=False)[0]
    dec=lambda c:K(c%5)+K(c//5)*beta
    alpha=(x**4+dec(7)*x**3+dec(6)*x*x+dec(2)*x+dec(5)).roots(multiplicities=False)[0]
    P=R([dec(c) for c in [11,22,18,5,19,20,15,16,9,22,1]])
    roots=[alpha**(25**i) for i in range(4)];p0=P(alpha);zeta=dec(11)
    columns=[(i,j) for j in characters for i in range(max(-1,(pole-10*j)//3)+1)]
    jets=[]
    for aindex,a in enumerate(roots):
        pn=[sum((P[i]*comb(i,n)*a**(i-n) for i in range(n,11)),K(0)) for n in range(pole+1)]
        Y=[p0**((25**aindex-1)//3)]+[K(0)]*pole
        assert p0*Y[0]**3==P(a)
        for n in range(1,pole+1):
            old=sum((Y[i]*Y[j]*Y[n-i-j] for i in range(n+1) for j in range(n+1-i)),K(0))
            Y[n]=(pn[n]/p0-old)/(3*Y[0]**2)
        YY=[sum((Y[i]*Y[n-i] for i in range(n+1)),K(0)) for n in range(pole+1)]
        chars=[[K(1)]+[K(0)]*pole,Y,YY]
        phases=[]
        for phase in range(3):
            rows=[]
            for n in range(pole+1):
                rows.append([zeta**(phase*j)*sum((K(comb(i,k))*a**(i-k)*chars[j][n-k]
                     for k in range(min(i,n)+1)),K(0)) for i,j in columns])
            phases.append(rows)
        jets.append(phases)
    code=lambda a:sum(int(c)*5**i for i,c in enumerate(K(a).polynomial().list()))
    return K,columns,jets,dict(modulus=[int(c) for c in K.modulus()],beta=code(beta),
        alpha=code(alpha),p0=code(p0),zeta=code(zeta)),code
