"""Exact tests for a proposed critical nodal C5^2 descent lemma.

These tests are NOT a proof of the uniform algebraic lemma or its
geometric interpretation. Python3 and NumPy; no external data files.
The coefficient ring is (Z/125)[a]/(a^2-2), with Frobenius a -> -a.
Arbitrary integral2x2 coefficient maps include mixed linear/Frobenius
corrections. The leading Frobenius has first been transported away.
"""
import argparse
import itertools
import json
from pathlib import Path
import random
import numpy as np

GROUP=list(itertools.product(range(5),repeat=2))
INDEX={g:i for i,g in enumerate(GROUP)}
MONOMIALS=GROUP
DEGREES=np.repeat([i+j for i,j in MONOMIALS],2)
V0=np.array([[i**h*j**k for h,k in MONOMIALS] for i,j in GROUP],dtype=np.int64)
V=np.kron(V0,np.eye(2,dtype=np.int64))


def rref(a):
    a=np.asarray(a,dtype=np.int64).copy()%5;r=0;piv=[]
    for c in range(a.shape[1]):
        nz=np.flatnonzero(a[r:,c])
        if not len(nz):continue
        j=r+int(nz[0]);a[[j,r]]=a[[r,j]]
        a[r]=a[r]*pow(int(a[r,c]),-1,5)%5
        rows=np.flatnonzero(a[:,c]);rows=rows[rows!=r]
        if len(rows):a[rows]=(a[rows]-a[rows,c,None]*a[None,r,:])%5
        piv.append(c);r+=1
        if r==len(a):break
    return a,piv


def kernel(a):
    a,piv=rref(a);free=[j for j in range(a.shape[1]) if j not in piv]
    out=np.zeros((len(free),a.shape[1]),dtype=np.int64)
    for i,j in enumerate(free):
        out[i,j]=1
        for row,col in enumerate(piv):out[i,col]=-a[row,j]%5
    return out


def solve(a,b):
    a=np.asarray(a,dtype=np.int64)%5;b=np.asarray(b,dtype=np.int64)%5
    rr,piv=rref(np.column_stack([a,b]));assert a.shape[1] not in piv
    z=np.zeros(a.shape[1],dtype=np.int64)
    for i,j in enumerate(piv):z[j]=rr[i,-1]
    assert np.array_equal(a@z%5,b)
    return z


def coefficient_matrix(c):
    u,v=map(int,c)
    return np.array([[u,2*v],[v,u]],dtype=np.int64)


def cm(v):
    out=np.zeros((50,50),dtype=np.int64)
    for i,(u,w) in enumerate(GROUP):
        for j,(h,k) in enumerate(GROUP):
            out[2*i:2*i+2,2*j:2*j+2]=coefficient_matrix(v[INDEX[(h-u)%5,(k-w)%5]])
    return out%125


def coeff_mul(a,b):
    return coefficient_matrix(a)@b%5


def good_quadratic(a,b,c):
    disc=(coeff_mul(b,b)-4*coeff_mul(a,c))%5
    if not np.any(disc):return False
    return all(np.any((a*i*i+b*i*j+c*j*j)%5) for i,j in GROUP if (i,j)!=(0,0))


