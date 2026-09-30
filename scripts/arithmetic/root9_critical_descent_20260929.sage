#!/usr/bin/env sage
"""Exact algebra for the 210 possible descended critical square classes.

The pole-order lemma is separate: any descended square class must be a
monic quartic divisor f of P.  This script retains arbitrary geometric
ratios and separates the vanishing leading comparison coefficient.
"""
import argparse, itertools, json, time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory');p.add_argument('--start',type=int,default=0);p.add_argument('--stop',type=int,default=210);p.add_argument('--inspect',action='store_true');p.add_argument('--boundary',action='store_true');p.add_argument('--certify',action='store_true');args=p.parse_args()
d=Path(args.directory);out=d/'descent';out.mkdir(exist_ok=True)
src=load(str(d/'actual_delta.sobj'));old=src['delta'];X=src['P'].parent();FF=X.base_ring();HW=FF.ring();h,w=HW.gens();K=HW.base_ring()
R=PolynomialRing(K,('H','q'),order='degrevlex');H,q=R.gens();F=R.fraction_field();RX=PolynomialRing(F,'x');x=RX.gen()
def graded(c,shift):
    c=FF(c)
    if not c:return F.zero()
    def part(v):
        rr={(i+j)%3 for (i,j),a in v.dict().items()};assert len(rr)==1
        r=rr.pop();return sum((a*H**i*q**((i+j-r)//3) for (i,j),a in v.dict().items()),R.zero()),r
    a,ar=part(c.numerator());b,br=part(c.denominator());ex=ar-br+shift;assert ex%3==0
    return F(a)/b*F(q)**(ex//3)
ds=[RX([graded(c,s) for c in row]) for row,s in zip(old,(-2,-1,0))]
PP=RX([graded(c,0) for c in src['P']]);B=ds[2][4];M=ds[1][7]
def constant(c):
    c=F(c);assert c.numerator().is_constant() and c.denominator().is_constant()
    return c.numerator().constant_coefficient()/c.denominator().constant_coefficient()
assert B.numerator().is_constant() and B.denominator().is_constant() and M.numerator().degree(H)==1 and M.numerator().degree(q)==0
PK=PolynomialRing(K,'x');P0=PK([constant(c) for c in PP]);roots=P0.roots(multiplicities=False);assert len(roots)==10
roots=sorted(roots,key=lambda c:tuple(c.polynomial().list()))
save({'delta_normalized':ds,'P':PP,'M':M,'B':B,'roots':roots},str(out/'normalized.sobj'))
print('NORMALIZED',[(i,j,c.numerator().degree(H),c.numerator().degree(q),str(c.denominator())) for i,row in enumerate(ds) for j,c in enumerate(row) if j>=row.degree()-1],flush=True)
print('M',M,'B',B,flush=True)
if args.inspect:raise SystemExit(0)
start=time.time();summ=[]
for no,rr in enumerate(itertools.combinations(roots,4)):
    if no<args.start or no>=args.stop:continue
    f=prod((x-r for r in rr),RX.one());pf,rem=PP.quo_rem(f);assert not rem
    R2=ds[2]-B*f;N=R2[3];assert R2.degree()<=3
    if not args.boundary:
        k=N/M
        e1=q*k*ds[1]-q*f*R2-B*pf*k**3
        e2=4*B*q*k**2*ds[0]-q*f*R2**2-3*B**2*PP*k**3
        rows=[c.numerator() for v in [e1,e2] for c in reversed(v.list()) if c]
        # Removing q factors is valid on the original chart q != 0.
        rows=[v//q**min(i[1] for i in v.dict()) for v in rows]
        # Invert only q, M and N: the latter records the forced k != 0.
        S=PolynomialRing(K,('inv','H','q'),order='degrevlex');iv,hh,qq=S.gens();phi=R.hom([hh,qq],S)
        unit=q*M.numerator()*N.numerator();polys=[phi(v) for v in rows]+[iv*phi(unit)-1]
    else:
        # M(H)=0 is a single exact K-value; retain all q,k solutions.
        hh0=-M.numerator()[0,0]/M.numerator()[1,0]
        S=PolynomialRing(K,('inv','k','q'),order='degrevlex');iv,kk,qq=S.gens();SF=S.fraction_field();SX=PolynomialRing(SF,'x');xx=SX.gen()
        def spec(c):return SF(c.numerator()(hh0,qq))/SF(c.denominator()(hh0,qq))
        z=[SX([spec(c) for c in v]) for v in ds];ff=SX([constant(c) for c in f]);pp=SX([constant(c) for c in PP]);pff=SX([constant(c) for c in pf]);rs=z[2]-constant(B)*ff
        e1=qq*kk*z[1]-qq*ff*rs-constant(B)*pff*kk**3
        e2=4*constant(B)*qq*kk**2*z[0]-qq*ff*rs**2-3*constant(B)**2*pp*kk**3
        rows=[c.numerator() for v in [e1,e2] for c in reversed(v.list()) if c]
        polys=rows+[iv*qq*kk-1]
    I=S.ideal(polys);st=time.time();gb=I.groebner_basis();dim=I.dimension();record={'index':no,'dimension':int(dim),'seconds':time.time()-st,'boundary':args.boundary,'equations':len(polys)}
    evidence={'quartic':f,'equations':polys,'groebner':gb,'record':record}
    if args.certify and dim<0:
        multipliers=list(S.one().lift(I));assert sum((c*v for c,v in zip(multipliers,polys)),S.zero())==1
        evidence['multipliers']=multipliers;record['identity_checked']=True;record['multiplier_terms']=sum(len(v.dict()) for v in multipliers)
    save(evidence,str(out/('%s_%03d.sobj'%('boundary' if args.boundary else 'generic',no))))
    summ.append(record);print('TWIST',no,'BOUNDARY',args.boundary,'DIM',dim,'TIME',record['seconds'],flush=True)
    if dim>=0:print('SURVIVING_SHAPE',[(str(g.lm()),len(g.dict())) for g in gb],flush=True)
    (out/('summary_%s_%d_%d.json'%('boundary' if args.boundary else 'generic',args.start,args.stop))).write_text(json.dumps(summ,indent=2)+'\n')
print('DONE',len(summ),'SECONDS',time.time()-start,flush=True)
