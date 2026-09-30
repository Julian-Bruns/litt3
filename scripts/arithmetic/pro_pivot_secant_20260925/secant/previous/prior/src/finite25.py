"""Exact F_25 and polynomial arithmetic; ascending rows, no dependencies."""
# Pure Python exact arithmetic in F_25 = F_5[b]/(b^2-b-3).
P=[11,22,18,5,19,20,15,16,9,22,1]
A=[1,21,14,22,13]
def add(a,b):return ((a%5+b%5)%5)+5*((a//5+b//5)%5)
def neg(a):return ((-(a%5))%5)+5*((-(a//5))%5)
def sub(a,b):return add(a,neg(b))
def mul(a,b):
 x,y=a%5,a//5;z,w=b%5,b//5
 return (x*z+3*y*w)%5+5*((x*w+y*z+y*w)%5)
def powf(a,n):
 r=1
 while n:
  if n&1:r=mul(r,a)
  a=mul(a,a);n//=2
 return r
def inv(a):
 if not a:raise ZeroDivisionError
 return powf(a,23)
def trim(p):
 p=list(p)
 while p and not p[-1]:p.pop()
 return p
def pa(p,q):
 r=[0]*max(len(p),len(q))
 for i in range(len(r)):r[i]=add(p[i] if i<len(p) else 0,q[i] if i<len(q) else 0)
 return trim(r)
def ps(p,q):return pa(p,[neg(x) for x in q])
def scale(p,a):return trim([mul(a,x) for x in p])
def pm(p,q):
 r=[0]*max(0,len(p)+len(q)-1)
 for i,a in enumerate(p):
  for j,b in enumerate(q):r[i+j]=add(r[i+j],mul(a,b))
 return trim(r)
def divmodp(p,q):
 p=trim(p);q=trim(q)
 if not q:raise ZeroDivisionError
 quot=[0]*max(0,len(p)-len(q)+1)
 v=inv(q[-1])
 while len(p)>=len(q):
  d=len(p)-len(q);c=mul(p[-1],v);quot[d]=c
  for j,b in enumerate(q):p[d+j]=sub(p[d+j],mul(c,b))
  p=trim(p)
 return trim(quot),p
def rem(p,q):return divmodp(p,q)[1]
def ppow(p,n,q=None):
 r=[1]
 while n:
  if n&1:r=pm(r,p);r=rem(r,q) if q else r
  p=pm(p,p);p=rem(p,q) if q else p;n//=2
 return r
def egcd(p,q):
 s0,s1,t0,t1=[1],[],[],[1]
 while q:
  a,r=divmodp(p,q);p,q=q,r;s0,s1=s1,ps(s0,pm(a,s1));t0,t1=t1,ps(t0,pm(a,t1))
 z=inv(p[-1]);return scale(p,z),scale(s0,z),scale(t0,z)
def der(p):return trim([mul(i%5,p[i]) for i in range(1,len(p))])
