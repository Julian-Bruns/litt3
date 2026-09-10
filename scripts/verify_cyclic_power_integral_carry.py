#!/usr/bin/env python3
"""Exact small tests of a multi-digit cyclic norm carry.

This verifies only integral group algebra, NOT higher inverse Cartier.
For q=5^a, use Z/5^(a+1)[e]/((1+e)^q-1) and a perturbed coefficient
operator e^2+5B_1+...+5^aB_a. Eliminate the first a-1 residual digits.
The last two augmentation coordinates should be (-c,-2c-d).
Variables here are the already Frobenius-transported coefficients.
"""
import argparse
import json
import random
import time
from math import comb
from pathlib import Path

parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--output',type=Path)
parser.add_argument('--max-power',type=int,default=3,choices=[1,2,3,4])
args=parser.parse_args()
started=time.monotonic();rng=random.Random(20260910)
receipt={'scope':'Integral algebra only; actual geometric carries not certified','powers':[]}

for power in range(1,args.max_power+1):
    q=5**power;modulus=5**(power+1)
    relation=[comb(q,j)%modulus for j in range(q)]
    norm=[comb(q,j+1)%modulus for j in range(q)]
    def mul(a,b):
        out=[0]*(2*q-1)
        for i,x in enumerate(a):
            if x:
                for j,y in enumerate(b):
                    if y:
                        out[i+j]=(out[i+j]+x*y)%modulus
        for i in range(2*q-2,q-1,-1):
            x=out[i]
            if x:
                for j in range(1,q):
                    out[i-q+j]=(out[i-q+j]-x*relation[j])%modulus
        return out[:q]
    def residual(operator,y,eta):
        return [(x-eta*n)%modulus for x,n in zip(mul(operator,y),norm)]
    samples=125 if power<=2 else (40 if power==3 else 3)
    minima=[]
    for number in range(samples):
        if power<=2:
            c=number//25;d=(number//5)%5;b=number%5
        else:
            c,d,b=[rng.randrange(5) for _ in range(3)]
        operator=[0]*q;operator[2]=1
        for digit in range(1,power+1):
            operator=[(x+5**digit*rng.randrange(5))%modulus for x in operator]
        y=[0]*q;y[q-3]=c;y[q-2]=d;y[q-1]=b
        eta=c
        for digit in range(1,power):
            raw=residual(operator,y,eta)
            assert all(x%(5**digit)==0 for x in raw)
            r=[(x//(5**digit))%5 for x in raw]
            assert r[:2]==[0,0],('EARLY_COKERNEL',power,digit,r[:2])
            correction=[(-r[j+2])%5 for j in range(q-2)]+[0,0]
            eta_digit=rng.randrange(5)
            correction[q-3]=(correction[q-3]+eta_digit)%5
            correction[q-2]=rng.randrange(5);correction[q-1]=rng.randrange(5)
            threshold=5**(power-digit)-3
            assert all(not x for x in correction[:threshold]),('SUPPORT',power,digit)
            minima.append(threshold)
            eta+=5**digit*eta_digit
            y=[(x+5**digit*z)%modulus for x,z in zip(y,correction)]
        raw=residual(operator,y,eta)
        assert all(x%(5**power)==0 for x in raw)
        final=[(x//(5**power))%5 for x in raw]
        assert final[:2]==[(-c)%5,(-2*c-d)%5],(power,number,final[:2])
    receipt['powers'].append({'power':power,'group_order':q,'samples':samples,
        'first_digits_have_zero_cokernel':True,'tested_support_thresholds':sorted(set(minima)),
        'final_coordinates':'(-c,-2c-d)'})
    print(json.dumps(receipt['powers'][-1]),flush=True)
receipt.update(status='PASS',seconds=time.monotonic()-started)
if args.output:
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
print('PASS cyclic multi-digit algebra',receipt['seconds'],flush=True)
