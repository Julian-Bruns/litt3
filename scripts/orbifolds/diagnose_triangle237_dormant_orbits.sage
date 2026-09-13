"""Refine the EXISTING degree84 census by monodromy group order.

Diagnostic for the new dormant-decoration Frobenius-orbit bound.
Does not regenerate or claim a new census. Requires its checked data dir.
"""
import argparse
import collections
import hashlib
import json
import pathlib
import time

parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('data_directory')
args=parser.parse_args()
folder=pathlib.Path(args.data_directory)
raw=(folder/'tables84.jsonl').read_bytes()
assert hashlib.sha256(raw).hexdigest()=='97aad0a105d12d0905415d16c3df2094e87fd5522f62e11dc86680f6de053926'
tables=[json.loads(line) for line in raw.decode().splitlines() if line]
assert len(tables)==155
survivors=json.loads((folder/'surviving_classes.json').read_text())
assert len(survivors['primitive'])==3 and len(survivors['hyperelliptic'])==42

R=PolynomialRing(GF(5),'t'); t=R.gen(); K=R.fraction_field()
r=K((2*t**2+3*t+2)/(t**2*(t-1)**2))
assert r.derivative(2)-3*r**2==0
assert all(GF(5)(2*e**2)+GF(5)(e**2-1)/4==0 for e in (2,3,7))
print('DORMANT_BASE_AND_LOCAL_DOUBLE_POLES_PASS',flush=True)

groups=collections.defaultdict(list)
started=time.monotonic()
for kind in ('primitive','hyperelliptic'):
    for number in survivors[kind]:
        table=tables[number-1]
        pa=libgap.PermList([row[0]+1 for row in table])
        pb=libgap.PermList([row[1]+1 for row in table])
        G=libgap.Group([pa,pb])
        order=int(G.Size())
        groups[(kind,order)].append(number)
        print('MONODROMY',number,kind,order,'seconds=',round(time.monotonic()-started,3),flush=True)
print('ORDER_BUCKETS',[(kind,order,numbers) for (kind,order),numbers in groups.items()],flush=True)
print('BUCKET_SIZES',[(kind,order,len(numbers)) for (kind,order),numbers in groups.items()],flush=True)
