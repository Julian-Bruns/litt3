"""Exact reciprocal-x jet of the residual, without full resultant expansion.
The universal scaling is Norm(Res_hat)=T^36 D_rev(T) q^11 d^36 R_hat(T).
All polynomials are truncated only after a proved nonnegative T valuation.
No critical leading coefficient or endpoint value is inverted.
"""
import json,time
from pathlib import Path
import ext
from ext import Element as E, EP
from ff import Poly,mul,power
from residual import RATIO,peval
from reconstruct import P,Q,t,v,epsilon
from resultant_formula import compact_resultant
ROOT=Path(__file__).resolve().parents[1]

class Jet:
 __slots__=('p',)
 precision=109
 def __init__(self,a=0):self.p=(a.p if isinstance(a,Jet) else EP(a)).truncate(self.precision)
 def __bool__(self):return bool(self.p)
 def __getitem__(self,i):return self.p[i]
 def __eq__(self,b):return self.p==Jet(b).p
 def __add__(self,b):return Jet(self.p+Jet(b).p)
 __radd__=__add__
 def __neg__(self):return Jet(-self.p)
 def __sub__(self,b):return self+-Jet(b)
 def __rsub__(self,b):return Jet(b)+-self
 def __mul__(self,b):return Jet(self.p.mullow(Jet(b).p,self.precision))
 __rmul__=__mul__
 def __pow__(self,n):
  if n==5:return Jet(self.p.frob())
  assert n>=0
  a=self;r=Jet(1)
  while n:
   if n&1:r=r*a
   n//=2
   if n:a=a*a
  return r
 def shift(self,n):return Jet(EP([E() for _ in range(n)]+[self.p[i] for i in range(len(self.p))]))

class CJ:
 __slots__=('a','cache')
 Pq=Jet()
 def __init__(self,a=0):
  if isinstance(a,CJ):self.a=a.a;self.cache=a.cache;return
  self.a=tuple(Jet(x) for x in a) if isinstance(a,tuple) else (Jet(a),Jet(),Jet());self.cache={}
 def __add__(self,b):
  b=CJ(b);return CJ(tuple(self.a[i]+b.a[i] for i in range(3)))
 __radd__=__add__
 def __neg__(self):return CJ(tuple(-a for a in self.a))
 def __sub__(self,b):return self+-CJ(b)
 def __rsub__(self,b):return CJ(b)+-self
 def __mul__(self,b):
  b=CJ(b);a0,a1,a2=self.a;b0,b1,b2=b.a;p=self.Pq
  return CJ((a0*b0+(a1*b2+a2*b1)*p,a0*b1+a1*b0+a2*b2*p,a0*b2+a1*b1+a2*b0))
 __rmul__=__mul__
 def square(self):
  a,b,c=self.a;p=self.Pq
  return CJ((a*a+2*b*c*p,2*a*b+c*c*p,2*a*c+b*b))
 def __pow__(self,n):
  if n in self.cache:return self.cache[n]
  if n==0:r=CJ(1)
  elif n==1:r=self
  elif n==2:r=self.square()
  elif n==5:
   a,b,c=self.a;p=self.Pq;r=CJ((a**5,c**5*p**3,b**5*p))
  elif n%2==0:r=(self**(n//2)).square()
  else:r=(self**(n-1))*self
  self.cache[n]=r;return r

def pmul(a,b):
 out=[Jet() for _ in range(len(a)+len(b)-1)]
 for i,x in enumerate(a):
  for j,y in enumerate(b):out[i+j]=out[i+j]+x*y
 return out

def padd(a,b):return [(a[i] if i<len(a) else Jet())+(b[i] if i<len(b) else Jet()) for i in range(max(len(a),len(b)))]
def pscale(a,b):return [x*b for x in a]
def p3(a):return pmul(pmul(a,a),a)

def residual_jet(q,u,max_n=72,verbose=False):
 assert 0<=max_n<=140
 start=time.time();Jet.precision=37+max_n
 d=peval(RATIO['d'],q);qi=q.inverse();di=d.inverse()
 Prev=Poly(P.tolist()[::-1]);trev=Poly(t.tolist()[::-1]);vrev=Poly(v.tolist()[::-1])
 CJ.Pq=(Jet(Prev)*qi).shift(2)
 data=json.loads((ROOT/'data/source_cramer.json').read_text());TT=[]
 for gi,weight in zip(data['G_numerators'],[12,16,20,24]):
  comp=[]
  for j,row in enumerate(gi):
   rr=[E() for _ in range(weight+1)]
   for i,terms in enumerate(row):
    total=E()
    for (ha,wb,ka,kb),cf in terms:
     assert ka==kb==0
     kk=wb-2*ha+j-1;assert kk%3==0
     qp=kk//3+1;assert qp>=0
     total=total+cf*u**ha*q**qp
    at=weight-i-4*j
    if total:assert at>=0
    if at>=0:rr[at]=rr[at]+total
   comp.append(Jet(rr))
  TT.append(CJ(tuple(comp)))
 C0=CJ((Jet(),(Jet(trev**3*Prev**3)*(q*d)).shift(1),Jet()))
 vhat=CJ((Jet(vrev)*(q*d)).shift(3))
 Qhat=CJ(Jet(Poly(Q.tolist()[::-1])).shift(1))
 rz=compact_resultant(3*TT[0],2*TT[1],TT[2],TT[3],Qhat,C0,vhat)
 if verbose:print('  reciprocal jet resultant',round(time.time()-start,3),flush=True)
 aa,bb,cc=[[r.a[j] for r in rz] for j in range(3)];pq=CJ.Pq
 nn=padd(padd(p3(aa),pscale(p3(bb),pq)),pscale(p3(cc),pq*pq))
 nn=padd(nn,pscale(pmul(pmul(aa,bb),cc),2*pq))
 if verbose:print('  reciprocal jet norm',round(time.time()-start,3),flush=True)
 assert len(nn)==7
 for x in nn:assert all(not x[i] for i in range(36))
 den=(Prev**40*trev**15*vrev**3).truncate(max_n+1)
 assert den[0]==1
 # Since 5^k>max_n, den^(5^k)=1 modulo T^(max_n+1).
 pp=1
 while pp<=max_n:pp*=5
 deninv=EP(den.pow_trunc(pp-1,max_n+1))
 cinv=(q**11*d**36).inverse()
 rr=[EP([x[36+i] for i in range(max_n+1)]).mullow(deninv,max_n+1)*cinv for x in nn]
 a0,b,c,e=[peval(RATIO[z],q) for z in ['a0','b','c','e']]
 V=a0*u**3+b*u*u+c*u+e
 L=mul(2,power(epsilon,24))*q*u**9*V**3*di**3
 assert rr[0][0]==L and all(not z[0] for z in rr[1:])
 il=L.inverse()
 A=[EP([r[n]*il for r in rr]) for n in range(max_n+1)]
 assert A[0]==1
 if verbose:print('  reciprocal jet normalized',round(time.time()-start,3),flush=True)
 return rr,A
