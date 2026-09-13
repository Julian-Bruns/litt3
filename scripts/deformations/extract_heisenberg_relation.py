#!/usr/bin/env sage-python
"""Extract the actual six-by-six free Hodge presentation and scalar Schur relation.

This is a structural diagnostic. No arbitrary algebra element is
identified with geometry: all six columns come from the saved actual
cohomology computation. The group-word basis is g^a h^b c^d, gh=c hg.
"""
import argparse
from functools import lru_cache
from itertools import product
import json
from math import comb
from pathlib import Path
import time

from sage.all import GF, PolynomialRing, matrix


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--deck',required=True)
    ap.add_argument('--hodge',required=True)
    ap.add_argument('--output',required=True)
    args=ap.parse_args()
    start=time.monotonic()
    deck,hodge=[json.loads(Path(p).read_text()) for p in [args.deck,args.hodge]]
    for key in ['case','plane','central','field_modulus','gluing','affine_rhs','infinity_rhs']:
        assert deck[key]==hodge[key]
    P=PolynomialRing(GF(5),'z')
    degree=len(deck['field_modulus'])-1
    k=GF(5**degree,name='b',modulus=P(deck['field_modulus']))
    encode=lambda x:[int(k(x).polynomial()[i]) for i in range(degree)]
    decode=lambda x:k(list(x))
    zero=k(0)
    order=sorted(product(range(5),repeat=3),key=lambda v:(v[0]+v[1]+2*v[2],v))
    position={v:i for i,v in enumerate(order)}
    def constant_generator(axis):
        out=[]
        for key in order:
            for j in range(6):
                out.append({6*position[key[:axis]+(i,)+key[axis+1:]]+j:k(comb(key[axis],i))
                            for i in range(key[axis]+1)})
        return out
    g,c=constant_generator(0),constant_generator(2)
    h=[None]*750
    for row in deck['columns']:
        h[row['column']]={int(i):decode(co) for i,co in row['entries'].items()}
    assert all(row is not None for row in h)
    def act(op,v):
        out={}
        for j,a in v.items():
            for i,b in op[j].items():out[i]=out.get(i,zero)+a*b
        return {i:a for i,a in out.items() if a}
    group_labels=list(product(range(5),repeat=3))
    group_position={v:i for i,v in enumerate(group_labels)}
    top=position[(4,4,4)]*6
    free_columns=[]
    for seed in range(6):
        orbit={(0,0,0):{top+seed:k(1)}}
        for a,b,d in group_labels:
            if a:orbit[a,b,d]=act(g,orbit[a-1,b,d])
            elif b:orbit[a,b,d]=act(h,orbit[0,b-1,d])
            elif d:orbit[a,b,d]=act(c,orbit[0,0,d-1])
            free_columns.append(orbit[a,b,d])
    basis=matrix(k,750,750,{(i,j):a for j,col in enumerate(free_columns) for i,a in col.items()},
                 sparse=False,implementation='generic')
    seeds={r['column']:{int(i):decode(co) for i,co in r['entries'].items()}
           for r in hodge['columns']}
    image=matrix(k,750,6,{(i,j):a for j in range(6) for i,a in seeds[top+j].items()},
                 sparse=False,implementation='generic')
    # Dense solve is independent of the census's augmentation-orbit sparse rank.
    coefficients=matrix(k,basis.__pari__().matsolve(image.__pari__()))
    assert basis*coefficients==image
    print(json.dumps(dict(stage='actual_free_coordinates_solved',seconds=time.monotonic()-start)),flush=True)

    one={group_position[(0,0,0)]:k(1)}
    @lru_cache(None)
    def mult_index(i,j):
        a,b,d=group_labels[i];A,B,D=group_labels[j]
        return group_position[((a+A)%5,(b+B)%5,(d+D-A*b)%5)]
    def add(x,y):
        z=dict(x)
        for i,a in y.items():z[i]=z.get(i,zero)+a
        return {i:a for i,a in z.items() if a}
    def neg(x):return {i:-a for i,a in x.items()}
    def scale(x,a):return {i:c*a for i,c in x.items() if c*a}
    def mul(x,y):
        z={}
        for i,a in x.items():
            for j,b in y.items():
                ij=mult_index(i,j);z[ij]=z.get(ij,zero)+a*b
        return {i:a for i,a in z.items() if a}
    def augmentation(x):return sum(x.values(),zero)
    def inverse(x):
        a=augmentation(x);assert a
        n=add(one,scale(x,-1/a))
        ans=dict(one);power=dict(one)
        for _ in range(1,17):
            power=mul(power,n);ans=add(ans,power)
        assert not mul(power,n)
        ans=scale(ans,1/a)
        assert mul(x,ans)==one and mul(ans,x)==one
        return ans
    # Row coefficients multiply entries on their left; transpose the six
    # seed-image columns to obtain the ordinary noncommutative row matrix.
    A=[[{n:coefficients[125*j+n,i] for n in range(125) if coefficients[125*j+n,i]}
         for j in range(6)] for i in range(6)]
    original=A
    constant=matrix(k,[[augmentation(a) for a in row] for row in A],implementation='generic')
    assert constant.rank()==5
    pivots=[]
    while len(A)>1:
        n=len(A)
        i,j=next((i,j) for i in range(n) for j in range(n) if augmentation(A[i][j]))
        A[0],A[i]=A[i],A[0]
        for row in A:row[0],row[j]=row[j],row[0]
        inv=inverse(A[0][0])
        left=[mul(A[i][0],inv) for i in range(1,n)]
        A=[[add(A[i][j],neg(mul(left[i-1],A[0][j])))
            for j in range(1,n)] for i in range(1,n)]
        pivots.append([i,j])
        print(json.dumps(dict(stage='noncommutative_Schur',remaining=n-1,
                              seconds=time.monotonic()-start)),flush=True)
    f=A[0][0]
    pbw={}
    for i,j,l in group_labels:
        value=zero
        for n,a in f.items():
            ga,gb,gc=group_labels[n]
            if ga>=i and gb>=j and gc>=l:
                value+=a*k(comb(ga,i)*comb(gb,j)*comb(gc,l))
        if value:pbw[i,j,l]=value
    assert all(i+j+2*l>=2 for i,j,l in pbw)
    quadratic={key:a for key,a in pbw.items() if key[0]+key[1]+2*key[2]==2}
    # In gr_J, (xy)^*=yx=xy-z and z^*=-z. Thus self-adjointness
    # of the quadratic symbol means 2*[z]f+[xy]f=0.
    qstar=2*quadratic.get((0,0,1),zero)+quadratic.get((1,1,0),zero)
    right_columns=[]
    for i in range(125):right_columns.append(mul({i:k(1)},f))
    right=matrix(k,125,125,{(i,j):a for j,col in enumerate(right_columns) for i,a in col.items()},
                 implementation='generic',sparse=False)
    scalar_rank=int(right.__pari__().matrank())
    result=dict(status='PASS',case=deck['case'],plane=deck['plane'],central=deck['central'],
        field_modulus=deck['field_modulus'],alpha=deck['alpha'],
        constant_rank=5,scalar_rank=scalar_rank,defect=125-scalar_rank,
        relation_group={str(n):encode(a) for n,a in f.items()},
        relation_pbw={','.join(map(str,key)):encode(a) for key,a in pbw.items()},
        quadratic={','.join(map(str,key)):encode(a) for key,a in quadratic.items()},
        quadratic_adjoint_error=encode(qstar),quadratic_self_adjoint=not bool(qstar),
        pivots=pivots,seconds=time.monotonic()-start,deck=args.deck,hodge=args.hodge,
        scope='Actual noncommutative Schur relation; no assertion that it is a universal normal form.')
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({key:result[key] for key in ['status','case','plane','central','defect',
                     'quadratic','quadratic_self_adjoint','seconds']}),flush=True)


if __name__=='__main__':main()
