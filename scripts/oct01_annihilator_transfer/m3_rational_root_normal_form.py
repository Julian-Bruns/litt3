#!/usr/bin/env python3
"""Tiny literal F25 check for the m3 rational critical-root reduction."""
import ast
import json
from pathlib import Path

source = Path(__file__).with_name('fixed_linear_denominator_itinerary.py')
tree = ast.parse(source.read_text())
helpers = [node for node in tree.body
           if isinstance(node, (ast.Import, ast.ImportFrom, ast.FunctionDef))]
namespace = {}
exec(compile(ast.Module(body=helpers, type_ignores=[]), str(source), 'exec'), namespace)
P = [11,22,18,5,19,20,15,16,9,22,1]
Z = [15,19,24,12,10,19,3,24,18,16]
leading = [12,1]
quotient, remainder = namespace['divrem'](namespace['pmul'](leading, Z), P)
root_value = namespace['evaluate'](P, 18)
assert quotient == [16]
assert len(remainder) == 9 and remainder[-1] == 5
assert root_value != 0
record = {
    'field': 'F25, beta^2=beta+3, code a+5b',
    'linear_critical_leading': leading, 'root': 18,
    'P_at_root': root_value, 'quotient': quotient, 'remainder': remainder,
    'gap17': 0, 'gap14': remainder[-1],
}
destination = Path('/Users/julian/Documents/litt3-computation-data/oct01_local_continuation/annihilator_transfer/m3_rational_root_normal_form.json')
destination.write_text(json.dumps(record, indent=2) + '\n')
print(json.dumps(record))
