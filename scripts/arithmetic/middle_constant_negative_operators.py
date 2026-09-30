#!/usr/bin/env python3
"""Exhaust constant linear operators from matched K maps to negative-line maps.

Seek T:k^15->k^16 and constant row identities Q(z)T=R W(z), where
W is the complete matched H,J system and Q the full Hom-to-L pencil.
Any such operator must kill an admissible map when Hom(F^2 R,L)=0.
Failure in this constant class does not exclude parameter-dependent operators.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path

import numpy as np
from sage.all import GF, PolynomialRing, matrix


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument("data",type=Path)
    ap.add_argument("--output",type=Path,required=True)
    args=ap.parse_args(); start=time.time()
    r=np.load(args.data/'residual_system.npz',allow_pickle=False)
    H,J=r['H'],r['J']
    Q=np.load(args.data/'pencils.npz',allow_pickle=False)['Q'][:16]
    assert H.shape==(30,15,10) and J.shape==(23,15,6) and Q.shape==(16,43,16)
    W=np.zeros((53,16,15),dtype=np.uint8)
    W[:30,:10,:]=H.transpose(0,2,1)
    W[30:,10:,:]=J.transpose(0,2,1)
    k=GF(25,'a',modulus=PolynomialRing(GF(5),'v')([2,4,1]))
    dec=lambda c:k(int(c)%5)+k(int(c)//5)*k.gen()
    enc=lambda c:int(c.polynomial()[0])+5*int(c.polynomial()[1])
    A=matrix(k,53,240,[dec(c) for c in W.reshape(-1)])
    assert A.rank()==53
    N=A.right_kernel().basis_matrix().transpose()
    assert N.ncols()==187 and A*N==0
    slices=[N[[z*15+s for z in range(16)],:] for s in range(15)]
    blocks=[matrix(k,43,16,[dec(Q[z,q,i]) for q in range(43) for z in range(16)]) for i in range(16)]
    cols=[]
    for i in range(16):
        for s in range(15):
            cols.append((blocks[i]*slices[s]).list())
    M=matrix(k,cols).transpose()
    print('OPERATOR SYSTEM',M.nrows(),M.ncols(),flush=True)
    K=M.right_kernel().basis_matrix()
    assert M*K.transpose()==0
    ops=[matrix(k,16,15,row) for row in K.rows()]
    constraints=matrix(k,0,15)
    for T in ops:
        constraints=constraints.stack(T)
    constraints=constraints.row_space().basis_matrix()
    identities=[]
    piv=list(A.pivots()); inv=A[:,piv].inverse()
    for T in ops:
        QT=matrix(k,43,240,[sum(dec(Q[z,q,i])*T[i,s] for i in range(16))
                            for q in range(43) for z in range(16) for s in range(15)])
        rows=QT[:,piv]*inv
        assert rows*A==QT
        identities.append(rows)
    checkpoint=args.output.with_suffix('.npz')
    arr=lambda M:np.array([[enc(c) for c in row] for row in M.rows()],dtype=np.uint8)
    np.savez_compressed(checkpoint,operators=np.array([arr(T) for T in ops],dtype=np.uint8),
                        row_identities=np.array([arr(S) for S in identities],dtype=np.uint8),
                        forced_constraints=arr(constraints))
    out={'status':'COMPLETE','seconds':time.time()-start,'operator_space_dimension':int(K.nrows()),
         'forced_map_constraint_rank':int(constraints.nrows()),'system_rank':int(M.ncols()-K.nrows()),
         'source_sha256':{p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in [args.data/'residual_system.npz',args.data/'pencils.npz']},
         'checkpoint_sha256':hashlib.sha256(checkpoint.read_bytes()).hexdigest(),
         'scope':'Complete constant linear operator class on the actual matched system; not arbitrary differential or parameter-dependent operators.'}
    args.output.write_text(json.dumps(out,indent=2)+'\n')
    print(json.dumps(out),flush=True)


if __name__=='__main__':
    main()
