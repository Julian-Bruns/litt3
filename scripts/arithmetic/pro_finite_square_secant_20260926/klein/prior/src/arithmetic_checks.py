"""Exhaustive small-field law checks and exact input consistency."""
from ff25 import *
import json
from pathlib import Path
for a in range(25):
    assert add(a,0)==a and mul(a,1)==a and add(a,neg(a))==0
    if a: assert mul(a,inv(a))==1 and power(a,24)==1
    for b in range(25):
        assert add(a,b)==add(b,a) and mul(a,b)==mul(b,a)
        for c in range(25):
            assert mul(mul(a,b),c)==mul(a,mul(b,c))
            assert add(add(a,b),c)==add(a,add(b,c))
            assert mul(a,add(b,c))==add(mul(a,b),mul(a,c))
assert mul(5,5)==add(5,3)
root=Path(__file__).resolve().parents[1]
d=json.loads((root/'inputs/coefficients.json').read_text())
P,A=d['P'],d['A']
assert len(P)==11 and len(A)==5
for f in (P,A,pder(A)): assert pgcd(f,pder(f))==[1]
assert pgcd(P,A)==[1] and pgcd(P,pder(A))==[1] and pgcd(A,pder(A))==[1]
print('PASS: all F25 field laws (25^3 triples), encoding, and exact gcd checks')
print('These are arithmetic checks, not a search for geometric solutions.')
