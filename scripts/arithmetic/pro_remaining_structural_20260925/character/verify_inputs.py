"""Check all claimed affine-stratum inputs against the reconstructed tensors.
No polynomial-module generation algorithm is used by this checker.
"""
from pathlib import Path
import argparse
import numpy as np
from exact import mm,rank
ROOT=Path(__file__).resolve().parents[1]

def check_input(name,tensor,first):
    # Earlier homogeneous coordinates vanish; coordinate `first` is one.
    tensor=tensor[:,:,first:]
    nr,nc,ns=tensor.shape;nv=ns-1
    data=np.load(ROOT/f'data/{name}.npz')
    mons=[tuple(map(int,m)) for m in data['monomials']]
    assert len(mons)==nc*(nv+1) and len(set(mons))==len(mons)
    allowed=set()
    for comp in range(nc):
        allowed.add((comp,)+(0,)*nv)
        for j in range(nv):
            ex=[0]*nv;ex[j]=1;allowed.add((comp,)+tuple(ex))
    assert set(mons)==allowed
    idx={m:i for i,m in enumerate(mons)}
    A=np.zeros((nr,len(mons)),dtype=np.uint8)
    for r in range(nr):
        for comp in range(nc):
            A[r,idx[(comp,)+(0,)*nv]]=tensor[r,comp,0]
            for j in range(nv):
                ex=[0]*nv;ex[j]=1
                A[r,idx[(comp,)+tuple(ex)]]=tensor[r,comp,j+1]
    assert np.array_equal(A,data['affine_matrix'])
    H=data['row_transform'];n=int(data['rank'])
    assert H.shape==(nr,nr) and rank(H)==nr
    R=mm(H,A)
    assert not np.any(R[n:]) and rank(R[:n])==n
    lines=iter((ROOT/f'data/{name}.txt').read_text().splitlines())
    assert tuple(map(int,next(lines).split()))==(nv,nc,n)
    for row in R[:n]:
        nt=int(next(lines));actual={}
        for _ in range(nt):
            term=list(map(int,next(lines).split()))
            assert len(term)==nv+2 and 0<term[-1]<25
            m=tuple(term[:-1]);assert m in allowed and m not in actual
            actual[m]=term[-1]
        expected={m:int(c) for m,c in zip(mons,row) if c}
        assert actual==expected
    assert next(lines,None) is None
    print(f'PASS: {name}: exact stratum substitution and invertible row operations; {nv} free variables, {n} generators',flush=True)

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--checkpoints',action='store_true');args=parser.parse_args()
    N=np.load(ROOT/'data/necessary_tensor.npz')['N']
    for j in range(6):check_input('N_chart0' if j==0 else f'N_stratum{j}',N,j)
    A=np.load(ROOT/'data/unmatched.npz')['A']
    H=A[:,:10,:15].transpose(0,2,1)
    for j in range(3,10):check_input(f'matched_stratum{j}',H,j)
    if args.checkpoints:
        for j in range(3):check_input('matched_chart0' if j==0 else f'matched_stratum{j}',H,j)
    print('ALL REQUESTED MODULE INPUTS VERIFIED',flush=True)
if __name__=='__main__':main()
