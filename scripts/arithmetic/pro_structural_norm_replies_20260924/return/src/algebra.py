"""Exact F_25 and Laurent arithmetic, standard library + NumPy.
Polynomial encoding: dict (x exponent, y exponent): F_25 integer code, y^3=P.
"""
import numpy as np
ADD=np.zeros((25,25),dtype=np.uint8); MUL=np.zeros((25,25),dtype=np.uint8)
for a in range(25):
 for b in range(25):
  a0,a1=a%5,a//5; b0,b1=b%5,b//5
  ADD[a,b]=(a0+b0)%5+5*((a1+b1)%5)
  MUL[a,b]=(a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5)
NEG=np.array([((-a%5)%5)+5*((-(a//5))%5) for a in range(25)],dtype=np.uint8)
INV=np.zeros(25,dtype=np.uint8)
for a in range(1,25): INV[a]=np.flatnonzero(MUL[a]==1)[0]
P_CODES=[11,22,18,5,19,20,15,16,9,22,1]
C_CODES=[2,16,16,7,1,2,7,1,24,11]
P={(i,0):v for i,v in enumerate(P_CODES) if v}
one={(0,0):1}
def add(a,b):
 c=a.copy()
 for ij,v in b.items():
  w=int(ADD[c.get(ij,0),v])
  if w: c[ij]=w
  else: c.pop(ij,None)
 return c
def scale(a,b): return {ij:int(MUL[v,b]) for ij,v in a.items()} if b else {}
def neg(a): return {ij:int(NEG[v]) for ij,v in a.items()}
def sub(a,b): return add(a,neg(b))
def mul(a,b):
 if not a or not b: return {}
 # Convolution over the two F_5 components, followed by y reduction.
 ia=min(i for i,j in a); za=max(i for i,j in a)
 ib=min(i for i,j in b); zb=max(i for i,j in b)
 aa=np.zeros((3,2,za-ia+1),dtype=np.int64)
 bb=np.zeros((3,2,zb-ib+1),dtype=np.int64)
 for (i,j),v in a.items(): aa[j,0,i-ia]=v%5; aa[j,1,i-ia]=v//5
 for (i,j),v in b.items(): bb[j,0,i-ib]=v%5; bb[j,1,i-ib]=v//5
 z=np.zeros((5,2,za-ia+zb-ib+1),dtype=np.int64)
 for j in range(3):
  for k in range(3):
   if not aa[j].any() or not bb[k].any(): continue
   ac=np.convolve(aa[j,0],bb[k,0]); bd=np.convolve(aa[j,1],bb[k,1]); ad=np.convolve(aa[j,0],bb[k,1]); bc=np.convolve(aa[j,1],bb[k,0])
   z[j+k,0]+=ac+3*bd; z[j+k,1]+=ad+bc+bd
 z%=5; c={}; high={}
 for j in range(5):
  for h,v in enumerate(z[j,0]+5*z[j,1]):
   if v: (c if j<3 else high)[(h+ia+ib,j if j<3 else j-3)]=int(v)
 if high: c=add(c,mul(high,P))
 return c
def powp(a,power):
 ans=one.copy()
 while power:
  if power&1: ans=mul(ans,a)
  a=mul(a,a); power//=2
 return ans
def plus(a): return {ij:v for ij,v in a.items() if ij[0]>=0}
def minus(a): return {ij:v for ij,v in a.items() if ij[0]<0}
def L(d): return [(i,j) for j in range(3) for i in range((d-10*j)//3+1)]
def forbidden(d): return [(i,j) for j in range(3) for i in range((d-10*j)//3+1,0)]
def vec(a,basis): return np.array([a.get(ij,0) for ij in basis],dtype=np.uint8)
def matpol(v,basis): return {ij:int(a) for ij,a in zip(basis,v) if a}
e={( -m,2):v for m,v in enumerate(C_CODES,1)}
u_basis=[{(-1,1):1}]+[{(i,2):1} for i in range(-5,0)]
v_basis=[{(i,0):1} for i in (-2,-1)]+[{(i,1):1} for i in range(-5,0)]+[{(i,2):1} for i in range(-6,0)]
UV=[(p,{}) for p in u_basis]+[({},p) for p in v_basis]
def mm(A,B):
 # F_25 matrix product via four integer matrix products.
 A=np.asarray(A,dtype=np.int64); B=np.asarray(B,dtype=np.int64)
 a,b=A%5,A//5; c,d=B%5,B//5
 bd=b@d
 return ((a@c+3*bd)%5+5*((a@d+b@c+bd)%5)).astype(np.uint8)
def rref(A,pivot_limit=None):
 A=A.copy(); m,n=A.shape; lim=n if pivot_limit is None else pivot_limit; piv=[]; r=0
 for c in range(lim):
  nz=np.flatnonzero(A[r:,c])
  if not len(nz): continue
  h=r+int(nz[0]); A[[r,h]]=A[[h,r]]
  A[r]=MUL[A[r],INV[A[r,c]]]
  co=A[:,c].copy(); co[r]=0
  A=ADD[A,MUL[NEG[co][:,None],A[r][None,:]]]
  piv.append(c); r+=1
  if r==m: break
 return A,piv
def kernel(A):
 R,piv=rref(A); free=[j for j in range(A.shape[1]) if j not in piv]
 N=np.zeros((A.shape[1],len(free)),dtype=np.uint8)
 for c,j in enumerate(free):
  N[j,c]=1
  for r,h in enumerate(piv): N[h,c]=NEG[R[r,j]]
 return N
def cokernel(A):
 R,piv=rref(np.concatenate([A,np.eye(A.shape[0],dtype=np.uint8)],axis=1),A.shape[1])
 assert len(piv)==A.shape[1]
 return R[A.shape[1]:,A.shape[1]:],R[:A.shape[1],A.shape[1]:]
