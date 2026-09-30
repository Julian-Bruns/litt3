#!/usr/bin/env python3
"""Exhaustive check of small integer consequences, not of actual maps."""
from itertools import product
import json

def verify():
    compositions=[m for m in product(range(6),repeat=4) if sum(m)==5]
    assert len(compositions)==56
    assert all(max(m)>=2 for m in compositions)
    assert all(max(m)>15-14 for m in compositions) # H_i1 must vanish for n=15
    equal_positive=[m for m in compositions if len(set(a for a in m if a))==1]
    assert len(equal_positive)==4
    assert all(max(m)==5 for m in equal_positive)
    assert 6>15-11 and 6>16-11
    # For n=16, a nonzero H_i1 has degree <=2 and order >=max(m).
    # Two distinct double roots would force its only coefficient to vanish.
    candidates=[m for m in compositions if max(m)==2 and m.count(2)==1]
    assert len(candidates)==4
    assert all(sorted(m)==[1,1,1,2] for m in candidates)
    partitions=sorted(set(tuple(sorted((a for a in m if a),reverse=True)) for m in compositions))
    return {'ordered_norm_compositions':56,'positive_partitions':partitions,
            'n15_H_i1_degree_bound':1,'n15_minimum_H_i1_zero_order':2,
            'equal_positive_compositions':equal_positive,
            'n16_nonzero_H_i1_possible_compositions':candidates,
            'scope':'Only integer corollaries of FOUNDATIONS.md; not a search for maps or scalar coefficients.'}
if __name__=='__main__': print(json.dumps(verify(),indent=2))
