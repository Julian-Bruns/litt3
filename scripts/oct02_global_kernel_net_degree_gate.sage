#!/usr/bin/env sage
"""Exact all-geometric degree bound for constant two-form planes on fixed X.

No parameter sweep or field arithmetic table is generated. Every covector
with >=2 branch zeros is the unique annihilator of one pair of distinct
branch loss-vectors. All other covectors have saturation degree <=4.
"""
import itertools, json, os, sys
from sage.all import GF, PolynomialRing, matrix

outdir = sys.argv[1]
os.makedirs(outdir, exist_ok=True)
K=GF(5**8,'a')
R=PolynomialRing(K,'x'); x=R.gen()
beta=next(c for c,m in (x*x-x-3).roots())
def code(c):
    return K(c%5)+(c//5)*beta
def pol(v):
    return R([code(c) for c in v])
P=pol([11,22,18,5,19,20,15,16,9,22,1])
qs=[pol(v) for v in ([24,2,1],[5,16,0,1],[5,20,0,0,8,1])]
loss=[qs[1]*qs[2].derivative()-qs[2]*qs[1].derivative(),
      qs[2]*qs[0].derivative()-qs[0]*qs[2].derivative(),
      qs[0]*qs[1].derivative()-qs[1]*qs[0].derivative()]
roots=[r for r,m in P.roots()]
assert len(roots)==10 and P.is_squarefree()
rows=[tuple(f(r) for f in loss) for r in roots]
assert all(any(v) for v in rows)
assert all(matrix(K,[rows[i],rows[j]]).rank()==2
           for i,j in itertools.combinations(range(10),2))
def coords(c):
    v=[int(t) for t in K(c).polynomial().list()]
    return v+[0]*(8-len(v))
def normalize(v):
    c=next(t for t in v if t)
    return tuple(t/c for t in v)
cases=[]; maximum=4
seen=set()
for i,j in itertools.combinations(range(10),2):
    u,v=rows[i],rows[j]
    cov=(u[1]*v[2]-u[2]*v[1],u[2]*v[0]-u[0]*v[2],u[0]*v[1]-u[1]*v[0])
    cov=normalize(cov)
    if cov in seen: continue
    seen.add(cov)
    zeros=[k for k,row in enumerate(rows) if sum(c*t for c,t in zip(cov,row))==0]
    infinity_pole=2 if cov[0] else (1 if cov[1] else 0)
    degree=3+len(zeros)-infinity_pole
    maximum=max(maximum,degree)
    cases.append({'pair':[i,j],'covector':[coords(c) for c in cov],
                  'zero_indices':zeros,'infinity_pole':infinity_pole,
                  'saturation_degree':degree})
receipt={'scope':'all nonzero geometric constant covectors in the fixed three-form net',
         'field_order':5**8,'field_modulus':[int(c) for c in K.modulus().list()],
         'beta':coords(beta),'P_codes':[11,22,18,5,19,20,15,16,9,22,1],
         'q_codes':[[24,2,1],[5,16,0,1],[5,20,0,0,8,1]],
         'root_coordinates':[coords(r) for r in roots],
         'loss_vectors':[[coords(c) for c in row] for row in rows],
         'checks':{'ten_simple_roots':True,'all_loss_vectors_nonzero':True,
                   'all_45_pairs_independent':True},
         'covector_cases':cases,
         'generic_bound_when_at_most_one_zero':4,
         'maximum_saturation_degree':int(maximum)}
with open(os.path.join(outdir,'certificate.json'),'w') as f:
    json.dump(receipt,f,indent=2,default=int)
print(json.dumps({'unique_pair_covectors':len(cases),
                  'maximum_saturation_degree':int(maximum),
                  'maximal_cases':[c['zero_indices'] for c in cases if c['saturation_degree']==maximum]},default=int))
