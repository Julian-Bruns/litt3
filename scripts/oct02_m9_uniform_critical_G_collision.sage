#!/usr/bin/env sage
"""NEW exact distinct-critical G collision support, hard10s onecore."""
import json,time,signal
from pathlib import Path
from itertools import permutations
started=time.monotonic();signal.signal(signal.SIGALRM,lambda s,f:(_ for _ in ()).throw(TimeoutError('G collision support hard10s')));signal.setitimer(signal.ITIMER_REAL,10)
E=GF(25,'b',modulus=PolynomialRing(GF(5),'t')([2,4,1]));b=E.gen();R=PolynomialRing(E,'x');x=R.gen()
def code(c):return E(c%5)+E(c//5)*b
def poly(cs):return R([code(c) for c in cs])
P=poly([11,22,18,5,19,20,15,16,9,22,1]);Z=poly([15,19,24,12,10,19,3,24,18,16]);A=poly([1,21,14,22,13]);q=poly([13,18,24]);q3=poly([1,22,9,1]);L=PolynomialRing(E,'lam');lam=L.gen();S=PolynomialRing(L,'xx');xx=S.gen();delta=S(q3)+lam*S(q);K=(S(Z)*delta).quo_rem(S(P))[0]
def mult(g):
 cols=[xx**j*g%delta for j in range(3)];return matrix(L,[[cols[j][i] for j in range(3)] for i in range(3)])
def det(M):return sum(((-1)**sum(p[i]>p[j] for i in range(3) for j in range(i+1,3))*prod(M[i,p[i]] for i in range(3)) for p in permutations(range(3))),L.zero())
M=mult(K**3*S(P));tr=M.trace();c2=sum(M[i,i]*M[j,j]-M[i,j]*M[j,i] for i in range(3) for j in range(i+1,3));dd=det(M)
DG=tr**2*c2**2-4*c2**3-4*tr**3*dd-27*dd**2+18*tr*c2*dd
Ddelta=-det(mult(delta.derivative()));collision,rem=DG.quo_rem(Ddelta);assert not rem and collision
factors=list(collision.factor());rad=prod(f for f,m in factors)
boundaries={'critical_discriminant':Ddelta,'branch':det(mult(S(P))),'Kzero':det(mult(K)),'selected_critical':det(mult(S(A)))}
def encode(g):return [[int(c) for c in v.polynomial().list()] for v in g.list()]
out={'scope':'Distinct critical roots with equal K^3P values force the residual G-discriminant support. No source or marked phase realization claimed. Critical-repeat factor removed exactly.','G_discriminant_degree':int(DG.degree()),'critical_discriminant_degree':int(Ddelta.degree()),'collision_degree':int(collision.degree()),'radical_degree':int(rad.degree()),'collision_polynomial':encode(collision),'factors':[{'degree':int(f.degree()),'multiplicity':int(m),'polynomial':encode(f)} for f,m in factors],'boundary_gcd_degrees':{key:int(rad.gcd(g).degree()) for key,g in boundaries.items()},'seconds':time.monotonic()-started}
Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform/critical_G_collision_support.json').write_text(json.dumps(out,indent=2)+'\n');print('Gcollision degrees',DG.degree(),collision.degree(),rad.degree(),'factors',[(f.degree(),m) for f,m in factors],'boundarygcds',out['boundary_gcd_degrees'],'seconds',out['seconds'],flush=True);signal.setitimer(signal.ITIMER_REAL,0)
