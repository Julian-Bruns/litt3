#!/usr/bin/env python3
"""Exhaustive 4x4 minors, exponents (0,1,4,5), on mu_29.
Normalizing one row label to 0 covers every four-element subset.
Only standard-library exact F_5 polynomial arithmetic is used.
"""
from itertools import combinations, permutations
from hashlib import sha256
import json
from phase_sums import MODULUS, powmod, rem, gcd, sub

def verify():
    f, x = MODULUS, [0, 1]
    assert powmod(x, 5**14, f) == x
    for d in (7, 2):
        assert gcd(sub(powmod(x, 5**d, f), x), f) == [1]
    assert powmod(x, 29, f) == [1]
    powers = [powmod(x, j, f) for j in range(29)]
    perms=[]
    for p in permutations(range(4)):
        parity=sum(p[i]>p[j] for i in range(4) for j in range(i+1,4))%2
        perms.append((p, -1 if parity else 1))
    exps=(0,1,4,5)
    count=0; zeros=[]; digest=sha256()
    for tail in combinations(range(1,29),3):
        labels=(0,)+tail
        coeff=[0]*29
        for p,sign in perms:
            e=sum(labels[i]*exps[p[i]] for i in range(4))%29
            coeff[e]=(coeff[e]+sign)%5
        value=rem(coeff,f)
        packed=bytes(value+[0]*(14-len(value)))
        digest.update(bytes(labels)); digest.update(packed)
        count+=1
        if not value: zeros.append(labels)
    assert count == 3276
    return {"modulus_ascending":f,"column_exponents":list(exps),
            "normalization":"one phase is 1; all normalized distinct four-subsets",
            "normalized_subsets":count,"zero_minors":len(zeros),
            "zero_labels":zeros,"enumeration_sha256":digest.hexdigest(),
            "scope":"All four distinct mu_29 points; coefficients may lie in the full algebraic closure."}
if __name__ == '__main__':
    print(json.dumps(verify(),indent=2))
