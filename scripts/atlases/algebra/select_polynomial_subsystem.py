#!/usr/bin/env python3
"""Select recorded low-degree equations without changing coefficients."""
import argparse,hashlib,json
from pathlib import Path
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('source',type=Path);p.add_argument('out',type=Path)
p.add_argument('--max-degree',type=int,required=True);args=p.parse_args()
args.out.mkdir(exist_ok=False);raw=args.source.read_bytes();data=json.loads(raw)
indices=[i for i,f in enumerate(data['equations']) if max((sum(e) for e,c in f),default=-1)<=args.max_degree]
output={k:data[k] for k in ('prime','field_degree','field_modulus','variables')}
output.update(equations=[data['equations'][i] for i in indices],
    previous_source=str(args.source.resolve()),previous_source_sha256=hashlib.sha256(raw).hexdigest(),
    original_row_indices=indices,
    scope='Exact selected subsystem; positive solutions need not solve omitted equations')
(args.out/'source.json').write_text(json.dumps(output,separators=(',',':'))+'\n')
print(json.dumps(dict(rows=len(indices),terms=sum(len(f) for f in output['equations']),
    max_degree=args.max_degree,source_sha256=output['previous_source_sha256'])))
