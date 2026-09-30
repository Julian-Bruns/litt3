#!/usr/bin/env sage
"""New constant-family application of the pole-order quartic-twist lemma."""
import itertools,json,sys,time
from pathlib import Path
d=Path(sys.argv[1]);out=d/'nondescent';out.mkdir(exist_ok=True)
s=load(str(d/'descent'/'normalized.sobj'));ds=s['delta_normalized'];P=s['P'];X=P.parent();F=X.base_ring();R=F.ring();H,q=R.gens();K=R.base_ring();x=X.gen();B=s['B'];M=ds[1][7]
def con(c):
 c=F(c);assert c.numerator().is_constant() and c.denominator().is_constant();return K(c.numerator().constant_coefficient()/c.denominator().constant_coefficient())
assert M and M.numerator().is_constant() and M.denominator().is_constant()
PX=PolynomialRing(K,'x');roots=PX([con(c) for c in P]).roots(multiplicities=False);assert len(roots)==10
S=PolynomialRing(K,('inv','H','q'),order='degrevlex');iv,hh,qq=S.gens();phi=R.hom([hh,qq],S);summ=[];start=time.time()
for i,rr in enumerate(itertools.combinations(roots,4)):
 ff=prod((x-r for r in rr),X.one());pf=P//ff;assert ff*pf==P
 rem=ds[2]-B*ff;N=rem[3];k=N/M
 e1=q*k*ds[1]-q*ff*rem-B*pf*k**3
 e2=4*B*q*k**2*ds[0]-q*ff*rem**2-3*B**2*P*k**3
 rows=[c.numerator() for p in [e1,e2] for c in p if c]
 pol=[phi(p) for p in rows]+[iv*phi(q*H*N.numerator())-1]
 I=S.ideal(pol);st=time.time();gb=I.groebner_basis();assert I.dimension()<0,(i,gb)
 mult=list(S.one().lift(I));assert sum(c*p for c,p in zip(mult,pol))==1
 record={'index':i,'seconds':time.time()-st,'literal_unit':True,'terms':sum(len(c.dict()) for c in mult)}
 save({'quartic':ff,'equations':pol,'multipliers':mult,'record':record},str(out/('twist_%03d.sobj'%i)))
 summ.append(record);print('TWIST',record,flush=True)
 (out/'receipts.json').write_text(json.dumps(summ,indent=2)+'\n')
print('COMPLETE',len(summ),time.time()-start,flush=True)
