#!/usr/bin/env python3
"""Merge recorded necessary rows, retaining exact per-row provenance.

The inherited necessity of each input is a separate proof prerequisite.
No equation is altered and no solver verdict is made.
"""
import argparse, hashlib, json
from pathlib import Path
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('basis',type=Path);p.add_argument('extra',type=Path)
p.add_argument('out',type=Path);p.add_argument('--indices',type=int,nargs='+',required=True)
args=p.parse_args();args.out.mkdir(exist_ok=False)
raw1=args.basis.read_bytes();raw2=args.extra.read_bytes()
a,b=json.loads(raw1),json.loads(raw2)
for key in ('field_degree','field_modulus','variables'):assert a[key]==b[key]
assert all(0<=i<len(b['equations']) for i in args.indices)
payload={key:b[key] for key in ('prime','field_degree','field_modulus','variables')}
payload.update(equations=a['equations']+[b['equations'][i] for i in args.indices],
    first_source=str(args.basis.resolve()),first_source_sha256=hashlib.sha256(raw1).hexdigest(),
    second_source=str(args.extra.resolve()),second_source_sha256=hashlib.sha256(raw2).hexdigest(),
    second_source_indices=args.indices,
    scope='Exact necessary-row merge; both input proof chains separately required')
(args.out/'source.json').write_text(json.dumps(payload,separators=(',',':'))+'\n')
print(json.dumps(dict(rows=len(payload['equations']),terms=sum(len(f) for f in payload['equations']))))
