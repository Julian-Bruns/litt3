#!/usr/bin/env python3
"""Replay a polynomial identity DAG, including its final unit, without Sage."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse,hashlib,json,time
from pathlib import Path
from scripts.atlases.algebra.exact_polynomial_field import ExactPolynomialField
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('source',type=Path);p.add_argument('dag',type=Path);p.add_argument('receipt',type=Path)
p.add_argument('--allow-partial',action='store_true')
args=p.parse_args();raw=args.source.read_bytes();dagraw=args.dag.read_bytes();src=json.loads(raw);dag=json.loads(dagraw)
assert dag['source_sha256']==hashlib.sha256(raw).hexdigest()
for key in ('prime','field_degree','field_modulus','variables'):assert src[key]==dag[key]
field=ExactPolynomialField(src['field_modulus']);d=field.degree;n=len(src['variables']);start=time.monotonic();products=0
def decode(poly):
    out={}
    for e,c in poly:
        assert len(e)==n and all(type(x) is int and x>=0 for x in e)
        assert len(c)<=d and all(type(x) is int and 0<=x<5 for x in c)
        e=tuple(e);assert e not in out;c=field.reduce(c);assert any(c);out[e]=c
    return out
rows=[decode(f) for f in src['equations']]
for j,node in enumerate(dag['nodes']):
    expected=decode(node['polynomial']);actual={};seen=set()
    for i,w in node['weights']:
        assert type(i) is int and 0<=i<len(rows) and i not in seen;seen.add(i)
        for a,c in decode(w).items():
            for b,h in rows[i].items():
                e=tuple(x+y for x,y in zip(a,b));v=actual.setdefault(e,[0]*d)
                product=field.multiply(c,h)
                for k,z in enumerate(product):v[k]=(v[k]+z)%5
                products+=1
    assert {e:tuple(c) for e,c in actual.items() if any(c)}==expected,('failed node',j)
    rows.append(expected)
unit=dag['unit_index']
if unit is None:assert args.allow_partial
else:
    assert type(unit) is int and 0<=unit<len(rows)
    assert rows[unit]=={(0,)*n:(1,)+(0,)*(d-1)}
receipt=dict(status='independent_polynomial_identity_DAG_unit_PASS' if unit is not None else 'independent_polynomial_identity_DAG_partial_PASS',nodes=len(dag['nodes']),
    expanded_products=products,source_sha256=hashlib.sha256(raw).hexdigest(),
    certificate_sha256=hashlib.sha256(dagraw).hexdigest(),seconds=time.monotonic()-start,
    scope='Unit identity in source system; source geometric necessity separately required')
with args.receipt.open('x') as f:json.dump(receipt,f,indent=2);f.write('\n')
print(json.dumps(receipt),flush=True)
