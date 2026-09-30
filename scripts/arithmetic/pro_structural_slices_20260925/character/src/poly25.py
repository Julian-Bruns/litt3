"""Univariate polynomials and finite extensions of F25, exact integer coding."""
from exact import ADD,SUB,MUL,NEG,INV
A=ADD.tolist();S=SUB.tolist();M=MUL.tolist();N=NEG.tolist();I=INV.tolist()
def tr(p):
 p=list(p)
 while p and not p[-1]:p.pop()
 return p
def add(p,q):return tr([A[p[i] if i<len(p) else 0][q[i] if i<len(q) else 0] for i in range(max(len(p),len(q)))])
def neg(p):return [N[c] for c in p]
def sub(p,q):return add(p,neg(q))
def scale(p,c):return tr([M[x][c] for x in p])
def mul(p,q):
 if not p or not q:return []
 out=[0]*(len(p)+len(q)-1)
 for i,a in enumerate(p):
  if a:
   for j,b in enumerate(q):
    if b:out[i+j]=A[out[i+j]][M[a][b]]
 return tr(out)
def divmodp(p,q):
 p=tr(p);q=tr(q)
 if not q:raise ZeroDivisionError
 out=[0]*max(0,len(p)-len(q)+1);inv=I[q[-1]]
 while p and len(p)>=len(q):
  i=len(p)-len(q);c=M[p[-1]][inv];out[i]=c
  for j,b in enumerate(q):p[i+j]=S[p[i+j]][M[c][b]]
  p=tr(p)
 return tr(out),p
def rem(p,q):return divmodp(p,q)[1]
def monic(p):return scale(p,I[p[-1]]) if p else []
def gcd(p,q):
 while q:p,q=q,rem(p,q)
 return monic(p)
def xgcd(p,q):
 a,b=[1],[];c,d=[],[1]
 while q:
  t,r=divmodp(p,q);p,q=q,r;a,b=b,sub(a,mul(t,b));c,d=d,sub(c,mul(t,d))
 inv=I[p[-1]];return scale(p,inv),scale(a,inv),scale(c,inv)
def powmod(p,n,q):
 out=[1];p=rem(p,q)
 while n:
  if n&1:out=rem(mul(out,p),q)
  p=rem(mul(p,p),q);n//=2
 return out
def derivative(p):return tr([M[i%5][p[i]] for i in range(1,len(p))])
def evaluate(p,x):
 out=0
 for c in p[::-1]:out=A[M[out][x]][c]
 return out

def irreducible(p):
 p=monic(p);n=len(p)-1
 if n<1:return False
 x=[0,1];h=x
 for d in range(1,n+1):
  h=powmod(h,25,p)
  if d<=n//2 and len(gcd(sub(h,x),p))>1:return False
 return rem(sub(h,x),p)==[]

def factor_squarefree(p,seed=2026):
 import random
 rng=random.Random(seed);p=monic(p)
 if gcd(p,derivative(p))!=[1]:raise ValueError('Polynomial must be squarefree')
 def edf(g,d):
  if len(g)-1==d:return [monic(g)]
  while True:
   a=tr([rng.randrange(25) for _ in range(len(g)-1)])
   h=gcd(sub(powmod(a,(25**d-1)//2,g),[1]),g)
   if 1<len(h)<len(g):
    q,r=divmodp(g,h);assert not r
    return edf(h,d)+edf(q,d)
 out=[];d=1;x=[0,1];h=x
 while 2*d<=len(p)-1:
  h=powmod(h,25,p);g=gcd(sub(h,x),p)
  if len(g)>1:
   out+=edf(g,d);p,r=divmodp(p,g);assert not r;p=monic(p);h=rem(h,p)
  d+=1
 if len(p)>1:out.append(monic(p))
 out.sort(key=lambda f:(len(f),f))
 assert all(irreducible(f) for f in out)
 return out

class Extension:
 def __init__(self,h):self.h=monic(h);self.degree=len(h)-1;self.zero=();self.one=(1,)
 def elt(self,p):return tuple(rem(p,self.h))
 def add(self,a,b):return tuple(add(a,b))
 def sub(self,a,b):return tuple(sub(a,b))
 def neg(self,a):return tuple(neg(a))
 def mul(self,a,b):return tuple(rem(mul(a,b),self.h))
 def inv(self,a):
  if not a:raise ZeroDivisionError
  g,u,v=xgcd(a,self.h)
  if g!=[1]:raise ZeroDivisionError('Element not a unit')
  return tuple(rem(u,self.h))
 def pow(self,a,n):return tuple(powmod(a,n,self.h))
 def scalar(self,a):return () if not a else (int(a),)

def rref_extension(mat,K):
 R=[[K.elt(v) for v in row] for row in mat];m=len(R);n=len(R[0]) if m else 0;k=0;p=[]
 for j in range(n):
  inds=[i for i in range(k,m) if R[i][j]]
  if not inds:continue
  i=inds[0];R[k],R[i]=R[i],R[k];c=K.inv(R[k][j]);R[k]=[K.mul(c,x) for x in R[k]]
  for i in range(m):
   if i!=k and R[i][j]:
    c=R[i][j];R[i]=[K.sub(x,K.mul(c,y)) for x,y in zip(R[i],R[k])]
  p.append(j);k+=1
  if k==m:break
 return R,p

def kernel_extension(mat,K):
 R,p=rref_extension(mat,K);n=len(R[0]);free=[j for j in range(n) if j not in p];out=[]
 for j in free:
  v=[K.zero]*n;v[j]=K.one
  for i,col in enumerate(p):v[col]=K.neg(R[i][j])
  out.append(v)
 return out
