"""Exact arithmetic in K=F25[t]/(A(t)/leading_coefficient(A)).
An integer code contains four base-25 digits; each digit is an F25 code.
The finite-pole and collision computations take place over K and extend
unchanged to its algebraic closure. They do NOT enumerate K-valued parameters.
"""
import functools
from base import *

modA=pscale(A,inv[A[-1]])
@functools.lru_cache(None)
def dig(a):return (a%25,(a//25)%25,(a//625)%25,a//15625)
def enc(a):return sum(t*25**i for i,t in enumerate(a))
def ea(a,b):return enc([add[x][y] for x,y in zip(dig(a),dig(b))])
def en(a):return enc([neg[x] for x in dig(a)])
def es(a,b):return ea(a,en(b))
@functools.lru_cache(300000)
def em(a,b):
 if not a or not b:return 0
 if a==1:return b
 if b==1:return a
 if a>b:a,b=b,a
 z=[0]*7
 for i,x in enumerate(dig(a)):
  for j,y in enumerate(dig(b)):z[i+j]=add[z[i+j]][mul[x][y]]
 for i in range(6,3,-1):
  if z[i]:
   v=z[i]
   for j in range(4):z[i-4+j]=add[z[i-4+j]][neg[mul[v][modA[j]]]]
 return enc(z[:4])
def epow(a,n):
 v=1
 while n:
  if n&1:v=em(v,a)
  a=em(a,a);n//=2
 return v
@functools.lru_cache(None)
def ei(a):
 if not a:raise ZeroDivisionError()
 return epow(a,25**4-2)
def epa(a,b):return trim([ea(a[i] if i<len(a) else 0,b[i] if i<len(b) else 0) for i in range(max(len(a),len(b)))])
def eps(a,b):return trim([em(v,b) for v in a])
def epm(a,b):
 if not a or not b:return []
 z=[0]*(len(a)+len(b)-1)
 for i,x in enumerate(a):
  for j,y in enumerate(b):z[i+j]=ea(z[i+j],em(x,y))
 return trim(z)
def epp(a,n):
 r=[1]
 while n:
  if n&1:r=epm(r,a)
  a=epm(a,a);n//=2
 return r
def epd(a,b):
 a=a[:];q=[0]*max(0,len(a)-len(b)+1);ib=ei(b[-1])
 while len(a)>=len(b) and a:
  m=len(a)-len(b);c=em(a[-1],ib);q[m]=c
  for i,x in enumerate(b):a[i+m]=es(a[i+m],em(c,x))
  trim(a)
 return trim(q),a

def err(M):
 M=[x[:] for x in M];nr=len(M);nc=len(M[0]);piv=[];r=0
 for c in range(nc):
  s=next((j for j in range(r,nr) if M[j][c]),None)
  if s is None:continue
  M[r],M[s]=M[s],M[r];iv=ei(M[r][c]);M[r]=[em(iv,x) for x in M[r]]
  for j in range(nr):
   if j!=r and M[j][c]:
    v=M[j][c];M[j]=[es(x,em(v,y)) for x,y in zip(M[j],M[r])]
  piv.append(c);r+=1
  if r==nr:break
 return M,piv
def ens(M):
 R,p=err(M);free=[i for i in range(len(M[0])) if i not in p];out=[]
 for j in free:
  z=[0]*len(M[0]);z[j]=1
  for i,c in enumerate(p):z[c]=en(R[i][j])
  out.append(z)
 return out

def expand(v,ker):
 return [sumf([em(a,b[i]) for a,b in zip(v,ker)]) for i in range(len(ker[0]))]
def sumf(v):
 z=0
 for x in v:z=ea(z,x)
 return z

