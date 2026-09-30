#!/usr/bin/env sage
"""Independent Hasse-jet Sylvester checks of the large interpolation.

Aggregate coefficients modulo120 (three jets) or600 (eight jets) at
F25* nodes. Lucas's theorem gives these exact periods. The complete
polynomials remain retained; this check supplements their degree bounds.
"""
import sys,json,time
from pathlib import Path
import numpy as np
d=Path(sys.argv[1]);co=load(str(d.parent/'coordinates.sobj'));K=co['root'].parent();a=K.gen();beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
assert beta**2==beta+3
Q=PolynomialRing(K,'T');T=Q.gen();original=json.load(open(d.parent/'content_curve_native.json'))['coefficients']
depth=int(json.load(open(d/'norm_projection.71.json'))['jets'])
assert depth in [3,8]
char_period=5 if depth<=5 else 25
period=24*char_period
def buckets(coeff):
 v=np.asarray(coeff,dtype=np.int64);ix=np.arange(len(v),dtype=np.int64)%period;rows=[]
 for j in range(8):
  rows.append(np.bincount(ix,weights=v%5,minlength=period).astype(np.int64)%5);v//=5
 return [sum(K(int(rows[2*i][j]))*a**i+K(int(rows[2*i+1][j]))*beta*a**i for i in range(4)) for j in range(period)]
def jet(b,z):return Q([sum(K(binomial(j%char_period,k)%5)*b[j]*z**((j-k)%24) for j in range(period)) for k in range(depth)])
jb=[buckets(r) for r in original];checks=[];start=time.time()
for index in [71,72]:
 p=json.load(open(d/('norm_tail_content.%d.json'%index)));pb=[buckets(r) for r in p['coefficients']]
 norm=json.load(open(d/('norm_projection.%d.json'%index)));nb=buckets(norm['norm_of_primitive_row'])
 for z in [K(1),beta,beta+1]:
  aa=[jet(b,z) for b in jb];bb=[jet(b,z) for b in pb];m=len(aa)-1;n=len(bb)-1;M=matrix(Q,m+n)
  for i in range(n):
   for j in range(m+1):M[i,i+j]=aa[m-j]
  for i in range(m):
   for j in range(n+1):M[n+i,i+j]=bb[n-j]
  actual=M.det();want=jet(nb,z);assert all(actual[j]==want[j] for j in range(depth))
  checks.append({'index':int(index),'node':str(z),'hasse_jets':depth});print('INDEPENDENT_SYLVESTER_JETS_PASS',index,z,depth,time.time()-start,flush=True)
(d/'hermite_independent_checks.json').write_text(json.dumps({'status':'PASS','scope':'Six full fixed Sylvester determinants, all retained Hasse jets; degree-certified reconstruction remains the global proof','hasse_jets':depth,'checks':checks,'seconds':time.time()-start},indent=2)+'\n')
