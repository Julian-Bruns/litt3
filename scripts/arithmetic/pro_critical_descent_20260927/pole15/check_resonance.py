#!/usr/bin/env python3
"""Supplementary exact integer checks for the new theoretical arguments.
This does not verify local geometry or search for maps.
"""
from itertools import product
import json

def partitions(n, cap=None):
    if n==0:
        yield ()
    else:
        for a in range(min(n, cap or n),0,-1):
            for rest in partitions(n-a,a):
                yield (a,)+rest

def verify():
    rows=[]
    for part in partitions(5):
        if len(part)>4: continue
        allowed=[]
        for clusters in product(*[[r for r in range(1,m+1) if m%r==0] for m in part]):
            residues={(m+2*r)%5 for m,r in zip(part,clusters)}
            if len(residues)!=1: continue
            lower=max(m+2*r for m,r in zip(part,clusters))
            allowed.append({'cluster_sizes':list(clusters), 'residue_mod_5':residues.pop(),
                            'minimum_order':lower})
        rows.append({'partition':list(part), 'possibilities':allowed})
    assert min(p['minimum_order'] for r in rows for p in r['possibilities']) == 7
    assert {tuple(r['partition']) for r in rows if r['possibilities']} == {(5,),(4,1),(3,2)}
    margins=[7*l*l-20*l+15 for l in range(1,8)]
    assert all(m>0 for m in margins)
    assert (1*pow(3,-1,5))%5 == 2
    assert (3*pow(4,-1,5))%5 == 2
    assert 12*(-11)%29 == 13 and 17*(-11)%29 == 16
    assert 2*(-11)%29 == 7
    assert all(3 > n-15 for n in (15,16,17))
    return {'constant_character_partition_table':rows,
            'common_infinity_positive_margins_l_1_to_7':margins,
            'zero_resonance_mod_5':2, 'common_infinity_resonance_mod_5':2,
            'leading_q_ratio_exponent_mod_29':18,
            'reciprocity_weight_mod_29':7,
            'degree_exclusion_without_new_minors':[15,16,17,18],
            'degree_exclusion_with_four_phase_minors':[15,16,17,18,19],
            'scope':'Integer and scalar arithmetic only; theoretical proofs are in PREVIOUS_REPORT.md.'}
if __name__ == '__main__':
    print(json.dumps(verify(),indent=2))
