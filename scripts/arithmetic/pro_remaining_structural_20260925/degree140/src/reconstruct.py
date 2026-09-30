"""Reconstruct the entire homogeneous linear coefficient spaces over K=F_(5^8).
The affine origin is N5=vQ. Conditions at the roots of t are imposed using
polynomial remainders modulo t and t^2, without choosing root extensions.
"""
import json, math
import numpy as np
from ff import *
P=[11,22,18,5,19,20,15,16,9,22,1]
A=[1,21,14,22,13]
Q=[0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]
B0=[8,14,19,2,10,19,3,24,18,16]
L0=[18,20,20,15]
alpha=25
t=pdiv(pscale(A,inv(13)),[neg(alpha),1])
S=pdiv(psub(Q,ppow(L0,5)),ppow(t,3))
epsilon=peval([24,4,0,23],alpha)
eta=peval([11,0,18,20],alpha)
Cd=peval([3,10,1,14],alpha)
Ca=peval([18,14,10,19],alpha)

def zero():return [[],[],[]]
def cone(a):return [list(a),[],[]]
def cadd(a,b):return [padd(x,y) for x,y in zip(a,b)]
def cscale(a,s):return [pscale(x,s) for x in a]
def csub(a,b):return cadd(a,cscale(b,4))
def cxmul(a,p):return [pmul(x,p) for x in a]
def cmul(a,b):
 out=zero()
 for i in range(3):
  for j in range(3):
   q=pmul(a[i],b[j]);d=i+j
   if d>=3:q=pmul(q,P);d-=3
   out[d]=padd(out[d],q)
 return out

def cpow(a,n):
 z=cone([1])
 while n:
  if n&1:z=cmul(z,a)
  a=cmul(a,a);n>>=1
 return z

def cmon(i,j):
 r=zero();r[j]=[0]*i+[1];return r

