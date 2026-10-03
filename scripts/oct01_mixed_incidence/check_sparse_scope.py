#!/usr/bin/env python3
"""Distinguish seven augmented columns from ordinary root powers."""
import json
import sys
from collections import defaultdict
from pathlib import Path
sys.path.insert(0, '/Users/julian/Documents/litt3-computation-data/october01_audited_replies/mixed_span_incidence/src')
from field import K, xi, ksum

phases = (2, 3, 6, 15, 24, 27, 28)
coefficients = (1, 2, 3, 4, 3, 2, 1)
ordinary = ksum(K.scale(K.pow(xi, j), c) for j, c in zip(phases, coefficients))
augmented = ksum(K.scale(K.mul(K.sub(K.pow(xi, j), K.one),
                              K.sub(K.pow(xi, j), xi)), c)
                for j, c in zip(phases, coefficients))
expanded = defaultdict(int)
for j, c in zip(phases, coefficients):
    for power, value in ((2*j, c), (j, -c), (j+1, -c), (1, c)):
        expanded[power % 29] = (expanded[power % 29]+value) % 5
terms = sorted((j, c) for j, c in expanded.items() if c)
assert ordinary != K.zero and augmented == K.zero
assert len(terms) == 14
result = dict(phases=phases, coefficients_F5=coefficients,
              ordinary_sum_original_K=ordinary, augmented_sum_original_K=augmented,
              expanded_terms_F5=terms, expanded_support=14,
              scope='seven augmented-column dependence does not contradict independence of at most nine ordinary root powers')
path = Path('/Users/julian/Documents/litt3-computation-data/oct01_local_continuation/mixed/sparse_scope_check.json')
path.write_text(json.dumps(result, indent=2)+'\n')
print(json.dumps(result))
