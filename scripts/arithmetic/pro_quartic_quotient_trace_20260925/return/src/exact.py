"""Exact F_25 and Laurent arithmetic for the specified curve. Python >=3.11, NumPy."""
from __future__ import annotations
import numpy as np
from functools import lru_cache
ADD=np.zeros((25,25),dtype=np.uint8); MUL=ADD.copy()
for z in range(25):
 a,b=z%5,z//5
 for w in range(25):
  c,d=w%5,w//5
  ADD[z,w]=(a+c)%5+5*((b+d)%5)
  MUL[z,w]=(a*c+3*b*d)%5+5*((a*d+b*c+b*d)%5)
NEG=np.array([(-z%5)%5+5*((-(z//5))%5) for z in range(25)],dtype=np.uint8)
SUB=ADD[:,NEG]
INV=np.zeros(25,dtype=np.uint8)
for a in range(1,25): INV[a]=next(b for b in range(1,25) if MUL[a,b]==1)
P_ROW=[11,22,18,5,19,20,15,16,9,22,1]
C_ROW=[2,16,16,7,1,2,7,1,24,11]
P={(i,0):v for i,v in enumerate(P_ROW) if v}
e={(-i-1,2):v for i,v in enumerate(C_ROW)}
u_basis=[{(-1,1):1}]+[{(i,2):1} for i in range(-5,0)]
v_basis=[{(i,0):1} for i in range(-2,0)]+[{(i,1):1} for i in range(-5,0)]+[{(i,2):1} for i in range(-6,0)]
COORDS=[(u,{}) for u in u_basis]+[({},v) for v in v_basis]

def add(*polys):
 z={}
 for p in polys:
  for m,c in p.items():
   n=int(ADD[z.get(m,0),c])
   if n:z[m]=n
   elif m in z:del z[m]
 return z

def scale(a,p):
 if not a:return {}
 return {m:int(MUL[a,c]) for m,c in p.items()}

def neg(p):return {m:int(NEG[c]) for m,c in p.items()}
def sub(p,q):return add(p,neg(q))
def mul(p,q):
 z={}
 for (i,j),c in p.items():
  for (h,l),d in q.items():
   cc=int(MUL[c,d]); jj=j+l; ii=i+h
   if jj<3:
    m=(ii,jj); z[m]=int(ADD[z.get(m,0),cc])
   else:
    for h2,d2 in enumerate(P_ROW):
     if d2:
      m=(ii+h2,jj-3); z[m]=int(ADD[z.get(m,0),MUL[cc,d2]])
 return {m:c for m,c in z.items() if c}
def power(p,n):
 z={(0,0):1}
 while n:
  if n&1:z=mul(z,p)
  n//=2
  if n:p=mul(p,p)
 return z
@lru_cache(None)
def Ppower(n):return power(P,n)
def frobenius25(p):
 z={}
 for (i,j),c in p.items():
  z=add(z,{(25*i+h,25*j%3):int(MUL[c,d]) for (h,_),d in Ppower(25*j//3).items()})
 return z
E=frobenius25(e)
UV25=[(frobenius25(u),frobenius25(v)) for u,v in COORDS]
def plus(p):return {m:c for m,c in p.items() if m[0]>=0}
def minus(p):return {m:c for m,c in p.items() if m[0]<0}
def L(d):return [(i,j) for j in range(3) for i in range(max(0,(d-10*j)//3+1))]
def forbidden(d):return [(i,j) for j in range(3) for i in range((d-10*j)//3+1,0)]
def vec(p,basis):return np.array([p.get(m,0) for m in basis],dtype=np.uint8)
def poly(v,basis):return {m:int(c) for m,c in zip(basis,v) if c}
def dot(A,B):
 A=np.asarray(A,dtype=np.uint8); B=np.asarray(B,dtype=np.uint8)
 one=(B.ndim==1)
 if one:B=B[:,None]
 out=np.zeros((A.shape[0],B.shape[1]),dtype=np.uint8)
 for k in range(A.shape[1]):
  if np.any(A[:,k]) and np.any(B[k]):out=ADD[out,MUL[A[:,k,None],B[k,None,:]]]
 return out[:,0] if one else out

def rref(A,pivot_limit=None):
 A=np.array(A,dtype=np.uint8,copy=True); nr,nc=A.shape
 if pivot_limit is None:pivot_limit=nc
 piv=[];r=0
 for c in range(pivot_limit):
  nz=np.flatnonzero(A[r:,c])
  if len(nz)==0:continue
  i=r+int(nz[0]); A[[r,i]]=A[[i,r]]
  A[r]=MUL[INV[A[r,c]],A[r]]
  idx=np.flatnonzero(A[:,c]); idx=idx[idx!=r]
  A[idx]=SUB[A[idx],MUL[A[idx,c,None],A[r,None,:]]]
  piv.append(c);r+=1
  if r==nr:break
 return A,piv

def rank(A):return len(rref(A)[1])
def kernel(A):
 R,piv=rref(A); free=[j for j in range(A.shape[1]) if j not in piv]
 out=np.zeros((A.shape[1],len(free)),dtype=np.uint8)
 for k,j in enumerate(free):
  out[j,k]=1
  out[piv,k]=NEG[R[:len(piv),j]]
 return out

def eliminate(A):
 n,m=A.shape
 R,piv=rref(np.concatenate([A,np.eye(n,dtype=np.uint8)],axis=1),m)
 if len(piv)!=m:raise ValueError(('not injective',len(piv),m))
 return R[m:,m:],R[:m,m:]

def linear_combination(coeff,polys):
 z={}
 for a,p in zip(coeff,polys):
  if a:z=add(z,scale(int(a),p))
 return z

FB=L(31); AB=L(20); GB=L(131); QB=L(120)
RAWB=forbidden(-144); RAWD=forbidden(-155); RAWQ=forbidden(-151)
NB=L(24); A0B=L(124)
FREE=[({m:1},plus(mul(e,{m:1}))) for m in FB]+[({},{m:1}) for m in AB]

def raw_quotient(U,V,f,a,g0=None,q0=None,return_map=False):
 g0={} if g0 is None else g0; q0={} if q0 is None else q0
 p=sub(a,mul(e,f))
 uf=mul(U,f); g=add(neg(plus(uf)),g0)
 q=add(plus(sub(mul(e,g),mul(U,p))),q0)
 B=add(mul(E,add(g,uf)),mul(V,f));h=neg(plus(B))
 D=add(neg(mul(e,h)),mul(E,add(q,neg(mul(e,g)),mul(U,p))),mul(V,p));r=neg(plus(D))
 residual=np.concatenate([vec(B,RAWB),vec(D,RAWD)])
 if return_map:return residual,(a,q,r,f,g,h)
 return residual

def neg_residual(U,V,n0,a0=None):
 return vec(add(mul(E,add(a0 or {},minus(mul(U,n0)))),mul(V,n0)),RAWQ)

def evaluate(tensor,z):
 out=np.zeros(tensor.shape[1:],dtype=np.uint8)
 for j,c in enumerate(z):
  if c:out=ADD[out,MUL[c,tensor[j]]]
 return out

# Faster exact dense convolution for nontrivial Laurent products. No floating point.
_mul_sparse=mul

def _conv25(a,b):
 a=a.astype(np.int64);b=b.astype(np.int64)
 a0=a%5;a1=a//5;b0=b%5;b1=b//5
 ac=np.convolve(a0,b0);bd=np.convolve(a1,b1)
 cross=np.convolve(a0+a1,b0+b1)-ac
 return ((ac+3*bd)%5+5*(cross%5)).astype(np.uint8)

def mul_dense(p,q):
 def groups(z):
  out=[]
  for j in range(3):
   terms={i:c for (i,l),c in z.items() if l==j}
   if not terms:continue
   lo=min(terms);hi=max(terms);v=np.zeros(hi-lo+1,dtype=np.uint8)
   for i,c in terms.items():v[i-lo]=c
   out.append((j,lo,v))
  return out
 ans={}
 for j,lo,a in groups(p):
  for l,mo,b in groups(q):
   c=_conv25(a,b);i0=lo+mo;jj=j+l
   if jj>=3:c=_conv25(c,np.array(P_ROW,dtype=np.uint8));jj-=3
   for h in np.flatnonzero(c):
    mon=(i0+int(h),jj);ans[mon]=int(ADD[ans.get(mon,0),c[h]])
 return {m:c for m,c in ans.items() if c}

def mul(p,q):
 if len(p)*len(q)<150:return _mul_sparse(p,q)
 return mul_dense(p,q)
