#!/usr/bin/env sage
"""Fixed same-fiber two-zero spaces: determinant norm and pencil divisibility."""
import json,time,os
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
S=PolynomialRing(E,'lam');lam=S.gen()
q=poly([13,18,24]);d=poly([1,22,9,1]);ds=[S(d[j])+lam*q[j] for j in range(3)]
def remainder_in_pencil(N):
 rem=[S.zero() for _ in range(3)]
 for coefficient in reversed(N.list()):
  top=rem[2]
  rem=[S(coefficient)-ds[0]*top,rem[0]-ds[1]*top,rem[1]-ds[2]*top]
 return rem
resume_index=int(os.environ.get('M9_CERT_RESUME','0'))
previous=json.loads((folder/'same_fiber_determinants.json').read_text()) if resume_index else None
records=previous['records'][:resume_index] if previous else []
pattern_index=0
for omitted in aroots:
 endpoints=[(r,y) for r in aroots if r!=omitted for y in cubes(r)]
 for r in aroots:
  if r==omitted:continue
  ys=cubes(r)
  for pair in combinations(ys,2):
   pattern_index+=1
   if pattern_index<=resume_index:continue
   hit={(r,y) for y in pair}
   contact=matrix(E,[row for pt in endpoints for (j,t),row in allrows[pt].items() if pt not in hit or t<2-j])
   kernel=contact.right_kernel_matrix();assert kernel.nrows()==4
   sections=[]
   for v in kernel.rows():
    fs=[[R.zero() for _ in range(3)] for _ in range(4)]
    for c,bas in zip(v,basis):
     if c:
      for j in range(4):fs[j]=add(fs[j],scale(bas[j],c))
    sections.append(fs)
   det=determinant([[sections[i][j] for i in range(4)] for j in range(4)])
   N=norm(det)
   if N:
    N=N.monic();rem=remainder_in_pencil(N)
    polynomials=[g for g in rem if g]
    gg=rem[0];bezout=[S.one(),S.zero(),S.zero()]
    for index in [1,2]:
     gg,aa,bb=gg.xgcd(rem[index])
     bezout=[aa*f for f in bezout];bezout[index]+=bb
    scalar=gg.leading_coefficient()
    gg/=scalar;bezout=[f/scalar for f in bezout]
    assert sum(c*f for c,f in zip(bezout,rem))==gg
   else:rem=[];gg=S.zero();bezout=[]
   records.append({'omitted_A_root':coords(omitted),'relaxed_endpoints':[[coords(v) for v in pt] for pt in hit],
                   'dimension':4,'determinant':encoded(det),'norm':encoded([N])[0],
                   'norm_degree':int(N.degree()),'determinant_pole':int(max((3*h.degree()+10*j for j,h in enumerate(det) if h),default=-1)),
                   'pencil_remainders':[[coords(v) for v in f.list()] for f in rem],
                   'pencil_gcd':[coords(v) for v in gg.list()],'pencil_gcd_degree':int(gg.degree()),
                   'pencil_bezout':[[coords(v) for v in f.list()] for f in bezout],
                   'sections':[[encoded(f) for f in fs] for fs in sections],
                   'coefficient_kernel':[[coords(v) for v in row] for row in kernel.rows()]})
   print(len(records),'norm_degree',N.degree(),'pencil_gcd_degree',gg.degree(),'seconds',time.time()-started,flush=True)
   if time.time()-started>24:break
  if time.time()-started>24:break
 if time.time()-started>24:break
out={'scope':'Fixed same-x two-endpoint zero contact spaces; determinant norm necessary for common poles, and exact leading pencil divisibility. No actual-source sweep.',
     'field_modulus':meta['field_modulus'],'beta_coordinates':meta['beta_coordinates'],'records':records,
     'complete':len(records)==36,'seconds':time.time()-started,'prior_certificate_seconds':previous['seconds'] if previous else 0,'sage_version':version()}
(folder/'same_fiber_determinants.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
print('DONE',len(records),time.time()-started,'seconds')
