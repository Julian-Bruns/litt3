#!/usr/bin/env python3
"""All five DISTINCT mu_29 points have e_2 != 0 and e_3 != 0.
Normalizing one point to 1 covers all five-subsets. This is not a map search.
"""
from itertools import combinations
from hashlib import sha256
import json
from phase_sums import MODULUS, powmod, rem, gcd, sub

def verify():
    f,x=MODULUS,[0,1]
    assert powmod(x,5**14,f)==x
    for d in (7,2): assert gcd(sub(powmod(x,5**d,f),x),f)==[1]
    assert powmod(x,29,f)==[1]
    count=0; zero_counts={2:0,3:0}; digest=sha256()
    for tail in combinations(range(1,29),4):
        labels=(0,)+tail
        digest.update(bytes(labels))
        for k in (2,3):
            a=[0]*29
            for term in combinations(labels,k):
                e=sum(term)%29; a[e]=(a[e]+1)%5
            value=rem(a,f)
            digest.update(bytes(value+[0]*(14-len(value))))
            if not value: zero_counts[k]+=1
        count+=1
    assert count==20475
    assert zero_counts=={2:0,3:0}
    return {'modulus_ascending':f,'normalization':'one phase is 1',
            'normalized_distinct_five_subsets':count,
            'zero_e2':zero_counts[2],'zero_e3':zero_counts[3],
            'enumeration_sha256':digest.hexdigest(),
            'scope':'All five distinct mu_29 points. No unknown geometric scalar is restricted to a finite field.'}
if __name__=='__main__': print(json.dumps(verify(),indent=2))
