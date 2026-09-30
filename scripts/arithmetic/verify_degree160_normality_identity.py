#!/usr/bin/env python3
"""Independent standard-library check of the degree160 rank certificate.

Checks the full polynomial identity over F25[u,v], with no Groebner
basis, sampling, Sage, or Singular. The separate reconstruction checks
that the matrix and denominator come from the geometric formulas.
"""
import argparse
from itertools import permutations
import json
from pathlib import Path
import time


def fadd(a,b):
    return (a%5+b%5)%5+5*((a//5+b//5)%5)


def fmul(a,b):
    a0,a1=a%5,a//5;b0,b1=b%5,b//5
    return (a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5)


ADD=[[fadd(a,b) for b in range(25)] for a in range(25)]
MUL=[[fmul(a,b) for b in range(25)] for a in range(25)]
NEG=[next(b for b in range(25) if ADD[a][b]==0) for a in range(25)]


def readpoly(rows):
    out={}
    for i,j,c in rows:
        assert 0<=c<25 and i>=0 and j>=0 and (i,j) not in out
        if c:out[i,j]=c
    return out


def add(a,b):
    out=a.copy()
    for e,c in b.items():
        v=ADD[out.get(e,0)][c]
        if v:out[e]=v
        elif e in out:del out[e]
    return out


def scale(a,c):
    return {e:MUL[v][c] for e,v in a.items()} if c else {}


def mul(a,b):
    out={}
    for (i,j),c in a.items():
        table=MUL[c]
        for (i1,j1),c1 in b.items():
            e=(i+i1,j+j1);v=ADD[out.get(e,0)][table[c1]]
            if v:out[e]=v
            elif e in out:del out[e]
    return out


def det3(m):
    out={}
    for p in permutations(range(3)):
        sign=4 if sum(p[i]>p[j] for i in range(3) for j in range(i+1,3))%2 else 1
        term=mul(mul(m[0][p[0]],m[1][p[1]]),m[2][p[2]])
        out=add(out,scale(term,sign))
    return out


def verify(path):
    data=json.loads(path.read_text())
    assert data['field_modulus_ascending']==[2,4,1]
    assert data['variables']==['u','v']
    N=[[readpoly(p) for p in row] for row in data['matrix']]
    assert len(N)==5 and all(len(row)==3 for row in N)
    D=readpoly(data['denominator']);disc=readpoly(data['discriminant'])
    assert D and disc and data['kappa']
    total={}
    assert len(data['minor_rows'])==len(data['multipliers'])==10
    for rows,multiplier in zip(data['minor_rows'],data['multipliers']):
        assert len(rows)==3 and len(set(rows))==3
        minor=det3([N[i] for i in rows])
        total=add(total,mul(readpoly(multiplier),minor))
    D2=mul(D,D)
    target=scale(mul(mul(D2,D2),disc),data['kappa'])
    assert total==target
    return {'identity':'sum a_i minor_i = [14] D^4 disc(h)',
            'target_total_degree':max(i+j for i,j in target),
            'target_term_count':len(target),'verified':'PASS',
            'scope':'Exact polynomial identity; matrix construction checked separately.'}


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('certificate',type=Path)
    p.add_argument('--output',type=Path)
    args=p.parse_args();start=time.monotonic();result=verify(args.certificate)
    result['elapsed_seconds']=round(time.monotonic()-start,3)
    body=json.dumps(result,indent=2)+'\n';print(body)
    if args.output:args.output.write_text(body)
