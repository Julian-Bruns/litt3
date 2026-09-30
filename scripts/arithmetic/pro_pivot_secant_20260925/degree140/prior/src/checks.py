"""Independent checks against original congruences and fixed-degree Sylvester matrices."""
import math,random
import numpy as np
import exact as E
from atlas import fixed_data
from residual import div_y_power,resultant_coeffs,norm_lambda
from necessary_curve import sylvester

def pole(g):
 values=[3*i+10*j for j,p in enumerate(g) for i,c in enumerate(p) if c]
 return max(values) if values else -10**9

def check_original_atlas(a):
 P,A,Q,B,L,t,Ct=fixed_data();F=E.F;v=E.poly([1]) if a['root'] is None else E.poly([F.N(a['root']),1])
 eps=F.A(F.A(24,F.M(4,25)),F.M(23,F.P(25,3)))
 Cd=F.A(F.A(F.A(3,F.M(10,25)),F.P(25,2)),F.M(14,F.P(25,3)))
 Ca=F.A(F.A(F.A(18,F.M(14,25)),F.M(10,F.P(25,2))),F.M(19,F.P(25,3)))
 T=(E.poly(),E.mul(E.power(t,3),E.power(P,3)),E.poly())
 for col,raw in enumerate(a['data']):
  H=[tuple(E.poly(p) for p in g) for g in raw];kappa=int(col==0)
  N=[E.czero() for _ in range(11)];N[0]=(v,E.poly(),E.poly()) if col==0 else E.czero();N[2:6]=H
  if col==0:N[5]=E.cadd(N[5],(E.mul(v,Q),E.poly(),E.poly()))
  for i in range(6):assert pole(N[i])<=10+12*i
  for j in range(1,6):
   G=E.czero()
   for i in range(j+1):G=E.cadd(G,E.cpoly(N[i],E.scale(E.power(E.neg(B),j-i),math.comb(5-i,j-i)%5)))
   div_y_power(G,j,P) # exact division is the congruence test
  q0=E.sub(Q,E.power(L,5))
  for j in range(5):
   G=E.czero()
   for i in range(6-j):G=E.cadd(G,E.cpoly(N[i],E.scale(E.power(E.neg(L),5-i-j),math.comb(5-i,j)%5)))
   G=E.cpoly(G,q0)
   if j==0:G=E.cadd(G,E.cscale(T,kappa))
   assert all(not len(E.rem(p,E.power(t,5-j))) for p in G)
  for j in range(11):
   G=N[j]
   if j>=5:G=E.cadd(G,E.cpoly(N[j-5],Q))
   if j==10:G=E.cadd(G,E.cscale(T,kappa))
   assert pole(G)<=10+12*j-max(0,j-5)
  D2=div_y_power(H[0],2,P)
  assert pole(D2)<=12+(a['root'] is not None)
  if a['root'] is not None:assert int(E.evaluate(D2[0],a['root']))==0
  topa=E.coeff(D2,4,0) if a['root'] is None else E.coeff(D2,1,1)
  assert topa==int(col==1)
  assert E.coeff(H[2],19,0)==int(col==2)
  assert E.coeff(H[2],12,2)==int(col==3)
  assert E.coeff(H[3],16,2)==int(col==4)
  assert E.coeff(H[1],12,1)==(eps if col==0 else 0)
  assert E.coeff(H[1],15,0)==(Cd if col==2 else (Ca if col==1 and a['root'] is not None else 0))
 return True

def scalar_resultant_checks(count=160,seed=140):
 rng=random.Random(seed);F=E.F;P=E.poly([2,1,1]) # irrelevant for scalar curve elements
 for trial in range(count):
  a,b,c,h,Q,T,lam,v=[rng.randrange(E.SIZE) for _ in range(8)]
  if trial%4==0:a=0
  if trial%7==0:b=0
  if trial%11==0:lam=0
  if trial%13==0:c=0
  if trial%17==0:v=0
  H=[(E.poly([F.M(2,a)]),E.poly(),E.poly()),(E.poly([F.M(3,b)]),E.poly(),E.poly()),(E.poly([c]),E.poly(),E.poly()),(E.poly([h]),E.poly(),E.poly())]
  qc=(E.poly([Q]),E.poly(),E.poly());tc=(E.poly([T]),E.poly(),E.poly());rs=resultant_coeffs(H,qc,tc,P,E.poly([v]))
  got=0
  for r in rs[::-1]:got=F.A(F.M(got,lam),int(r[0][0]) if len(r[0]) else 0)
  U=E.poly([Q,0,0,0,0,1]);S=E.poly([h,c,F.M(3,b),F.M(2,a)])
  f=E.add(E.add(E.scale(E.power(U,2),F.M(lam,v)),E.mul(U,S)),E.poly([T]))
  d=E.poly([c,b,a]);want=sylvester(f,d,10,2)
  assert got==want,(trial,got,want)
 return count

def infinity_certificate(H,root,R):
 F=E.F;P,A,Q,B,L,t,Ct=fixed_data();v=E.poly([1]) if root is None else E.poly([F.N(root),1])
 aa=E.cscale(H[0],3);bb=E.cscale(H[1],2);cc=H[2]
 E0=E.cadd(E.csub(E.cpoly(E.cpow(aa,5,P),E.power(Q,2)),E.cpoly(E.cpow(bb,5,P),Q)),E.cpow(cc,5,P))
 n=norm_lambda([E0],P)[0];assert len(n)-1==287
 S=E.exactdiv(E.mul(v,n),E.mul(E.power(P,20),E.power(t,8)))
 assert len(S)-1==(63 if root is None else 64)
 assert not len(E.sub(R[6],E.mul(E.mul(t,v),E.power(S,2))))
 return {'root':root,'degree_norm_E0':287,'S':S.tolist(),'formula':'R_lambda6=t*v*S^2','degree_S':len(S)-1}
