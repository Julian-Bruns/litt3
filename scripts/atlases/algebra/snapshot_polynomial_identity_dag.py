#!/usr/bin/env python3
"""Freeze a valid DAG prefix and expose its proved rows as a new source."""
import argparse,hashlib,json
from pathlib import Path
p=argparse.ArgumentParser(description=__doc__);p.add_argument('dag',type=Path);p.add_argument('out',type=Path)
args=p.parse_args();raw=args.dag.read_bytes();data=json.loads(raw);args.out.mkdir(exist_ok=False)
(args.out/'dag.json').write_bytes(raw)
out={k:data[k] for k in ('prime','field_degree','field_modulus','variables')}
out.update(equations=[n['polynomial'] for n in data['nodes']],
    identity_dag=str((args.out/'dag.json').resolve()),identity_dag_sha256=hashlib.sha256(raw).hexdigest(),
    scope='Frozen local-identity prefix; exact replay and original geometric chain required')
(args.out/'source.json').write_text(json.dumps(out,separators=(',',':'))+'\n')
print(json.dumps(dict(rows=len(out['equations']),terms=sum(len(f) for f in out['equations']))))
