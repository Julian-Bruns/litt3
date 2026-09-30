"""Exact F25 arithmetic, linear algebra and Laurent functions. No floats.
Encoding [a+5b]=a+b*beta, beta^2=beta+3. Arrays are uint8 field codes.
"""
import numpy as np
ADD=np.empty((25,25),dtype=np.uint8);MUL=ADD.copy()
for a in range(25):
 for b in range(25):
  a0,a1=a%5,a//5;b0,b1=b%5,b//5
  ADD[a,b]=(a0+b0)%5+5*((a1+b1)%5)
  MUL[a,b]=(a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5)
NEG=np.array([(-a%5)%5+5*((-(a//5))%5) for a in range(25)],dtype=np.uint8)
SUB=ADD[:,NEG];INV=np.zeros(25,dtype=np.uint8)
for a in range(1,25):INV[a]=np.flatnonzero(MUL[a]==1)[0]
def mm(A,B):
 A=np.asarray(A,dtype=np.int64);B=np.asarray(B,dtype=np.int64)
 a,b=A%5,A//5;c,d=B%5,B//5;bd=b@d
 return ((a@c+3*bd)%5+5*((a@d+b@c+bd)%5)).astype(np.uint8)
def rref(A,transform=False):
 A=np.array(A,dtype=np.uint8,copy=True);nr,nc=A.shape;H=np.eye(nr,dtype=np.uint8) if transform else None;piv=[];r=0
 for j in range(nc):
  q=np.flatnonzero(A[r:,j])
  if not len(q):continue
  q=int(q[0])+r
  if q!=r:
   A[[r,q]]=A[[q,r]]
   if transform:H[[r,q]]=H[[q,r]]
  inv=INV[A[r,j]];A[r]=MUL[inv,A[r]]
  if transform:H[r]=MUL[inv,H[r]]
  rows=np.flatnonzero(A[:,j]);rows=rows[rows!=r];cs=A[rows,j].copy()
  A[rows]=SUB[A[rows],MUL[cs[:,None],A[r][None,:]]]
  if transform:H[rows]=SUB[H[rows],MUL[cs[:,None],H[r][None,:]]]
  piv.append(j);r+=1
  if r==nr:break
 return (A,piv,H) if transform else (A,piv)
def rank(A):return len(rref(A)[1])
def nullspace(A):
 R,piv=rref(A);free=[j for j in range(R.shape[1]) if j not in piv];N=np.zeros((R.shape[1],len(free)),dtype=np.uint8)
 for t,j in enumerate(free):
  N[j,t]=1
  for r,k in enumerate(piv):N[k,t]=NEG[R[r,j]]
 return N
def solve(A,b):
 b=np.asarray(b,dtype=np.uint8)
 if b.ndim==1:b=b[:,None]
 R,piv=rref(np.column_stack([A,b]));n=A.shape[1]
 if any(p>=n for p in piv):return None
 x=np.zeros((n,b.shape[1]),dtype=np.uint8)
 for r,p in enumerate(piv):x[p]=R[r,n:]
 return x
def contract_last(A,x):return mm(A.reshape(-1,len(x)),np.array(x,dtype=np.uint8)[:,None]).reshape(A.shape[:-1])
P_ROW=[11,22,18,5,19,20,15,16,9,22,1];E_ROW=[2,16,16,7,1,2,7,1,24,11]
P={(i,0):c for i,c in enumerate(P_ROW) if c};ONE={(0,0):1}
def add(*ps):
 r={}
 for p in ps:
  for m,c in p.items():
   q=int(ADD[r.get(m,0),c])
   if q:r[m]=q
   elif m in r:del r[m]
 return r
def scale(p,c):return {m:int(MUL[c,a]) for m,a in p.items()} if c else {}
def neg(p):return {m:int(NEG[a]) for m,a in p.items()}
def sub(p,q):return add(p,neg(q))
def mul(p,q):
 r={}
 for (i,j),c in p.items():
  for (k,l),d in q.items():
   a=int(MUL[c,d]);n=j+l
   if n<3:
    key=(i+k,n);b=int(ADD[r.get(key,0),a])
    if b:r[key]=b
    elif key in r:del r[key]
   else:
    for (t,_),cc in P.items():
     key=(i+k+t,n-3);b=int(ADD[r.get(key,0),MUL[a,cc]])
     if b:r[key]=b
     elif key in r:del r[key]
 return r
def power(p,n):
 r=ONE
 while n:
  if n&1:r=mul(r,p)
  n//=2
  if n:p=mul(p,p)
 return r
def pos(p):return {m:c for m,c in p.items() if m[0]>=0}
def minus(p):return {m:c for m,c in p.items() if m[0]<0}
def basis(d):return [(i,j) for j in range(3) for i in range((d-10*j)//3+1)]
def obs_basis(d):return [(i,j) for j in range(3) for i in range((d-10*j)//3+1,0)]
def vec(p,mons):return np.array([p.get(m,0) for m in mons],dtype=np.uint8)
def poly(v,mons):return {m:int(c) for m,c in zip(mons,v) if c}
def mon(m):return {m:1}
e={(-i-1,2):c for i,c in enumerate(E_ROW)};E=power(e,25)
def input_mons(full=True):
 us=[(i-6,2) for i in range(1,6)]+[None]*11
 vs=[None]*5+[(i-6,1) for i in range(1,6)]+[(i-7,2) for i in range(1,7)]
 if full:us += [(-1,1),None,None];vs += [None,(-2,0),(-1,0)]
 return us,vs
def uv_powers(full=True):
 us,vs=input_mons(full)
 return [(power(mon(u),25) if u else {},power(mon(v),25) if v else {}) for u,v in zip(us,vs)]
def raw_equations(U,V,f,alpha,g0=None,q0=None,reconstruct=False):
 g0={} if g0 is None else g0;q0={} if q0 is None else q0
 a=add(pos(mul(e,f)),alpha);ps=sub(a,mul(e,f));g=add(neg(pos(mul(U,f))),g0)
 H=sub(mul(e,g),mul(U,ps));q=add(pos(H),q0)
 B=add(mul(E,minus(mul(U,f))),mul(V,f),mul(E,g0));h=neg(pos(B))
 D=add(mul(e,pos(B)),neg(mul(E,minus(H))),mul(E,q0),mul(V,ps));r=neg(pos(D))
 if reconstruct:return a,q,r,f,g,h,B,D
 return np.concatenate([vec(B,obs_basis(-144)),vec(D,obs_basis(-155))])
def raw_L(U,V,n0,a0=None):
 a0={} if a0 is None else a0
 return vec(add(mul(E,add(a0,minus(mul(U,n0)))),mul(V,n0)),obs_basis(-151))
