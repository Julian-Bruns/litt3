#!/usr/bin/env python3
"""Independent jet reconstruction and minor verification of pole16 evidence.

Does not import the generator, use its power-series exponent17 formula,
or use a rank/pivot algorithm. Builds y-jets by their cubic recurrence,
then verifies each specified determinant by an independent elimination.
Run with Sage; only exact finite-field arithmetic is used.
"""
import argparse
import itertools
import json
import time
from pathlib import Path
from math import comb
from sage.all import GF, PolynomialRing

def weights(n, r):
    if r==1:
        yield (n,)
        return
    for i in range(n+1):
        for tail in weights(n-i,r-1): yield (i,)+tail

def determinant(rows,K):
    a=[list(r) for r in rows]; value=K(1)
    for i in range(len(a)):
        j=next((j for j in range(i,len(a)) if a[j][i]),None)
        if j is None: return K(0)
        if j!=i: a[i],a[j]=a[j],a[i]; value=-value
        pivot=a[i][i]; value*=pivot
        inv=pivot**-1
        for j in range(i+1,len(a)):
            scalar=a[j][i]*inv
            for k in range(i+1,len(a)): a[j][k]-=scalar*a[i][k]
            a[j][i]=K(0)
    return value

def main():
    ap=argparse.ArgumentParser();ap.add_argument('certificate',type=Path)
    ap.add_argument('summary',type=Path);args=ap.parse_args()
    start=time.monotonic();data=json.loads(args.certificate.read_text())
    R0=PolynomialRing(GF(5),'z');z=R0.gen()
    modulus=R0(data['field_modulus']);assert modulus.degree()==24 and modulus.is_irreducible()
    K=GF(5**24,'z',modulus=modulus);z=K.gen()
    def dec(n):
        val=K(0); p=K(1)
        while n:
            n,c=divmod(n,5);val+=c*p;p*=z
        return val
    beta=dec(data['beta']);alpha=dec(data['alpha']);y0=dec(data['y0'])
    assert beta*beta==beta+3
    c25=lambda c:K(c%5)+K(c//5)*beta
    p=[c25(c) for c in [11,22,18,5,19,20,15,16,9,22,1]]
    aa=[c25(c) for c in [1,21,14,22,13]]
    evaluate=lambda coeff,a:sum((c*a**i for i,c in enumerate(coeff)),K(0))
    assert alpha**4+c25(7)*alpha**3+c25(6)*alpha**2+c25(2)*alpha+c25(5)==0
    assert y0**3==evaluate(p,alpha)
    roots=[alpha**(25**i) for i in range(4)]
    sheets=[y0**(25**i) for i in range(4)]
    zeta=c25(11);assert zeta**3==1 and zeta!=1 and zeta==dec(data['zeta'])
    assert roots==[dec(v) for v in data['roots']] and sheets==[dec(v) for v in data['sheets']]
    assert len(set(roots))==4 and all(evaluate(aa,a)==0 and evaluate(p,a)!=0 for a in roots)
    jets=[]
    for a,y in zip(roots,sheets):
        local_p=[sum((p[i]*comb(i,n)*a**(i-n) for i in range(n,11)),K(0)) for n in range(16)]
        Y=[y]+[K(0)]*15
        for n in range(1,16):
            known=sum((Y[i]*Y[j]*Y[n-i-j]
                       for i in range(n+1) for j in range(n+1-i)),K(0))
            Y[n]=(local_p[n]-known)/(3*y*y)
        for n in range(16):
            assert sum((Y[i]*Y[j]*Y[n-i-j] for i in range(n+1)
                       for j in range(n+1-i)),K(0))==local_p[n]
        row_list=[]
        for n in range(16):
            row=[K(comb(i,n))*a**(i-n) if i>=n else K(0) for i in range(6)]
            row += [sum((K(comb(j,k))*a**(j-k)*Y[n-k]
                         for k in range(min(n,j)+1)),K(0)) for j in range(3)]
            row_list.append(row)
        jets.append(row_list)
    expected=set();reps=set()
    for w in weights(16,4):
        if w!=min(w[i:]+w[:i] for i in range(4)): continue
        reps.add(w);occupied=[i for i,m in enumerate(w) if m]
        for tail in itertools.product(range(3),repeat=len(occupied)-1):
            phase=[0]*4
            for i,v in zip(occupied[1:],tail): phase[i]=v
            expected.add((w,tuple(phase)))
    assert len(reps)==245 and len(expected)==4147
    seen=set()
    for i,rec in enumerate(data['records']):
        key=(tuple(rec['weights']),tuple(rec['phases']));assert key in expected and key not in seen
        seen.add(key);rows=[]
        for a,m in enumerate(key[0]):
            phase=zeta**key[1][a]
            rows += [r[:6]+[phase*c for c in r[6:]] for r in jets[a][:m]]
        selected=rec['minor_rows']
        assert len(selected)==9 and len(set(selected))==9 and all(0<=j<16 for j in selected)
        d=determinant([rows[j] for j in selected],K)
        assert d and d==dec(rec['determinant'])
        if (i+1)%1000==0:print('verified',i+1,'exact nonzero minors',flush=True)
    assert seen==expected and data['survivors']==[] and data['systems']==4147
    summary=dict(result='PASS',geometric_scope='all primitive support patterns for pole16',
        systems=4147,composition_count=969,rotation_orbits=245,
        independent_cubic_jet_recurrence=True,all_exact_nonzero_minors=True,
        field_modulus_irreducible=True,elapsed_seconds=time.monotonic()-start)
    args.summary.parent.mkdir(parents=True,exist_ok=True)
    args.summary.write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps(summary),flush=True)

if __name__=='__main__':main()
