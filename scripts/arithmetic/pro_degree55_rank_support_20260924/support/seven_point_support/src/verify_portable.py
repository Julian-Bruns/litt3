#!/usr/bin/env python3
"""Independent, standard-library-only verifier of the 1,716 Cartier obstructions.

It does not import field.py, cartier_test.py, NumPy, Numba, or a computer-algebra
system. It reconstructs the field, points, jets and Cartier matrix from the
polynomial rows, then checks a full-rank minor for each Frobenius orbit.
"""
from array import array
from itertools import combinations
from pathlib import Path
import json
import platform
import sys
import time

ROOT = Path(__file__).resolve().parents[1]
A = [1, 21, 14, 22, 13]
P = [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]
Q = [0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]
q0 = 25**4
q = q0**3
BASIS = [(i,j) for j,n in ((0,9),(1,6),(2,3)) for i in range(n+1)]
AD = [[(a%5+b%5)%5 + 5*((a//5+b//5)%5) for b in range(25)] for a in range(25)]
MU = [[((a%5)*(b%5)+3*(a//5)*(b//5))%5
       + 5*(((a%5)*(b//5)+(a//5)*(b%5)+(a//5)*(b//5))%5)
       for b in range(25)] for a in range(25)]
NE = [(-a%5)%5+5*((-(a//5))%5) for a in range(25)]
IV = [0]+[next(b for b in range(1,25) if MU[a][b]==1) for a in range(1,25)]
MONIC = [MU[a][IV[A[-1]]] for a in A[:4]]

def ba(a,b):
    return (AD[a%25][b%25] + 25*AD[(a//25)%25][(b//25)%25]
            +625*AD[(a//625)%25][(b//625)%25]
            +15625*AD[a//15625][b//15625])

def bn(a):
    return NE[a%25]+25*NE[(a//25)%25]+625*NE[(a//625)%25]+15625*NE[a//15625]

def alpha_times(a):
    """Multiply by alpha in F_25[alpha]/A; no logarithm table involved."""
    t=a//15625
    aa=[0,a%25,(a//25)%25,(a//625)%25]
    return sum(AD[aa[i]][NE[MU[t][MONIC[i]]]]*25**i for i in range(4))

LOG=array('i',[-1])*q0
EXP=array('i',[0])*(2*(q0-1))
a=1
for n in range(q0-1):
    assert a!=0 and LOG[a]==-1, 'alpha does not enumerate the nonzero field elements'
    LOG[a]=n; EXP[n]=a
    a=alpha_times(a)
assert a==1
EXP[q0-1:]=EXP[:q0-1]
assert all(x>=0 for x in LOG[1:])

def bm(a,b):
    return 0 if a==0 or b==0 else EXP[LOG[a]+LOG[b]]

CUBE=0
for v in reversed(P): CUBE=ba(alpha_times(CUBE),v)
assert CUBE==121684 and EXP[(LOG[CUBE]*((q0-1)//3))%(q0-1)]==11
assert MU[MU[11][11]][11]==1 and 11!=1

def add(a,b):
    return ba(a%q0,b%q0)+q0*ba((a//q0)%q0,(b//q0)%q0)+q0*q0*ba(a//(q0*q0),b//(q0*q0))

def neg(a):
    return bn(a%q0)+q0*bn((a//q0)%q0)+q0*q0*bn(a//(q0*q0))

def sub(a,b): return add(a,neg(b))

def mul(a,b):
    a0,a1,a2=a%q0,(a//q0)%q0,a//(q0*q0)
    b0,b1,b2=b%q0,(b//q0)%q0,b//(q0*q0)
    c0=ba(bm(a0,b0),bm(CUBE,ba(bm(a1,b2),bm(a2,b1))))
    c1=ba(ba(bm(a0,b1),bm(a1,b0)),bm(CUBE,bm(a2,b2)))
    c2=ba(ba(bm(a0,b2),bm(a1,b1)),bm(a2,b0))
    return c0+q0*c1+q0*q0*c2

def power(a,n):
    r=1
    while n:
        if n&1:r=mul(r,a)
        a=mul(a,a);n//=2
    return r

def inverse(a):
    assert a
    return power(a,q-2)

def pmul(a,b):
    c=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b): c[i+j]=AD[c[i+j]][MU[x][y]]
    return c

def ppow(a,n):
    r=[1]
    for _ in range(n):r=pmul(r,a)
    return r

def peval(a,x):
    r=0
    for c in reversed(a): r=add(mul(r,x),c)
    return r

def deriv(a): return [MU[i%5][a[i]] for i in range(1,len(a))]

def cartier_matrix():
    aa=ppow(A,4);pp=ppow(P,3)
    m=[[0]*21 for _ in range(21)]
    for c,(i,j) in enumerate(BASIS):
        hh=[0]*i+aa
        if j==0:hh=pmul(hh,P);jj=1
        elif j==1:hh=pmul(hh,pp);jj=0
        else:jj=2
        for e in range(4,len(hh),5):m[BASIS.index(((e-4)//5,jj))][c]=power(hh[e],5)
    return m

def finite_jets(r,s):
    pp1=deriv(P);pp2=[MU[x][3] for x in deriv(pp1)]
    den=mul(3,mul(s,s))
    y1=mul(peval(pp1,r),inverse(den))
    y2=mul(sub(peval(pp2,r),mul(3,mul(s,mul(y1,y1)))),inverse(den))
    yy=[(1,0,0),(s,y1,y2),(mul(s,s),mul(2,mul(s,y1)),add(mul(y1,y1),mul(2,mul(s,y2))))]
    xp=[1]
    for _ in range(9):xp.append(mul(xp[-1],r))
    out=[[0]*21 for _ in range(3)]
    for c,(i,j) in enumerate(BASIS):
        xx=(xp[i],mul(i%5,xp[i-1]) if i else 0,
            mul((i*(i-1)//2)%5,xp[i-2]) if i>=2 else 0)
        for e in range(3):
            for z in range(e+1):out[e][c]=add(out[e][c],mul(xx[z],yy[j][e-z]))
    return out

def multiply(a,b):
    out=[[0]*len(b[0]) for _ in range(len(a))]
    for i,row in enumerate(a):
        for z,x in enumerate(row):
            if x:
                for j,y in enumerate(b[z]):
                    if y:out[i][j]=add(out[i][j],mul(x,y))
    return out

def determinant(a):
    a=[row[:] for row in a]; n=len(a); d=1
    assert all(len(row)==n for row in a)
    for i in range(n):
        rr=next((j for j in range(i,n) if a[j][i]),None)
        if rr is None:return 0
        if rr!=i:a[rr],a[i]=a[i],a[rr];d=neg(d)
        v=a[i][i];d=mul(d,v);vi=inverse(v)
        for j in range(i+1,n):
            if a[j][i]:
                rat=mul(a[j][i],vi)
                for c in range(i+1,n):a[j][c]=sub(a[j][c],mul(rat,a[i][c]))
                a[j][i]=0
    return d

def rotate(mask,j):
    return (mask & (1<<12))|sum(1<<((i+j)%12) for i in range(12) if (mask>>i)&1)

def main():
    start=time.perf_counter()
    print('Independent portable verifier; Python',platform.python_version(),flush=True)
    print('Field: exhaustive nonzero multiplicative cycle verified; cubic is irreducible.',flush=True)
    inp=json.loads((ROOT/'data'/'input.json').read_text())
    assert inp['P']==P and inp['A']==A and inp['Q']==Q
    assert deriv(Q)==pmul(P,ppow(A,2))
    data=json.loads((ROOT/'certificates'/'cartier_spaces.json').read_text())
    M=cartier_matrix();assert M==data['cartier_matrix']
    assert [list(x) for x in BASIS]==data['basis']
    pts=[];r=25;s=q0
    for i in range(12):
        assert peval(A,r)==0 and power(s,3)==peval(P,r)
        pts.append([r,s]);r=power(r,25);s=power(s,25)
    assert [r,s]==pts[0] and len({tuple(x) for x in pts})==12
    assert pts==data['points']
    assert all(pts[i][0]==pts[i+4][0]==pts[i+8][0] for i in range(4))
    assert data['field']=={'base_order':q0,'field_order':q,'generator':25,'cube':CUBE}
    jets=[finite_jets(*x) for x in pts]
    oo=[[0]*21 for _ in range(3)]
    for i,bc in enumerate(((9,0),(6,1),(3,2))):oo[i][BASIS.index(bc)]=1
    jets.append(oo)
    # An independent consistency check: Cartier fixes dlog A.
    va=[0]*21
    for i,c in enumerate(deriv(A)):va[BASIS.index((i,2))]=c
    cv=multiply(M,[[power(x,5)] for x in va])
    assert [x[0] for x in cv]==va
    masks={sum(1<<i for i in cc) for cc in combinations(range(13),6)}
    assert len(masks)==1716 and {int(x) for x in data['all_masks']}==masks
    expected={min(rotate(m,j) for j in range(12)) for m in masks}
    records={r['representative']:r for r in data['records']}
    assert set(records)==expected and len(expected)==146
    dets={}
    for ii,(mask,record) in enumerate(sorted(records.items()),1):
        indices=[i for i in range(13) if mask>>i&1]
        assert indices==record['missed_points']
        J=[row[:] for i in indices for row in jets[i]]
        JM=multiply(J,M)
        full=J+[[power(x,5) for x in row] for row in JM]
        selected=record['full_rank_rows']
        assert len(selected)==21 and len(set(selected))==21 and all(0<=i<36 for i in selected)
        det=determinant([full[i] for i in selected])
        assert det!=0, ('singular certificate',mask)
        dets[str(mask)]=det
        if ii%20==0 or ii==146:print('Full-rank minors checked:',ii,'/ 146',flush=True)
    for mm,rr in data['all_masks'].items():
        mask=int(mm);rep=rr['representative'];shift=rr['shift']
        assert rep in records and 0<=shift<12 and rotate(rep,shift)==mask
        assert rep==min(rotate(mask,j) for j in range(12))
    print('PASS: all 1716 geometric subsets covered, all 146 rank-21 certificates valid.',flush=True)
    print('PASS: W_D intersect Cartier^{-1}(W_D) = 0 in every case.',flush=True)
    print('Elapsed verification seconds:',round(time.perf_counter()-start,3),flush=True)
    expected_dets_path=ROOT/'certificates'/'portable_determinants.json'
    if expected_dets_path.exists():
        assert dets==json.loads(expected_dets_path.read_text())
        print('PASS: independently recomputed determinants match the archived values.',flush=True)
    if '--write-determinants' in sys.argv:
        expected_dets_path.write_text(json.dumps(dets,indent=2)+'\n')
        print('Wrote portable_determinants.json.',flush=True)
    print('STATUS: verification passed; the global covering-existence problem remains OPEN.',flush=True)

if __name__=='__main__':main()
