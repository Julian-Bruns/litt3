#!/usr/bin/env sage
"""Stored21 cofactors: exact local base orders, differential, quadratic span."""
import json,time,signal
from pathlib import Path
from itertools import combinations_with_replacement
started=time.monotonic()
def deadline(signum,frame):raise TimeoutError('10-second21 data-only budget')
signal.signal(signal.SIGALRM,deadline);signal.setitimer(signal.ITIMER_REAL,10)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
data=json.loads((folder/'triple_kernel_maps.json').read_text())
Q=PolynomialRing(GF(5),'t');E=GF(5**24,'e',modulus=Q(data['field_modulus']))
def unpack(v):return E(v)
beta=unpack(data['beta_coordinates']);R=PolynomialRing(E,'x');x=R.gen()
def code(c):return E(c%5)+E(c//5)*beta
P=R([code(c) for c in [11,22,18,5,19,20,15,16,9,22,1]])
def mul(f,g):
 h=[R.zero() for _ in range(5)]
 for i in range(3):
  for j in range(3):h[i+j]+=f[i]*g[j]
 h[0]+=P*h[3];h[1]+=P*h[4]
 return h[:3]
S=PowerSeriesRing(E,'s',default_prec=12);s=S.gen()
def polseries(g,r):return sum((S(c)*(r+s)**j for j,c in enumerate(g)),S.zero())
endpoints=[tuple(unpack(v) for v in pt) for pt in data['selected_endpoints']]
ys={}
for r,y in endpoints:
 pp=polseries(P,r);yy=S(y)
 for j in range(1,12):yy+=((pp-yy**3)[j]/(3*y*y))*s**j
 ys[r,y]=yy
records=[]
for prototype in data['prototypes'][1:]:
 cofactors=[[R([unpack(v) for v in h]) for h in f] for f in prototype['cofactors']]
 vals=[]
 for i,(r,y) in enumerate(endpoints):
  series=[sum((polseries(f[c],r)*ys[r,y]**c for c in range(3)),S.zero()) for f in cofactors]
  minimum=min(f.valuation() for f in series)
  forced=3 if i in prototype['relaxed_endpoint_indices'] else 6
  vals.append({'endpoint_index':i,'cofactor_orders':list(map(int,[f.valuation() for f in series])),'common_order':int(minimum),'forced_order':int(forced)})
 pairs=list(combinations_with_replacement(range(5),2));products=[mul(cofactors[i],cofactors[j]) for i,j in pairs]
 maxdeg=max(h.degree() for f in products for h in f if h)
 M=matrix(E,[[f[c][n] for f in products] for c in range(3) for n in range(maxdeg+1)])
 def derivative(f):return [3*P*h.derivative()+c*P.derivative()*h for c,h in enumerate(f)]
 d0=derivative(cofactors[0]);ratios=[]
 for f in cofactors[1:]:
  aa=mul(cofactors[0],derivative(f));bb=mul(d0,f)
  ratios.append(all(aa[c]==bb[c] for c in range(3)))
 records.append({'relaxed_endpoint_indices':prototype['relaxed_endpoint_indices'],'local_orders':vals,
                 'total_finite_base_degree':sum(v['common_order'] for v in vals),
                 'coordinate_line_bundle_degree':82-sum(v['common_order'] for v in vals),
                 'quadratic_product_rank':int(M.rank()),'ratio_derivatives_zero':ratios,
                 'separable_kernel_map':not all(ratios)})
 print('prototype',prototype['relaxed_endpoint_indices'],'base',records[-1]['total_finite_base_degree'],'Ldegree',records[-1]['coordinate_line_bundle_degree'],'quadraticrank',records[-1]['quadratic_product_rank'],'separable',records[-1]['separable_kernel_map'],flush=True)
out={'scope':'Only two stored21 prototype maps; base divisor localization and intrinsic degree diagnostics, no Veronese embedding replay.',
     'records':records,'seconds':time.monotonic()-started,'sage_version':version()}
(folder/'21_kernel_base_localization.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
signal.setitimer(signal.ITIMER_REAL,0);print('DONEseconds',time.monotonic()-started)
