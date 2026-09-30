"""Exact finite extensions of F25. Elements are base-25 encoded integers.
A modulus [c0,...,c_r] represents sum c_i*t^i over F25, with c_r=1.
"""
from exact import ADD,MUL,NEG,INV
from functools import lru_cache

class F25:
 order=25;degree=1;modulus=None
 def add(self,a,b):return int(ADD[a,b])
 def mul(self,a,b):return int(MUL[a,b])
 def neg(self,a):return int(NEG[a])
 def sub(self,a,b):return self.add(a,self.neg(b))
 def inv(self,a):
  if a==0:raise ZeroDivisionError
  return int(INV[a])
 def power(self,a,n):
  if n<0:a=self.inv(a);n=-n
  v=1
  while n:
   if n&1:v=self.mul(v,a)
   a=self.mul(a,a);n//=2
  return v
 def validate(self):return True

class F25Extension(F25):
 def __init__(self,modulus,check=True):
  self.modulus=tuple(int(c) for c in modulus)
  if len(self.modulus)<3 or self.modulus[-1]!=1 or any(not 0<=c<25 for c in self.modulus):
   raise ValueError('Use a monic degree-at-least-two polynomial with F25-coded coefficients.')
  self.degree=len(self.modulus)-1;self.order=25**self.degree
  if check and not self.validate():raise ValueError('The defining polynomial is reducible.')
 @lru_cache(maxsize=100000)
 def digits(self,a):
  if not 0<=a<self.order:raise ValueError('field element code out of range')
  z=[]
  for _ in range(self.degree):z.append(a%25);a//=25
  return tuple(z)
 def encode(self,digits):
  z=0
  for a in reversed(digits):z=25*z+int(a)
  return z
 def add(self,a,b):return self.encode([int(ADD[c,d]) for c,d in zip(self.digits(a),self.digits(b))])
 def neg(self,a):return self.encode([int(NEG[c]) for c in self.digits(a)])
 def mul(self,a,b):
  if a==0 or b==0:return 0
  if a<25 and b<25:return int(MUL[a,b])
  aa=self.digits(a);bb=self.digits(b);n=self.degree
  cc=[0]*(2*n-1)
  for i,c in enumerate(aa):
   if c:
    for j,d in enumerate(bb):
     if d:cc[i+j]=int(ADD[cc[i+j],MUL[c,d]])
  for i in range(2*n-2,n-1,-1):
   c=cc[i]
   if c:
    for j,d in enumerate(self.modulus[:-1]):cc[i-n+j]=int(ADD[cc[i-n+j],NEG[MUL[c,d]]])
  return self.encode(cc[:n])
 def inv(self,a):
  if not a:raise ZeroDivisionError
  return self.power(a,self.order-2)
 def validate(self):
  # Rabin irreducibility criterion, q=25, computed in the quotient algebra.
  n=self.degree;x=25;xp=[x]
  for _ in range(n):xp.append(self.power(xp[-1],25))
  if xp[n]!=x:return False
  primes=[];m=n;d=2
  while d*d<=m:
   if m%d==0:
    primes.append(d)
    while m%d==0:m//=d
   d+=1
  if m>1:primes.append(m)
  from ffpoly import gcd
  f=F25()
  for ell in primes:
   h=list(self.digits(self.sub(xp[n//ell],x)))
   if len(gcd(list(self.modulus),h,f))>1:return False
  return True

def matmul(A,B,F):
 if not A:return []
 out=[[0]*len(B[0]) for _ in A]
 for i,row in enumerate(A):
  for k,a in enumerate(row):
   if a:
    for j,b in enumerate(B[k]):
     if b:out[i][j]=F.add(out[i][j],F.mul(a,b))
 return out

def rref(A,F):
 A=[list(map(int,row)) for row in A]
 if not A:return A,[]
 nr,nc=len(A),len(A[0]);r=0;piv=[]
 for c in range(nc):
  i=next((i for i in range(r,nr) if A[i][c]),None)
  if i is None:continue
  A[r],A[i]=A[i],A[r];invc=F.inv(A[r][c]);A[r]=[F.mul(invc,a) for a in A[r]]
  for i in range(nr):
   if i!=r and A[i][c]:
    a=A[i][c];A[i]=[F.sub(x,F.mul(a,y)) for x,y in zip(A[i],A[r])]
  piv.append(c);r+=1
  if r==nr:break
 return A,piv

def rank(A,F):return len(rref(A,F)[1])
def kernel(A,F):
 R,piv=rref(A,F);n=len(A[0]);free=[j for j in range(n) if j not in piv];out=[]
 for j in free:
  v=[0]*n;v[j]=1
  for i,p in enumerate(piv):v[p]=F.neg(R[i][j])
  out.append(v)
 return out

def normalize(v,F):
 a=next((c for c in v if c),None)
 if a is None:raise ValueError('zero projective vector')
 t=F.inv(a);return [F.mul(t,c) for c in v]
