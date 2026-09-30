"""Extract and certify the 37-by-24 invariant block from the exact full tensors."""
from pathlib import Path
import sys,numpy as np
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT/'upstream'/'src'))
import compute as F
D=dict(np.load(ROOT/'data'/'pure_v_return.npz'))
I=np.array([i for i in range(35) if (i<23 and F.b31[i][1]==1) or (i>=23 and F.b20[i-23][1]==0)],np.int64)
S=np.array([i for i,m in enumerate(F.bas0(24)) if m[1]==0],np.int64)
T=D['T'][:,:,I];C=D['C'][:,:,:,I];Q=D['Q'][:,:,S]
tr=np.where(np.any(T,axis=(0,2)))[0];nr=np.where(np.any(C,axis=(0,1,3))|np.any(Q,axis=(0,2)))[0]
assert (len(I),len(S),len(tr),len(nr))==(15,9,23,14)
# The constant blocks in the invariant Laurent sectors have full column rank.
P=np.load(ROOT/'upstream'/'data'/'hom_tensor.npz')
brows=[i for i,m in enumerate(F.bm144) if m[1]==0]+[len(F.bm144)+i for i,m in enumerate(F.bm155) if m[1]==2]
bcols=[i for i,m in enumerate(F.b131) if m[1]==1]+[len(F.b131)+i for i,m in enumerate(F.b120) if m[1]==0]
A=P['A'][np.ix_(brows,bcols)]
N=np.load(ROOT/'upstream'/'data'/'negative_second.npz')
trows=[i for i,m in enumerate(F.bas1(-151)) if m[1]==2];tcols=[i for i,m in enumerate(F.bas0(124)) if m[1]==0]
AN=N['A'][np.ix_(trows,tcols)]
assert A.shape==(105,82) and len(F.rref(A)[1])==82
assert AN.shape==(56,42) and len(F.rref(AN)[1])==42
np.savez_compressed(ROOT/'data'/'equivariant.npz',T=T[:,tr,:],C=C[:,:,nr,:],Q=Q[:,nr,:],c_indices=I,s_indices=S,T_rows=tr,N_rows=nr)
print('PASS: invariant constant blocks 105x82 rank 82 and 56x42 rank 42; reduced matrix 37x24')

