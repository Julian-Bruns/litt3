#!/usr/bin/env python3
"""Exact unit-root624 and multiplicity-one13 checks, standard library."""
from verify_reverse_pro_primary import xc, trim, gcdp, divmodp, xpower

p = 5
q = [3,0,3,1,1]
assert all(c % 5 == 0 for c in xc[:12])
sq = [1,2,1]
product = [0]*7
for i,x in enumerate(q):
    for j,y in enumerate(sq):
        product[i+j] = (product[i+j]+x*y) % 5
assert product == trim(xc[12:], 5)
assert xpower(625,q,5) == [0,1]
r = xpower(25,q,5)
if len(r)<2:
    r += [0]*(2-len(r))
r[1] -= 1
assert gcdp(q,trim(r,5),5) == [1]
assert xpower(624,q,5) == [1]
for d in (2,3,13):
    assert xpower(624//d,q,5) != [1]

def order(a,n):
    b,r = a%n,1
    while b != 1:
        b=b*a%n
        r+=1
    return r

assert order(5,13)==4
assert 624//6==104
for ell in (2,3,7,11,19,23):
    assert ell%13 not in (0,1,12,5,8)
    o=order(5,ell)
    assert o%4 != 0
    print(f'quotient prime {ell}: order of5 = {o}; GSp4 has no13; PASS')
assert order(5,8)==2
assert order(5,16)==4
print('Quartic irreducible, root order624; residual obstruction104; PASS')
print('Abelian quotient exponent2^a with a<=3 is allowed; exponent16 reaches the boundary.')
for ell in (37,41,89):
    f=order(5,ell)
    assert f%8==4 and pow(5,f//2,ell)==ell-1
    assert ell%13 not in (0,1,12,5,8)
    print(f'hyperelliptic quotient prime {ell}: field degree{f} halves to{f//2}; PASS')
assert all(pow(5,e,8) != 7 for e in range(2))
print('Inversion is absent for primitive order8 characters; no mixed-order shortcut.')
