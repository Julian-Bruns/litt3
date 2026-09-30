"""Reconstruct the supplied linear tensors and retain exact elimination data."""
from pathlib import Path
import numpy as np,time,json
from exact import *
ROOT=Path(__file__).resolve().parents[1]
def main():
    start=time.monotonic()
    log=[]
    def say(s):
        print(s,flush=True);log.append(s)
        (ROOT/'logs'/'build.log').write_text('\n'.join(log)+'\n')
    fb=[LP.term(i,j) for i,j in basis(31)]
    ab=[LP.term(i,j) for i,j in basis(20)]
    gb=[LP.term(i,j) for i,j in basis(131)]
    qb=[LP.term(i,j) for i,j in basis(120)]
    nb=[LP.term(i,j) for i,j in basis(24)]
    tb=[LP.term(i,j) for i,j in basis(124)]
    CT=np.column_stack([lower(ZERO,ZERO,ZERO,ZERO,g,ZERO)[1] for g in gb]+[lower(ZERO,ZERO,ZERO,ZERO,ZERO,q)[1] for q in qb])
    RT,CTc=elimination(CT)
    assert np.array_equal(matmul(RT,CT),np.eye(235,dtype=np.uint8))
    assert not matmul(CTc,CT).any()
    CQ=np.column_stack([residual(E*t,-151) for t in tb]); RQ,CQc=elimination(CQ)
    assert np.array_equal(matmul(RQ,CQ),np.eye(116,dtype=np.uint8))
    assert not matmul(CQc,CQ).any()
    say(f'constant matrices: T {CT.shape} rank 235; Q {CQ.shape} rank 116; left inverses and cokernels verified')
    T=np.zeros((19,80,35),dtype=np.uint8);Q=np.zeros((19,43,16),dtype=np.uint8)
    REC=np.zeros((19,235,35),dtype=np.uint8)
    RAW=np.zeros((19,315,35),dtype=np.uint8)
    X25=[b**25 for b in XIB]
    for k in range(19):
        U=X25[k] if k<6 else ZERO;V=X25[k] if k>=6 else ZERO
        raw=np.column_stack([lower(U,V,f,ZERO)[1] for f in fb]+[lower(U,V,ZERO,a)[1] for a in ab])
        RAW[k]=raw;T[k]=matmul(CTc,raw);REC[k]=NEG[matmul(RT,raw)]
        qr=np.column_stack([residual(E*(U*n).minus()+V*n,-151) for n in nb])
        Q[k]=matmul(CQc,qr)
        say(f'source {k:02d}: rank(T_i)={len(rref(T[k])[1])}, rank(Q_i)={len(rref(Q[k])[1])}; elapsed {time.monotonic()-start:.2f}s')
    np.savez_compressed(ROOT/'data'/'tensors.npz',T=T,Q=Q,REC=REC,RAW=RAW,CT=CT,RT=RT,CTc=CTc,CQ=CQ,RQ=RQ,CQc=CQc)
    meta={'field':'F5[beta]/(beta^2-beta-3)','encoding':'a+5b -> a+b beta; ascending polynomial rows','axes':{'T':['source coordinate (19)','residual (80)','f then alpha (35)'],'Q':['source coordinate (19)','residual (43)','s0 (16)'],'REC':['source coordinate (19)','g0 then q0 (235)','f then alpha (35)']},'basis_f':basis(31),'basis_alpha':basis(20),'basis_g0':basis(131),'basis_q0':basis(120),'basis_s0':basis(24),'basis_t0':basis(124)}
    (ROOT/'data'/'tensor_format.json').write_text(json.dumps(meta,indent=2)+'\n')
    say(f'finished in {time.monotonic()-start:.2f}s')
if __name__=='__main__':main()
