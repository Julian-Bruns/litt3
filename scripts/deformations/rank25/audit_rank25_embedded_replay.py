"""Compare every digit and fifth coordinate with the original F625 replay."""
import hashlib
import json
from pathlib import Path
import sys

new = Path(sys.argv[1])
old = Path('/Users/julian/Documents/litt3-computation-data/'
           'rank25-one-parameter-returned-20260912-hsze3x/root_plus/'
           'fifth_constant_4200_0.json')
a = json.loads(old.read_text()); b = json.loads(new.read_text())
degree = len(b['E5'][0]); stride = degree//4
keys = ['zeta', 'third_digit', 'rho5_coordinates', 'E5']
for key in keys:
    assert len(a[key]) == len(b[key])
    for original, extended in zip(a[key], b[key]):
        assert extended[::stride] == original, key
        assert not any(c for i, c in enumerate(extended) if i % stride), key
result = {'status': 'PASS full original-point regression',
          'coefficient_degree': degree, 'embedding': f't=h^{stride}',
          'all_arrays_match': keys, 'complementary_coefficient_positions_zero': True,
          'original_sha256': hashlib.sha256(old.read_bytes()).hexdigest(),
          'extended_sha256': hashlib.sha256(new.read_bytes()).hexdigest()}
(new.parent/'original_point_regression.json').write_text(json.dumps(result, indent=2)+'\n')
print(json.dumps(result, indent=2))
