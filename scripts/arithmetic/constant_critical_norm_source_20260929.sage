#!/usr/bin/env sage
"""Transfer the new critical-norm test to the accepted constant source.

Reads its previously certified exact ratio-source coefficients. No source
family verification is repeated, and no square exclusion is presumed.
"""
import json,sys
from pathlib import Path
source=Path(sys.argv[1]);out=Path(sys.argv[2]);(out/'descent').mkdir(parents=True,exist_ok=True)
K=GF(5**8,name='a',modulus=[2,2,4,2,0,0,1,0,1]);a=K.gen()
beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def elt(c):
 z=K(0)
 for i in range(4):
  digit=c%25;c//=25;z+=(digit%5+(digit//5)*beta)*a**i
 return z
R=PolynomialRing(K,('H','q'),order='degrevlex');H,q=R.gens();F=R.fraction_field();RX=PolynomialRing(F,'x');x=RX.gen()
P=RX([elt(c) for c in [11,22,18,5,19,20,15,16,9,22,1]])
G=[]
for row in json.load(open(source))['G']:
 g=[RX(0) for _ in range(3)]
 for i,j,h,k,c in row:g[j]+=elt(c)*F(H)**h*F(q)**k*x**i
 G.append(g)
def mul(a,b):
 c=[RX(0) for _ in range(3)]
 for i in range(3):
  for j in range(3):c[(i+j)%3]+=a[i]*b[j]*(P/q if i+j>=3 else 1)
 return c
g11=mul(G[1],G[1]);g02=mul(G[0],G[2]);delta=[]
for v,w in zip(g11,g02):
 qq,rem=(4*v+3*w).quo_rem(P**2);assert not rem;delta.append(qq*q**2)
B=delta[2][4];assert B and B.numerator().degree(H)==0 and B.denominator().degree(H)==0
delta=[p/B for p in delta];assert delta[2][4]==1
save({'delta_normalized':delta,'P':P,'B':F(1),'removed_scalar':B},str(out/'descent'/'normalized.sobj'))
print('CONSTANT_CRITICAL_SOURCE',[(p.degree(),max(c.numerator().degree(H) for c in p),max(c.numerator().degree(q) for c in p)) for p in delta], 'normalized_by',B,flush=True)
