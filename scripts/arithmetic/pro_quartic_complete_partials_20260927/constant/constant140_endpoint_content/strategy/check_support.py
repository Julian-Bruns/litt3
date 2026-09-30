#!/usr/bin/env python3
"""Exhaustive finite support arithmetic; no coefficient evaluations or solution search."""
from itertools import combinations_with_replacement
D=(0,2,3,4,7,9,11)
triples=list(combinations_with_replacement(range(7),3))
pairs=list(combinations_with_replacement(range(7),2))
for T in range(71,75):
    max_mu=-1
    for a in triples:
        for b in pairs:
            for c in pairs:
                mu=sum(a)+5*sum(b)+25*sum(c)
                base=sum(D[i] for i in a)+5*sum(D[i] for i in b)+25*sum(D[i] for i in c)
                if base>T: continue
                max_mu=max(mu,max_mu)
                if 44<=mu<=48:
                    assert c==(0,0), (T,mu,a,b,c)
                    assert T-base<25, (T,mu,base,a,b,c)
    expected=47 if T<=72 else 48
    assert max_mu==expected,(T,max_mu,expected)
    print(f'T={T}: maximum mu degree {max_mu}; coefficients mu=44..48 have last Frobenius block exactly L^50: PASS')
print('GLOBAL SUPPORT ENUMERATION PASS. No assertion about common zeros.')
