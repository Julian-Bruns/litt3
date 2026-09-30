"""Exact tower F_25[a]/A(a)[s]/(s^3-P(a)).
The public functions optionally use Numba for speed; no probabilistic arithmetic.
"""
import numpy as np
from numba import njit

A_CODES = (1,21,14,22,13)
P_CODES = (11,22,18,5,19,20,15,16,9,22,1)
Q_CODES = (0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24)
BASE = 25**4
ORDER = BASE**3
ADD25 = np.empty((25,25),dtype=np.int64)
MUL25 = np.empty((25,25),dtype=np.int64)
for a in range(25):
 for b in range(25):
  a0,a1=a%5,a//5; b0,b1=b%5,b//5
  ADD25[a,b]=(a0+b0)%5+5*((a1+b1)%5)
  MUL25[a,b]=(a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5)
NEG25=np.array([(-a%5)%5+5*((-(a//5))%5) for a in range(25)],dtype=np.int64)
INV25=np.zeros(25,dtype=np.int64)
for a in range(1,25):
 INV25[a]=next(b for b in range(1,25) if MUL25[a,b]==1)
MOD4=np.array([MUL25[a,INV25[A_CODES[4]]] for a in A_CODES[:4]],dtype=np.int64)

@njit(cache=True)
def badd(a,b):
 r=0; p=1
 for i in range(4):
  r+=ADD25[a%25,b%25]*p
  a//=25; b//=25; p*=25
 return r

@njit(cache=True)
def bneg(a):
 r=0; p=1
 for i in range(4):
  r+=NEG25[a%25]*p; a//=25; p*=25
 return r

@njit(cache=True)
def bmul_slow(a,b):
 aa=np.zeros(4,dtype=np.int64); bb=aa.copy(); cc=np.zeros(7,dtype=np.int64)
 for i in range(4):
  aa[i]=a%25; bb[i]=b%25; a//=25; b//=25
 for i in range(4):
  for j in range(4):
   cc[i+j]=ADD25[cc[i+j],MUL25[aa[i],bb[j]]]
 for i in range(6,3,-1):
  t=cc[i]
  for j in range(4):
   cc[i-4+j]=ADD25[cc[i-4+j],NEG25[MUL25[t,MOD4[j]]]]
 r=0
 for i in range(3,-1,-1): r=r*25+cc[i]
 return r

@njit(cache=True)
def bpow_slow(a,n):
 r=1
 while n:
  if n&1: r=bmul_slow(r,a)
  a=bmul_slow(a,a); n//=2
 return r

@njit(cache=True)
def tables(generator):
 log=np.full(BASE,-1,dtype=np.int64)
 exp=np.zeros(2*(BASE-1),dtype=np.int64)
 t=1
 for i in range(BASE-1):
  if log[t]!=-1: raise ValueError('generator has small order')
  log[t]=i; exp[i]=t
  t=bmul_slow(t,generator)
 if t!=1: raise ValueError('bad multiplicative cycle')
 exp[BASE-1:]=exp[:BASE-1]
 return log,exp

# Exhaustively constructed tables are a certificate of field arithmetic.
# The first primitive element in this deterministic scan is used.
def setup():
 factors=[]; n=BASE-1; p=2
 while p*p<=n:
  if n%p==0:
   factors.append(p)
   while n%p==0: n//=p
  p+=1
 if n>1: factors.append(n)
 generator=next(a for a in range(25,1000)
    if all(bpow_slow(a,(BASE-1)//p)!=1 for p in factors)
    and bpow_slow(a,BASE-1)==1)
 log,exp=tables(generator)
 c=0
 for v in reversed(P_CODES): c=badd(bmul_slow(c,25),v)
 assert bpow_slow(c,(BASE-1)//3)==11
 return generator,log,exp,c

GENERATOR, LOG, EXP, CUBE = setup()

@njit(cache=True)
def bmul(a,b):
 if a==0 or b==0: return 0
 return EXP[LOG[a]+LOG[b]]

@njit(cache=True)
def add(a,b):
 r=0; p=1
 for i in range(3):
  r+=badd(a%BASE,b%BASE)*p
  a//=BASE; b//=BASE; p*=BASE
 return r

@njit(cache=True)
def neg(a):
 r=0; p=1
 for i in range(3):
  r+=bneg(a%BASE)*p; a//=BASE; p*=BASE
 return r

@njit(cache=True)
def sub(a,b): return add(a,neg(b))

@njit(cache=True)
def mul(a,b):
 a0=a%BASE; a1=(a//BASE)%BASE; a2=a//(BASE*BASE)
 b0=b%BASE; b1=(b//BASE)%BASE; b2=b//(BASE*BASE)
 c0=badd(bmul(a0,b0),bmul(CUBE,badd(bmul(a1,b2),bmul(a2,b1))))
 c1=badd(badd(bmul(a0,b1),bmul(a1,b0)),bmul(CUBE,bmul(a2,b2)))
 c2=badd(badd(bmul(a0,b2),bmul(a1,b1)),bmul(a2,b0))
 return c0+BASE*c1+BASE*BASE*c2

@njit(cache=True)
def power(a,n):
 r=1
 while n:
  if n&1: r=mul(r,a)
  a=mul(a,a); n//=2
 return r

@njit(cache=True)
def inv(a):
 if a==0: raise ZeroDivisionError()
 return power(a,ORDER-2)

@njit(cache=True)
def row_reduce(mat):
 out=mat.copy(); r=0; piv=[]
 for c in range(out.shape[1]):
  pos=-1
  for i in range(r,out.shape[0]):
   if out[i,c]!=0: pos=i; break
  if pos==-1: continue
  for j in range(out.shape[1]):
   t=out[r,j]; out[r,j]=out[pos,j]; out[pos,j]=t
  a=inv(out[r,c])
  for j in range(c,out.shape[1]): out[r,j]=mul(out[r,j],a)
  for i in range(out.shape[0]):
   if i==r: continue
   a=out[i,c]
   if a!=0:
    for j in range(c,out.shape[1]): out[i,j]=sub(out[i,j],mul(a,out[r,j]))
  piv.append(c); r+=1
  if r==out.shape[0]: break
 return out,np.array(piv,dtype=np.int64)

@njit(cache=True)
def matmul(a,b):
 r=np.zeros((a.shape[0],b.shape[1]),dtype=np.int64)
 for i in range(a.shape[0]):
  for k in range(a.shape[1]):
   if a[i,k]!=0:
    for j in range(b.shape[1]):
     if b[k,j]!=0: r[i,j]=add(r[i,j],mul(a[i,k],b[k,j]))
 return r

@njit(cache=True)
def mpow_entries(a,n):
 r=a.copy()
 for i in range(a.shape[0]):
  for j in range(a.shape[1]): r[i,j]=power(a[i,j],n)
 return r

@njit(cache=True)
def kernel(a):
 rr,piv=row_reduce(a); rank=len(piv)
 out=np.zeros((a.shape[1],a.shape[1]-rank),dtype=np.int64)
 t=0
 for j in range(a.shape[1]):
  if j not in piv:
   out[j,t]=1
   for i in range(rank): out[piv[i],t]=neg(rr[i,j])
   t+=1
 return out

@njit(cache=True)
def polyval(row,x):
 v=0
 for c in row[::-1]: v=add(mul(v,x),c)
 return v