def basisL(d):return [(i,j) for j in range(3) for i in range(max(-1,(d-10*j)//3)+1)]
D2mons=basisL(14)
slots=[(2,i,j) for i,j in D2mons]+[(n,i,j) for n,d in [(3,46),(4,57),(5,70)] for i,j in basisL(d)]+[('kappa',0,0)]

B2=ppow(B0,2);B3=ppow(B0,3);L2=ppow(L0,2);L3=ppow(L0,3)
t2=ppow(t,2);y10=[[],ppow(P,3),[]];ty10=cxmul(y10,ppow(t,3))

def unpack(vec):
 H={n:zero() for n in [2,3,4,5]};k=0
 for s,z in zip(slots,vec):
  z=int(z)
  if not z:continue
  n,i,j=s
  if n=='kappa':k=z;continue
  q=cmon(i,j)
  if n==2:q=cmul(q,cmon(0,2))
  H[n]=cadd(H[n],cscale(q,z))
 return H,k

def constraints(vec):
 H,k=unpack(vec);out=[]
 # y-ideal conditions at j=3,4,5; j=1,2 hold automatically.
 E3=csub(H[3],cscale(cxmul(H[2],B0),3))
 E4=cadd(csub(H[4],cscale(cxmul(H[3],B0),2)),cscale(cxmul(H[2],B2),3))
 E5=cadd(csub(cadd(H[5],cxmul(H[3],B2)),cxmul(H[4],B0)),cscale(cxmul(H[2],B3),4))
 for j,E in [(3,E3),(4,E4),(5,E5)]:
  for z in range(3):
   e=max(0,(j-z+2)//3);mod=ppow(P,e);rem=pmod(E[z],mod)
   out.extend(rem+[0]*(len(mod)-1-len(rem)))
 # Root-of-t conditions, all five original j retained algebraically.
 E=cadd(csub(H[4],cscale(cxmul(H[3],L0),2)),cscale(cxmul(H[2],L2),3))
 for p in E:
  rem=pmod(p,t);out.extend(rem+[0]*(3-len(rem)))
 E=cadd(csub(cadd(H[5],cxmul(H[3],L2)),cxmul(H[4],L0)),cscale(cxmul(H[2],L3),4))
 E=cadd(cxmul(E,S),cscale(y10,k))
 for p in E:
  rem=pmod(p,t2);out.extend(rem+[0]*(6-len(rem)))
 # Infinity condition j=10. Other infinity conditions follow from pole bounds.
 E=cadd(cxmul(H[5],Q),cscale(ty10,k))
 for j in range(3):
  for i in range(max(0,(125-10*j)//3+1),max(len(E[j]),[43,40,36][j])):
   out.append(E[j][i] if i<len(E[j]) else 0)
 return out

def matmul(A,B):
 A=np.asarray(A);B=np.asarray(B);C=np.zeros((A.shape[0],B.shape[1]),np.int32)
 for j in range(A.shape[1]):C=vadd(C,vmul(A[:,j,None],B[None,j,:]))
 return C

def coeffrow(n,i,j):
 r=np.zeros(len(slots),np.int32)
 if (n,i,j) in slots:r[slots.index((n,i,j))]=1
 return r

def topmatrix(linear):
 return np.array([coeffrow('kappa',0,0),coeffrow(2,1,1) if linear else coeffrow(2,4,0),coeffrow(4,19,0),coeffrow(4,12,2),coeffrow(5,16,2)])

def space(M,root):
 linear=root is not None
 r=coeffrow(2,1,1) if not linear else sum_eval_row(root)
 Mv=np.vstack([M,r]);B,piv=kernel(Mv)
 assert len(B)==7,(root,len(B))
 T=matmul(topmatrix(linear),B.T);_,tp=rref(T)
 assert len(tp)==5
 # A canonical right-inverse splitting with unused kernel coordinates zero.
 W=solve(T,np.eye(5,dtype=np.int32));split=matmul(B.T,W).T
 kb,kp=kernel(T);ker=matmul(kb,B)
 assert len(ker)==2
 assert not matmul(Mv,split.T).any() and not matmul(Mv,ker.T).any()
 assert np.array_equal(matmul(topmatrix(linear),split.T),np.eye(5,dtype=np.int32))
 assert not matmul(topmatrix(linear),ker.T).any()
 # Verify the supplied top relation, and b=epsilon*kappa, for all 7 directions.
 for v in list(split)+list(ker):
  k,a,d,e,f=matmul(topmatrix(linear),np.array(v)[:,None])[:,0]
  assert dot(coeffrow(3,12,1),v)==mul(epsilon,int(k))
  assert dot(coeffrow(3,15,0),v)==add(mul(Cd,int(d)),mul(Ca,int(a)) if linear else 0)
 return {'root':root,'linear':linear,'split':split.tolist(),'kernel':ker.tolist(),'matrix_rank':len(piv),'dimension':len(B)}

def sum_eval_row(root):
 r=np.zeros(len(slots),np.int32)
 for i in range(5):r[slots.index((2,i,0))]=powf(root,i)
 return r

def build():
 print('K constants:',dict(alpha=alpha,epsilon=epsilon,eta=eta,Cd=Cd,Ca=Ca,t=t),flush=True)
 assert not pmod(psub(Q,ppow(B0,5)),ppow(P,2))
 assert not pmod(psub(Q,ppow(L0,5)),ppow(A,3))
 assert pder(Q)==pmul(P,ppow(A,2))
 assert pgcd(S,t)==[1]
 assert pgcd(P,A)==[1] and pgcd(P,pder(P))==[1] and pgcd(A,pder(A))==[1]
 vals=np.zeros(ORDER,dtype=np.int32);elems=np.arange(ORDER,dtype=np.int32)
 for q in reversed(P):vals=vadd(vmul(vals,elems),q)
 roots=np.flatnonzero(vals==0).tolist();assert len(roots)==10
 print('P roots:',roots,flush=True)
 M=np.array([constraints(np.eye(1,len(slots),i,dtype=np.int32)[0]) for i in range(len(slots))],dtype=np.int32).T
 print('Constraint matrix:',M.shape,flush=True)
 B,piv=kernel(M);print('Unrestricted dimension:',len(B),flush=True);assert len(B)==8
 cases=[]
 for root in [None]+roots:
  V=space(M,root);cases.append(V);print('case',root,'rank',V['matrix_rank'],'dim',V['dimension'],flush=True)
 data={'field':{'base_characteristic':5,'beta_relation':[2,4,1],'alpha_relation':[5,2,6,7,1],'encoding':'c0+25*c1+625*c2+15625*c3, ci=[a+5b]'},'P':P,'A':A,'Q':Q,'B0':B0,'L0':L0,'alpha':alpha,'epsilon':epsilon,'eta':eta,'Cd':Cd,'Ca':Ca,'t':t,'slots':slots,'top_order':['kappa','a','d','e','f'],'cases':cases}
 (ROOT/'data'/'spaces.json').write_text(json.dumps(data,indent=2)+'\n')
 np.save(ROOT/'data'/'constraints.npy',M)
 print('EXACT RECONSTRUCTION PASSED',flush=True)
 return data
if __name__=='__main__':build()
