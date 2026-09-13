#!/usr/bin/env python3
"""Exact binary polynomial checks for the fixed-X two-torsion orbit reduction.

Uses the recorded Frobenius polynomial, not a new point-count computation.
The output counts marked cover labels, not abstract source curves.
"""
import json

coefficients=[3814697265625,-305175781250,-177001953125,13916015625,
    -1210937500,1451562500,48171875,-58884375,3536250,601875,
    141450,-94215,3083,3716,-124,57,-29,-2,1]
f=sum((c&1)<<i for i,c in enumerate(coefficients))


def rem(a,b):
    while a.bit_length()>=b.bit_length():a ^= b<<(a.bit_length()-b.bit_length())
    return a


def gcd(a,b):
    while b:a,b=b,rem(a,b)
    return a


def mul(a,b):
    result=0
    while b:
        if b&1:result ^= a
        b >>= 1;a <<= 1
        if a&(1<<18):a ^= f
    return result


def power(a,n):
    result=1
    while n:
        if n&1:result=mul(result,a)
        a=mul(a,a);n >>= 1
    return result


assert f.bit_length()==19 and f&1
assert power(2,2**18)==2
assert all(gcd(power(2,2**(18//p))^2,f)==1 for p in (2,3))
assert power(2,171)==1 and power(2,57)!=1 and power(2,9)!=1
assert power(2,57)!=power(2,114)
assert power(2,57)^power(2,114)==1
assert ((2**18-1)//171)==1533
assert ((2**18-1)//3)//57==1533
print(json.dumps(dict(mod2_exponents=[i for i in range(19) if (f>>i)&1],
    irreducible_degree=18,frobenius_order_on_JX2=171,
    nonzero_double_cover_labels=2**18-1,double_label_orbits=1533,
    rho_stable_rank2_subgroups=(2**18-1)//3,
    subgroup_orbit_length=57,subgroup_orbits=1533,
    scope='Exact finite algebra using the established Frobenius polynomial; no cover exclusion'),indent=2))
