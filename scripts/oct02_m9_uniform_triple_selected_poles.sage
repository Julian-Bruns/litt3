#!/usr/bin/env sage
"""Stronger selected-pole contact on three already saved triple prototypes."""
import json,time
from pathlib import Path
from math import comb
started=time.time()
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
data=json.loads((folder/'triple_kernel_maps.json').read_text())
Q=PolynomialRing(GF(5),'t');E=GF(5**24,'e',modulus=Q(data['field_modulus']))
def unpack(v):return E(v)
beta=unpack(data['beta_coordinates'])
source=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_quotient_probe.sage').read_text().split('records=[]')[0]
source=source.replace("E=GF(5**24,'e');R=PolynomialRing(E,'x');x=R.gen()", "R=PolynomialRing(E,'x');x=R.gen()")
source=source.replace("beta=(x*x-x-3).roots(multiplicities=False)[0]", "assert beta*beta-beta-3==0")
exec(compile(source,'quotient_probe_prefix','exec'))
def coords(v):return [int(a) for a in v.polynomial().list()]
def decode_function(f):return [R([unpack(v) for v in h]) for h in f]
def encode_poly(g):return [coords(v) for v in g.list()]
def norm(f):
 aa,bb,cc=f
 return aa**3+P*bb**3+P**2*cc**3-3*P*aa*bb*cc
S4=PowerSeriesRing(E,'s4',default_prec=4);s4=S4.gen()
def polynomial_series(g,r):return sum((S4(c)*(r+s4)**j for j,c in enumerate(g)),S4.zero())
def stronger_rows(r,y):
 pp=polynomial_series(P,r);yy=S4(y)
 for j in range(1,4):yy+=((pp-yy**3)[j]/(3*y*y))*s4**j
 aa=polynomial_series(Z,r)/yy;rows=[[] for j in range(4)]
 for fs in basis:
  ff=[sum((polynomial_series(f[c],r)*yy**c for c in range(3)),S4.zero()) for f in fs]
  for j in range(4):
   g=sum((E(comb(h,j))*aa**(h-j)*ff[h] for h in range(j,4)),S4.zero())
   rows[j].append(g[3-j])
 return matrix(E,rows)
endpoints=[tuple(unpack(v) for v in pt) for pt in data['selected_endpoints']]
extra={pt:stronger_rows(*pt) for pt in endpoints}
L=PolynomialRing(E,'lam');lam=L.gen();q=poly([13,18,24]);d=poly([1,22,9,1]);ds=[L(d[j])+lam*q[j] for j in range(3)]
def pencil_remainder(N):
 rem=[L.zero() for _ in range(3)]
 for coefficient in reversed(N.list()):
  top=rem[2];rem=[L(coefficient)-ds[0]*top,rem[0]-ds[1]*top,rem[1]-ds[2]*top]
 return rem
records=[]
for prototype in data['prototypes']:
 hit=set(prototype['relaxed_endpoint_indices'])
 kernel=matrix(E,[[unpack(v) for v in row] for row in prototype['coefficient_kernel']])
 sections=[[decode_function(f) for f in fs] for fs in prototype['sections']]
 for endpoint_index,pt in enumerate(endpoints):
  if endpoint_index in hit:continue
  constrained=(extra[pt]*kernel.transpose()).right_kernel_matrix()
  record={'triple_endpoint_indices':prototype['relaxed_endpoint_indices'],'pole_endpoint_index':endpoint_index,
          'dimension':int(constrained.nrows())}
  if constrained.nrows()==1:
   p=[[R.zero() for _ in range(3)] for _ in range(4)]
   for c,fs in zip(constrained[0],sections):
    for j in range(4):p[j]=add(p[j],scale(fs[j],c))
   norms=[norm(f) for f in p if any(f)];gcd=norms[0]
   for g in norms[1:]:gcd=gcd.gcd(g)
   gcd=gcd.monic();rem=pencil_remainder(gcd)
   gg=rem[0];bezout=[L.one(),L.zero(),L.zero()]
   for j in [1,2]:
    gg,aa,bb=gg.xgcd(rem[j]);bezout=[aa*f for f in bezout];bezout[j]+=bb
   if gg:
    scalar=gg.leading_coefficient();gg/=scalar;bezout=[f/scalar for f in bezout]
    assert sum(c*f for c,f in zip(bezout,rem))==gg
   record.update({'line_in_prototype':list(map(coords,constrained[0])),
                  'coefficient_norm_gcd':encode_poly(gcd),'coefficient_norm_gcd_degree':int(gcd.degree()),
                  'pencil_remainders':list(map(encode_poly,rem)),'pencil_gcd':encode_poly(gg),'pencil_gcd_degree':int(gg.degree()),
                  'pencil_bezout':list(map(encode_poly,bezout))})
  records.append(record)
  print(len(records),'dim',record['dimension'],'normgcd',record.get('coefficient_norm_gcd_degree'),'pencilgcd',record.get('pencil_gcd_degree'),flush=True)
out={'scope':'Weight4 required by an actual c pole at a selected endpoint outside a triple zero set; three saved prototypes,18 constraints, no cofactor replay.',
     'field_modulus':data['field_modulus'],'records':records,'seconds':time.time()-started,'sage_version':version()}
(folder/'triple_selected_pole_constraints.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
print('DONE',len(records),time.time()-started,'seconds')
