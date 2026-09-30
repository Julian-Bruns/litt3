from exact import *
from pathlib import Path
import sympy as sp
from sympy.polys.agca.extensions import MonogenicFiniteExtension
from sympy.polys.rings import ring
root=Path(__file__).resolve().parents[1]
B=np.load(root/'data/fonly_char2.npz')['B'][[1,2,3,4,5,8,9,10,11,12]]
A=B.transpose(1,0,2)
A=rref(A.reshape(28,-1))[0][:6].reshape(6,10,4)
np.savez_compressed(root/'data/j2_B_fonly.npz',A=A)
print(A.shape)
print('nnz',np.count_nonzero(A))
for r in range(6):
 print('relation',r,[(i,j,int(A[r,i,j])) for i in range(10) for j in range(4) if A[r,i,j]])
b=sp.Symbol('b');K=MonogenicFiniteExtension(sp.Poly(b*b-b-3,b,modulus=5)); K.has_assoc_Field=True
R,*p=ring('p0,p1,p2,p3',K)
cs=[K.convert(n%5+(n//5)*b) for n in range(25)]
M=[[sum((R.ground_new(cs[int(A[r,i,j])])*p[j] for j in range(4)),R.zero) for i in range(10)] for r in range(6)]
from itertools import permutations
for f in range(4):
 RR,piv=rref(A[:,:,f]);cols=piv
 print('p',f,'pivot',cols,flush=True)
 # fraction-free via sympy DomainMatrix.
 from sympy.polys.matrices import DomainMatrix
 mat=DomainMatrix.from_list([[M[r][i] for i in cols] for r in range(6)],R.to_domain())
 det=mat.det()
 print('det',det,flush=True)
