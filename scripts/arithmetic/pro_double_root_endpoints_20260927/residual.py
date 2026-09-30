"""Reconstruct the actual residual with the cube-root parameter removed.
Use V=y/w, V^3=P/q, G_i=w*g_i.  Then Rcal=q^25*Norm(resultant_bar)/(P^40*t^15*v^3).
All operations are exact.  The resultant formula is polynomial in the
coefficients and thus retains every fixed-degree specialization.
"""
from exact import ROOT,DATA,t as t_codes,epsilon as eps_code,code
from extension import E,Poly,init
import json,time

class Curve:
 __slots__=('c',)
 Pbar=None
 def __init__(self,obj=0):
  if isinstance(obj,Curve):self.c=obj.c
  elif isinstance(obj,(int,E,Poly)):self.c=(obj if isinstance(obj,Poly) else Poly(obj),Poly(),Poly())
  else:self.c=tuple(v if isinstance(v,Poly) else Poly(v) for v in obj)
  assert len(self.c)==3
 def __bool__(self):return any(self.c)
 def __add__(self,other):
  other=Curve(other);return Curve([a+b for a,b in zip(self.c,other.c)])
 __radd__=__add__
 def __neg__(self):return Curve([-a for a in self.c])
 def __sub__(self,other):return self+-Curve(other)
 def __rsub__(self,other):return Curve(other)+-self
 def __mul__(self,other):
  if not isinstance(other,Curve):return Curve([a*other for a in self.c])
  z=[Poly(),Poly(),Poly()]
  for i in range(3):
   for j in range(3):
    x=self.c[i]*other.c[j];k=i+j
    if k>=3:x=x*self.Pbar;k-=3
    z[k]=z[k]+x
  return Curve(z)
 __rmul__=__mul__
 def __pow__(self,n):
  if n==5:return Curve([self.c[0].frob(),self.c[2].frob()*(self.Pbar**3),self.c[1].frob()*self.Pbar])
  a=self;b=Curve(1)
  while n:
   if n&1:b=b*a
   a=a*a;n//=2
  return b
 def __eq__(self,other):return not (self-Curve(other))


def resultant_coefficients(a,b,c,g,Q,T,v):
 """Return coefficients of mu^0,mu^1,mu^2; a=3G2,b=2G3,c=G4,g=G5."""
 a2=a*a;a3=a2*a;a4=a2*a2;a5=a**5
 b2=b*b;b3=b2*b;b4=b2*b2;b5=b**5
 c2=c*c;c3=c2*c;c4=c2*c2;c5=c**5
 D=b2+a*c
 N=a5*(Q*Q)-b5*Q+c5
 M=a2*g*g+b*g*(b2-a*c)+c2*(2*b2+a*c)
 V=2*a5*Q*g+a3*b3*Q-a4*b*c*Q-b5*g+3*b4*c2+2*a*b2*c3+3*a2*c4
 K2=b5*b5+3*a5*(c5+b5*Q)+2*a5*a5*(Q*Q)
 C0=a3*N*M+T*(a5*V-a3*(D**4))+(a5*a5)*(T*T)
 C1=(N*V+T*K2)*v
 C2=(N*N)*(v*v)
 return [C0,C1,C2]


def bp_add(a,b):return [(a[i] if i<len(a) else Poly())+(b[i] if i<len(b) else Poly()) for i in range(max(len(a),len(b)))]
def bp_neg(a):return [-v for v in a]
def bp_mul(a,b):
 if not a or not b:return []
 out=[Poly() for _ in range(len(a)+len(b)-1)]
 for i,v in enumerate(a):
  if v:
   for j,w in enumerate(b):
    if w:out[i+j]=out[i+j]+v*w
 return out

def bp_pow(a,n):
 b=[Poly(1)]
 while n:
  if n&1:b=bp_mul(a,b)
  a=bp_mul(a,a);n//=2
 return b

def bp_scale(a,s):return [v*s for v in a]


