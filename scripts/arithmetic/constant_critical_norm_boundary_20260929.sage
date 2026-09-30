#!/usr/bin/env sage
"""Exact boundary identity finishing the constant critical-norm projection."""
import json,sys,time
from pathlib import Path
d=Path(sys.argv[1]);st=time.time();s=load(str(d/'tails.sobj'));rec=load(str(d/'resultant_projection.sobj'))
p1,p2=rec['polys'];g,u,v=p1.xgcd(p2);assert u*p1+v*p2==g
R=s['tails'][0].parent();H,q=R.gens();K=R.base_ring();U=PolynomialRing(K,'h');h=U.gen();receipts=[]
for idx,(f,m) in enumerate(g.factor()):
 assert f.degree()==1;qq=-f[0]/f[1]
 if not qq:continue
 vals=[]
 for t in s['tails']:vals.append(U([sum(c*qq**j for (ii,j),c in t.dict().items() if ii==i) for i in range(t.degree(H)+1)]))
 gg=U(0);coeff=[]
 for p in vals:
  new,a,b=gg.xgcd(p);coeff=[a*c for c in coeff]+[b];gg=new
 assert sum(c*p for c,p in zip(coeff,vals))==gg
 # H is an original unit. This permits, but does not assume, a pure
 # H-power gcd on the exceptional q-fibre.
 e=gg.valuation();assert gg==h**e
 save({'factor':f,'q':qq,'tail_values':vals,'multipliers':coeff,'gcd':gg},str(d/('boundary_identity_%02d.sobj'%idx)))
 receipts.append({'q':str(qq),'projection_multiplicity':int(m),'boundary_H_power':int(e),'literal_identity':True})
save({'resultants':[p1,p2],'multipliers':[u,v],'gcd':g},str(d/'projection_bezout.sobj'))
(d/'boundary_verified.json').write_text(json.dumps({'status':'PASS','projection_degrees':[int(p1.degree()),int(p2.degree())],'literal_projection_identity':True,'boundary':receipts,'seconds':time.time()-st},indent=2)+'\n');print(receipts,flush=True)
