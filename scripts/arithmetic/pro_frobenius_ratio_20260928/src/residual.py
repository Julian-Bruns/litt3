"""Residual circuit over any currently selected finite K-algebra.
Uses no critical leading-coefficient inversion. q,d,F6,u are checked units
by callers when an allowed ratio is required.
"""
import json,time
from pathlib import Path
from functools import lru_cache
import ext
from ext import EP,Element as E
from ff import Poly,mul,power,inv
from reconstruct import P,Q,t,v,epsilon
from resultant_formula import compact_resultant
ROOT=Path(__file__).resolve().parents[1]
class Curve:
 __slots__=('a','cache')
 Pq=EP()
 def __init__(self,a=0):
  if isinstance(a,Curve):self.a=a.a;self.cache=a.cache;return
  self.a=tuple(EP(i) for i in a) if isinstance(a,tuple) else (EP(a),EP(),EP());self.cache={}
 def __add__(self,b):
  b=Curve(b);return Curve(tuple(self.a[i]+b.a[i] for i in range(3)))
 __radd__=__add__
 def __neg__(self):return Curve(tuple(-x for x in self.a))
 def __sub__(self,b):return self+-Curve(b)
 def __rsub__(self,b):return Curve(b)+-self
 def __mul__(self,b):
  b=Curve(b);a0,a1,a2=self.a;b0,b1,b2=b.a;p=self.Pq
  return Curve((a0*b0+(a1*b2+a2*b1)*p,
                a0*b1+a1*b0+a2*b2*p,
                a0*b2+a1*b1+a2*b0))
 __rmul__=__mul__
 def square(self):
  a,b,c=self.a;p=self.Pq
  return Curve((a*a+2*(b*c)*p,2*a*b+c*c*p,2*a*c+b*b))
 def __pow__(self,n):
  if n in self.cache:return self.cache[n]
  if n==0:r=Curve(1)
  elif n==1:r=self
  elif n==2:r=self.square()
  elif n==5:
   a,b,c=self.a;p=self.Pq
   r=Curve((a.frob(),c.frob()*p**3,b.frob()*p))
  elif n%2==0:r=(self**(n//2)).square()
  else:r=(self**(n-1))*self
  self.cache[n]=r;return r

def peval(row,q):
 out=E()
 for c in row[::-1]:out=out*q+c
 return out
RATIO={'a0':[350365,93449],'d':[47171,357608], 'b':[90885,339126,362701,194731,371097,144818], 'c':[56518,278019,104390,351083,235630,246647,217983], 'e':[0,324104,260238,219737,136154,199269,240524,27757,108951,319279], 'C':[375887,61969,120100,319268,316878,42015,131041,344618,17272,253241,28972,368439,192911,239943,130588]}

def check_open(q,u,ordinary=True):
 a0,d,b,c,e=[peval(RATIO[z],q) for z in ['a0','d','b','c','e']]
 for val in [q,u,d,q-10149,q-118020,q-64426]:val.inverse()
 V=a0*u**3+b*u*u+c*u+e
 V.inverse()
 if ordinary:(b*u+c).inverse()
 assert b*u*u+2*c*u+3*e==0
 return V

def pmul(a,b):
 out=[EP() for _ in range(len(a)+len(b)-1)]
 for i,x in enumerate(a):
  for j,y in enumerate(b):out[i+j]=out[i+j]+x*y
 return out

def padd(a,b):return [(a[i] if i<len(a) else EP())+(b[i] if i<len(b) else EP()) for i in range(max(len(a),len(b)))]
def pscale(a,b):return [x*b for x in a]
def p3(a):return pmul(pmul(a,a),a)

def residual(q,u,verbose=False):
 start=time.time();d=peval(RATIO['d'],q);qi=q.inverse();di=d.inverse()
 Curve.Pq=EP(P)*qi
 data=json.loads((ROOT/'data'/'source_cramer.json').read_text())
 T=[]
 for gi in data['G_numerators']:
  comp=[]
  for j,row in enumerate(gi):
   rr=[]
   for s in row:
    total=E()
    for (ha,wb,ka,kb),coeff in s:
     assert ka==kb==0
     k=wb-2*ha+j-1;assert k%3==0
     qp=k//3+1;assert qp>=0
     total=total+coeff*(u**ha)*(q**qp)
    rr.append(total)
   comp.append(EP(rr))
  T.append(Curve(tuple(comp)))
 const=Curve((EP(),EP(t**3*P**3)*(q*d),EP()))
 rz=compact_resultant(3*T[0],2*T[1],T[2],T[3],Curve(EP(Q)),const,Curve(EP(v)*(q*d)))
 if verbose:print('  resultant circuit',round(time.time()-start,3),flush=True)
 aa,bb,cc=[[r.a[j] for r in rz] for j in range(3)]
 pq=Curve.Pq
 norm=padd(padd(p3(aa),pscale(p3(bb),pq)),pscale(p3(cc),pq*pq))
 norm=padd(norm,pscale(pmul(pmul(aa,bb),cc),2*pq)) # -3=2 in characteristic five
 if verbose:print('  norm circuit',round(time.time()-start,3),flush=True)
 denominator=EP(P**40*t**15*v**3)
 constinv=(q**11*d**36).inverse()
 rr=[(n//denominator)*constinv for n in norm]
 assert len(rr)==7
 assert rr[0].degree()==140 and all(p.degree()<140 for p in rr[1:]),[p.degree() for p in rr]
 a0,b,c,e=[peval(RATIO[z],q) for z in ['a0','b','c','e']]
 V=a0*u**3+b*u*u+c*u+e
 predicted=E(mul(2,power(epsilon,24)))*q*u**9*V**3*di**3
 assert rr[0][140]==predicted,('leading coefficient',rr[0][140],predicted)
 L=predicted
 if verbose:print('  exact residual division and leading coefficient',round(time.time()-start,3),flush=True)
 linv=L.inverse()
 A=[EP([rr[s][140-n]*linv for s in range(7)]) for n in range(141)]
 assert A[0]==1
 return rr,A

class Tails:
 def __init__(self,A,verbose=False,max_n=140):
  assert 1<=max_n<=140
  self.max_n=max_n
  self.A=A;self.memo={};self.a2=[];self.a3=[]
  start=time.time()
  for n in range(max_n+1):
   acc=EP()
   for i in range(n//2+1):
    if i==n-i:acc=acc+A[i]*A[i]
    else:acc=acc+2*A[i]*A[n-i]
   self.a2.append(acc)
  for n in range(max_n+1):
   acc=EP()
   for i in range(n+1):acc=acc+A[i]*self.a2[n-i]
   self.a3.append(acc)
  self.p5=[a.frob(1) for a in self.a2[:max_n//5+1]]
  self.p25=[a.frob(2) for a in self.a2[:max_n//25+1]]
  self.a1f125=A[1].frob(3)
  if verbose:print('  a2/a3 Frobenius preparation',round(time.time()-start,3),flush=True)
 def C(self,n):
  assert 0<=n<=self.max_n
  if n in self.memo:return self.memo[n]
  acc=EP()
  for j in range(n//25+1):
   inner=EP()
   for i in range((n-25*j)//5+1):inner=inner+self.a3[n-25*j-5*i]*self.p5[i]
   acc=acc+inner*self.p25[j]
  self.memo[n]=acc;return acc
 def tail(self,n):
  assert 71<=n<=140
  return self.C(n)+(2*self.a1f125*self.C(n-125) if n>=125 else EP())
