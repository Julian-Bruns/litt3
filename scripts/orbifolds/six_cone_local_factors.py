#!/usr/bin/env sage-python
"""Exact small checks for the six-cone local good-place argument."""
import json
from sage.all import QQ, PolynomialRing, NumberField, ZZ

R = PolynomialRing(QQ, 'x')
x = R.gen()
fields = [NumberField(x**3 + x**2 - 2*x - 1, 'a'),
          NumberField(x**3 - 3*x + 1, 'b')]
assert [K.discriminant() for K in fields] == [49, 81]
compositum = fields[0].composite_fields(fields[1])[0]
assert compositum.degree() == 9
assert compositum.discriminant() == 49**3 * 81**3 == 62523502209
assert compositum.discriminant() > 15143226271
factors = {}
for f in (3, 6, 9):
    assert (5**f-1) % 31 == 0
    factors[str(f)] = {sign: [[int(p), int(a)] for p, a in ZZ(5**f+eps).factor()]
                      for sign, eps in [('minus', -1), ('plus', 1)]}
assert ZZ(601).is_prime() and (5**6+1) % 601 == 0
assert ZZ(5167).is_prime() and (5**9+1) % 5167 == 0
print(json.dumps({'status': 'PASS', 'local_factors': factors,
                  'cubic_discriminants': [49, 81],
                  'compositum_degree': 9,
                  'compositum_discriminant': 62523502209,
                  'degree_nine_discriminant_upper_bound': 15143226271}, indent=2))
