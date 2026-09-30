"""Exact checks at selected nonstable connecting images, not a geometric search."""
from pathlib import Path
import json
import numpy as np
from exact import *
ROOT=Path(__file__).resolve().parents[1]
bm=basis(23);cm=basis(12)
M=np.column_stack([vec(mul(e,mon(m)),obs_basis(12)) for m in bm]);NN=nullspace(M)
sections=[]
for j in range(NN.shape[1]):
 B=poly(NN[:,j],bm);sections.append((pos(mul(e,B)),B))
sections += [(mon(m),{}) for m in cm]
us=[(i-6,2) for i in range(1,6)]+[None]*11+[(-1,1),None,None]
vs=[None]*5+[(i-6,1) for i in range(1,6)]+[(i-7,2) for i in range(1,7)]+[None,(-2,0),(-1,0)]
M=np.array([[add(mul(mon(u),A) if u else {},mul(mon(v),B) if v else {}).get((-1,2),0) for u,v in zip(us,vs)] for A,B in sections],dtype=np.uint8)
assert M.shape==(19,19) and rank(M)==19
D=np.load(ROOT/'data/pencils.npz');W=np.load(ROOT/'data/middle_system.npz')['W'];U=np.load(ROOT/'data/unmatched.npz');matched=U['A'][:,:10,:15].transpose(0,2,1)
res=[]
for rr in [9,14]:
 def ev(p):
  q=0
  for (i,j),c in p.items():
   if j==0:
    v=1
    for _ in range(i):v=int(MUL[v,rr])
    q=int(ADD[q,MUL[c,v]])
  return q
 for which in [0,1]:
  rhs=np.array([ev(s[which]) for s in sections],dtype=np.uint8)
  xi=solve(M,rhs)[:,0]
  t=contract_last(D['T'].transpose(1,2,0),xi);q=contract_last(D['Q'].transpose(1,2,0),xi)
  print('r',rr,'fiber coordinate',which,'xi',xi.tolist(),'T rank',rank(t),'Q rank',rank(q),flush=True)
  if not np.any(xi[10:]):
   h=contract_last(matched,xi[:10]);print('matched rank',rank(h),'kernel',nullspace(h).T.tolist(),flush=True)
  res.append(dict(point=[rr,0],fiber_coordinate=which,xi=xi.tolist(),T_rank=rank(t),Q_rank=rank(q)))
(ROOT/'data/branch_sanity.json').write_text(json.dumps(res,indent=2)+'\n')
