#!/usr/bin/env sage
"""Bounded singleton contact spaces and projective-kernel x-recovery test."""
import json,time
from pathlib import Path
from itertools import combinations,permutations
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
perms=list(permutations(range(4)))
signs=[(-1)**sum(perm[i]>perm[j] for i in range(4) for j in range(i+1,4)) for perm in perms]
def determinant(m):
 result=[R.zero() for _ in range(3)]
 for perm,sign in zip(perms,signs):
  term=[R.one(),R.zero(),R.zero()]
  for j in range(4):term=mul(term,m[j][perm[j]])
  result=add(result,scale(term,sign))
 return result
omitted=aroots[0];endpoints=[(r,y) for r in aroots if r!=omitted for y in cubes(r)]
full=matrix(E,[row for pt in endpoints for row in allrows[pt].values()])
records=[]
for distinguished_r in aroots[1:]:
 pt0=(distinguished_r,cubes(distinguished_r)[0])
 contact=matrix(E,[row for pt in endpoints for (j,t),row in allrows[pt].items() if pt!=pt0 or t<2-j])
 kernel=contact.right_kernel_matrix();d0=kernel.nrows()
 print('singleton dimension',d0,flush=True)
 assert d0<=5
 sections=[]
 for v in kernel.rows():
  fs=[[R.zero() for _ in range(3)] for _ in range(4)]
  for c,bas in zip(v,basis):
   if c:
    for j in range(4):fs[j]=add(fs[j],scale(bas[j],c))
  sections.append(fs)
 if d0!=5:
  records.append({'relaxed_endpoint':[coords(v) for v in pt0],'dimension':int(d0),
                  'sections':[[encoded(f) for f in fs] for fs in sections],
                  'coefficient_kernel':[[coords(v) for v in row] for row in kernel.rows()]})
  continue
 cofactors=[]
 for missing in range(5):
  cols=[i for i in range(5) if i!=missing]
  cofactor=determinant([[sections[i][j] for i in cols] for j in range(4)])
  cofactors.append(scale(cofactor,(-1)**missing))
 assert any(any(f) for f in cofactors)
 # Exact coefficient linear relations among kappa_i and x*kappa_i.
 candidates=cofactors+[[x*h for h in f] for f in cofactors]
 maxdeg=max(h.degree() for f in candidates for h in f if h)
 coefficient=matrix(E,[[f[c][n] for f in candidates] for c in range(3) for n in range(maxdeg+1)])
 relations=coefficient.right_kernel_matrix()
 denominators=relations.matrix_from_columns(range(5,10))
 exceptions=denominators.right_kernel_matrix()
 exception_full=full*kernel.transpose()*exceptions.transpose()
 norms=[norm(f) for f in cofactors if any(f)]
 gcd=norms[0]
 for nn in norms[1:]:gcd=gcd.gcd(nn)
 gcd=gcd.monic()
 record={'relaxed_endpoint':[coords(v) for v in pt0],'dimension':int(d0),
         'cofactors':[encoded(f) for f in cofactors],
         'cofactor_pole_bounds':[int(max((3*h.degree()+10*c for c,h in enumerate(f) if h),default=-1)) for f in cofactors],
         'x_relation_dimension':int(relations.nrows()),'x_denominator_rank':int(denominators.rank()),
         'x_exception_dimension':int(exceptions.nrows()),'x_exception_is_empty_stratum':bool(exception_full.is_zero() and exceptions.nrows()==2),
         'x_relations':[[coords(v) for v in row] for row in relations.rows()],
         'common_norm_gcd':encoded([gcd])[0],'common_norm_gcd_degree':int(gcd.degree()),
         'sections':[[encoded(f) for f in fs] for fs in sections],
         'coefficient_kernel':[[coords(v) for v in row] for row in kernel.rows()]}
 records.append(record)
 print('singleton',len(records),'poles',record['cofactor_pole_bounds'],'relations',relations.nrows(),'denrank',denominators.rank(),'exceptiondim',exceptions.nrows(),'gcddegree',gcd.degree(),'seconds',time.time()-started,flush=True)
 if time.time()-started>25:break
out={'scope':'Three fixed singleton contact spaces for one omitted A root; necessary projective kernel map and linear x-recovery relations; no lambda or source sweep.',
     'field_modulus':meta['field_modulus'],'beta_coordinates':meta['beta_coordinates'],'omitted_A_root':coords(omitted),
     'records':records,'complete':len(records)==3,'seconds':time.time()-started,'sage_version':version()}
(folder/'singleton_kernel_map.json').write_text(json.dumps(out,indent=2)+'\n')
print('DONE',time.time()-started,'seconds')
