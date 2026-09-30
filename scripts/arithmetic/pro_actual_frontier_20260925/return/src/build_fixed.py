"""Build the FULL fixed-target tensor, not just the quotient rank locus.
TOP[i,j] multiplies eta_i*z_j*w. Set eta=xi and z=xi**25.
"""
from pathlib import Path
import time,json,itertools,argparse
import numpy as np
from exact import *
from point_test import D,combine_tensor
ROOT=Path(__file__).resolve().parents[1]
def main():
    start=time.monotonic();log=[]
    ap=argparse.ArgumentParser();ap.add_argument("--start",type=int,default=0);ap.add_argument("--stop",type=int,default=19);args=ap.parse_args()
    def say(s):
        print(s,flush=True);log.append(s);(ROOT/'logs'/'build_fixed.log').write_text('\n'.join(log)+'\n')
    fb=[LP.term(i,j) for i,j in basis(31)];ab=[LP.term(i,j) for i,j in basis(20)]
    gb=[LP.term(i,j) for i,j in basis(131)];qb=[LP.term(i,j) for i,j in basis(120)]
    sb=[LP.term(i,j) for i,j in basis(24)];tb=[LP.term(i,j) for i,j in basis(124)]
    TOP=np.zeros((19,19,43,35),dtype=np.uint8)
    EVTOP=np.zeros((19,19,2,35),dtype=np.uint8)
    EVS=np.zeros((19,2,16),dtype=np.uint8)
    EVPHI=np.zeros((19,4,35),dtype=np.uint8)
    AF=np.zeros((2,35),dtype=np.uint8);NU=np.zeros((19,35),dtype=np.uint8)
    fbases=fb+[ZERO]*12;alphas=[ZERO]*23+ab
    zeroeta=np.zeros(19,dtype=np.uint8)
    checkpoint=ROOT/'data'/'fixed_tensors.npz'
    if args.start:
        old=np.load(checkpoint)
        for name in ['TOP','EVTOP','EVS','EVPHI','AF','NU']:
            locals()[name][...] = old[name]
        log=(ROOT/'logs'/'build_fixed.log').read_text().splitlines()
    for j in range(args.start,args.stop):
        z=np.zeros(19,dtype=np.uint8);z[j]=1
        U=XIB[j]**25 if j<6 else ZERO;V=XIB[j]**25 if j>=6 else ZERO
        for c,(f,alpha) in enumerate(zip(fbases,alphas)):
            rr=D['REC'][j,:,c]
            g0=linear_combination(rr[:123],gb);q0=linear_combination(rr[123:],qb)
            phi,res=lower(U,V,f,alpha,g0,q0);a,q,r,f,g,h=phi
            # These are formal recovered columns; their residual is precisely the stored tensor.
            assert np.array_equal(matmul(D['CTc'],res[:,None])[:,0],D['T'][j,:,c])
            if j==0:AF[:,c]=[a.eval(5,14),f.eval(5,14)]
            EVPHI[j,:,c]=[q.eval(5,14),r.eval(5,14),g.eval(5,14),h.eval(5,14)]
            for i in range(19):
                eta=np.zeros(19,dtype=np.uint8);eta[i]=1
                top,res=top_res(U,V,eta,phi)
                TOP[i,j,:,c]=matmul(D['CQc'],res[:,None])[:,0]
                t0=linear_combination(NEG[matmul(D['RQ'],res[:,None])[:,0]],tb)
                top2,res2=top_res(U,V,eta,phi,ZERO,t0)
                assert np.array_equal(matmul(D['CQc'],res2[:,None])[:,0],TOP[i,j,:,c])
                assert not matmul(D['RQ'],res2[:,None]).any()
                if j==0:NU[i,c]=top2[0].eval(5,14)
                EVTOP[i,j,:,c]=[top2[1].eval(5,14),top2[2].eval(5,14)]
        for c,s in enumerate(sb):
            top,res=top_res(U,V,zeroeta,(ZERO,)*6,s)
            assert np.array_equal(matmul(D['CQc'],res[:,None])[:,0],D['Q'][j,:,c])
            t0=linear_combination(NEG[matmul(D['RQ'],res[:,None])[:,0]],tb)
            top2,res2=top_res(U,V,zeroeta,(ZERO,)*6,s,t0)
            EVS[j,:,c]=[top2[1].eval(5,14),top2[2].eval(5,14)]
        say(f'source {j:02d}: all 665 target/section configurations and 16 top-row corrections verified; elapsed {time.monotonic()-start:.2f}s')
    SEVAL=np.array([p.eval(5,14) for p in sb],dtype=np.uint8)
    np.savez_compressed(ROOT/'data'/'fixed_tensors.npz',TOP=TOP,EVTOP=EVTOP,EVS=EVS,EVPHI=EVPHI,AF=AF,NU=NU,SEVAL=SEVAL)
    say(f'CHUNK COMPLETE [{args.start},{args.stop}); elapsed {time.monotonic()-start:.2f}s')
if __name__=='__main__':main()
