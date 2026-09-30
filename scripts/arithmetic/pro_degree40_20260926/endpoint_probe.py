#!/usr/bin/env python3
"""Exact endpoint series over F_25(alpha)[e,d]; e=epsilon^-1, d=Z_2.
Universal endpoint-jet reconstruction; the complete nonexistence proof is in REPORT.md.
No floating-point arithmetic, third-party package, or finite-field search is used.
"""
import argparse, json, sys
from pathlib import Path

ADD=[[ (a%5+b%5)%5 + 5*((a//5+b//5)%5) for b in range(25)] for a in range(25)]
NEG=[(-a%5)%5+5*((-(a//5))%5) for a in range(25)]
MUL=[[((a%5)*(b%5)+3*(a//5)*(b//5))%5+5*(((a%5)*(b//5)+(a//5)*(b%5)+(a//5)*(b//5))%5) for b in range(25)] for a in range(25)]
def fpow(a,n):
 r=1
 while n:
  if n&1:r=MUL[r][a]
  a=MUL[a][a];n>>=1
 return r
INV=[0]+[fpow(a,23) for a in range(1,25)]

class Field:
 def __init__(self,mod,name):
  self.n=len(mod)-1; self.name=name
  self.mod=tuple(MUL[x][INV[mod[-1]]] for x in mod[:-1])
  self.zero=Elt(self,(0,)*self.n);self.one=self(1)
  self.gen=Elt(self,(0,1)+(0,)*(self.n-2))
 def __call__(self,x):
  if isinstance(x,Elt):
   assert x.F is self; return x
  if isinstance(x,int):return Elt(self,(x,)+(0,)*(self.n-1))
  return Elt(self,tuple(x)+(0,)*(self.n-len(x)))
class Elt:
 __slots__=('F','v')
 def __init__(self,F,v):self.F=F;self.v=v
 def __bool__(self):return any(self.v)
 def __eq__(self,b):
  if isinstance(b,int):b=self.F(b)
  return isinstance(b,Elt) and self.F is b.F and self.v==b.v
 def __add__(self,b):
  b=self.F(b);return Elt(self.F,tuple(ADD[x][y] for x,y in zip(self.v,b.v)))
 __radd__=__add__
 def __neg__(self):return Elt(self.F,tuple(NEG[x] for x in self.v))
 def __sub__(self,b):return self+-self.F(b)
 def __rsub__(self,b):return self.F(b)+-self
 def __mul__(self,b):
  b=self.F(b);F=self.F;n=F.n
  if not self or not b:return F.zero
  r=[0]*(2*n-1)
  for i,a in enumerate(self.v):
   if a:
    ma=MUL[a]
    for j,c in enumerate(b.v):
     if c:r[i+j]=ADD[r[i+j]][ma[c]]
  for i in range(2*n-2,n-1,-1):
   c=r[i]
   if c:
    mc=MUL[NEG[c]]
    for j,a in enumerate(F.mod):
     if a:r[i-n+j]=ADD[r[i-n+j]][mc[a]]
  return Elt(F,tuple(r[:n]))
 __rmul__=__mul__
 def __pow__(self,n):
  if n<0:return self.inv()**(-n)
  a=self;r=self.F.one
  while n:
   if n&1:r=r*a
   n>>=1
   if n:a=a*a
  return r
 def inv(self):
  if not self:raise ZeroDivisionError
  return self**(25**self.F.n-2)
 def __truediv__(self,b):return self*self.F(b).inv()
 def __repr__(self):return str(list(self.v))

FA=Field([1,21,14,22,13],'alpha'); al=FA.gen
FQ=Field([4,22,7,20,21,7,24,1],'zeta'); zeta=FQ.gen
P=[11,22,18,5,19,20,15,16,9,22,1];A=[1,21,14,22,13]
def ev(poly,a):
 r=a.F.zero
 for c in reversed(poly):r=r*a+a.F(c)
 return r
def der(poly):return [MUL[i%5][poly[i]] for i in range(1,len(poly))]
def tr(a):
 b=a+a**25+a**625+a**15625
 assert not any(b.v[1:]);return b.v[0]

# Sparse polynomials in d,e with coefficients in FA.
class Poly:
 __slots__=('v',)
 def __init__(self,v):self.v={m:c for m,c in v.items() if c}
 @staticmethod
 def of(x):
  if isinstance(x,Poly):return x
  return Poly({(0,0):FA(x)})
 def __bool__(self):return bool(self.v)
 def __add__(self,b):
  b=Poly.of(b);r=self.v.copy()
  for m,c in b.v.items():r[m]=r.get(m,FA.zero)+c
  return Poly(r)
 __radd__=__add__
 def __neg__(self):return Poly({m:-c for m,c in self.v.items()})
 def __sub__(self,b):return self+-Poly.of(b)
 def __rsub__(self,b):return Poly.of(b)+-self
 def __mul__(self,b):
  b=Poly.of(b);r={}
  for (d,e),c in self.v.items():
   for (f,g),a in b.v.items():
    m=(d+f,e+g);r[m]=r.get(m,FA.zero)+c*a
  return Poly(r)
 __rmul__=__mul__
 def scale(self,c):return Poly({m:a*FA(c) for m,a in self.v.items()})
 def __pow__(self,n):
  a=self;r=Poly.of(1)
  while n:
   if n&1:r=r*a
   n>>=1
   if n:a=a*a
  return r
 def json(self):return [[d,e,list(c.v)] for (d,e),c in sorted(self.v.items())]
 def __repr__(self):return str(self.json())
ZERO=Poly.of(0);ONE=Poly.of(1);D=Poly({(1,0):FA.one});E=Poly({(0,1):FA.one})
def sadd(a,b,N):return [(a[i] if i<len(a) else ZERO)+(b[i] if i<len(b) else ZERO) for i in range(N+1)]
def smul(a,b,N):
 r=[ZERO]*(N+1)
 for i,ai in enumerate(a[:N+1]):
  if ai:
   for j,bj in enumerate(b[:N+1-i]):
    if bj:r[i+j]=r[i+j]+ai*bj
 return r
def spow(a,n,N):
 r=[ONE]+[ZERO]*N
 while n:
  if n&1:r=smul(r,a,N)
  n>>=1
  if n:a=smul(a,a,N)
 return r
def seval(pol,a,N):
 r=[ZERO]*(N+1)
 for c in reversed(pol):
  r=smul(r,a,N);r[0]=r[0]+FA(c)
 return r
def ufrom(z,N):
 rhs=[ZERO]*(N+1)
 for m in range(5):
  off=13-3*m
  if off>N:continue
  zz=spow(z,m,N-off);fac=(E**(4-m)).scale(A[m])
  for i in range(N+1-off):rhs[i+off]=rhs[i+off]+zz[i]*fac
 u=[Poly.of(al)]+[ZERO]*N
 for i in range(1,N+1):
  ai=seval(A,u[:i],i)[i]
  u[i]=(rhs[i]-ai).scale(APinv)
 return u

def equation(z,n):
 u=ufrom(z,n+1)
 deriv=[u[i+1].scale((i+1)%5) for i in range(n+1)]
 tz=[z[i].scale((i-3)%5) if i<len(z) else ZERO for i in range(n+1)]
 ph=[ZERO]*(n+1)
 for m in range(11):
  off=30-3*m
  if off>n:continue
  zm=spow(z,m,n-off);fac=(E**(10-m)).scale(P[m])
  for i in range(n+1-off):ph[i+off]=ph[i+off]+zm[i]*fac
 pu=seval(P,u,n)
 lhs=smul(spow(tz,3,n),spow(pu,2,n),n)
 rhs=smul(spow(ph,2,n),spow(deriv,3,n),n)
 return lhs[n]-rhs[n],u

p0=ev(P,al);ap=ev(der(A),al);APinv=ap.inv();ell=FA(13)
B=(FA(3)*p0**2*ap**3/ell**3)**pow(29,-1,25**4-1)
a=ell*B**4/ap
c=B*a*(ev(der(P),al)/p0-ev(der(der(A)),al)/ap)
b=(FA(4)*ell*B**3*c-(ev(der(der(A)),al)/FA(2))*a**2)/ap
H0=FA(3)*B**3*p0**2

def compute(N):
 if N != 4: raise ValueError("Only the proved and verified order N=4 is exposed")
 z=[Poly.of(B)];cert={}
 for n in range(1,N+1):
  if n==2:z.append(D)
  else:z.append(ZERO)
  hn,u=equation(z,n)
  if n%5==2:
   cert[str(n)]=hn.json()
   print('resonance',n,'residual',hn,flush=True)
   assert not hn, 'resonance obstruction'
  else:
   factor=B/(H0*FA((2*n+1)%5))
   z[n]=(-hn).scale(factor)
   hn,u=equation(z,n)
   assert not hn
  print('Z',n,z[n],flush=True)
 assert z[1].v==Poly.of(c).v
 u=ufrom(z,N+1)
 assert u[1].v==Poly.of(a).v and u[2].v==Poly.of(b).v
 return z,u,cert

if __name__=='__main__':
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('order',type=int,nargs='?',default=4,choices=[4])
 parser.add_argument('--write',action='store_true',help='regenerate the deterministic evidence file')
 args=parser.parse_args();N=args.order
 z,u,cert=compute(N)
 out={'N':N,'field_alpha_modulus':A,'field_zeta_modulus':[4,22,7,20,21,7,24,1], 'B':list(B.v),'a':list(a.v),'b':list(b.v),'c':list(c.v),'z':[v.json() for v in z],'u':[v.json() for v in u],'resonances':cert}
 path=Path(__file__).resolve().parents[1]/'evidence'/'endpoint_series.json'
 if args.write:
  path.write_text(json.dumps(out,indent=2)+'\n')
  print('WROTE deterministic endpoint certificate')
 else:
  assert json.loads(path.read_text())==out, 'saved endpoint certificate differs from reconstruction'
  print('PASS: saved endpoint certificate matches full universal reconstruction')
 print('Endpoint reconstruction: ALL CHECKS PASSED')
