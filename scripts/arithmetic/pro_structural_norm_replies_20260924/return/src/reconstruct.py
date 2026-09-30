"""Reconstruct the supplied exact T and Q coefficient tensors."""
from algebra import *
from pathlib import Path
import time,json
ROOT=Path(__file__).resolve().parents[1]
E=powp(e,25)
BB=forbidden(-144); DD=forbidden(-155); QQ=forbidden(-151)
free_basis=[('f',ij) for ij in L(31)]+[('a',ij) for ij in L(20)]
def lower(f,a,U,V,g0=None,q0=None):
 g0={} if g0 is None else g0; q0={} if q0 is None else q0
 p=sub(a,mul(e,f)); g=add(neg(plus(mul(U,f))),g0)
 q=add(plus(sub(mul(e,g),mul(U,p))),q0)
 B=add(mul(E,add(g,mul(U,f))),mul(V,f)); h=neg(plus(B))
 D=add(add(neg(mul(e,h)),mul(E,add(sub(q,mul(e,g)),mul(U,p)))),mul(V,p))
 r=neg(plus(D))
 res=np.concatenate([vec(B,BB),vec(D,DD)])
 return res,(a,q,r,f,g,h)
def main():
 start=time.time(); print('START reconstruction',flush=True)
 const=[]
 for ij in L(131): const.append(lower({},{},{},{},{ij:1},{})[0])
 for ij in L(120): const.append(lower({},{},{},{},{},{ij:1})[0])
 Ac=np.stack(const,axis=1); pc,rc=cokernel(Ac)
 print('T constant rank',Ac.shape[1], 'seconds',time.time()-start,flush=True)
 Aq=np.stack([vec(mul(E,{ij:1}),QQ) for ij in L(124)],axis=1); pq,rq=cokernel(Aq)
 print('Q constant rank',Aq.shape[1], 'seconds',time.time()-start,flush=True)
 TS=[]; QS=[]
 for jj,(u,v) in enumerate(UV):
  U,V=powp(u,25),powp(v,25)
  raw=[]
  for kind,ij in free_basis:
   f={ij:1} if kind=='f' else {}; a=plus(mul(e,f)) if kind=='f' else {ij:1}
   raw.append(lower(f,a,U,V)[0])
  TS.append(mm(pc,np.stack(raw,axis=1)))
  qr=[]
  for ij in L(24):
   n={ij:1}; qr.append(vec(add(mul(E,minus(mul(U,n))),mul(V,n)),QQ))
  QS.append(mm(pq,np.stack(qr,axis=1)))
  print('coordinate',jj,'seconds',round(time.time()-start,2),flush=True)
 np.savez_compressed(ROOT/'data'/'matrices.npz',T=np.stack(TS),Q=np.stack(QS),Ac=Ac,Pc=pc,Rc=rc,Aq=Aq,Pq=pq,Rq=rq)
 print('DONE',time.time()-start,flush=True)
if __name__=='__main__': main()
