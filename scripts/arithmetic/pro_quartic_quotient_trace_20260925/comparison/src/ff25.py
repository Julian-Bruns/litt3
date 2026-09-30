"""Exact F_25 and ascending-polynomial arithmetic, standard library only."""
p=5

def add(a,b): return (a%5+b%5)%5+5*((a//5+b//5)%5)
def neg(a): return ((-(a%5))%5)+5*((-(a//5))%5)
def sub(a,b): return add(a,neg(b))
def mul(a,b):
 a0,a1=a%5,a//5; b0,b1=b%5,b//5
 return (a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5)
def pow_(a,n):
 if n<0: return pow_(inv(a),-n)
 s=1
 while n:
  if n&1:s=mul(s,a)
  a=mul(a,a); n//=2
 return s

def inv(a):
 if not a: raise ZeroDivisionError()
 return pow_(a,23)
def div(a,b):return mul(a,inv(b))
def trim(a):
 a=list(a)
 while len(a)>1 and a[-1]==0:a.pop()
 return a or [0]
def padd(a,b):return trim([add(a[i] if i<len(a) else 0,b[i] if i<len(b) else 0) for i in range(max(len(a),len(b)))])
def pneg(a):return list(map(neg,a))
def psub(a,b):return padd(a,pneg(b))
def pscale(a,c):return trim([mul(x,c) for x in a])
def pmul(a,b):
 c=[0]*(len(a)+len(b)-1)
 for i,x in enumerate(a):
  for j,y in enumerate(b):c[i+j]=add(c[i+j],mul(x,y))
 return trim(c)
def ppow(a,n):
 c=[1]
 while n:
  if n&1:c=pmul(c,a)
  a=pmul(a,a);n//=2
 return c
def pdivmod(a,b):
 a=trim(a);b=trim(b)
 if b==[0]:raise ZeroDivisionError()
 q=[0]*max(1,len(a)-len(b)+1)
 while a!=[0] and len(a)>=len(b):
  j=len(a)-len(b);c=div(a[-1],b[-1]);q[j]=c
  a=psub(a,[0]*j+pscale(b,c))
 return trim(q),a

def pdiv(a,b):
 q,r=pdivmod(a,b)
 if r!=[0]:raise ValueError('not exact')
 return q

def pmod(a,b):return pdivmod(a,b)[1]
def pmonic(a):return pscale(a,inv(a[-1]))
def pgcd(a,b):
 while b!=[0]:a,b=b,pmod(a,b)
 return pmonic(a)
def pder(a):return trim([mul(i%5,a[i]) for i in range(1,len(a))])
def peval(a,x):
 c=0
 for ai in a[::-1]:c=add(mul(c,x),ai)
 return c

def rat(n,d):
 g=pgcd(n,d);n=pdiv(n,g);d=pdiv(d,g);lc=inv(d[-1])
 return pscale(n,lc),pscale(d,lc)
def rder(r):
 n,d=r
 return rat(psub(pmul(pder(n),d),pmul(n,pder(d))),pmul(d,d))
def rmul(r,s):return rat(pmul(r[0],s[0]),pmul(r[1],s[1]))
def rsub(r,s):return rat(psub(pmul(r[0],s[1]),pmul(s[0],r[1])),pmul(r[1],s[1]))
P=[11,22,18,5,19,20,15,16,9,22,1]
A=[1,21,14,22,13]
