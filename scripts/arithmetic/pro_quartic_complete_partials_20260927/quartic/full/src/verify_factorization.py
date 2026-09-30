#!/usr/bin/env python3
"""Verify the universal polynomial identity, not a sample of endpoints.
No SymPy, logarithm tables, compiler or numerical linear algebra is used.
"""
from pathlib import Path
import sys,json
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'src'))
from exact_fields import code,to_code
ADD=[[to_code(code(a)+code(b))for b in range(25)]for a in range(25)]
MUL=[[to_code(code(a)*code(b))for b in range(25)]for a in range(25)]
NEG=[to_code(-code(a))for a in range(25)]
BAR=[(a%5+a//5)%5+5*((-(a//5))%5)for a in range(25)]
N=28;zero=(0,)*N
const=lambda c: {zero:c}if c else {}
def var(i):
 m=[0]*N;m[i]=1;return {tuple(m):1}
def add(*args):
 out={}
 for p in args:
  for m,c in p.items():out[m]=ADD[out.get(m,0)][c]
 return {m:c for m,c in out.items()if c}
def neg(p):return {m:NEG[c]for m,c in p.items()}
def sub(p,q):return add(p,neg(q))
def mul(p,q):
 out={}
 for m,c in p.items():
  for n,d in q.items():
   key=tuple(x+y for x,y in zip(m,n));out[key]=ADD[out.get(key,0)][MUL[c][d]]
 return {m:c for m,c in out.items()if c}
def prod(*args):
 out=const(1)
 for p in args:out=mul(out,p)
 return out
mapping=list(range(7,14))+list(range(0,7))+list(range(21,28))+list(range(14,21))
def bar(p):return {tuple(m[mapping[i]]for i in range(N)):BAR[c]for m,c in p.items()}
vs=[var(i)for i in range(N)]
a0,a1,a2,b0,b1,b2,b3=vs[:7];c0,c1,c2,c3,d0,d1,d2=vs[14:21]
delta=const(20)
w1=add(mul(a0,d1),mul(a1,d0),neg(mul(b0,c1)),neg(mul(b1,c0)),neg(prod(delta,b2,c3)),neg(prod(delta,b3,c2)))
w2=add(mul(a0,d2),mul(a1,d1),mul(a2,d0),neg(mul(b0,c2)),neg(mul(b1,c1)),neg(mul(b2,c0)),neg(prod(delta,b3,c3)))
w3=add(mul(a1,d2),mul(a2,d1),neg(mul(b0,c3)),neg(mul(b1,c2)),neg(mul(b2,c1)),neg(mul(b3,c0)))
dx=sub(mul(a1,bar(a1)),mul(d1,bar(d1)));dy=sub(mul(c3,bar(c3)),mul(b3,bar(b3)))
Y=sub(mul(b3,bar(w3)),mul(bar(c3),w3))
R=add(mul(dy,w1),mul(b1,bar(Y)),mul(c1,Y))
X=sub(mul(bar(a1),R),mul(d1,bar(R)))
Z=add(prod(dx,dy,w2),neg(mul(a2,X)),neg(mul(d2,bar(X))),prod(dx,b2,bar(Y)),prod(dx,c2,Y))
if '--write-expansion' in sys.argv:
 data={'variables_Q':['a0','a1','a2','b0','b1','b2','b3','aa0','aa1','aa2','bb0','bb1','bb2','bb3'],
       'variables_H':['c0','c1','c2','c3','d0','d1','d2','cc0','cc1','cc2','cc3','dd0','dd1','dd2'],
       'terms':[[list(m),c]for m,c in sorted(Z.items())]}
 (ROOT/'full/evidence/residual_expansion.json').write_text(json.dumps(data,sort_keys=True,separators=(',',':'))+'\n')
expansion=json.loads((ROOT/'full/evidence/residual_expansion.json').read_text())
assert Z=={tuple(m):c for m,c in expansion['terms']}
f=json.loads((ROOT/'full/evidence/residual_factorization.json').read_text())
assert f['rank']==92
factored={}
for j in range(f['rank']):
 qpoly={tuple(f['Q_monomials'][i])+zero[:14]:c for i,c in f['Q_features'][j]}
 hpoly={zero[:14]+tuple(f['H_monomials'][i]):c for i,c in f['H_features'][j]}
 factored=add(factored,mul(qpoly,hpoly))
 weights=set()
 for i,c in f['H_features'][j]:
  m=f['H_monomials'][i]
  weights.add((sum(x*y for x,y in zip(m,[5]*4+[8]*3+[-5]*4+[-8]*3))%29,sum(x*y for x,y in zip(m,[0,1,2,3,0,1,2]*2))%4))
 assert weights=={tuple(f['H_weights'][j])}
assert factored==Z
# Verify the generated header carries exactly these same sparse factors.
# factor_residual.py independently rebuilds it by exact Gaussian elimination.
import re
text=(ROOT/'full/src/factor_data.hpp').read_text()
def header_matrix(name):
 match=re.search(r'constexpr unsigned char '+name+r'\[[0-9]+\]\[[0-9]+\]=(\{.*?\});',text)
 assert match,name
 return json.loads(match.group(1).replace('{','[').replace('}',']'))
assert header_matrix('QM')==f['Q_monomials'];assert header_matrix('HM')==f['H_monomials'];assert header_matrix('HW')==f['H_weights']
for name,key in [('QC','Q_features'),('HC','H_features')]:
 dense=header_matrix(name)
 assert [[(j,c)for j,c in enumerate(row)if c]for row in dense]==[[tuple(x)for x in row]for row in f[key]]
print(json.dumps({'status':'PASS','universal_identity_verified_coefficientwise':True,'independent_variables':28,'field':'F25, beta^2=beta+3','expanded_nonzero_terms':len(Z),'bilinear_terms':f['rank'],'orbit_weight_identities':f['rank'],'generated_header_verified':True},sort_keys=True))
