"""Independent, deliberately simple arithmetic in K tensor L.
Unlike the C++ engine, this implementation reduces the zeta modulus first.
Elements have 28 F25 codes: index 4*j+i means alpha^i*zeta^j.
"""
from ff25 import add,sub,mul,neg
from itertools import permutations

class ReferenceField:
 def __init__(self,km,lm):
  self.km=km;self.lm=lm
 def zero(self):return [0]*28
 def one(self):return [1]+[0]*27
 def const(self,n):return [n]+[0]*27
 def add(self,a,b):return [add(x,y) for x,y in zip(a,b)]
 def sub(self,a,b):return [sub(x,y) for x,y in zip(a,b)]
 def scale(self,a,n):return [mul(x,n) for x in a]
 def mul(self,a,b):
  v=[[0]*7 for _ in range(13)]
  for i,x in enumerate(a):
   if not x:continue
   for j,y in enumerate(b):
    if y:
     r=i//4+j//4;c=i%4+j%4
     v[r][c]=add(v[r][c],mul(x,y))
  for r in range(12,6,-1):
   for c in range(7):
    z=v[r][c]
    if z:
     for j in range(7):v[r-7+j][c]=sub(v[r-7+j][c],mul(z,self.lm[j]))
  for r in range(7):
   for c in range(6,3,-1):
    z=v[r][c]
    if z:
     for j in range(4):v[r][c-4+j]=sub(v[r][c-4+j],mul(z,self.km[j]))
  return [v[r][c] for r in range(7) for c in range(4)]
 def power(self,a,n):
  r=self.one()
  while n:
   if n&1:r=self.mul(r,a)
   a=self.mul(a,a);n//=2
  return r
 def outer(self,a,b):return [mul(a[i],b[j]) for j in range(7) for i in range(4)]
 def embed(self,a):return list(a)+[0]*(28-len(a))
 def det3(self,m):
  r=self.zero()
  for p in permutations(range(3)):
   t=self.one()
   for i in range(3):t=self.mul(t,m[i][p[i]])
   odd=sum(p[i]>p[j] for i in range(3) for j in range(i+1,3))%2
   r=self.sub(r,t) if odd else self.add(r,t)
  return r
