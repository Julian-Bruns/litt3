#!/usr/bin/env sage-python
"""Recover the complete actual Hodge rank from six free deck columns.

The chosen cohomology generators are b_i*w1^4*w2^4*w3^4. Their deck
norms are -b_i, so freeness and Nakayama certify that they are an actual
k[H125]-basis. No 750-by-750 source inversion is necessary.
"""
import argparse
from functools import lru_cache
import itertools
import json
from math import comb
from pathlib import Path
import time

from sage.all import GF, PolynomialRing


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--deck',required=True)
    ap.add_argument('--hodge',required=True)
    ap.add_argument('--output',required=True)
    args=ap.parse_args()
    start=time.monotonic()
    deck=json.loads(Path(args.deck).read_text())
    hodge=json.loads(Path(args.hodge).read_text())
    assert deck['column_kind']=='deck_h' and len(deck['columns'])==750
    assert hodge.get('column_kind','Hodge')=='Hodge'
    for key in ['case','plane','central','field_modulus','alpha','gluing','affine_rhs','infinity_rhs']:
        assert deck[key]==hodge[key],key
    pol=PolynomialRing(GF(5),'z')
    degree=len(deck['field_modulus'])-1
    k=GF(5**degree,name='c',modulus=pol(deck['field_modulus']))
    c=k.gen()
    zero=k(0)
    @lru_cache(maxsize=None)
    def decode(co):return k(list(co))
    def decoded(entries):return {int(i):decode(tuple(value)) for i,value in entries.items()}
    order=sorted(itertools.product(range(5),repeat=3),key=lambda v:(v[0]+v[1]+2*v[2],v))
    position={v:i for i,v in enumerate(order)}
    def constant_generator(coordinate):
        cols=[]
        for monomial in order:
            for base in range(6):
                out={}
                for j in range(monomial[coordinate]+1):
                    sub=list(monomial);sub[coordinate]=j
                    coefficient=k(comb(monomial[coordinate],j)%5)
                    if coefficient:out[6*position[tuple(sub)]+base]=coefficient
                cols.append(out)
        return cols
    g=constant_generator(0)
    central=constant_generator(2)
    h=[None]*750
    for row in deck['columns']:h[row['column']]=decoded(row['entries'])
    assert all(row is not None for row in h)
    def add_term(out,i,a):
        value=out.get(i,zero)+a
        if value:out[i]=value
        else:out.pop(i,None)
    def action(operator,v):
        out={}
        for j,a in v.items():
            for i,b in operator[j].items():add_term(out,i,a*b)
        return out
    def difference(operator,v):
        out=action(operator,v)
        for i,a in v.items():add_term(out,i,-a)
        return out
    # Verify the actual cohomology representation on EVERY basis vector.
    for j in range(750):
        v={j:k(1)}
        assert action(g,action(h,v))==action(central,action(h,action(g,v)))
        w=v
        for _ in range(5):w=action(h,w)
        assert w==v
    representation_seconds=time.monotonic()-start
    print(json.dumps(dict(stage='all750_deck_relations_pass',seconds=representation_seconds)),flush=True)
    top=position[(4,4,4)]*6
    source={row['column']:decoded(row['entries']) for row in hodge['columns']}
    assert all(top+i in source for i in range(6))
    seeds=[source[top+i] for i in range(6)]
    orbit={}
    pivots={}
    pivot_count=[]
    operations=0
    for exponent in order:
        a,b,d=exponent
        if a:
            previous=orbit[(a-1,b,d)];op=g
        elif b:
            previous=orbit[(0,b-1,d)];op=h
        elif d:
            previous=orbit[(0,0,d-1)];op=central
        else:previous=None
        columns=[difference(op,v) for v in previous] if previous is not None else seeds
        orbit[exponent]=columns
        for col in columns:
            reduced=dict(col)
            while reduced:
                i=max(reduced)
                coefficient=reduced[i]
                if i not in pivots:
                    inverse=coefficient**(-1)
                    pivots[i]={j:x*inverse for j,x in reduced.items()}
                    break
                for j,x in pivots[i].items():
                    add_term(reduced,j,-coefficient*x)
                    operations+=1
        pivot_count.append(len(pivots))
        if len(pivot_count)%10==0:
            print(json.dumps(dict(stage='orbit_rank',monomials=len(pivot_count),rank=len(pivots),
                                  seconds=time.monotonic()-start)),flush=True)
    rank=len(pivots)
    defect=750-rank
    assert 25<=defect<=125
    result=dict(status='PASS',case=deck['case'],plane=deck['plane'],central=deck['central'],
        plane_rank=deck['plane_rank'],base_plane=deck['base_plane'],genus=251,
        tangent_dimension=750,rank=rank,defect=defect,
        deck_relations_checked_on=750,free_generators=6,full_group_basis_monomials=125,
        rank_progression=pivot_count,field_updates=operations,
        representation_seconds=representation_seconds,seconds=time.monotonic()-start,
        deck_source=args.deck,hodge_source=args.hodge,
        scope='Actual full Hodge rank using independently verified deck relations and six free generators; geometric construction still requires scoped audit.')
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result),flush=True)


if __name__=='__main__':main()
