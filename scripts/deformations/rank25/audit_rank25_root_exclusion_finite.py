"""Standard-library replay of the finite-etale joint exclusion certificate.

The exact local geometric calculations supplying the residues are audited
separately. This script checks factor coverage, CRT data and the unit ideal.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import hashlib
import json
from pathlib import Path

from scripts.deformations.rank25.audit_rank25_one_parameter_return import (
    f, Z, O, plus, times, divide, gcd, neg,
)

root = Path(__file__).resolve().parents[3]
source = root/'Research/computations/rank25_one_parameter_full_exclusion.json'
data = json.loads(source.read_text())
decode = lambda p: [f.digits(c) for c in p]
G = decode(data['G_monic'])
remainders = list(map(decode, data['residual_polynomials_mod_G']))
product = [O]
for piece in data['pieces']:
    factor = decode(piece['factor'])
    assert gcd(product, factor) == [O]
    product = times(product, factor)
    for p, wanted in zip(remainders, piece['residuals']):
        assert divide(p, factor)[1] == decode(wanted)
assert product == G and len(G)-1 == data['root_count'] == 30
derivative = [f.mul((i%5,0,0,0),G[i]) for i in range(1,len(G))]
assert gcd(G, derivative) == [O] and G[0] != Z
for p in remainders:
    assert all(c == Z for i,c in enumerate(p) if i%2)
c = f.digits(data['separating_combination_coefficient'])
separator = plus(remainders[0], [f.mul(c,v) for v in remainders[1]])
assert separator == decode(data['separating_polynomial'])
a, b = decode(data['bezout_G']), decode(data['bezout_separator'])
assert plus(times(a,G), times(b,separator)) == [O]
assert gcd(G, separator) == [O]
result = {'status': 'PASS independent finite-etale unit-ideal audit',
          'geometric_scope': 'All roots of the accepted scalar; local geometric evaluation remains a separate input.',
          'root_count': 30, 'factors': 7, 'squarefree': True,
          'both_remainder_polynomials_even': True,
          'joint_Bezout_identity': 'a*G+b*(R5+c*R6)=1',
          'source_sha256': hashlib.sha256(source.read_bytes()).hexdigest()}
(root/'Research/computations/rank25_one_parameter_exclusion_finite_audit.json').write_text(
    json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
