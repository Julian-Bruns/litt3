"""Test the missing critical norm filtration, not a geometric theorem.

Exact F5 linear lifting through25, including arbitrary deck-linear
first corrections. Source functions are lifted as polynomials, not
coefficientwise function-value lifts before division.
"""
from fractions import Fraction
import itertools
import json
from pathlib import Path
import random
import sys
import numpy as np


def main():
    base=Path('/Users/julian/Documents/litt3-computation-data/rank25-universal-trace-return-20260913-9D6dTa/replay')
    sys.path.insert(0,str(base/'lib'));import finite_field as F
    group=list(itertools.product(range(5),repeat=2));idx={g:i for i,g in enumerate(group)}
    shift=[np.array([idx[(i+h)%5,(j+k)%5] for i,j in group]) for h,k in group]
    def cm(v):return np.array([[v[idx[(h-i)%5,(k-j)%5]] for h,k in group] for i,j in group],dtype=np.int64)
    def mul(a,b):return cm(a)@b%125
    one=np.zeros(25,dtype=np.int64);one[0]=1
    e=[];logs=[]
    for g in [(1,0),(0,1)]:
        z=-one.copy();z[idx[g]]=1;e.append(z%125)
        out=np.zeros(25,dtype=np.int64);power=one
        for n in range(1,5):
            power=mul(power,z);out=(out+(-1)**(n+1)*pow(n,-1,125)*power)%125
        logs.append(out)
    ep=[[one] for _ in range(2)]
    for i in range(2):
        for _ in range(4):ep[i].append(mul(ep[i][-1],e[i]))
    mons=[(i,j) for i in range(5) for j in range(5)]
    degrees=np.array([i+j for i,j in mons])
    V=np.array([[i**a*j**b for a,b in mons] for i,j in group],dtype=np.int64)
    def rank(a):return len(F.rref(np.array(a,dtype=np.uint16))[1])
    def solve(a,b):
        a=np.asarray(a,dtype=np.uint16);b=np.asarray(b,dtype=np.uint16)
        rr,piv=F.rref(np.column_stack([a,b]));assert a.shape[1] not in piv
        z=np.zeros(a.shape[1],dtype=np.int64)
        for r,p in enumerate(piv):z[p]=rr[r,-1]
        assert np.array_equal(a.astype(np.int64)@z%5,b)
        return z
    rng=random.Random(20260913)
    forms=[(a,b,c) for a in range(1,5) for b in range(5) for c in range(1,5) if (b*b-4*a*c)%5 in (2,3)]
    cases=[]
    for trial in range(40):
        a,b,c=forms[trial%len(forms)]
        f=(a*mul(logs[0],logs[0])+b*mul(logs[0],logs[1])+c*mul(logs[1],logs[1]))%125
        if trial>=len(forms)//2:
            for i,j in mons:
                if i+j>=3:f=(f+rng.randrange(5)*mul(ep[0][i],ep[1][j]))%125
        correction=np.array([rng.randrange(5) for _ in range(25)],dtype=np.int64)
        L=cm((f+5*correction)%125)
        ext=np.column_stack([L,-np.ones(25,dtype=np.int64)])%125
        M=ext%5;K=F.nullspace(M.astype(np.uint16)).astype(np.int64)
        assert len(K)==10
        left=F.nullspace(M.T.astype(np.uint16)).astype(np.int64)
        carry=(ext@K.T%25)//5
        B=left@carry%5
        compatible=F.nullspace(B.astype(np.uint16)).astype(np.int64)
        leading=K.T@compatible.T%5
        assert leading.shape==(26,4)
        poly=np.column_stack([solve(V%5,leading[:25,j]) for j in range(4)])
        assert not np.any(poly[degrees>2])
        h=F.nullspace(leading[25:,:].astype(np.uint16)).astype(np.int64)
        homogeneous=poly@h.T%5
        assert homogeneous.shape==(25,3) and not np.any(homogeneous[degrees>1])
        low=np.flatnonzero(degrees<=6)
        liftM=np.column_stack([L@V[:,low],-np.ones(25,dtype=np.int64)])%5
        traces=[]
        for j in range(4):
            x0=V@poly[:,j];eta0=int(leading[25,j])
            res=(L@x0-eta0)%25
            assert not np.any(res%5)
            repair=solve(liftM,(-res//5)%5)
            x1=V[:,low]@repair[:-1]
            trace=int(sum(x0+5*x1)%25);assert trace==0
            traces.append(trace)
        # Low quadratic products are all in im(f): P2 is the image of P4.
        low4=np.flatnonzero(degrees<=4)
        for mon in np.flatnonzero(degrees<=2):solve((L@V[:,low4])%5,V[:,mon]%5)
        cases.append({'quadratic':[a,b,c],'higher_terms':trial>=len(forms)//2,
                      'leading_norm_solution_dimension':4,'leading_AS_bound':2,
                      'homogeneous_dimension':3,'homogeneous_AS_bound':1,
                      'combined_integral_trace_mod25':traces})
    result={'status':'PASS exact finite tests','cases':cases,
        'scope':'Tests the critical C5^2 norm filtration for40 F5 coefficient models with varying higher augmentation terms and arbitrary5*convolution corrections. Not a proof for arbitrary k coefficients, mixed Frobenius, or actual geometry.',
        'leverage':'Modulo25 norm compatibility restricts the leading digit to F2 and the homogeneous case to F1. Combined integral trace is25-divisible; this is the proposed mechanism for removing a terminal25*quadratic term.'}
    out=Path(__file__).resolve().parents[3]/'Research/computations/rank25_critical_norm_probe.json'
    out.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k!='cases'},indent=2));print('Cases:',len(cases))


if __name__=='__main__':main()
