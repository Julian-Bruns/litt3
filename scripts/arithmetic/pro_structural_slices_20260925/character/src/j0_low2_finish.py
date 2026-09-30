from exact import *
from macaulay import independent_equations,macaulay
from pathlib import Path
import json
root=Path(__file__).resolve().parents[1];T=np.load(root/'data/pencils.npz')['T'];g=json.loads((root/'data/grades.json').read_text());za,zb,zc=g['z_groups']
KA=np.load(root/'certificates/j0_low2_A.npz')['common'];KB=np.load(root/'certificates/j0_low2_B.npz')['common']
S=np.zeros((19,8),dtype=np.uint8);S[za,0]=KA[:,0];S[zb,1]=KB[:,0];S[np.ix_(zc,range(2,8))]=np.eye(6,dtype=np.uint8)
cols=[0,1,2]+list(range(23,35));TT=mm(S.T,T.reshape(19,-1)).reshape(8,80,35)[:,:,cols]
A=independent_equations(TT.transpose(1,0,2))
print('tensor',A.shape,flush=True)
np.savez_compressed(root/'data/j0_low2_restricted.npz',S=S,columns=cols,A=A)
for d in [1,2,3]:
 with open(root/f'data/j0_low2_degree{d}.txt','w') as f:
  f.write(' '.join(map(str,A.shape))+'\n'+' '.join(map(str,A.flatten()))+f'\n{d} 3\n')
