"""Seven relative cofactor polynomials on the actual quotient incidence."""
from algebra import *
from pathlib import Path
import numpy as np,json
ROOT=Path(__file__).resolve().parents[1]
B=np.load(ROOT/'data'/'cofactors.npz')['B']
J=np.load(ROOT/'data'/'modification_model.npz')['J']
G=J[[0,1,2,3,7,8,9],:]
D=np.stack([mm(G,B[:,j].reshape(11,35*35)).reshape(7,35,35) for j in range(19)],axis=1)
np.savez_compressed(ROOT/'data'/'global_coupling.npz',D=D,G=G)
print('Seven cofactor tensor shape',D.shape)
print('Each coordinate is sum D[l,j,a,b] z_j m_a m_b; z_j=xi_j^25.')
