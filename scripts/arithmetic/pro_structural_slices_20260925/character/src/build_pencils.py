#!/usr/bin/env python3
"""Reconstruct T and Q from the user's actual transitions and elimination."""
from pathlib import Path
import json, time
import numpy as np
from exact import *
ROOT=Path(__file__).resolve().parents[1]

def equations(U,V,f,alpha,g0,q0,E):
    a=(e*f).plus()+alpha
    p=a-e*f
    g=-(U*f).plus()+g0
    q=(e*g-U*p).plus()+q0
    B=E*g+(V+U*E)*f
    h=-B.plus()
    D=-e*h+E*(q-e*g)+(V+U*E)*p
    return np.concatenate((B.coefficients(basis_bracket(-144)),D.coefficients(basis_bracket(-155))))

def build():
    start=time.time(); Z=LP(); E=frob25(e)
    fs=basis_L(31); alphas=basis_L(20); gs=basis_L(131); qs=basis_L(120)
    us=[frob25(LP.mono(*b)) for b in U_BASIS]
    vs=[frob25(LP.mono(*b)) for b in V_BASIS]
    print('dimensions',len(fs),len(alphas),len(gs),len(qs),flush=True)
    C=np.column_stack([equations(Z,Z,Z,Z,LP.mono(*b),Z,E) for b in gs]+[equations(Z,Z,Z,Z,Z,LP.mono(*b),E) for b in qs])
    R,p,H=rref(C,True)
    assert C.shape==(315,235) and p==list(range(235))
    assert np.array_equal(mm(H,C),R)
    print('C shape',C.shape,'rank',len(p),'seconds',round(time.time()-start,2),flush=True)
    T=[]; raw=[]
    for a in range(19):
        U=us[a] if a<6 else Z; V=vs[a-6] if a>=6 else Z
        A=np.column_stack([equations(U,V,LP.mono(*b),Z,Z,Z,E) for b in fs]+[equations(U,V,Z,LP.mono(*b),Z,Z,E) for b in alphas])
        raw.append(A); T.append(mm(H[235:],A))
        print('T coefficient',a,flush=True)
    T=np.array(T); raw=np.array(raw)
    ns=basis_L(24); aas=basis_L(124); bb=basis_bracket(-151)
    Cq=np.column_stack([(E*LP.mono(*b)).coefficients(bb) for b in aas])
    Rq,pq,Hq=rref(Cq,True)
    assert Cq.shape==(159,116) and pq==list(range(116))
    assert np.array_equal(mm(Hq,Cq),Rq)
    Q=[]; rawq=[]
    for a in range(19):
        U=us[a] if a<6 else Z; V=vs[a-6] if a>=6 else Z
        A=np.column_stack([(E*(U*LP.mono(*b)).minus()+V*LP.mono(*b)).coefficients(bb) for b in ns])
        rawq.append(A); Q.append(mm(Hq[116:],A))
    Q=np.array(Q)
    np.savez_compressed(ROOT/'data/pencils.npz',T=T,Q=Q,C=C,H=H,raw=raw,Cq=Cq,Hq=Hq,rawq=np.array(rawq))
    metadata={'field':'F5[beta]/(beta^2-beta-3)','encoding':'a+5b means a+b*beta, 0<=a,b<5', 'axes_T':['z index 0..18','equation 0..79','f then alpha coefficient 0..34'], 'axes_Q':['z index 0..18','equation 0..42','n0 coefficient 0..15'], 'f_basis':fs,'alpha_basis':alphas,'g0_basis':gs,'q0_basis':qs,'n0_basis':ns,'a0_basis':aas,'u_basis':U_BASIS,'v_basis':V_BASIS}
    (ROOT/'data/bases.json').write_text(json.dumps(metadata,indent=2)+'\n')
    print('DONE',time.time()-start, 'T',T.shape,'Q',Q.shape,flush=True)

if __name__=='__main__': build()
