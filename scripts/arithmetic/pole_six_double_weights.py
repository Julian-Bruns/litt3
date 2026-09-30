#!/usr/bin/env python3
"""Extend the verified moment certificate to weights 0,1,2,3.

The local triple-pole residue argument is proved in the companion prose.
This script checks the finite deductions and the seven-case conjugacy.
It does not assert that any surviving pole pattern is realizable.
"""
from pathlib import Path
import argparse, importlib.util, json, sys

ap=argparse.ArgumentParser()
ap.add_argument('--archive',type=Path,required=True)
ap.add_argument('--output',type=Path,required=True)
args=ap.parse_args();args.output.mkdir(parents=True,exist_ok=True)
sys.dont_write_bytecode=True
spec=importlib.util.spec_from_file_location('moment_fields',args.archive/'src/independent_check.py')
c=importlib.util.module_from_spec(spec);spec.loader.exec_module(c)
data=json.loads((args.archive/'data/consistent_systems.json').read_text())
c.check_exceptions(data)
records=[]
for entry in data['systems']:
 for candidate in entry.get('candidates',[]):
  base=candidate['fourier_base']
  shifts=[[((v+s)%5) for v in base] for s in range(5)]
  allowed=[w for w in shifts if all(v<=3 for v in w)]
  if not allowed:continue
  assert len(allowed)==1 and candidate['distinct_values']==4
  weights=allowed[0];z,f,g=entry['case'];x=candidate['moments']
  assert z==58 and g==f+58
  cc=c.lscale(c.la(c.EP[0][0],c.EP[z][0]),(3,0))
  bb=c.lscale(c.la(c.EP[f][1],c.EP[g][1]),(3,0))
  numerator=c.la(bb,(c.cm(c.C0,(x[2],c.NEG[x[3]])),c.CZERO,c.CZERO,c.CZERO))
  denominator=c.la(cc,(c.cm(c.C0,(x[0],c.NEG[x[1]])),c.CZERO,c.CZERO,c.CZERO))
  assert denominator!=c.LZERO
  epsilon=c.lm(numerator,c.lp(denominator,5**56-2))
  assert c.lm(epsilon,denominator)==numerator
  # Validate both trace equations, not just their cross-multiplied version.
  aa=c.lscale(c.la(c.EP[0][1],c.EP[z][1]),(3,0))
  dd=c.lscale(c.la(c.EP[f][0],c.EP[g][0]),(3,0))
  aa=c.la(aa,(c.cm(c.C0,(x[2],x[3])),c.CZERO,c.CZERO,c.CZERO))
  dd=c.la(dd,(c.cm(c.C0,(x[0],x[1])),c.CZERO,c.CZERO,c.CZERO))
  assert c.lm(epsilon,aa)==dd
  assert [weights.count(i) for i in range(4)]==[4,8,10,7]
  assert sum(weights)+6==55
  assert sum(1 if w in [1,2] else 2 if w==3 else 0 for w in weights)==32
  records.append({'case':entry['case'],'parameter':candidate['parameter'],
                  'moments':x,'weights':weights,'epsilon':epsilon})
assert len(records)==7
by_h={r['case'][1]-29:r for r in records}
assert set(by_h)=={2,3,11,14,17,19,21}
for h,r in by_h.items():
 r2=by_h[(24*h)%29]
 for i in range(29):assert r2['weights'][(24*i)%29]==r['weights'][i]
 assert c.lp(tuple(tuple(v) for v in r['epsilon']),25**4)==tuple(tuple(v) for v in r2['epsilon'])
out={'status':'necessary patterns only; no realization',
     'covering_degree':55,'genus_bounds':[3,16],
     'minimal_denominator_degree':32,'triple_poles':7,
     'conjugacy':'single orbit of coefficient Frobenius 25^4',
     'cases':records}
(args.output/'double_weight_profiles.json').write_text(json.dumps(out,indent=2)+'\n')
print('PASS: exactly seven {0,1,2,3} rows; all n=55, r=32, seven triple poles.')
print('PASS: one arithmetic orbit; both trace equations and all epsilon conjugates checked.')
print('OPEN: actual quadratic models for these necessary data.')
