#!/usr/bin/env sage
"""NEW bounded geometric N32 jet test at the existing F125 parameter."""
from sage.all import *
import json, time
started=time.monotonic()
U=PolynomialRing(GF(5),'a'); aa=U.gen()
k=GF(125,'alpha',modulus=aa**3+aa+1)
B=PolynomialRing(k,'x'); x=B.gen()
Z=PolynomialRing(B,'z'); z=Z.gen()
F=x*(x-1)*(x-2)*(x-3)*(x-k.gen())
ff=(x+z)*(x+z-1)*(x+z-2)*(x+z-3)*(x+z-k.gen())
fc=ff.list(); A=[B(1)]
for n in range(1,32):
    rhs=fc[n]*F**(n-1) if n<len(fc) else B(0)
    A.append((rhs-sum(A[j]*A[n-j] for j in range(1,n)))/k(2))
    assert 2*A[n]+sum(A[j]*A[n-j] for j in range(1,n))==rhs
J=[[A[n-i] for i in range(14)] for n in range(17,32)]
def det(rows):
    M=[r[:] for r in rows]; previous=B(1); sign=1
    for p in range(13):
        if not M[p][p]:
            q=next(q for q in range(p+1,14) if M[q][p])
            M[p],M[q]=M[q],M[p]; sign=-sign
        pivot=M[p][p]
        for r in range(p+1,14):
            for c in range(p+1,14):
                numerator=pivot*M[r][c]-M[r][p]*M[p][c]
                value,remainder=numerator.quo_rem(previous)
                assert not remainder
                M[r][c]=value
            M[r][p]=B(0)
        previous=pivot
    return sign*M[13][13]
h1=det(J[:14]); print('FIRST_MINOR',h1.degree(),time.monotonic()-started,flush=True)
h2=det(J[1:]); print('SECOND_MINOR',h2.degree(),time.monotonic()-started,flush=True)
g,u,v=h1.xgcd(h2)
assert u*h1+v*h2==g
branch=g.gcd(F)
residual=g
while residual.degree()>0:
    part=residual.gcd(F)
    if part.degree()==0: break
    residual=residual//part
def coeff(poly):
    return [[int(c) for c in el.polynomial().list()]+[0]*(3-len(el.polynomial().list())) for el in poly.list()]
record={'test':'N32 geometric Hasse maximal-minor sufficient certificate',
        'modulus':[1,1,0,1],'matrix_rows':list(range(17,32)),
        'matrix_columns':list(range(14)),'minor_deleted_rows':[31,17],
        'minor_degrees':[int(h1.degree()),int(h2.degree())],
        'gcd_degree':int(g.degree()),'branch_gcd_degree':int(branch.degree()),
        'branch_saturated_gcd_degree':int(residual.degree()),
        'status':'PASS' if residual.degree()==0 else 'UNRESOLVED',
        'h1':coeff(h1),'h2':coeff(h2),'gcd':coeff(g),
        'bezout_u':coeff(u),'bezout_v':coeff(v),
        'elapsed_seconds':time.monotonic()-started}
path='../litt3-computation-data/oct02_reciprocal_torsion32_specialization.json'
with open(path,'w') as out: json.dump(record,out,separators=(',',':'),default=int)
print(json.dumps({key:value for key,value in record.items() if key not in ['h1','h2','gcd','bezout_u','bezout_v']},default=int),flush=True)
