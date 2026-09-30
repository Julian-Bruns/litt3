#!/usr/bin/env python3
"""Reconstruct all three Sym15 sections and certify Frobenius support.

This is a section-space calculation, not an all-twist or etale decision.
"""
import argparse
import json
from math import comb
from pathlib import Path
import pro_quadratic_twist_vanishing as q

def reconstruct(columns,vector,n,twist=0):
    free=[{} for _ in range(n+1)]
    for (i,r,m),a in zip(columns,vector):
        if a:free[i]=q.add(free[i],{(r,m):a})
    powers=[q.ONE]
    for _ in range(n):powers.append(q.multiply(powers[-1],q.E))
    affine=[{} for _ in range(n+1)]
    other=[]
    for i in range(n,-1,-1):
        residual={}
        for j in range(i+1,n+1):
            coefficient=(comb(j,i)*(-1)**(j-i))%5
            if coefficient:residual=q.add(residual,q.multiply(powers[j-i],affine[j]),coefficient)
        affine[i]=q.add(free[i],{key:q.NEG[a] for key,a in residual.items() if key[1]>=0})
        g=q.add(affine[i],residual)
        assert all(-3*m-10*r>=5*n-11*i-twist for (r,m) in g)
        other.append(g)
    return affine,list(reversed(other))

def serialize(polys):return [[[r,m,a] for (r,m),a in sorted(p.items())] for p in polys]

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',type=Path,required=True)
    args=p.parse_args();n=15
    columns,rows,matrix=q.system(n);rr,pivots=q.rref(matrix)
    nonpivots=[i for i in range(len(columns)) if i not in pivots]
    print('matrix',len(rows),len(columns),'rank',len(pivots),'kernel',len(nonpivots),flush=True)
    assert len(nonpivots)==3
    rank5=q.prime_field_rank(matrix)
    assert rank5==2*len(pivots)==696
    print('independent F5 rank',rank5,flush=True)
    sections=[]
    for free in nonpivots:
        vector=[0]*len(columns);vector[free]=1
        for i,pivot in enumerate(pivots):vector[pivot]=q.NEG[rr[i][free]]
        for row in matrix:
            value=0
            for a,b in zip(row,vector):value=q.ADD[value][q.MUL[a][b]]
            assert not value
        affine,other=reconstruct(columns,vector,n)
        indices=[i for i,p in enumerate(affine) if p]
        assert all(i%5==0 for i in indices)
        assert all(not p or i%5==0 for i,p in enumerate(other))
        print('free',columns[free],'support',indices,'Frobenius-polynomial',all(i%5==0 for i in indices),flush=True)
        sections.append({'free_column':columns[free],'free_vector':vector,'affine':serialize(affine),
                         'other_chart':serialize(other),'nonzero_binary_indices':indices,
                         'in_Frobenius_subbundle':all(i%5==0 for i in indices)})
    args.output.write_text(json.dumps({'power':n,'twist':0,'rank':len(pivots),'independent_F5_rank':rank5,'columns':columns,
        'rows':rows,'matrix':matrix,'sections':sections,
        'scope':'Exact section-space reconstruction; no all-twist nonexistence assertion.'},separators=(',',':'))+'\n')

if __name__=='__main__':main()
