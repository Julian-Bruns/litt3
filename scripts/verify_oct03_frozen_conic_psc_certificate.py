"""Verify only the fresh recorded PSC7/8 common-root certificate.

Standard-library finite-field Euclidean arithmetic; does not reconstruct
N, rerun the subresultant calculation, enumerate parameters, or use Sage.
Writes exact stripped factors and Bezout coefficients outside litt3.
"""
import json
from pathlib import Path
import time

started = time.monotonic()
data_dir = Path(__file__).resolve().parents[2] / 'litt3-computation-data' / 'oct03_frozen_conic_principal_subresultant_probe'
events = [json.loads(line) for line in (data_dir / 'stdout.jsonl').read_text().splitlines()]
rows = {row['index']: row for row in events if row['event'] == 'principal_subresultant'}
assert set(rows) == {7, 8}
assert any(row['event'] == 'tiny_deficient_subresultant_check' and row['verdict'] == 'PASS' for row in events)

def add(a, b):
    return (a % 5 + b % 5) % 5 + 5 * ((a // 5 + b // 5) % 5)

def neg(a):
    return (-a % 5) + 5 * ((-(a // 5)) % 5)

def mul(a, b):
    a0, a1 = a % 5, a // 5
    b0, b1 = b % 5, b // 5
    return (a0 * b0 + 3 * a1 * b1) % 5 + 5 * ((a0 * b1 + a1 * b0 + a1 * b1) % 5)

plus = [[add(a, b) for b in range(25)] for a in range(25)]
times = [[mul(a, b) for b in range(25)] for a in range(25)]
minus = [neg(a) for a in range(25)]
inverse = {a: next(b for b in range(1, 25) if times[a][b] == 1) for a in range(1, 25)}

def trim(p):
    while p and p[-1] == 0:
        p.pop()
    return p

def padd(p, q):
    return trim([plus[p[i] if i < len(p) else 0][q[i] if i < len(q) else 0] for i in range(max(len(p), len(q)))])

def pneg(p):
    return [minus[a] for a in p]

def pscale(p, c):
    return trim([times[a][c] for a in p])

def pmul(p, q):
    if not p or not q:
        return []
    out = [0] * (len(p) + len(q) - 1)
    for i, a in enumerate(p):
        if a:
            row = times[a]
            for j, b in enumerate(q):
                if b:
                    out[i + j] = plus[out[i + j]][row[b]]
    return trim(out)

def pdiv(p, q):
    assert q
    rem = p[:]
    quotient = [0] * max(0, len(p) - len(q) + 1)
    inv_lc = inverse[q[-1]]
    while len(rem) >= len(q):
        shift = len(rem) - len(q)
        c = times[rem[-1]][inv_lc]
        quotient[shift] = c
        row = times[c]
        for j, b in enumerate(q):
            rem[shift + j] = plus[rem[shift + j]][minus[row[b]]]
        trim(rem)
    return trim(quotient), rem

def strip_known(p):
    valuations = []
    for factor in ([0, 1], [4, 1]):
        v = 0
        while len(p) > 1:
            q, r = pdiv(p, factor)
            if r:
                break
            p = q
            v += 1
        valuations.append(v)
    return p, valuations

original = {i: trim(rows[i]['coefficient_codes'][:]) for i in (7, 8)}
assert len(original[7]) == 1735 and len(original[8]) == 1690
stripped = {}
valuations = {}
for i in (7, 8):
    stripped[i], valuations[i] = strip_known(original[i][:])

a, b = stripped[7][:], stripped[8][:]
old_u, u = [1], []
old_v, v = [], [1]
steps = 0
while b:
    q, r = pdiv(a, b)
    a, b = b, r
    old_u, u = u, padd(old_u, pneg(pmul(q, u)))
    old_v, v = v, padd(old_v, pneg(pmul(q, v)))
    steps += 1
assert len(a) == 1 and a[0] != 0
unit = inverse[a[0]]
bezout7, bezout8 = pscale(old_u, unit), pscale(old_v, unit)
assert padd(pmul(bezout7, stripped[7]), pmul(bezout8, stripped[8])) == [1]
report = {
    'verdict': 'PASS',
    'scope': 'Recorded integral PSC7/8 have no common geometric s-root outside0,1; subresultant generation is not rerun',
    'field': 'F25,beta^2=beta+3; a+5b encodes a+b*beta',
    'stripped_factor_valuations_s_sminus1': valuations,
    'stripped_PSC_codes': stripped,
    'bezout_PSC7_codes': bezout7,
    'bezout_PSC8_codes': bezout8,
    'bezout_identity': 'A(s)*stripped_PSC7(s)+B(s)*stripped_PSC8(s)=1',
    'euclidean_steps': steps,
    'elapsed_seconds': time.monotonic() - started,
}
(data_dir / 'independent_gcd_bezout.json').write_text(json.dumps(report, indent=2) + '\n')
print(json.dumps({key: value for key, value in report.items() if key not in ['stripped_PSC_codes', 'bezout_PSC7_codes', 'bezout_PSC8_codes']}, indent=2))
