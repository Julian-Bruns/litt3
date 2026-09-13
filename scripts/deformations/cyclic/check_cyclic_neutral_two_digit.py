#!/usr/bin/env python3
"""Exact two-digit augmentation checks; no Hodge geometry is certified."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import json
import random
from math import comb
from scripts.deformations.cyclic.verify_cyclic_power_additive_carry import apply_operator, residual, divided, phi

rng=random.Random(20260911)
q=5;modulus=25
relation=[0]+[comb(5,j)%25 for j in range(1,5)]
norm=[comb(5,j+1)%25 for j in range(5)]
field=[(x,y) for x in range(5) for y in range(5)]
count=0
for eta in field:
    for b in field:
        correction=[tuple(rng.randrange(5) for _ in range(4)) for _ in range(q)]
        operator=[tuple(5*c for c in row) for row in correction]
        a,c,d,f=operator[1];operator[1]=(a+1,c,d,f-1)
        source=[(0,0)]*q
        source[3]=phi(eta,5);source[4]=phi(b,5)
        r=divided(residual(operator,source,eta,relation,norm,modulus),5)
        # The augmentation is the constant coefficient in the e-basis.
        assert r[0]==((-eta[0])%5,(-eta[1])%5)
        count+=1

# In functions, e^3R=P1 and an arbitrary shifted product remains P2.
def diff(v):return [(v[(i+1)%5]-v[i])%5 for i in range(5)]
def dpower(v,n):
    for _ in range(n):v=diff(v)
    return v
products=0
for a in range(5):
    for b in range(5):
        f=[(a+b*i)%5 for i in range(5)]
        for c in range(5):
            for d in range(5):
                g=[(c+d*i)%5 for i in range(5)]
                for shift in range(5):
                    product=[f[i]*g[(i+shift)%5]%5 for i in range(5)]
                    assert dpower(product,3)==[0]*5
                    assert sum(product)%5==0
                    products+=1
print(json.dumps(dict(status='PASS',mixed_operator_samples=count,
    equivariant_shifted_products=products,
    norm_residual='augmentation = -eta, no second Frobenius',
    scope='Finite algebra only; actual global-input comparison needs audit'),indent=2))
