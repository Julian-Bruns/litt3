#!/usr/bin/env sage
"""One111 kernel map: complete degree-seven Veronese section test."""
import json,time
from pathlib import Path
started=time.time()
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
data=json.loads((folder/'triple_kernel_maps.json').read_text());prototype=data['prototypes'][0]
Q=PolynomialRing(GF(5),'t');E=GF(5**24,'e',modulus=Q(data['field_modulus']))
def unpack(v):return E(v)
R=PolynomialRing(E,'x');x=R.gen();beta=unpack(data['beta_coordinates'])
def code(c):return E(c%5)+E(c//5)*beta
P=R([code(c) for c in [11,22,18,5,19,20,15,16,9,22,1]])
def coords(v):return [int(a) for a in v.polynomial().list()]
def mul(f,g):
 h=[R.zero() for _ in range(5)]
 for i in range(3):
  for j in range(3):h[i+j]+=f[i]*g[j]
 h[0]+=P*h[3];h[1]+=P*h[4]
 return h[:3]
cofactors=[[R([unpack(v) for v in h]) for h in f] for f in prototype['cofactors']]
def exponent_vectors(n,slots=5):
 if slots==1:yield (n,);return
 for a in range(n+1):
  for tail in exponent_vectors(n-a,slots-1):yield (a,)+tail
one=[R.one(),R.zero(),R.zero()]
cache={(0,0,0,0,0):one}
for n in range(1,5):
 for exponents in exponent_vectors(n):
  index=next(i for i,a in enumerate(exponents) if a)
  parent=list(exponents);parent[index]-=1
  cache[exponents]=mul(cache[tuple(parent)],cofactors[index])
tags=list(exponent_vectors(7));columns=[]
for exponents in tags:
 left=list(exponents);right=[0]*5;remaining=3
 for i in range(5):
  moved=min(left[i],remaining);left[i]-=moved;right[i]+=moved;remaining-=moved
 columns.append(mul(cache[tuple(left)],cache[tuple(right)]))
assert len(columns)==330
maxdeg=max(h.degree() for f in columns for h in f if h)
rowtags=[(c,n) for c in range(3) for n in range(maxdeg+1)]
M=matrix(E,[[f[c][n] for f in columns] for c,n in rowtags])
print('matrix',M.nrows(),M.ncols(),'generation_seconds',time.time()-started,flush=True)
pivcols=list(M.pivots());rank=len(pivcols)
out={'scope':'One111 triple prototype only; degree7 coordinate monomials, complete-section embedding criterion if rank251.',
     'field_modulus':data['field_modulus'],'prototype_endpoint_indices':prototype['relaxed_endpoint_indices'],
     'matrix_rows':int(M.nrows()),'matrix_columns':int(M.ncols()),'monomial_degree':7,
     'rank':int(rank),'expected_complete_dimension':251,'pivot_columns':pivcols,
     'column_exponents':tags,'seconds_at_rank':time.time()-started,'sage_version':version()}
output=folder/'veronese111_embedding.json';output.write_text(json.dumps(out,indent=2,default=int)+'\n')
print('rank',rank,'seconds',time.time()-started,flush=True)
if rank==251 and time.time()-started<38:
 C=M.matrix_from_columns(pivcols);pivrows=list(C.transpose().pivots())
 minor=C.matrix_from_rows(pivrows).det();assert minor
 out.update({'pivot_rows':pivrows,'pivot_row_tags':[rowtags[i] for i in pivrows],
             'minor':coords(minor),'nonzero_minor':True,'seconds':time.time()-started})
 output.write_text(json.dumps(out,indent=2,default=int)+'\n')
 print('PASS nonzero251minor; seconds',time.time()-started,flush=True)
else:print('No full-section completion or minor time allowance; saved rank.',flush=True)
