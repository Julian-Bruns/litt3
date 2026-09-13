#!/usr/bin/env sage-python
"""Stress-test proposed noncommutative normal forms, not geometric operators.

Keep the same commutative quadratic/quartic germ while varying explicitly
self-adjoint terms supported on the noncommutative central variable.
"""
import argparse
from itertools import product
import json
from pathlib import Path
import random
import time

from sage.all import GF, matrix


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',required=True)
    args=ap.parse_args();start=time.monotonic()
    k=GF(5);labels=list(product(range(5),repeat=3))
    index={g:i for i,g in enumerate(labels)};size=125
    def mul(a,b):
        i,j,l=a;I,J,L=b
        return ((i+I)%5,(j+J)%5,(l+L-I*j)%5)
    identity=matrix.identity(k,size)
    def difference(g):
        M=matrix(k,size,size)
        for i,h in enumerate(labels):
            M[i,index[mul(h,g)]]+=1;M[i,i]-=1
        return M
    x,y,z=[difference(g) for g in [(1,0,0),(0,1,0),(0,0,1)]]
    log=lambda a:sum((k((-1)**(i+1))/k(i)*a**i for i in range(1,5)),
                     matrix(k,size,size))
    X,Y,Z=map(log,[x,y,z])
    assert X**5==0 and Y**5==0 and Z**5==0
    powers=[[identity]+[a**i for i in range(1,5)] for a in [X,Y,Z]]
    # Averages below use the actual inverse anti-involution on the
    # group algebra: X*,Y*,Z*=-X,-Y,-Z, and reverse product order.
    perturbations=[]
    for i,j,l in labels:
        if not l or i+j+2*l<3:continue
        f=powers[0][i]*powers[1][j]*powers[2][l]
        star=k((-1)**(i+j+l))*powers[2][l]*powers[1][j]*powers[0][i]
        f=(f+star)/k(2)
        if f:perturbations.append(((i,j,l),f))
    output=[]
    for name,q in [('node',X**2+Y**2),('radical_quartic',X**2+Y**4)]:
        cases=[]
        cases.append(dict(test='base',defect=size-int(q.rank())))
        for coefficient in range(5):
            cases.append(dict(test='central_square',coefficient=coefficient,
                              defect=size-int((q+coefficient*Z**2).rank())))
        for label,f in perturbations:
            cases.append(dict(test='single_symmetric_central',label=list(label),
                              defect=size-int((q+f).rank())))
        rng=random.Random(20260911)
        for trial in range(60):
            chosen=rng.sample(perturbations,min(8,len(perturbations)))
            coeff=[rng.randrange(1,5) for _ in chosen]
            f=q+sum((c*term[1] for c,term in zip(coeff,chosen)),matrix(k,size,size))
            cases.append(dict(test='mixed',trial=trial,
                              terms=[[list(term[0]),c] for c,term in zip(coeff,chosen)],
                              defect=size-int(f.rank())))
        distribution={}
        for row in cases:distribution[str(row['defect'])]=distribution.get(str(row['defect']),0)+1
        output.append(dict(commutative_germ=name,cases=cases,distribution=distribution))
        print(json.dumps(dict(germ=name,distribution=distribution,seconds=time.monotonic()-start)),flush=True)
    result=dict(status='PASS algebraic tests',results=output,seconds=time.monotonic()-start,
                scope='Arbitrary self-adjoint group-algebra elements with fixed abelianization; NOT actual Hodge operators or geometric counterexamples.')
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')


if __name__=='__main__':main()
