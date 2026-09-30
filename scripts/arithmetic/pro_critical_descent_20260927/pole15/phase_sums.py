#!/usr/bin/env python3
"""Exhaustive equal-sum classification for multisets of <=5 elements of mu_29.
Python standard library only. No search over geometric map coefficients.
"""
from itertools import combinations_with_replacement
from hashlib import sha256
import json

P = 5
# An irreducible factor of Phi_29 over F_5; coefficients ascend.
MODULUS = [1, 2, 4, 0, 4, 4, 3, 1, 3, 4, 4, 0, 4, 2, 1]

def trim(a):
    a = [x % P for x in a]
    while a and a[-1] == 0: a.pop()
    return a

def sub(a, b):
    return trim([(a[i] if i < len(a) else 0) -
                 (b[i] if i < len(b) else 0) for i in range(max(len(a), len(b)))])

def rem(a, b):
    a, b = trim(a), trim(b)
    if not b: raise ZeroDivisionError('zero polynomial')
    inv = pow(b[-1], -1, P)
    while len(a) >= len(b):
        c, j = a[-1] * inv % P, len(a) - len(b)
        for i, x in enumerate(b): a[i+j] = (a[i+j] - c*x) % P
        a = trim(a)
    return a

def mulmod(a, b, f):
    z = [0] * max(0, len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b): z[i+j] = (z[i+j]+x*y) % P
    return rem(z, f)

def powmod(a, n, f):
    z = [1]
    while n:
        if n & 1: z = mulmod(z, a, f)
        a = mulmod(a, a, f); n >>= 1
    return z

def gcd(a, b):
    while b: a,b = b,rem(a,b)
    return trim([x*pow(a[-1],-1,P) for x in a]) if a else []

def verify():
    f, x = MODULUS, [0,1]
    # Rabin's irreducibility criterion, prime divisors 2 and 7 of degree 14.
    assert powmod(x, 5**14, f) == x
    assert gcd(sub(powmod(x, 5**7, f), x), f) == [1]
    assert gcd(sub(powmod(x, 5**2, f), x), f) == [1]
    assert powmod(x, 29, f) == [1] and x != [1]
    assert rem([1]*29, f) == []
    d = len(f)-1
    one_lanes = sum(1 << (4*i) for i in range(d))
    high_lanes = 8*one_lanes
    def pack(a): return sum(c << (4*i) for i,c in enumerate(a))
    def unpack(a): return tuple((a >> (4*i)) & 15 for i in range(d))
    def add(a,b):
        # Each nibble sum is in 0..8, so no inter-nibble carry occurs.
        s=a+b
        return s-5*(((s+3*one_lanes)&high_lanes)>>3)
    for a in range(5):
        for b in range(5):
            assert add(a*one_lanes,b*one_lanes) == ((a+b)%5)*one_lanes
    phases = [pack(powmod(x,j,f)) for j in range(29)]
    assert len(set(phases)) == 29
    for a in phases:
        for b in phases:
            assert unpack(add(a,b)) == tuple((u+v)%5 for u,v in zip(unpack(a),unpack(b)))
    results=[]
    expected_counts = [29,435,4495,35960,237336]
    for m in range(1,6):
        sums={}; collisions=0; digest=sha256(); count=0
        for ms in combinations_with_replacement(range(29),m):
            total=0
            for j in ms: total=add(total,phases[j])
            count+=1
            digest.update(bytes(ms)); digest.update(total.to_bytes(7,'little'))
            if total in sums:
                previous=sums[total]; collisions+=1
                # The only allowed collisions are between constant 5-multisets.
                assert m == 5 and total == 0
                assert len(set(ms)) == len(set(previous)) == 1
            else: sums[total]=ms
        assert count == expected_counts[m-1]
        assert collisions == (28 if m == 5 else 0)
        if m == 5:
            assert 0 in sums and len(set(sums[0])) == 1
            assert len(sums) == 237308
        results.append({'size':m,'multisets':count,'distinct_sums':len(sums),
                        'collisions':collisions,'nonzero_collisions':0,
                        'enumeration_sha256':digest.hexdigest()})
    return {'modulus_ascending':MODULUS,'irreducibility':'Rabin checks passed',
            'primitive_root_order':29,'results':results,
            'scope':'All phase multisets of each stated size; NOT a search for actual maps.'}

if __name__ == '__main__':
    print(json.dumps(verify(),indent=2))
