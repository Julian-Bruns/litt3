#!/usr/bin/env python3
"""Isolate already certified low-degree equations before prolongation.

The new ideal is a SUBIDEAL of the saved necessary system. A proved unit
would suffice; a nonunit or finite-span saturation has no geometric verdict.
All retained equation indices and the original source hash are recorded.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse,json,hashlib,time
from pathlib import Path
from sage.all import GF,PolynomialRing
from scripts.atlases.algebra.export_polynomial_macaulay import export_system

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('source',type=Path);p.add_argument('out',type=Path)
p.add_argument('--degree',type=int,default=2)
p.add_argument('--full-degree',type=int,default=1)
p.add_argument('--no-linear-elimination',action='store_true')
args=p.parse_args();raw=args.source.read_bytes();data=json.loads(raw);started=time.monotonic()
k=GF(5**data['field_degree'],'a',modulus=PolynomialRing(GF(5),'z')(data['field_modulus']))
R=PolynomialRing(k,len(data['variables']),names=data['variables'],order='degrevlex')
equations=[R({tuple(e):k(c) for e,c in f}) for f in data['equations']]
indices=[i for i,f in enumerate(equations) if f.total_degree()<=args.degree]
export_system(R,[equations[i] for i in indices],args.out,c_degree=0,field_only=True,
              full_degree=args.full_degree,eliminate_linear=not args.no_linear_elimination)
(args.out/'subsystem_provenance.json').write_text(json.dumps(dict(
    source=str(args.source.resolve()),source_sha256=hashlib.sha256(raw).hexdigest(),
    degree_cutoff=args.degree,retained_equation_indices=indices,
    scope='Exact subideal of the saved necessary system; no exclusion',
    seconds=time.monotonic()-started),indent=2)+'\n')
