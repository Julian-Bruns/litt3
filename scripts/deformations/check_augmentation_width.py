#!/usr/bin/env sage-python
"""Actual group-algebra checks for the augmentation-width defect bound.

No arbitrary algebra element is claimed to be a geometric Hodge operator.
The geometric implication is proved separately using the actual free
cohomology presentation and its cyclic-quotient specialization.
"""
import argparse
import itertools
import json
import math
from pathlib import Path
import time

from sage.all import GF, matrix, vector


def hilbert(weights, p=5):
    h = [1]
    for weight in weights:
        out = [0] * (len(h) + (p-1)*weight)
        for i, coefficient in enumerate(h):
            for j in range(p):
                out[i+j*weight] += coefficient
        h = out
    return h


def check_heisenberg(p):
    k = GF(p)
    labels = list(itertools.product(range(p), repeat=3))
    index = {g:i for i,g in enumerate(labels)}
    size = p**3
    def multiply(g,h):
        a,b,c = g
        d,e,f = h
        return ((a+d)%p,(b+e)%p,(c+f+a*e)%p)
    def right_difference(g):
        ans = matrix(k,size,size)
        for i,h in enumerate(labels):
            ans[i,index[multiply(h,g)]] += 1
            ans[i,i] -= 1
        return ans
    x,y,z = [right_difference(g) for g in [(1,0,0),(0,1,0),(0,0,1)]]
    one = matrix.identity(k,size)
    # Row vectors act by right multiplication: xy-yx=z(1+y)(1+x).
    assert x*y-y*x == z*(one+y)*(one+x)
    assert x**p == y**p == z**p == matrix(k,size,size)
    # Actual binomial basis of k[H], not a guessed associated graded.
    identity = vector(k,[int(g==(0,0,0)) for g in labels])
    pbw=[]
    weights=[]
    for i,j,l in labels:
        pbw.append(identity*(x**i)*(y**j)*(z**l))
        weights.append(i+j+2*l)
    assert matrix(k,pbw).rank() == size
    space=matrix.identity(k,size).row_space()
    dimensions=[]
    for n in range(4*(p-1)+2):
        expected=matrix(k,[v for v,w in zip(pbw,weights) if w>=n],
                        ncols=size).row_space()
        assert space == expected,(p,n,space.dimension(),expected.dimension())
        dimensions.append(int(space.dimension()))
        base=space.basis_matrix()
        space=(base*x).stack(base*y).row_space()
    h=[dimensions[i]-dimensions[i+1] for i in range(len(dimensions)-1)]
    assert h==hilbert([1,1,2],p)
    width=max(dimensions[i]-dimensions[i+2] for i in range(len(dimensions)-2))
    assert width==p*p
    # A few arbitrary test elements check the inequality, not sharpness
    # or geometric realizability. Reversing multiplication is immaterial.
    samples=[]
    for c in range(p):
        f=x*y+y*x+c*z
        length=size-f.rank()
        assert length>=width
        samples.append(dict(central=c,cokernel=int(length)))
    return dict(p=p,order=size,radical_dimensions=dimensions,
                hilbert=h,width=width,arbitrary_sample_cokernels=samples)


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',required=True)
    args=ap.parse_args()
    start=time.monotonic()
    results=[check_heisenberg(p) for p in [3,5]]
    for row in results:
        print(json.dumps(row),flush=True)
    abelian=[]
    for q in [5,25,125]:
        for rank in [1,2,3]:
            h=hilbert([1]*rank,q)
            width=max(a+b for a,b in zip(h+[0],[0]+h))
            expected=2 if rank==1 else 2*q-1 if rank==2 else (3*q*q-1)//2
            assert width==expected
            abelian.append(dict(q=q,rank=rank,width=width))
    result=dict(status='PASS',heisenberg=results,abelian=abelian,
                seconds=time.monotonic()-start,
                scope='Actual finite group algebra and radical filtration; no geometric realization of arbitrary sample elements.')
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(dict(status='PASS',seconds=result['seconds'])),flush=True)


if __name__=='__main__':
    main()