def run(cases=24):
    rng=random.Random(20260913);identity=np.zeros((25,2),dtype=np.int64);identity[0,0]=1
    def multiply(a,b):return (cm(a)@b.reshape(50)).reshape(25,2)%125
    e=[];logs=[];powers=[]
    for g in [(1,0),(0,1)]:
        z=-identity.copy();z[INDEX[g],0]=1;e.append(z%125)
        p=identity.copy();log=np.zeros((25,2),dtype=np.int64);ep=[p]
        for n in range(1,5):
            p=multiply(p,z);ep.append(p)
            log=(log+(-1)**(n+1)*pow(n,-1,125)*p)%125
        logs.append(log);powers.append(ep)
    qmon=[multiply(logs[0],logs[0]),multiply(logs[0],logs[1]),multiply(logs[1],logs[1])]
    norm=np.tile(np.eye(2,dtype=np.int64),(25,1))
    records=[]
    for trial in range(cases):
        if trial==0:abc=[np.array(c) for c in [(1,0),(0,0),(2,0)]]
        elif trial==1:abc=[np.array(c) for c in [(1,0),(0,0),(0,1)]]
        else:
            while True:
                abc=[np.array([rng.randrange(5),rng.randrange(5)]) for _ in range(3)]
                if good_quadratic(*abc):break
        assert good_quadratic(*abc)
        f=sum((q@coefficient_matrix(c).T for q,c in zip(qmon,abc)),np.zeros((25,2),dtype=np.int64))%125
        if trial>=2:
            for i,j in MONOMIALS:
                if i+j>=3:
                    c=np.array([rng.randrange(5),rng.randrange(5)])
                    f=(f+multiply(powers[0][i],powers[1][j])@coefficient_matrix(c).T)%125
        # A general deck-equivariant Z5-linear coefficient correction.
        blocks=[np.array([[rng.randrange(25) for _ in range(2)] for _ in range(2)],dtype=np.int64) for _ in GROUP]
        correction=np.zeros((50,50),dtype=np.int64)
        for i,(u,w) in enumerate(GROUP):
            for j,(h,k) in enumerate(GROUP):
                correction[2*i:2*i+2,2*j:2*j+2]=blocks[INDEX[(h-u)%5,(k-w)%5]]
        L=(cm(f)+5*correction)%125
        ext=np.column_stack([L,-norm])%125;M=ext%5
        K=kernel(M);left=kernel(M.T)
        assert K.shape==(20,52)
        first_free_polys=np.column_stack([solve(V,v[:50]) for v in K])
        assert not np.any(first_free_polys[DEGREES>4])
        carry=(ext@K.T%25)//5;B=left@carry%5
        liftable=kernel(B);leading=K.T@liftable.T%5
        assert leading.shape==(52,8)
        poly=np.column_stack([solve(V,leading[:50,j]) for j in range(8)])
        assert not np.any(poly[DEGREES>2])
        homogeneous=poly@kernel(leading[50:,:]).T%5
        assert homogeneous.shape==(50,6) and not np.any(homogeneous[DEGREES>1])
        # Second Bockstein: allow ALL free first repairs before deciding
        # whether the leading digit extends to a norm equation modulo125.
        second=[]
        for j in range(8):
            z0=leading[:,j]
            first=(ext@z0%25)//5
            z1=solve(M,-first)
            z25=z0+5*z1
            residual=ext@z25%125
            assert not np.any(residual%25)
            second.append(left@(residual//25)%5)
        second=np.column_stack(second)
        free_first_obstruction=kernel(B.T)
        full_leading=leading@kernel(free_first_obstruction@second%5).T%5
        assert full_leading.shape==(52,2) and not np.any(full_leading[50:])
        full_poly=np.column_stack([solve(V,full_leading[:50,j]) for j in range(2)])
        assert not np.any(full_poly[DEGREES>0])
        low6=np.flatnonzero(DEGREES<=6)
        repairM=np.column_stack([L@V[:,low6],-norm])%5
        for j in range(8):
            x0=V@poly[:,j];eta0=leading[50:,j]
            residue=(L@x0-norm@eta0)%25
            assert not np.any(residue%5)
            repair=solve(repairM,(-residue//5)%5)
            x1=V[:,low6]@repair[:-2]
            assert not np.any((x0+5*x1).reshape(25,2).sum(axis=0)%25)
        low4=np.flatnonzero(DEGREES<=4)
        for j in np.flatnonzero(DEGREES<=2):solve(L@V[:,low4]%5,V[:,j]%5)
        records.append({'quadratic':[c.tolist() for c in abc],
            'higher_augmentation_terms':trial>=2,'mixed_additive_correction':True,
            'liftable_dimension_over_F5':8,'leading_AS_bound':2,
            'homogeneous_dimension_over_F5':6,'homogeneous_AS_bound':1,
            'combined_trace_mod25':[0,0],'all_free_first_repairs_AS_bound':4,
            'F2_in_image':True,
            'mod125_leading_dimension_over_F5':2,
            'mod125_leading_is_invariant':True,'mod125_eta_reduction_zero':True})
    return {'status':'PASS','coefficient_ring':'(Z/125)[a]/(a^2-2)',
        'cases':records,'scope':'Finite model tests only; NOT the all-coefficient theorem or the geometric comparison.',
        'proposed_new_lemma':'For L mod5=f*Phi with nonsingular quadratic symbol and no F5 zero direction, Lx=Neta mod25 forces xbar in F2, or F1 if etabar=0, and Tr(x)=0 mod25.'}


if __name__=='__main__':
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('--output',type=Path)
    args=ap.parse_args();result=run()
    if args.output:args.output.write_text(json.dumps(result,indent=2)+'\n')
    print('PASS:',len(result['cases']),'mixed-additive F25 critical-norm tests.')
    print(result['scope'])
