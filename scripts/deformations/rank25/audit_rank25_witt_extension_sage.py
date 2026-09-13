"""Independent Sage quotient-ring checks of the extended Witt arithmetic."""
import hashlib
import json
from pathlib import Path
import random
import sys
from sage.all import Integers, PolynomialRing

destination = Path(sys.argv[1])
engine = destination/'reconstruction'
sys.path.insert(0, str(engine))
sys.argv = ['audit', '--precision', '4200', '--modulus', '3125',
            '--third-parameters', str(destination/'octic_0/parameters.json')]
import witt as w
import numpy as np

P = PolynomialRing(Integers(3125), 'H'); H = P.gen()
stride = w.DEG//4
f = H**w.DEG+4*H**(3*stride)+H**(2*stride)+4*H**stride+3
O = P.quotient(f, 'h'); h = O.gen()
def element(a): return O(P([int(c) for c in a]))
def exact(a):
    p = a.lift()
    return [int(p[i]) for i in range(w.DEG)]
sigma_h = element(w.SIGGEN)
assert f(sigma_h) == 0
assert all(c % 5 == 0 for c in exact(sigma_h-h**5))
random_source = random.Random(12092026)
for _ in range(48):
    a = np.array([random_source.randrange(3125) for _ in range(w.DEG)], dtype=np.int64)
    b = np.array([random_source.randrange(3125) for _ in range(w.DEG)], dtype=np.int64)
    aa, bb = element(a), element(b)
    assert w.cm(a, b).tolist() == exact(aa*bb)
    assert ((w.SIGMAT@a) % 3125).tolist() == exact(P(list(map(int, a)))(sigma_h))
    if np.any(a % 5):
        assert w.ci(a).tolist() == exact(aa**-1)
result = {'status': 'PASS independent Sage quotient-ring arithmetic',
          'coefficient_degree': w.DEG, 'modulus': 3125, 'random_full_coefficient_cases': 48,
          'checks': ['full extension multiplication', 'coefficient Frobenius', 'unit inverses'],
          'witt_source_sha256': hashlib.sha256((engine/'witt.py').read_bytes()).hexdigest()}
(destination/'independent_witt_arithmetic.json').write_text(json.dumps(result, indent=2)+'\n')
print(json.dumps(result, indent=2))
