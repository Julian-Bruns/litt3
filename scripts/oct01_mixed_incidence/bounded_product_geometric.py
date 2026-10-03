#!/usr/bin/env sage
"""One bounded geometric-relaxation experiment; finite chart is not omitted in claims."""
import argparse,json,time
from pathlib import Path
from product_subfield_model import build_product

ap=argparse.ArgumentParser();ap.add_argument('--source',required=True)
ap.add_argument('--output',required=True,type=Path);args=ap.parse_args()
start=time.monotonic();R,eq,labels,data=build_product(json.loads(args.source))
kept=[p for p,label in zip(eq,labels)
      if label[0] not in ('v_actual_phi3','u_actual_phi3','fundamental_H_field')]
meta=dict(source=json.loads(args.source),variables=R.ngens(),equations=len(kept),
          degrees=[int(p.total_degree()) for p in kept],
          field_size=int(R.base_ring().cardinality()),status='built; solver pending',
          scope='necessary geometric relaxation only; no finite-field or moment-return equations')
args.output.write_text(json.dumps(meta,indent=2)+'\n')
print(json.dumps(meta),flush=True)
I=R.ideal(kept);gb=I.groebner_basis(algorithm='singular:slimgb')
meta.update(status='completed',unit_ideal=gb==[R.one()],
            basis_length=len(gb),seconds=time.monotonic()-start)
if gb==[R.one()]:
    from sage.interfaces.singular import singular
    si=I._singular_(singular);sg=singular.ideal(1)
    lift=singular.lift(si,sg).sage()
    certificate=[R(lift[i,0]) for i in range(len(kept))]
    assert sum(a*b for a,b in zip(certificate,kept))==1
    cert=args.output.with_suffix('.certificate.txt')
    cert.write_text('\n'.join(map(str,certificate))+'\n')
    meta['certificate']=str(cert);meta['certificate_exact_combination_verified']=True
args.output.write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta),flush=True)
