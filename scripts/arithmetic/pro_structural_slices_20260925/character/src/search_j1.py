"""Bounded F25 exploration only; NOT an algebraic-closure exclusion."""
from exact import *
from pathlib import Path
import json,time
root=Path(__file__).resolve().parents[1]
D=np.load(root/'data/pencils.npz');T=D['T'];Q=D['Q'];g=json.loads((root/'data/grades.json').read_text())
zA,zB,zC=g['z_groups'];s0,s1,s2=g['section_groups'];rows=g['row_groups']
I=T[zB][:,rows[1],34].T;J=T[zC][:,rows[1],30:34].transpose(1,0,2)
RI,p,H=rref(I,True);assert len(p)==10
rec=np.stack([mm(H[:10],J[:,i,:]) for i in range(6)],axis=1)
proj=np.stack([mm(H[10:],J[:,i,:]) for i in range(6)],axis=1)
# data for exact symbolic branch parametrization
np.savez_compressed(root/'data/j1_nonzero_alpha2_branch.npz',H=H,I=I,J=J,recovery=rec,projected=proj)
rng=np.random.default_rng(516);counts={};start=time.time();witnesses=[]
for it in range(10000):
 alpha=rng.integers(0,25,4,dtype=np.uint8)
 M=mm(proj.reshape(-1,4),alpha).reshape(proj.shape[:2])
 N=kernel(M)
 c=mm(N,rng.integers(0,25,N.shape[1],dtype=np.uint8))
 if not np.any(c):continue
 b=NEG[mm(mm(rec.reshape(-1,4),alpha).reshape(10,6),c)]
 z=np.zeros(19,dtype=np.uint8);z[zB]=b;z[zC]=c
 tz=mm(z,T.reshape(19,-1)).reshape(80,35)
 const=ADD[tz[:,34],mm(tz[:,30:34],alpha)]
 M=tz[:,s1];RR,pv=rref(np.column_stack((M,const)))
 possible=(15 not in pv)
 if possible:
  qz=mm(z,Q.reshape(19,-1)).reshape(43,16)
  key=(rank(tz),rank(qz));counts[str(key)]=counts.get(str(key),0)+1
  print('SOLVABLE',it,'ranks',key,'z',z.tolist(),'alpha',alpha.tolist(),flush=True)
  witnesses.append({'iteration':it,'z':z.tolist(),'alpha1':alpha.tolist(),'rankT':key[0],'rankQ':key[1]})
 else:counts['inconsistent']=counts.get('inconsistent',0)+1
 if (it+1)%1000==0:print('progress',it+1,'counts',counts,'sec',round(time.time()-start,2),flush=True)
(root/'data/j1_bounded_results.json').write_text(json.dumps({'status':'bounded search only, not geometric exclusion','iterations':10000,'seed':516,'counts':counts,'solvable_samples':witnesses},indent=2)+'\n')
print('DONE',time.time()-start,counts,flush=True)
