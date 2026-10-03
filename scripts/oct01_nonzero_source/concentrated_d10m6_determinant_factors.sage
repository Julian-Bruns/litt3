#!/usr/bin/env sage
"""Inspect the exact retained auxiliary-rank drop polynomial; no root sweep."""
from sage.all import *
import argparse,json,time
from pathlib import Path
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);ap.add_argument('--root',type=int,default=145049);args=ap.parse_args();data=args.work/'data';start=time.time()
path=data/f'concentrated_d10m6_endpoint_determinant_{args.root}.sobj';saved=load(str(path));det=saved['determinant'];g=saved['saturation_remaining'];unit=saved['unit'];fac=list(g.factor())
assert prod((f**n for f,n in fac),g.parent().one())*g.leading_coefficient()==g
forbidden=det//g;power=int(saved['saturation_power']);assert not unit**power%forbidden
saved['remaining_factorization']=fac;saved['forbidden_factor']=forbidden;saved['unit_power_quotient']=unit**power//forbidden
save(saved,str(path));summary={'root':int(args.root),'row_degree_bound':int(saved['row_degree_bound']),'determinant_degree':int(det.degree()),'remaining_degree':int(g.degree()),'saturation_power':power,'source_denominator_degree':int(saved['H'].degree()),'freev_D_independent':True,'factor_degrees_multiplicities':[(int(f.degree()),int(n)) for f,n in fac],'remaining_squarefree_degree':int(g.radical().degree()),'scope':'all eta auxiliary matrix; closed rankdrop retained, no existence decision'}
(data/f'concentrated_d10m6_endpoint_determinant_{args.root}.json').write_text(json.dumps(summary,separators=(',',':'))+'\n');print(summary);print('SECONDS',time.time()-start,flush=True)
