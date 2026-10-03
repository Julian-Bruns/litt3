#!/usr/bin/env sage
"""Three endpoint-zero fixed spaces: rank inventory and three kernel maps."""
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
def contact_matrix(hit):return matrix(E,[row for pt in endpoints for (j,t),row in allrows[pt].items() if pt not in hit or t<2-j])
rank_records=[]
for indices in combinations(range(9),3):
 hit={endpoints[i] for i in indices}
 if len({pt[0] for pt in hit})==1:continue
 contact=contact_matrix(hit)
 rank_records.append({'endpoint_indices':list(indices),'dimension':int(50-contact.rank()),'x_fibers':len({pt[0] for pt in hit})})
assert len(rank_records)==81
print('81 triple dimensions',sorted(set(r['dimension'] for r in rank_records)),'seconds',time.time()-started,flush=True)
records=[]
output=folder/'triple_kernel_maps.json'
def save():
 out={'scope':'One omitted root, all81 non-all-same-fiber triple contact ranks, and only three explicit kernel-map prototypes; no all-triple or source sweep.',
      'field_modulus':meta['field_modulus'],'beta_coordinates':meta['beta_coordinates'],'omitted_A_root':coords(omitted),
      'selected_endpoints':[[coords(v) for v in pt] for pt in endpoints],'rank_records':rank_records,
      'prototypes':records,'seconds':time.time()-started,'sage_version':version()}
 output.write_text(json.dumps(out,indent=2,default=int)+'\n')
save()
for indices in [(0,3,6),(0,1,3),(0,1,6)]:
 hit={endpoints[i] for i in indices};contact=contact_matrix(hit)
 kernel=contact.right_kernel_matrix();d0=kernel.nrows()
 sections=[]
 for v in kernel.rows():
  fs=[[R.zero() for _ in range(3)] for _ in range(4)]
  for c,bas in zip(v,basis):
   if c:
    for j in range(4):fs[j]=add(fs[j],scale(bas[j],c))
  sections.append(fs)
 record={'relaxed_endpoint_indices':list(indices),'dimension':int(d0),
         'sections':[[encoded(f) for f in fs] for fs in sections],
         'coefficient_kernel':[[coords(v) for v in row] for row in kernel.rows()]}
 if d0==5:
  cofactors=[]
  for missing in range(5):
   cols=[i for i in range(5) if i!=missing]
   cofactors.append(scale(determinant([[sections[i][j] for i in cols] for j in range(4)]),(-1)**missing))
  assert any(any(f) for f in cofactors)
  for j in range(4):
   check=[R.zero() for _ in range(3)]
   for i in range(5):check=add(check,mul(sections[i][j],cofactors[i]))
   assert not any(check)
  candidates=cofactors+[[x*h for h in f] for f in cofactors]
  maxdeg=max(h.degree() for f in candidates for h in f if h)
  coefficient=matrix(E,[[f[c][n] for f in candidates] for c in range(3) for n in range(maxdeg+1)])
  relations=coefficient.right_kernel_matrix();denominators=relations.matrix_from_columns(range(5,10))
  norms=[norm(f) for f in cofactors if any(f)];gcd=norms[0]
  for nn in norms[1:]:gcd=gcd.gcd(nn)
  record.update({'cofactors':[encoded(f) for f in cofactors],
                 'cofactor_pole_bounds':[int(max((3*h.degree()+10*c for c,h in enumerate(f) if h),default=-1)) for f in cofactors],
                 'x_relation_dimension':int(relations.nrows()),'x_denominator_rank':int(denominators.rank()),
                 'x_relations':[[coords(v) for v in row] for row in relations.rows()],
                 'common_norm_gcd':encoded([gcd.monic()])[0],'common_norm_gcd_degree':int(gcd.degree())})
 print('prototype',indices,'dim',d0,'relations',record.get('x_relation_dimension'),'denrank',record.get('x_denominator_rank'),'gcddegree',record.get('common_norm_gcd_degree'),'seconds',time.time()-started,flush=True)
 records.append(record);save()
 if time.time()-started>23:break
print('DONE',len(records),time.time()-started,'seconds')
