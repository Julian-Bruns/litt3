#!/usr/bin/env python3
"""Independent exact checker: GF(5) coordinates, not the field code in endpoint_probe.
Verifies the universal truncated identities in GF(5)[beta,alpha,d,e,t]/
(beta^2-beta-3, alpha^4+beta+2alpha+(1+beta)alpha^2+(2+beta)alpha^3, t^6).
All d,e coefficients are retained symbolically; this is not point sampling.
"""
import json
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
N=5

def reduce_base(a,b):
 """Reduce alpha^a beta^b, using integral GF(5) coefficients."""
 todo={(a,b):1};out={}
 while todo:
  (i,j),c=todo.popitem();c%=5
  if not c:continue
  if j>=2:
   for key,m in [((i,j-1),1),((i,j-2),3)]:
    todo[key]=(todo.get(key,0)+c*m)%5
  elif i>=4:
   # alpha^4=-beta-2alpha-(1+beta)alpha^2-(2+beta)alpha^3
   for da,db,m in [(0,1,4),(1,0,3),(2,0,4),(2,1,4),(3,0,3),(3,1,4)]:
    key=(i-4+da,j+db);todo[key]=(todo.get(key,0)+c*m)%5
  else:
   key=2*i+j;out[key]=(out.get(key,0)+c)%5
 return tuple(out.get(i,0) for i in range(8))
TAB=[[reduce_base(i//2+j//2,i%2+j%2) for j in range(8)] for i in range(8)]
BZERO=(0,)*8
BONE=(1,)+(0,)*7

def badd(a,b):return tuple((x+y)%5 for x,y in zip(a,b))
def bneg(a):return tuple(-x%5 for x in a)
def bmul(a,b):
 r=[0]*8
 for i,x in enumerate(a):
  if x:
   for j,y in enumerate(b):
    if y:
     xy=x*y
     for k,z in enumerate(TAB[i][j]):
      if z:r[k]+=xy*z
 return tuple(x%5 for x in r)
def bpow(a,n):
 r=BONE
 while n:
  if n&1:r=bmul(r,a)
  a=bmul(a,a);n//=2
 return r

def codes(row):
 out=[0]*8
 for i,x in enumerate(row):out[2*i]=x%5;out[2*i+1]=x//5
 return tuple(out)

class R:
 # Keys are (d exponent,e exponent,t exponent).
 def __init__(self,p):self.p={m:c for m,c in p.items() if any(c) and m[2]<=N}
 @staticmethod
 def const(c):return R({(0,0,0):c})
 def __add__(self,b):
  out=self.p.copy()
  for m,c in b.p.items():out[m]=badd(out.get(m,BZERO),c)
  return R(out)
 def __neg__(self):return R({m:bneg(c) for m,c in self.p.items()})
 def __sub__(self,b):return self+-b
 def __mul__(self,b):
  out={}
  for m,a in self.p.items():
   for n,c in b.p.items():
    key=tuple(x+y for x,y in zip(m,n))
    if key[2]>N:continue
    out[key]=badd(out.get(key,BZERO),bmul(a,c))
  return R(out)
 def __pow__(self,n):
  a=self;r=R.const(BONE)
  while n:
   if n&1:r=r*a
   a=a*a;n//=2
  return r
 def dt(self):
  out={}
  for (d,e,t),c in self.p.items():
   if t and t%5:out[(d,e,t-1)]=tuple(x*t%5 for x in c)
  return R(out)
 def trunc(self,n):return R({m:c for m,c in self.p.items() if m[2]<=n})

def k(n):return R.const(codes([n]))
T=R({(0,0,1):BONE}); EE=R({(0,1,0):BONE})
def ev(row,x):
 r=k(0)
 for a in reversed(row):r=r*x+k(a)
 return r

def loadseries(data):
 out={}
 for t,row in enumerate(data):
  for d,e,coeff in row:out[(d,e,t)]=codes(coeff)
 return R(out)

def require_zero(r,label):
 if r.p:raise AssertionError((label,r.p))
 print('PASS:',label)

def main():
 data=json.loads((ROOT/'evidence'/'endpoint_series.json').read_text())
 assert data['N']==4
 Z=loadseries(data['z']);U=loadseries(data['u'])
 P=[11,22,18,5,19,20,15,16,9,22,1];A=[1,21,14,22,13]
 # B is checked against the defining equation, not trusted as a lookup.
 alpha=R.const(codes([0,1]));BB=R.const(codes(data['B']))
 # Compute derivatives in GF(5) instead of relying on the row above.
 def diffrow(row):
  return [((i*(x%5))%5)+5*((i*(x//5))%5) for i,x in enumerate(row)][1:]
 ap=ev(diffrow(A),alpha);pp=ev(P,alpha)
 require_zero(BB**29*k(13)**3-k(3)*pp**2*ap**3,'B^29 * ell^3 = 3 P(alpha)^2 A\'(alpha)^3')
 require_zero(ev(A,alpha),'A(alpha)=0')
 rhs=k(0)
 for m in range(5):rhs=rhs+k(A[m])*EE**(4-m)*T**(13-3*m)*Z**m
 require_zero(ev(A,U)-rhs,'A(U)=sum A_m e^(4-m)t^(13-3m)Z^m modulo t^6, universally in d,e')
 ph=k(0)
 for m in range(11):ph=ph+k(P[m])*EE**(10-m)*T**(30-3*m)*Z**m
 H=(T*Z.dt()-k(3)*Z)**3*ev(P,U)**2-ph**2*U.dt()**3
 require_zero(H.trunc(4),'normalized differential equation modulo t^5, universally in d,e')
 # Independence of the only free low-order jet.
 assert not any(d and t==4 for d,e,t in Z.p)
 assert Z.p[(0,0,4)]==codes([20,12,13,8])
 assert Z.p[(0,1,4)]==codes([21,21,20,2])
 print('PASS: Z_4 has no d-dependence and has the recorded two coefficients')
 def mean(a):
  out=BZERO
  for q in (1,25,625,15625):out=badd(out,bpow(a,q))
  return tuple(4*x%5 for x in out)
 assert mean(codes([20,12,13,8]))==codes([12])
 assert mean(codes([21,21,20,2]))==codes([4])
 print('PASS: mean of Z_4 is [12]+4e')
 # Triangular coefficients are nonzero at orders 1,3,4, zero at order 2.
 h0overb=bmul(codes([3]),bmul(bpow(codes(data['B']),2),bpow(ev(P,alpha).p[(0,0,0)],2)))
 assert h0overb==codes([19,4,21,9])
 assert [((2*n+1)%5) for n in range(1,5)]==[3,0,2,4]
 print('PASS: triangular multiplier H0/B=[19,4,21,9], factors 3,0,2,4')
 print('Independent GF(5)-coordinate verification: ALL CHECKS PASSED')

if __name__=='__main__':main()
