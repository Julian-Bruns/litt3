#!/usr/bin/env python3
"""Rebuild all arrays and independently replay the tensor/witness linear algebra."""
import gzip
import json
import sys
import numpy as np
import numba
from reconstruct import *


def check(ok,message):
    if not ok:
        raise AssertionError(message)


def solve_aux(A,B,z,section):
    rhs=NEG[mm(z[None,:],B[:,:,section])[0]]
    rr,piv=rref(np.column_stack((A,rhs)))
    check(list(piv)==list(range(235)),'inconsistent auxiliary equations')
    aux=rr[:235,-1]
    check(np.array_equal(mm(A,aux[:,None])[:,0],rhs),'auxiliary residual')
    return aux


def main():
    print('Tensor verification; Python',sys.version.split()[0], 'NumPy',np.__version__, 'Numba',numba.__version__)
    disk=np.load(ROOT/'data'/'tensor.npz')
    rebuilt=generate()
    A,L,B,T=rebuilt
    for key,arr in zip(('A','L','B','T'),rebuilt):
        check(np.array_equal(disk[key],arr),'reconstruction mismatch: '+key)
    print('PASS complete from-scratch reconstruction equals all archived arrays A,L,B,T')
    with gzip.open(ROOT/'data'/'tensor.json.gz','rt',encoding='utf-8') as f:
        portable=json.load(f)
    for key,arr in zip(('A','L','B','T'),rebuilt):
        check(portable['arrays'][key]['shape']==list(arr.shape),'portable shape '+key)
        check(np.array_equal(np.asarray(portable['arrays'][key]['entries'],np.uint8),arr),'portable entries '+key)
    print('PASS portable JSON tensor equals NPZ and reconstructed arrays')
    check(rank(A)==235 and rank(L)==80 and not mm(L,A).any(),'annihilator dimensions')
    check(all(rank(t)==35 for t in T),'basis ranks')
    print('PASS rank A=235, rank L=80, LA=0, and all 19 basis ranks=35')
    w=json.loads((ROOT/'certificates'/'witness.json').read_text())
    z=np.asarray(w['z'],np.uint8); b=np.asarray(w['b'],np.uint8)
    Tz=mm(z[None,:],T.reshape(19,-1)).reshape(80,35)
    check(not mm(Tz,b[:,None]).any(),'bilinear witness')
    check(rank(Tz)==33,'witness matrix rank')
    ker=nullspace(Tz)
    expected=np.zeros((2,35),np.uint8);expected[0,11]=1;expected[1,23]=1
    check(np.array_equal(ker,expected),'kernel basis at witness')
    aux=solve_aux(A,B,z,23)
    check(np.array_equal(aux,np.array(w['auxiliary_coefficients'],np.uint8)),'stored auxiliary solution')
    print('PASS exact incidence witness, rank T(z)=33, kernel basis b_11,b_23')
    print('PASS all 235 auxiliary coefficients solve the original 315-row equation')

    # Exact projective-line fiber above b_23, not a bounded field search.
    line=json.loads((ROOT/'certificates'/'linear_fiber.json').read_text())
    N=nullspace(T[:,:,23].T)
    check(rank(T[:,:,23].T)==17 and N.shape==(2,19),'fiber dimension')
    check(np.array_equal(N,np.asarray(line['z_basis'],np.uint8)),'fiber basis')
    for i,zz in enumerate(N):
        check(not mm(T[:,:,23].T,zz[:,None]).any(),'fiber generator')
        check(np.array_equal(solve_aux(A,B,zz,23),np.asarray(line['auxiliary_basis'][i],np.uint8)),'fiber auxiliary basis')
    check(N[0,17]==1 and N[0,18]==0 and N[1,17]==0 and N[1,18]==1,'projective line independence')
    print('PASS exact geometric fiber over b_23 is a projective line with archived basis')

    # Verify that the second kernel vector gives the same rank-one quotient,
    # followed by a second section of K(5O).
    zero=LP.zero()
    vpoly=linear_comb(z[6:],[LP.mon(i,j) for i,j in vb]);V=vpoly**25
    q=linear_comb(aux[123:],[LP.mon(i,j) for i,j in qb])
    residual,mainmap=reconstruct(zero,LP.mon(0),zero,q,zero,V,True)
    check(not residual.any(),'main map replay')
    aux2=solve_aux(A,B,z,11)
    gg=linear_comb(aux2[:123],[LP.mon(i,j) for i,j in gb])
    qq=linear_comb(aux2[123:],[LP.mon(i,j) for i,j in qb])
    residual,secondmap=reconstruct(LP.mon(0,1),zero,gg,qq,zero,V,True)
    check(not residual.any(),'second map replay')
    s=(e*LP.mon(0,1)).plus();y=LP.mon(0,1)
    for name,value in {'a':s,'f':y,'q':s*q,'g':y*q,'r':s*mainmap['r'],'h':y*mainmap['r']}.items():
        check(secondmap[name].equal(value),'common quotient factorization: '+name)
    print('PASS both Hom basis maps factor through the same quotient O(-5O)')
    print('TENSOR VERIFICATION PASSED')

if __name__=='__main__':
    main()
