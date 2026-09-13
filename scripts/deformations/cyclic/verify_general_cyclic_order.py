#!/usr/bin/env python3
"""Exact higher-order cyclic preparation and nonlinear-carry diagnostics."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse
import json
from math import comb
from pathlib import Path
import random
import time

from scripts.deformations.cyclic.verify_cyclic_power_additive_carry import apply_operator, add_digit


def run_case(p, h, a, rng):
    q, modulus=p**a,p**(a+1)
    relation=[0]+[comb(q,j)%modulus for j in range(1,q)]
    norm=[comb(q,j+1)%modulus for j in range(q)]
    binomial=[[comb(j,i)%modulus for i in range(j+1)] for j in range(q)]
    nonsquare=next(i for i in range(2,p) if pow(i,(p-1)//2,p)==p-1)
    pair=lambda:(rng.randrange(p),rng.randrange(p))

    def transform(v, inverse=False):
        out=[[0,0] for _ in range(q)]
        for j,(x,y) in enumerate(v):
            if x or y:
                for i,b in enumerate(binomial[j]):
                    coefficient=b if inverse or (j-i)%2==0 else -b
                    out[i][0]+=coefficient*x;out[i][1]+=coefficient*y
        return [(x%modulus,y%modulus) for x,y in out]

    def multiply(v,w):
        return [((x*z+nonsquare*y*t)%modulus,(x*t+y*z)%modulus)
                for (x,y),(z,t) in zip(v,w)]

    records=[]
    modes=[0,2]
    if p>3*h-2:modes.append(1)
    for m in modes:
        for trial in range(4):
            leading=[pair() for _ in range(h+1)]
            if m==1:leading[0]=(0,0)
            if trial==0:leading[:h]=[(0,0)]*h
            eta=tuple(x+p*rng.randrange(modulus//p) for x in leading[0])
            operator=[(0,0,0,0)]*q
            for j in sorted(set(range(min(q,6)))|{q-1}):
                operator[j]=tuple(p*rng.randrange(modulus//p) for _ in range(4))
            aa,bb,cc,dd=operator[h]
            operator[h]=((aa+1)%modulus,bb,cc,(dd+1)%modulus)
            y=[(0,0)]*q
            y[q-h-1:]=leading

            def residual(v):
                out=[((x-n*eta[0])%modulus,(y-n*eta[1])%modulus)
                     for (x,y),n in zip(apply_operator(operator,v,relation,modulus),norm)]
                if m and m<=a:
                    sheets=transform(v)
                    product=sheets
                    for degree in range(2,2+a//m):
                        factor=[(x,-y%modulus) for x,y in sheets] if degree%2==0 else sheets[-1:]+sheets[:-1]
                        product=multiply(product,factor)
                        power=p**(m*(degree-1))
                        contribution=transform(product,inverse=True)
                        out=[((x-power*z)%modulus,(y-power*w)%modulus)
                             for (x,y),(z,w) in zip(out,contribution)]
                return out

            def digit(raw,j):
                power=p**j
                assert all(x%power==y%power==0 for x,y in raw)
                return [(x//power%p,y//power%p) for x,y in raw]

            for j in range(1,a):
                r=digit(residual(y),j)
                assert r[:h]==[(0,0)]*h,('early',p,h,a,m,j,r[:h])
                repair=[(-x%p,-y%p) for x,y in r[h:]]+[pair() for _ in range(h)]
                y=add_digit(y,repair,p**j,modulus)
            # The terminal representative is arbitrary, not only a zero digit.
            y=add_digit(y,[pair() for _ in range(q)],p**a,modulus)
            r=digit(residual(y),a)
            expected=[]
            for j in range(h):
                expected.append(tuple(sum(-((-1)**(j-i))*pow(j-i+1,-1,p)*leading[i][c]
                                          for i in range(j+1))%p for c in range(2)))
            assert r[:h]==expected,('carry',p,h,a,m,leading,r[:h],expected)
            if trial==0:
                repair=[(-x%p,-y%p) for x,y in r[h:]]+[(0,0)]*h
                y=add_digit(y,repair,p**a,modulus)
                assert residual(y)==[(0,0)]*q,('completion',p,h,a,m)
            records.append(dict(weight=m,trial=trial,completed=(trial==0)))
    return dict(prime=p,leading_order=h,power=a,group_order=q,checks=len(records),
                nonlinear_checks=sum(r['weight']!=0 for r in records),status='PASS')


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',required=True)
    args=parser.parse_args()
    output=Path(args.output)
    if output.exists():raise FileExistsError(output)
    started=time.monotonic();rng=random.Random(20260913)
    cases=[(3,1,1),(3,1,2),(5,2,1),(5,2,2),(5,2,3),
           (7,3,1),(7,3,2),(7,3,3),(11,3,1),(11,3,2),
           (11,4,1),(11,4,2),(11,5,1),(11,5,2)]
    records=[]
    for p,h,a in cases:
        records.append(run_case(p,h,a,rng));print(json.dumps(records[-1]),flush=True)
    result=dict(status='PASS',cases=records,total_checks=sum(r['checks'] for r in records),
                seconds=time.monotonic()-started,
                scope='Bounded mixed-additive and nonlinear equations, free repairs and terminal representatives; no geometric comparison.')
    output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:result[k] for k in ['status','total_checks','seconds']}),flush=True)


if __name__=='__main__':main()
