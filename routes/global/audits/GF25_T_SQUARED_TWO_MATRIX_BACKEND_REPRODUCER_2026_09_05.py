"""Fresh-process Sage 10.9 custom-modulus matrix audit; sage -python FILE."""
from itertools import permutations
from pathlib import Path
import re
from sage.all import GF, matrix, prod
import sage.version

k = GF(25, 't', modulus=[3, 0, 1])
t = k.gen()
canonical = GF(25, 'a')

def generic(rows):
    return matrix(k, rows, implementation='generic')

def direct_det(M):
    n = M.nrows()
    return sum((-1)**sum(p[i] > p[j] for i in range(n)
                         for j in range(i+1, n))
               * prod(M[i, p[i]] for i in range(n))
               for p in permutations(range(n)))

A = matrix(k, [[t]])
print('Sage', sage.version.version)
print('custom modulus', k.modulus(), 'canonical modulus', canonical.modulus())
print('scalar t squared', t*t, 'optimized 1x1 square', (A*A)[0, 0])
assert t*t == 2 and (A*A)[0, 0] == t+3
assert (generic([[t]])**2)[0, 0] == 2

# Test the suspected polynomial-coordinate reinterpretation, not a field map.
def to_canonical(x):
    return canonical.from_integer(x.to_integer())

def from_canonical(x):
    return k.from_integer(x.to_integer())

mismatch = 0
for x in k:
    for y in k:
        optimized = (matrix(k, [[x]])*matrix(k, [[y]]))[0, 0]
        assert optimized == from_canonical(to_canonical(x)*to_canonical(y))
        assert (generic([[x]])*generic([[y]]))[0, 0] == x*y
        mismatch += int(optimized != x*y)
print('625 products: canonical coordinate reinterpretation matches all; wrong', mismatch)

rows = [[2*t, 0, 2, 0, 0], [0, 0, 0, 1, 0], [3, 0, t, 0, 1],
        [0, 2, 0, 0, 0], [0, 0, 1, 0, 2*t]]
M = matrix(k, rows)
G = generic(rows)
MF = matrix(k, [[x**5 for x in row] for row in rows])
GF = generic([[x**5 for x in row] for row in rows])
assert M.det() == t+1
assert G.det() == direct_det(M) == 2*t
assert (M*MF)[0, 0] == t+4
assert (G*GF)[0, 0] == sum(M[0, i]*MF[i, 0] for i in range(5)) == 3
print('5x5 determinants optimized/generic/direct:', M.det(), G.det(), direct_det(M))
print('apply_map returns', type(G.apply_map(lambda x: x**5)).__name__)

# Rerun only the current frontier's affected, repaired certificate block.
certificate = Path(__file__).resolve().parents[1] / 'SUPERSPECIAL_GENUS_TWO_QUARTIC_DEGREE_FOUR_CERTIFICATE.md'
blocks = re.findall(r'```python\n(.*?)```', certificate.read_text(), re.S)
affected = [block for block in blocks if 'def direct_det(A):' in block]
assert len(affected) == 1
exec(compile(affected[0], str(certificate), 'exec'), {})
print('PASS: custom-modulus defect independently reproduced; current quartic block passes.')
