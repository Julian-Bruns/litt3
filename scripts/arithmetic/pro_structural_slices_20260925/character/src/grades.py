from exact import *
from macaulay import independent_equations
from pathlib import Path
import json
root=Path(__file__).resolve().parents[1];T=np.load(root/'data/pencils.npz')['T'];Q=np.load(root/'data/pencils.npz')['Q']
zs=[[0,6,7],[1,2,3,4,5,8,9,10,11,12],list(range(13,19))]
ws=[list(range(11))+[34],list(range(11,19))+list(range(23,30)),list(range(19,23))+list(range(30,34))]
zgrade={i:g for g,inds in enumerate(zs) for i in inds};wgrade={i:g for g,inds in enumerate(ws) for i in inds}
rr=[[],[],[]]
for r in range(80):
 nz,ns=np.nonzero(T[:,r,:]); gr=sorted({(zgrade[int(i)]+wgrade[int(j)])%3 for i,j in zip(nz,ns)})
 if len(gr)!=1: print('mixed row',r,gr)
 else: rr[gr[0]].append(r)
print('graded row counts',list(map(len,rr)))
for g in range(3):
 for j in range(3):
  A=T[zs[g]][:,:,ws[j]].transpose(1,0,2)
  print('zgrade',g,'section',j,'tensor row rank',rank(A.reshape(80,-1)))
# j2 projection which kills alpha of other characters, after zA=zC=0.
other=[i for i in range(23,35) if i not in ws[2]]
N=T[zs[1]][:,:,other].transpose(1,0,2).reshape(80,-1)
H=kernel(N.T).T
Projected=np.stack([mm(H,T[z][:,ws[2]]) for z in zs[1]]).transpose(1,0,2)
A=independent_equations(Projected)
Aold=np.load(root/'data/j2_B_full.npz')['A']
assert np.array_equal(A,Aold)
print('j2 unrestricted alpha projection PASS',N.shape,H.shape,A.shape)
(root/'data/grades.json').write_text(json.dumps({'z_groups':zs,'section_groups':ws,'row_groups':rr},indent=2)+'\n')
np.savez_compressed(root/'certificates/j2_alpha_projection.npz',H=H,projected=A)
