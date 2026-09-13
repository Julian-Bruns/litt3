"""Extract a new trace projection from the audited actual cubic sector.

This is a coefficient computation, NOT a universal trace-support theorem.
The sector made from one nu0 and two V inputs is independent of the
constant first repair and has parameter s^25*lambda^50 on the surface.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import hashlib
import json
from pathlib import Path
import zipfile

from scripts.deformations.rank25 import rank25_pro_data_model as m

root = Path(__file__).resolve().parents[3]
evidence = Path('/Users/julian/Documents/litt3-computation-data/'
                'rank25-one-parameter-returned-20260912-hsze3x/'
                'RANK25_ONE_PARAMETER_COMPLETED/generated')
with zipfile.ZipFile(root/'Research/pro_inputs/rank25_surface_fifth_inputs.zip') as z:
    data = m.unpack(json.loads(z.read('surface.json')))
row = data['dual'][0]
decode = lambda c: tuple(c//5**i % 5 for i in range(4))
receipts = []
for precision in (500, 700):
    source = evidence/f'extreme_certificate_precision_{precision}.json'
    raw = json.loads(source.read_text())
    for variant, values in raw['variants'].items():
        sectors = values['graph_sectors']
        projections = {
            e: m.mv([row], list(map(decode, v['normal'])))[0]
            for e, v in sectors.items()
        }
        assert projections == {
            '-150': m.ZERO, '-75': m.ZERO,
            '0': (3, 0, 4, 0), '75': m.ZERO,
        }
        receipts.append({'precision': precision, 'fourth_reference': variant,
                         'trace_projections': projections,
                         'source_sha256': hashlib.sha256(source.read_bytes()).hexdigest()})
result = {
    'status': 'PASS new trace projection of audited mixed/cubic Hodge sector',
    'surface_parameter_monomial': [25, 50],
    'coefficient': [3, 0, 4, 0],
    'meaning': 'One nu0 and two V first inputs, with their actual quadratic fourth repairs.',
    'scope_limit': 'Does not bound the full surface trace support or evaluate its other sectors; integral carries remain.',
    'receipts': receipts,
}
target = root/'Research/computations/rank25_surface_trace_cubic.json'
target.write_text(json.dumps(result, indent=2)+'\n')
print(json.dumps(result, indent=2))
