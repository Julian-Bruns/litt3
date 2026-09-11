#!/usr/bin/env python3
"""Check packing against separate polynomial convolution and long division."""
import json
import random
import time
from pathlib import Path
from exact_polynomial_field import ExactPolynomialField

random.seed(20260911)
source=Path('/Users/julian/Documents/litt3-computation-data/degree84-mixed-20260911-q64tkA/quadratic_v2/source.json')
moduli=[[3,0,1],json.loads(source.read_text())['field_modulus']]
moduli += [[random.randrange(5) for _ in range(d)]+[1] for d in (1,4,8,40,80)]
tests=0;timings={}
for modulus in moduli:
    F=ExactPolynomialField(modulus);d=F.degree
    pairs=[(tuple(random.randrange(5) for _ in range(d)),tuple(random.randrange(5) for _ in range(d)))
           for _ in range(1000 if d<=15 else 100)]
    t=time.monotonic();slow=[F.slow_multiply(a,b) for a,b in pairs];old=time.monotonic()-t
    t=time.monotonic();fast=[F.multiply(a,b) for a,b in pairs];new=time.monotonic()-t
    assert fast==slow
    # Worst-case4 coefficients enforce the carry-free bounds, too.
    assert F.multiply((4,)*d,(4,)*d)==F.slow_multiply((4,)*d,(4,)*d)
    tests+=len(pairs)+1;timings[d]=dict(slow_seconds=old,packed_seconds=new)
print(json.dumps(dict(status='PASS',exact_cases=tests,timings=timings),indent=2))
