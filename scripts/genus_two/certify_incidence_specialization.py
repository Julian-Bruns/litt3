#!/usr/bin/env sage-python
"""Check precisely the parameter factors inverted in the octic identity."""
import argparse
import hashlib
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, gcd

parser = argparse.ArgumentParser()
parser.add_argument('--record', type=Path, required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
assert not args.output.resolve().is_relative_to(Path(__file__).resolve().parents[2])
data = json.loads(args.record.read_text())
ring = PolynomialRing(GF(5), 'a')
a = ring.gen()
singular = a * (a - 1) * (a - 2) * (a - 3)
content = ring(data['transgression_content'])
delta = ring(data['form_clearing_denominator'])
coefficients = [ring(value) for exponent, value in data['octic_terms']]
assert content == singular**18
assert delta == singular**2
assert gcd(coefficients) == 1
assert all(sum(exponent) == 8 for exponent, value in data['octic_terms'])
assert max(p.degree() for p in coefficients) == 44
result = {
    'status': 'all_smooth_specialization_certified',
    'input_sha256': hashlib.sha256(args.record.read_bytes()).hexdigest(),
    'content': 'product(a-i,i=0..3)^18',
    'form_denominator': 'product(a-i,i=0..3)^2',
    'octic_coefficient_gcd': '1',
    'octic_coefficient_degree': 44,
    'source_denominator_role': 'multiplied into polynomial cochain; never inverted',
}
args.output.write_text(json.dumps(result, indent=2) + '\n')
print('PASS: only singular parameter factors are inverted; P8 never vanishes identically.')