def source_reduced(q,u):
 """The exact coefficients of G_i/w, in V=y/w, requiring only q,u."""
 source=json.loads((ROOT/'evidence/cramer_source.json').read_text())
 d=Poly(DATA['d']).eval(q);assert q and d and u
 G={}
 for n,rows in source['G'].items():
  parts=[{} for _ in range(3)]
  for i,j,terms in rows:
   v=E(0)
   for ih,iw,ik1,ik2,a in terms:
    assert ik1==ik2==0
    ew=iw-2*ih-1+j;assert ew%3==0
    v=v+E(a)*(u**ih)*(q**(ew//3))
   parts[j][i]=v/d
  G[int(n)]=Curve([Poly([p.get(i,E(0)) for i in range(max(p,default=-1)+1)]) for p in parts])
 return G


def make_residual(q,u,verbose=False):
 start=time.time();P=Poly(DATA['P']);Q=Poly(DATA['Q']);t=Poly(t_codes);v=Poly([-E(DATA['r']),1])
 Curve.Pbar=P/q
 G=source_reduced(q,u)
 T=Curve([Poly(),(t**3)*(P**3),Poly()])
 res=resultant_coefficients(3*G[2],2*G[3],G[4],G[5],Curve(Q),T,v)
 a,b,c=[[F.c[j] for F in res] for j in range(3)]
 norm=bp_add(bp_add(bp_pow(a,3),bp_scale(bp_pow(b,3),Curve.Pbar)),bp_scale(bp_pow(c,3),Curve.Pbar**2))
 norm=bp_add(norm,bp_scale(bp_mul(bp_mul(a,b),c),(-3%5)*Curve.Pbar))
 denominator=(P**40)*(t**15)*(v**3)
 R=[(p/denominator)*(q**25) for p in norm]
 degs=[p.degree() for p in R]
 d=Poly(DATA['d']).eval(q)
 F=sum((Poly(DATA[z]).eval(q)*(u**p) for z,p in [('a0',3),('b',2),('c',1),('e',0)]),E(0))
 L=(E(3)*(E(eps_code)**8))**3*q*(u**9)*(F**3)/(d**3)
 assert F and L and degs[0]==140 and R[0][140]==L
 assert all(n<140 for n in degs[1:])
 if verbose:print('actual residual x-degrees by scale:',degs,'seconds',round(time.time()-start,3),flush=True)
 return R


def sm(a,b,N):
 out=[Poly() for _ in range(N)]
 for i,v in enumerate(a[:N]):
  if v:
   for j,w in enumerate(b[:N-i]):
    if w:out[i+j]=out[i+j]+v*w
 return out

def sf(a,k,N):
 m=5**k;out=[Poly() for _ in range(N)]
 for i,v in enumerate(a):
  if i*m>=N:break
  out[i*m]=v.frob(k)
 return out


def square_equations(R,full=True,verbose=False):
 start=time.time();N=125 if full else 73
 A=[Poly([p[140-i] for p in R]) for i in range(141)]
 A2=sm(A,A,N);A3=sm(A2,A,N)
 C=sm(sm(A3,sf(A2,1,N),N),sf(A2,2,N),N)
 if full:
  B2=sm(C[:71],C[:71],141);L=A[0][0]
  out=C[71:125]+[B2[i]-A[i]*(L**125) for i in range(125,141)]
 else:out=C[71:73]
 if verbose:print('square equations degrees in scale:',[p.degree() for p in out],'seconds',round(time.time()-start,3),flush=True)
 return out


def sylvester_det(f,g):
 # Both coefficient lists are padded to the fixed degrees 10 and 2.
 assert len(f)==11 and len(g)==3
 mat=[[E(0) for _ in range(12)] for _ in range(12)]
 for i in range(2):mat[i][i:i+11]=list(reversed(f))
 for i in range(10):mat[i+2][i:i+3]=list(reversed(g))
 ans=E(1)
 for i in range(12):
  j=next((j for j in range(i,12) if mat[j][i]),None)
  if j is None:return E(0)
  if j!=i:mat[i],mat[j]=mat[j],mat[i];ans=-ans
  a=mat[i][i];ans=ans*a
  for j in range(i+1,12):
   if mat[j][i]:
    z=mat[j][i]/a
    for k in range(i,12):mat[j][k]=mat[j][k]-z*mat[i][k]
 return ans


def check_resultant():
 import random
 init([0,1]);rng=random.Random(271909)
 for i in range(90):
  a,b,c,g,Q,T,L=[E(rng.randrange(390625)) for j in range(7)]
  if i%3==0:a=E(0)
  if i%7==0:b=E(0)
  if i%11==0:L=E(0)
  f=[L*Q*Q+Q*g+T,Q*c,Q*3*b,Q*2*a,E(0),2*L*Q+g,c,3*b,2*a,E(0),L]
  cc=resultant_coefficients(a,b,c,g,Q,T,E(1))
  expected=cc[0]+cc[1]*L+cc[2]*L*L
  assert sylvester_det(f,[c,b,a])==expected,(i,a,b,c,g,Q,T,L)
 print('90 padded 12x12 Sylvester determinant checks passed, including quadratic and scale degree drops.',flush=True)

if __name__=='__main__':
 check_resultant()
 init([0,1])
 q=E(1);b=Poly(DATA['b']).eval(q);c=Poly(DATA['c']).eval(q);e=Poly(DATA['e']).eval(q)
 # Find a K-rational ordinary ramification point, only for an implementation test.
 from exact import power as kp,sub as ks,mul as km,add as ka,inv as ki
 for qc in range(1,100):
  if qc in DATA['excluded_q']:continue
  q=E(qc);b=Poly(DATA['b']).eval(q);c=Poly(DATA['c']).eval(q);e=Poly(DATA['e']).eval(q);C=c*c-3*b*e
  if not C or not b:continue
  # A square root via the cyclic logarithm table.
  from exact import LOG,EXP
  if LOG[C.a[0]]%2:continue
  xi=E(EXP[LOG[C.a[0]]//2]);u=(xi-c)/b
  if not u:continue
  F=Poly(DATA['a0']).eval(q)*u**3+b*u*u+c*u+e
  if not F:continue
  break
 else:raise AssertionError('no test ratio in bounded set')
 assert b*u*u+2*c*u+3*e==0 and b*u+c
 print('implementation test q,u:',q,u,flush=True)
 R=make_residual(q,u,True);tails=square_equations(R,False,True)
 g,s,t=tails[0].xgcd(tails[1]);assert s*tails[0]+t*tails[1]==g
 print('first-two-tail gcd degree:',g.degree(),flush=True)
