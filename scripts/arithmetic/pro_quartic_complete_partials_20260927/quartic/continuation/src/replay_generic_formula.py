#!/usr/bin/env python3
"""Independent polynomial arithmetic for sampled closed-form identities.
Synthetic positive tests exercise formulas only; H is NOT an endpoint multiset.
"""
from pathlib import Path
import sys,runpy,json
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'src'))
g=runpy.run_path(str(ROOT/'src/replay_candidates.py'))
FR,KR,S,embed,scalar,endpoint,coords,pack=[g[x] for x in ['FR','KR','S','embed','scalar','endpoint','coords','pack']]
def bar(z):
 a,b=z.c;return KR.row([a+b,-b])
def norm(z):
 a,b=z.c;return a*a+a*b+2*b*b
def unpackK(p):return KR.row(list(map(scalar,p)))
def encodeK(z):return [pack(a) for a in z.c]
def formula(A,B,C,D):
 W=A*D-B*C;dy=norm(C.c[3])-norm(B.c[3]);dx=norm(A.c[1])-norm(D.c[1]);assert dx and dy
 dyK=KR.from_base(dy);dxK=KR.from_base(dx);den=dx*dy;denK=KR.from_base(den)
 Y=B.c[3]*bar(W.c[3])-bar(C.c[3])*W.c[3]
 R=dyK*W.c[1]+B.c[1]*bar(Y)+C.c[1]*Y
 X=bar(A.c[1])*R-D.c[1]*bar(R)
 Z=denK*W.c[2]-A.c[2]*X-D.c[2]*bar(X)+dxK*(B.c[2]*bar(Y)+C.c[2]*Y)
 SS=denK*W.c[0]-A.c[0]*X-D.c[0]*bar(X)+dxK*(B.c[0]*bar(Y)+C.c[0]*Y)
 T=denK*SS+KR.from_base(norm(X)-dx*dx*norm(Y))
 x=X/denK;y=Y/dyK
 v=W-A*embed(x,FR)-D*embed(bar(x),FR)+B*embed(bar(y),FR)+C*embed(y,FR)+embed(KR.from_base(norm(x)-norm(y)),FR)
 assert not v.c[1] and not v.c[3] and v.c[2]*denK==Z and v.c[0]*denK**2==T
 return dx,dy,x,y,Z,T
c={'generic_formula_sample':0,'synthetic_formula_sample_not_endpoint_witness':0}
for r in map(json.loads,(ROOT/'continuation/evidence/generic_formula_samples.jsonl').read_text().splitlines()):
 A=endpoint(r['Q'],'e');B=endpoint(r['Q'],'c')
 if r['kind']=='generic_formula_sample':C=endpoint(r['H'],'c');D=endpoint(r['H'],'e')
 else:
  eps=FR.row(list(map(unpackK,r['epsilon'])));x=unpackK(r['x']);y=unpackK(r['y']);assert y==(eps*B).c[3]/eps.c[3]
  D=eps*(B-embed(y,FR))+embed(x,FR);C=eps*(A-embed(bar(x),FR))+embed(bar(y),FR);assert not D.c[3]
 dx,dy,x,y,Z,T=formula(A,B,C,D)
 assert pack(dx)==r['delta_x'] and pack(dy)==r['delta_y'] and encodeK(x)==r['x'] and encodeK(y)==r['y']
 if r['kind']=='generic_formula_sample':assert encodeK(Z)==r['Z'] and encodeK(T)==r['T']
 else:assert not Z and not T
 c[r['kind']]+=1
assert c=={'generic_formula_sample':16,'synthetic_formula_sample_not_endpoint_witness':8}
print(json.dumps({'status':'PASS','independent_polynomial_arithmetic':True,'counts':c},indent=2))
