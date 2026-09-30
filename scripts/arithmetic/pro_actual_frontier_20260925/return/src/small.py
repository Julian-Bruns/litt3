"""Actual sections of F_abs^{2*}R_xi(O), a complementary necessary test."""
from pathlib import Path
import numpy as np,json
from exact import *
ROOT=Path(__file__).resolve().parents[1]
def build():
    bb=[LP.term(i,j) for i,j in basis(151)]
    C=np.column_stack([residual(E*b,-124) for b in bb]);S=kernel(C)
    print('H0(F2K(O))',S.shape, 'constraint rank',len(rref(C)[1]),flush=True)
    bs=[linear_combination(S[:,j],bb) for j in range(S.shape[1])]
    aa=[(E*b).plus() for b in bs]
    B=np.zeros((19,32,S.shape[1]),dtype=np.uint8)
    for i,bxi in enumerate(XIB):
        F=bxi**25
        B[i]=np.column_stack([residual(F*(a if i<6 else b),-24) for a,b in zip(aa,bs)])
    np.savez_compressed(ROOT/'data'/'small.npz',C=C,S=S,B=B)
    (ROOT/'data'/'small_sections.json').write_text(json.dumps([{'a':a.terms(),'b':b.terms()} for a,b in zip(aa,bs)]))
    print('B shape',B.shape,'nnz',np.count_nonzero(B))
    print('coord ranks',[len(rref(B[i])[1]) for i in range(19)])
    print('b degrees',[max(3*i+10*j for i,j,c in b.terms()) for b in bs])
    return B
if __name__=='__main__':build()
