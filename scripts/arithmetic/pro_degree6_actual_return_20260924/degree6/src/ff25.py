"""Exact F_25 arithmetic. Code a+5*b denotes a+b*beta; beta^2=beta+3."""
def add(x,y): return ((x%5+y%5)%5)+5*((x//5+y//5)%5)
def neg(x): return (-x%5)+5*((- (x//5))%5)
def sub(x,y): return add(x,neg(y))
def mul(x,y):
 a,b=x%5,x//5;c,d=y%5,y//5
 return ((a*c+3*b*d)%5)+5*((a*d+b*c+b*d)%5)
def power(x,n):
 if n<0: return power(inv(x),-n)
 r=1
 while n:
  if n&1:r=mul(r,x)
  x=mul(x,x);n//=2
 return r
def inv(x):
 if not x: raise ZeroDivisionError
 return power(x,23)
def div(x,y):return mul(x,inv(y))
def trim(p):
 p=list(p)
 while len(p)>1 and p[-1]==0:p.pop()
 return p or [0]
def padd(p,q):return trim([add(p[i] if i<len(p) else 0,q[i] if i<len(q) else 0) for i in range(max(len(p),len(q)))])
def pneg(p):return [neg(v) for v in p]
def psub(p,q):return padd(p,pneg(q))
def pscale(p,c):return trim([mul(c,v) for v in p])
def pmul(p,q):
 out=[0]*(len(p)+len(q)-1)
 for i,a in enumerate(p):
  for j,b in enumerate(q):out[i+j]=add(out[i+j],mul(a,b))
 return trim(out)
def ppow(p,n):
 r=[1]
 while n:
  if n&1:r=pmul(r,p)
  p=pmul(p,p);n//=2
 return r
def pdivmod(p,q):
 p=trim(p);q=trim(q)
 if q==[0]:raise ZeroDivisionError
 out=[0]*max(1,len(p)-len(q)+1)
 while p!=[0] and len(p)>=len(q):
  k=len(p)-len(q);v=div(p[-1],q[-1]);out[k]=v
  p=psub(p,[0]*k+pscale(q,v))
 return trim(out),p
def pmonic(p):return pscale(p,inv(p[-1])) if p!=[0] else p
def pgcd(p,q):
 while trim(q)!=[0]:p,q=q,pdivmod(p,q)[1]
 return pmonic(p)
def pder(p):return trim([mul(i%5,p[i]) for i in range(1,len(p))])
def peval(p,x):
 r=0
 for c in reversed(p):r=add(mul(r,x),c)
 return r
def ppowmod(p,n,q):
 r=[1]
 while n:
  if n&1:r=pdivmod(pmul(r,p),q)[1]
  p=pdivmod(pmul(p,p),q)[1];n//=2
 return r
