"""Bihomogeneous degree-(1,d) ideal membership by exact F25 row reduction."""
from itertools import combinations_with_replacement
from exact import *

def monomials(n,d): return list(combinations_with_replacement(range(n),d))

def macaulay(A,d):
    # A[relation,z_variable,w_variable]. Row is sum A[r,i,j] z_i w_j.
    nr,nz,nw=A.shape
    mons=monomials(nw,d); prev=monomials(nw,d-1)
    index={m:i for i,m in enumerate(mons)}; nd=len(mons)
    out=np.zeros((nr*len(prev),nz*nd),dtype=np.uint8)
    maps=[[index[tuple(sorted(m+(j,)))] for j in range(nw)] for m in prev]
    for k,inds in enumerate(maps):
        for i in range(nz): out[k*nr:(k+1)*nr,i*nd+np.array(inds)]=A[:,i,:]
    return out,mons,prev

def independent_equations(A):
    R,p=rref(A.reshape(A.shape[0],-1))
    return R[:len(p)].reshape(len(p),A.shape[1],A.shape[2])

if __name__=='__main__':
    import sys,time
    from pathlib import Path
    root=Path(__file__).resolve().parents[1]
    D=np.load(root/'data/fonly_char2.npz')['B']
    T=np.load(root/'data/pencils.npz')['T']
    tests={
    'j2_groupA':(independent_equations(D[[0,6,7]].transpose(1,0,2)),4),
    'j2_groupC':(independent_equations(D[list(range(13,19))].transpose(1,0,2)),4),
    'j2_groupB_full':(independent_equations(T[[1,2,3,4,5,8,9,10,11,12]][:,:,[19,20,21,22,30,31,32,33]].transpose(1,0,2)),4)
    }
    for name,(A,nf) in tests.items():
        print(name,A.shape,flush=True)
        for d in [1,2,3,4]:
            M,mons,prev=macaulay(A,d)
            if M.size>70000000: print('SKIP shape',M.shape,flush=True); break
            ts=time.time();R,p=rref(M)
            pure=[i*len(mons)+mons.index((j,)*d) for i in range(A.shape[1]) for j in range(nf)]
            membership=[]
            for col in pure:
                if col not in p: membership.append(False); continue
                rr=R[p.index(col)]
                membership.append(np.count_nonzero(rr)==1)
            print(' degree',d,'shape',M.shape,'rank',len(p),'targets',sum(membership),'/',len(pure),'sec',round(time.time()-ts,2),flush=True)
            if all(membership):
                np.savez_compressed(root/f'certificates/{name}.npz',A=A,d=np.array(d),nf=np.array(nf))
                break
