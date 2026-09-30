#!/usr/bin/env python3
"""All genus-two characteristic-zero complete uniform numerical atlases.

The proof supplies n<=84 and 3<=r<=6. This enumerates that entire
bounded Hurwitz equation, without imposing a residue-characteristic
restriction on the indices. A numerical profile need not be realized.
"""
from fractions import Fraction
from itertools import combinations_with_replacement
import json


def main():
    profiles=[]
    for n in range(2,85):
        indices=[d for d in range(2,n+1) if n%d==0]
        for r in range(3,7):
            for branch in combinations_with_replacement(indices,r):
                if sum((1-Fraction(1,e) for e in branch),Fraction(0))==2+Fraction(2,n):
                    profiles.append({'degree':n,'indices':branch})
    assert len(profiles)==30
    assert sum(len(p['indices'])==3 for p in profiles)==22
    print(json.dumps(profiles,indent=2))


if __name__=='__main__': main()
