#!/usr/bin/env -S sage -python
"""One new symbolic Cartier ideal, not an endpoint census or carrier test."""
import json
import signal
import sys
from pathlib import Path
from sage.all import GF, PolynomialRing, singular

R = PolynomialRing(GF(5), names=('Q', 'B', 'S', 'Z'))
Q, B, S, Z = R.gens()
Rw = PolynomialRing(R, 'w')
w = Rw.gen()
A = w**3 + (3+2*Q)*w**2 + B*w - (3+2*Q)*B
Phi = w**5 + Q*w**4 + S
odd = (A**3 + 3*A*Phi*w**2)*Phi**2
rows = [R(odd[j]) for j in (14, 9, 4)]
I = R.ideal(rows + [Z*Q*S-1])
target = R.ideal([B**2, Q-1, S*Z-1])
out = Path('../litt3-computation-data/oct03_wild140_moving_cubic_cartier_gate')
if '--verify-only' in sys.argv:
    receipt = json.loads((out/'certificate.json').read_text())
    assert [str(p) for p in I.gens()] == receipt['generators']
    assert [str(p) for p in target.gens()] == receipt['target_generators']
    for expected, column in zip(target.gens(), receipt['lift_columns']):
        assert sum(R(coefficient)*generator
                   for coefficient, generator in zip(column, I.gens())) == expected
    assert all(p.reduce(target.groebner_basis()) == 0 for p in I.gens())
    print('Exact lift and reverse containment PASS; no original Groebner calculation repeated.')
    sys.exit(0)
signal.alarm(5)
gb = I.groebner_basis()
assert all(p.reduce(gb) == 0 for p in target.gens())
assert all(p.reduce(target.groebner_basis()) == 0 for p in I.gens())
lift = singular.lift(singular(I), singular(target)).sage()
assert lift.nrows() == len(I.gens())
assert lift.ncols() == len(target.gens())
for j, expected in enumerate(target.gens()):
    actual = sum(R(lift[i,j])*I.gens()[i] for i in range(len(I.gens())))
    assert actual == expected
signal.alarm(0)
receipt = {
    'field': 'F5', 'variables': ['Q','B','S','Z'],
    'normalization': 'a3=1; a2=3+2Q; a1=B; a0=-(3+2Q)B; Phi=w5+Qw4+S',
    'row_indices': [int(j) for j in (14,9,4)], 'generators': [str(p) for p in I.gens()],
    'target_generators': [str(p) for p in target.gens()],
    'groebner_basis': [str(p) for p in gb],
    'lift_columns': [[str(R(lift[i,j])) for i in range(lift.nrows())]
                     for j in range(lift.ncols())],
    'checks': {'target_in_I_by_exact_lift': True, 'I_in_target_by_reduction': True},
}
out.mkdir(parents=True, exist_ok=True)
(out/'certificate.json').write_text(json.dumps(receipt, indent=int(2))+'\n')
print(json.dumps({'basis': receipt['groebner_basis'], 'checks': receipt['checks']}))
