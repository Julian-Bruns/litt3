"""Literal implementation of formulas (6)--(10) of the problem."""
import numpy as np, json, time
from pathlib import Path
from algebra import *
ROOT=Path(__file__).resolve().parents[1]
C=[2,16,16,7,1,2,7,1,24,11]
e=linear_comb(C,[LP.mon(-m,2) for m in range(1,11)]);E=e**25
fb=B0(31);ab=B0(20);gb=B0(131);qb=B0(120)
ub=[(-1,1)]+[(i,2) for i in range(-5,0)]
vb=[(-2,0),(-1,0)]+[(i,1) for i in range(-5,0)]+[(i,2) for i in range(-6,0)]
zmon=[('u',i,j) for i,j in ub]+[('v',i,j) for i,j in vb]
out1=B1(-144);out2=B1(-155)

def reconstruct(f,alpha,g0,q0,U,V,full=False):
 a=(e*f).plus()+alpha;p=a-e*f
 w=(U*f).minus();g=g0-(U*f).plus()
 chi=e*g0+e*w-U*a;qp=q0+chi.plus()
 bs=E*(g0+w)+V*f;h=-bs.plus()
 ast=-e*h+E*(q0-chi.minus())+V*p;r=-ast.plus()
 residual=np.concatenate((bs.vec(out1),ast.vec(out2)))
 if full:return residual,{'a':a,'f':f,'g':g,'q':qp,'h':h,'r':r,'p':p,'w':w,'chi':chi,'bstar':bs,'astar':ast}
 return residual

def generate():
 t=time.time();z=LP.zero()
 A=[]
 for i,j in gb:A.append(reconstruct(z,z,LP.mon(i,j),z,z,z))
 for i,j in qb:A.append(reconstruct(z,z,z,LP.mon(i,j),z,z))
 A=np.array(A,np.uint8).T
 print('A',A.shape,'rank',rank(A),'seconds',time.time()-t,flush=True)
 L=nullspace(A.T);assert L.shape==(80,315);assert not mm(L,A).any()
 Bs=[];Ts=[]
 for idx,(which,i,j) in enumerate(zmon):
  F=LP.mon(i,j)**25;U=F if which=='u' else z;V=F if which=='v' else z
  B=[]
  for ii,jj in fb:B.append(reconstruct(LP.mon(ii,jj),z,z,z,U,V))
  for ii,jj in ab:B.append(reconstruct(z,LP.mon(ii,jj),z,z,U,V))
  B=np.array(B,np.uint8).T;T=mm(L,B);Bs.append(B);Ts.append(T)
  print('T',idx,'rank',rank(T),'nnz',np.count_nonzero(T),'seconds',round(time.time()-t,2),flush=True)
 return A,L,np.array(Bs,np.uint8),np.array(Ts,np.uint8)

if __name__=='__main__':
 A,L,B,T=generate()
 dest=ROOT/'data'/'tensor.npz';np.savez_compressed(dest,A=A,L=L,B=B,T=T)
 (ROOT/'data'/'bases.json').write_text(json.dumps(dict(f=fb,alpha=ab,g0=gb,q0=qb,extensions=zmon,residual_b=out1,residual_a=out2),indent=2)+'\n')
 print('saved',dest,flush=True)
