#!/usr/bin/env sage
"""New fixed two-section evaluation rank-drop probe, independent of lambda."""
import json,time
from pathlib import Path
from itertools import combinations
started=time.time()
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
meta=json.loads((folder/'quotient_probe_q3_0_certified.json').read_text())
Q=PolynomialRing(GF(5),'t');E=GF(5**24,'e',modulus=Q(meta['field_modulus']))
def unpack(v):return E(v)
beta=unpack(meta['beta_coordinates'])
source=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_quotient_probe.sage').read_text().split('records=[]')[0]
source=source.replace("E=GF(5**24,'e');R=PolynomialRing(E,'x');x=R.gen()", "R=PolynomialRing(E,'x');x=R.gen()")
source=source.replace("beta=(x*x-x-3).roots(multiplicities=False)[0]", "assert beta*beta-beta-3==0")
exec(compile(source,'quotient_probe_prefix','exec'))
def coords(v):return [int(a) for a in v.polynomial().list()]
def encoded(f):return [[coords(v) for v in h.list()] for h in f]
def norm(f):
 aa,bb,cc=f
 return aa**3+P*bb**3+P**2*cc**3-3*P*aa*bb*cc
records=[]
for omitted in aroots:
 endpoints=[(r,y) for r in aroots if r!=omitted for y in cubes(r)]
 contact=matrix(E,[row for pt in endpoints for row in allrows[pt].values()])
 kernel=contact.right_kernel_matrix()
 assert kernel.nrows()==2
 sections=[]
 for v in kernel.rows():
  fs=[[R.zero() for _ in range(3)] for _ in range(4)]
  for c,bas in zip(v,basis):
   if c:
    for j in range(4):fs[j]=add(fs[j],scale(bas[j],c))
  sections.append(fs)
 minors=[add(mul(sections[0][i],sections[1][j]),scale(mul(sections[0][j],sections[1][i]),-1)) for i,j in combinations(range(4),2)]
 norms=[norm(f) for f in minors]
 nonzero=[g for g in norms if g]
 assert nonzero
 gcd=nonzero[0]
 for g in nonzero[1:]:gcd=gcd.gcd(g)
 gcd=gcd.monic()
 selected=prod(x-r for r in aroots if r!=omitted)
 residual=gcd;removed=0
 while residual.degree()>0:
  common=residual.gcd(selected)
  if common.degree()==0:break
  residual=residual//common;removed+=common.degree()
 ratios={};zero_evaluation=[]
 for pt in endpoints:
  values=[[ev(fs[j],*pt) for j in range(4)] for fs in sections]
  row=next(((values[0][j],values[1][j]) for j in range(4) if values[0][j] or values[1][j]),None)
  if row is None:zero_evaluation.append(pt);continue
  assert all(values[0][i]*row[1]==values[1][i]*row[0] for i in range(4))
  key=('infinity',) if not row[0] else tuple(coords(row[1]/row[0]))
  ratios.setdefault(key,[]).append(pt)
 record={'omitted_A_root':coords(omitted),'contact_rank':int(contact.rank()),
         'kernel':[[coords(v) for v in row] for row in kernel.rows()],
         'sections':[[encoded(f) for f in fs] for fs in sections],
         'minor_norm_degrees':[int(g.degree()) for g in norms],
         'common_norm_gcd':encoded([gcd])[0],
         'gcd_degree':int(gcd.degree()),'removed_selected_degree':int(removed),
         'residual_degree':int(residual.degree()),'residual':encoded([residual])[0],
         'zero_evaluation_endpoints':[[coords(v) for v in pt] for pt in zero_evaluation],
         'endpoint_kernel_groups':[[[coords(v) for v in pt] for pt in pts] for pts in ratios.values()],
         'maximum_endpoint_common_zero_count':max(map(len,ratios.values()),default=0)}
 records.append(record)
 print('omission',len(records),'gcd',gcd.degree(),'residual',residual.degree(),'max shared endpoint zeros',record['maximum_endpoint_common_zero_count'],flush=True)
out={'scope':'Fixed empty endpoint-zero quotient stratum; rank-drop locus of two canonical sections on X, not a lambda or actual-source sweep.',
     'field_modulus':meta['field_modulus'],'beta_coordinates':meta['beta_coordinates'],
     'records':records,'seconds':time.time()-started,'sage_version':version()}
(folder/'empty_stratum_rank_drop.json').write_text(json.dumps(out,indent=2)+'\n')
print('DONE',time.time()-started,'seconds')
