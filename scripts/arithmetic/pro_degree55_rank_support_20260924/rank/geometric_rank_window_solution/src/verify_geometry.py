#!/usr/bin/env python3
"""Verify coefficient data, the projective partition, scroll kernels and points."""
from pathlib import Path
import json
import sys
import numpy as np
from ff25poly import *
from exact_linear_algebra import *
import build_point_certificates as BP
ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'input/src'))
import compute as F

def parse_module(path):
    text = iter(path.read_text().split())
    nv,nc,n = [int(next(text)) for _ in range(3)]
    polynomials=[]
    for _ in range(n):
        p={}
        for _ in range(int(next(text))):
            c,j = int(next(text)),int(next(text))
            m=tuple(int(next(text)) for _ in range(nv))
            assert 0 <= c < 25 and 0 <= j < nc
            key=(j,m)
            value=ADD[p.get(key,0)][c]
            if value:p[key]=value
            elif key in p:del p[key]
        polynomials.append(p)
    assert next(text,None) is None
    return nv,nc,polynomials

def canonical_scalar(terms):
    return {(0,tuple(m)):c for c,m in terms}

def verify_partition_and_sources():
    D=BP.D
    M=np.array(BP.M,np.uint8)
    assert len(F.rref(M)[1])==6
    A0=np.array(D['T'],np.uint8)
    A=np.zeros_like(A0)
    for i in range(6):
        for j in range(6):A[i]=F.ADD[A[i],F.MUL[M[j,i],A0[j]]]
    for ch in range(5):
        nv,nc,ps=parse_module(ROOT/f'data/modules/chart{ch}/input.txt')
        assert nv==5-ch and nc==15 and len(ps)==23
        expected=[]
        for r in range(23):
            p={}
            for j in range(15):
                for i in range(ch,6):
                    c=int(A[i,r,j])
                    if c:
                        m=[0]*nv
                        if i>ch:m[i-ch-1]=1
                        p[(j,tuple(m))]=c
            expected.append(p)
        assert ps==expected, ('chart input mismatch',ch)
    qs = {
      0:[[(1,(0,1,0,0,0)),(4,(2,0,0,0,0))],
         [(1,(0,0,0,1,0)),(4,(1,0,1,0,0))],
         [(1,(0,0,0,0,1)),(4,(0,1,1,0,0))]],
      1:[[(1,(1,0,0,0)),(24,(0,0,0,0))],
         [(1,(0,1,0,0)),(13,(0,0,0,0))],
         [(1,(0,0,1,0)),(1,(0,0,0,0))],
         [(1,(0,0,0,1)),(1,(0,0,0,0))]],
      2:[[(1,(1,0,0))],[(1,(0,1,0))]],
      3:[[(1,(0,1)),(4,(2,0))]],
      4:[[(1,(0,))]]}
    for ch in range(5):
        nv,nc,ps=parse_module(ROOT/f'data/modules/chart{ch}/annihilators.txt')
        assert nv==5-ch and nc==1
        assert ps==[canonical_scalar(q) for q in qs[ch]]
    # The final stratum is the point u=(0,0,0,0,0,1).
    last=[int(M[i,5]) for i in range(6)]
    ranks=[]
    for name in ['T','Q']:
        array=np.array(D[name],np.uint8)
        value=np.zeros(array.shape[1:],np.uint8)
        for c,a in zip(last,array):value=F.ADD[value,F.MUL[c,a]]
        ranks.append(len(F.rref(value)[1]))
    assert ranks==[13,7], ranks
    print('PASS: invertible coordinate change, all five module inputs, all boundary equations, and final point ranks (13,7).')

def verify_scroll():
    cert=json.loads((ROOT/'data/scroll_kernels.json').read_text())
    uv=[(0,0),(1,0),(2,0),(0,1),(1,1),(2,1)]
    M=np.array(BP.M,np.uint8)
    for name,want in [('T',13),('Q',7)]:
        A0=np.array(BP.D[name],np.uint8);A=np.zeros_like(A0)
        for i in range(6):
            for j in range(6):A[i]=F.ADD[A[i],F.MUL[M[j,i],A0[j]]]
        item=cert[name]
        ks=np.array(item['kernel_coefficients'],np.uint8)
        out={}
        for (a,b),mat in zip(uv,A):
            for (c,d),K in zip(item['monomials'],ks):
                m=(a+c,b+d)
                out[m]=F.ADD[out.get(m,np.zeros((A.shape[1],2),np.uint8)),F.matmul(mat,K)]
        assert not any(x.any() for x in out.values())
        # The constant coefficient vectors are already independent.
        assert item['monomials'][0]==[0,0]
        assert len(F.rref(ks[0])[1])==2
        a,b=item['sample']
        def fp(c,n):
            r=1
            for _ in range(n):r=int(F.MUL[r,c])
            return r
        val=np.zeros(A.shape[1:],np.uint8)
        for (i,j),mat in zip(uv,A):val=F.ADD[val,F.MUL[F.MUL[fp(a,i),fp(b,j)],mat]]
        assert len(F.rref(val)[1])==want
        print(f'PASS: two polynomial scroll kernels for {name}; rank bound {want}, attained at (a,b)=(2,3).')

def verify_shape_and_points():
    shape=BP.S
    lines=(ROOT/'data/shape.txt').read_text().splitlines()
    assert lines[0]=='5'
    def row(line):
        a=list(map(int,line.split()));assert a[0]==len(a)-1;return a[1:]
    assert row(lines[1])==shape['minpoly']
    for i in range(5):
        assert row(lines[2+2*i])==shape['coords'][i]
        assert lines[3+2*i]=='0'
    product=[1]
    for f in shape['factors']:
        assert irreducible(f)
        product=mul(product,f)
    assert product==shape['minpoly']
    assert gcd(product,deriv(product))==[1]
    assert len(product)==45 and product[0]!=0
    assert sorted(len(f)-1 for f in shape['factors'])==[2,2]+[4]*10
    data=BP.build()
    assert data==json.loads((ROOT/'data/points.json').read_text())
    product=[1]
    for point in data['strictly_semistable_orbits']:
        product=mul(product,point['root_modulus'])
    assert product==BP.P
    assert sum(p['degree_over_F25'] for p in data['strictly_semistable_orbits'])==10
    assert sum(p['degree_over_F25'] for p in data['isolated_points'])==45
    # The supplied star is the same point in the two coordinate systems.
    star=data['isolated_points'][-1]
    assert normalize(BP.change_coordinates(star['u_coordinates']),[0,1])==star['v_coordinates']
    print('PASS: residual factorization (2,2,4^10), exact residue fields, 45 isolated points, all rank/minor/kernel/tangent certificates, and all ten stability exclusions.')

def main():
    verify_partition_and_sources()
    verify_scroll()
    verify_shape_and_points()

if __name__=='__main__':main()
