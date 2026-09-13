#!/usr/bin/env python3
"""Independent exact multinomial check of high-power ghost coefficients."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
import json,time,argparse,random
from pathlib import Path
from math import comb
from sage.all import ZZ,Zq,PolynomialRing
from scripts.arithmetic.toric_prym_unit_roots import WittFrobenius
from scripts.arithmetic.toric_ghost_coefficients import GhostCoefficients

p=argparse.ArgumentParser(description=__doc__);p.add_argument('out',type=Path)
p.add_argument('--digits',type=int,default=3,choices=range(3,7));args=p.parse_args();digits=args.digits
start=time.monotonic();O=Zq(25,prec=digits,type='fixed-mod',names='a',
    modulus=PolynomialRing(ZZ,'v')([2,4,1]),implementation='FLINT')
phi=WittFrobenius(O,[2,4,1],digits,2);a=O.gen();c0=1+a;c1=a-1;c2=2+3*a
engine=GhostCoefficients({(0,0):c0,(1,0):c1,(0,1):c2},O,phi,digits)
rng=random.Random(20260911);checked=0
powers=[4,5,9,24,25]+[5**s-1 for s in range(3,digits+1)]
for n in powers:
    for _ in range(50):
        i=rng.randrange(n+2);j=rng.randrange(n+2-i)
        actual=engine.coefficient(n,(i,j),digits)
        expected=O.zero() if i+j>n else comb(n,i)*comb(n-i,j)*c1**i*c2**j*c0**(n-i-j)
        assert actual==expected,(n,i,j,actual,expected)
        checked+=1
result=dict(status='PASS',coefficient_checks=checked,powers=powers,
    digits=digits,coefficient_field_degree=2,true_nontrivial_witt_frobenius=True,
    seconds=time.monotonic()-start,statistics=engine.statistics())
args.out.write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))
