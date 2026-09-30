"""Prove a uniform polynomial degree bound before exact residual identity checks.

These are weighted degrees of polynomial curve functions, not values sampled
at parameter points. Give X weight 3 and v weight 10. The relation
v^3=P(X)/q preserves this filtration because deg(P)=10 and q is a unit.
"""
from pathlib import Path
import json

ROOT = Path(__file__).resolve().parents[1]
functions = json.loads((ROOT / 'data/residual_functions.json').read_text())
universal = json.loads((ROOT / 'data/resultant_universal.json').read_text())
degrees = {name: max(row[2] for row in rows) for name, rows in functions.items()}
assert degrees['P'] == 10
weights = [
    max(3 * degrees['Z'], 10),
    max(3 * degrees['A3'], 10 + 3 * degrees['B3'], 20 + 3 * degrees['C3']),
    max(3 * degrees['B4'], 10 + 3 * degrees['C4'], 20 + 3 * degrees['A4']),
    max(3 * degrees['C5'], 10 + 3 * degrees['A5'], 20 + 3 * degrees['B5']),
    10 + 3 * degrees['C0'],
    9 * degrees['t'],
    0,
]
assert universal['variables'] == ['a', 'b', 'c', 'd', 'Q', 'T', 'ell']
assert len(universal['terms']) == 55
bound = max(sum(e * w for e, w in zip(row[:-1], weights))
            for row in universal['terms'])
assert weights == [12, 29, 46, 63, 85, 27, 0]
assert bound == 460
assert 15 * degrees['t'] + 140 <= bound < 624
out = {
    'function_x_degrees': degrees,
    'weights_for_3_degree_a_b_c_d_Q_T_ell': weights,
    'norm_numerator_degree_bound': bound,
    'identity_check_grid_size': 624,
}
(ROOT / 'data/residual_degree_bound.json').write_text(json.dumps(out, indent=2) + '\n')
print('DEGREE_BOUND_PROVED resultant_weight=460 norm_X_degree=460 identity_nodes=624')
