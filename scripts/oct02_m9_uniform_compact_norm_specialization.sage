#!/usr/bin/env sage
"""NEW nonzero-lambda compact norm: independent 27- and9-algebra comparison."""
import json,time,signal
from pathlib import Path
from itertools import product
started=time.monotonic()
def expired(s,f):raise TimeoutError('new compactnorm specialization hard10s')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,10)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');data=json.loads((folder/'source_e_q3_complete.json').read_text())
R5=PolynomialRing(GF(5),'t');E=GF(5**24,'e',modulus=R5(data['field_modulus']));beta=E(data['beta']);R=PolynomialRing(E,'x');x=R.gen()
def code(c):return E(c%5)+E(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
P=poly([11,22,18,5,19,20,15,16,9,22,1]);A=poly([1,21,14,22,13]);Z=poly([15,19,24,12,10,19,3,24,18,16]);q=poly([13,18,24]);q3=poly([1,22,9,1])
for label in range(1,25):
 lam=code(label);delta=q3+lam*q;K,rem=(Z*delta).quo_rem(P)
 if not delta.is_squarefree() or delta.gcd(P*K*A).degree()!=0:continue
 roots=delta.roots(multiplicities=False)
 if len(set(K(r)**3*P(r) for r in roots))!=3:continue
 break
aroots=A.roots(multiplicities=False);ss=aroots[1:];s0,s1,s2=ss
z1=(x**3-P(s1)).roots(multiplicities=False)[0];z2=(x**3-P(s2)).roots(multiplicities=False)[0]
zz=[E.zero(),z1,z2];ell=[1/prod(ss[i]-ss[j] for j in range(3) if j!=i) for i in range(3)]
Rd=(Z*delta)%P;Rdx=(Z*delta*x)%P;T=(Z**2*delta)%P
c0=vector(E,[Rd(s0)/P(s0),sum(ell[i]*zz[i]*Rd(ss[i])/P(ss[i]) for i in range(3)),Rd[9]])
c1=vector(E,[Rdx(s0)/P(s0),sum(ell[i]*zz[i]*Rdx(ss[i])/P(ss[i]) for i in range(3)),Rdx[9]])
w=c0.cross_product(c1);tt=w[1]*sum(ell[i]*T(ss[i])/P(ss[i]) for i in range(3))
def functional(g):
 h=(Z*g)%P
 return -w[0]*h(s0)/P(s0)-w[1]*sum(ell[i]*zz[i]*h(ss[i])/P(ss[i]) for i in range(3))-w[2]*h[9]
def algebra(cubes):
 indices=list(product(range(3),repeat=len(cubes)));position={idx:i for i,idx in enumerate(indices)}
 def monomial(exponents,c):
  out=[E.zero()]*len(indices);idx=[]
  for n,a in enumerate(exponents):
   quotient,res=divmod(a,3);c*=cubes[n]**quotient;idx.append(res)
  out[position[tuple(idx)]]=c;return vector(E,out)
 def mul(a,b):
  out=vector(E,[0]*len(indices))
  for i,ai in enumerate(a):
   if ai:
    for j,bj in enumerate(b):
     if bj:out+=monomial(tuple(indices[i][n]+indices[j][n] for n in range(len(cubes))),ai*bj)
  return out
 def norm(a):return matrix(E,[mul(a,monomial(idx,E.one())) for idx in indices]).det()
 return monomial,mul,norm
records=[]
for pole in [3,4]:
 vals=[]
 for r0 in roots:
  r1,r2=[r for r in roots if r!=r0];rr=[r0,r1,r2];PP=[P(r) for r in rr];KK=[K(r) for r in rr]
  Li=[prod(x-rr[j] for j in range(3) if j!=i)/prod(rr[i]-rr[j] for j in range(3) if j!=i) for i in range(3)]
  ll=[functional(g) for g in Li]
  if pole==3:
   aa=[2*KK[0]*ll[0],-2*KK[1]*ll[1],-2*KK[2]*ll[2],2*ll[0]*KK[1]*(r2-r0)/(r2-r1),2*ll[0]*KK[2]*(r0-r1)/(r2-r1)]
  else:aa=[-2*KK[0]*ll[0],2*KK[1]*ll[1],2*KK[2]*ll[2],2*KK[0]*ll[1],2*KK[0]*ll[2]]
  mon,mul,norm=algebra(PP)
  det=mon((0,0,0),tt)+mon((2,0,0),aa[0])+mon((0,2,0),aa[1])+mon((0,0,2),aa[2])+mon((1,1,0),aa[3])+mon((1,0,1),aa[4])
  direct=norm(det)
  mon9,mul9,norm9=algebra([PP[1]/PP[0],PP[2]/PP[0]])
  Q=mon9((0,0),aa[0])+mon9((2,0),aa[1])+mon9((0,2),aa[2])+mon9((1,0),aa[3])+mon9((0,1),aa[4])
  compressed=norm9(mon9((0,0),tt**3)+PP[0]**2*mul9(mul9(Q,Q),Q))
  assert direct==compressed
  vals.append(direct)
 records.append({'root_pole':pole,'root_norm':[[int(c) for c in v.polynomial().list()] for v in vals],'cover81_norm':[int(c) for c in prod(vals).polynomial().list()],'all_27_vs9_equal':True})
out={'scope':'One NEW nonzero ordinary lambda specialization, one omission/pair; exact27x27 determinant compared to global-C3 compressed9x9 determinant for each of3 critical roots and both root profiles. No uniform norm polynomial or source decision.','lambda_code':label,'records':records,'seconds':time.monotonic()-started,'field_modulus':data['field_modulus'],'beta':data['beta'],'sage_version':version()}
(folder/'compact_norm_new_specialization.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
print('NEWcompactnorm lambda',label,'27vs9 PASS bothprofiles','seconds',out['seconds'],flush=True)
signal.setitimer(signal.ITIMER_REAL,0)
