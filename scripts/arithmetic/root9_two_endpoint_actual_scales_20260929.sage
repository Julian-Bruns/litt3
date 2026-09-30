#!/usr/bin/env sage
"""Actual scale compatibility at two DIFFERENT content endpoints.

Uses the proved single-sheet/B-nonzero reduction and both rational
forced-scale formulas. This is a new two-endpoint test, not another
same-endpoint double-sheet scan.
"""
import argparse,json,time,itertools
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('base');p.add_argument('--case',type=int,default=0);p.add_argument('--literal-lifts',action='store_true');a=p.parse_args();base=Path(a.base);out=base/'two_endpoint_actual';out.mkdir(exist_ok=True)
co=[load(str(base/str(i)/'coordinates.sobj')) for i in range(3)];Js=[load(str(base/str(i)/'content_gcd.sobj')) for i in range(3)]
R=Js[0].parent();H,Z=R.gens();K=R.base_ring();zeta=K.multiplicative_generator()**((K.order()-1)//3)
def local(i):
 d=base/str(i)
 def row(i,j):return R(load(str(d/('translated_'+str(i)+'_T'+str(j)+'.sobj'))))
 A=3*row(0,0);B=2*row(1,0);D= row(3,0);C1=row(2,1);C2=row(2,2);B1=2*row(1,1);D1=row(3,1)
 phi=[R(x) for x in load(str(d/'phi_shift_coefficients.sobj'))];ev=[R(x) for x in load(str(d/'constant_term_coefficients.sobj'))];m,m1=phi[3:5]
 ell0=ev[5]+sum(phi[k]*row(3,5-k) for k in range(3,6));ell1=ev[6]+sum(phi[k]*row(3,6-k) for k in range(3,7))
 rat,rem=D1.quo_rem(D);assert not rem and rat.is_constant();kap=rat.constant_coefficient()
 # [9] in the fixed F25 convention is4+beta, not the integer9.
 aa=K.gen();beta=-(aa**4+2*aa**3+aa**2+2*aa)/(aa**3+aa**2+1);V=(co[i]['root']-(4+beta))*R(co[i]['source_denominator'])
 N=-((ell1-kap*ell0)*B**3-(m*C2+m1*C1)*C1*B**2+(3*m*B1+3*m1*B+3*kap*m*B)*C1**2*B-2*m*A*C1**3)
 D=V*m**2*B**3
 return R(Js[i]),N,D
models=[local(i) for i in range(3)];cases=[]
for i,j in itertools.combinations(range(3),2):
 ratio=co[j]['P_root']/co[i]['P_root'];c=ratio.nth_root(3);assert c**3==ratio
 for k in range(3):cases.append((i,j,c*zeta**k))
i,j,c=cases[a.case];rot=R.hom([H,c*Z],R);f,n,d=models[i];g,nn,dd=[rot(v) for v in models[j]];eq=n*dd-nn*d
# Strip only the already invertible H and Z powers. Keep every other
# polynomial boundary in the ideals and in the final unit certificate.
def strip(v):
 if not v:return v
 h=min(e[0] for e in v.dict());z=min(e[1] for e in v.dict());return v//(H**h*Z**z)
pol=[strip(v) for v in [f,g,eq]]
st=time.time();print('CASE',a.case,i,j,str(c),'DEGREES',[(v.degree(H),v.degree(Z),len(v.dict())) for v in pol],flush=True)
I=R.ideal(pol);checkpoint=out/('case_%d_unlocalized.sobj'%a.case)
if checkpoint.exists():
 previous=load(str(checkpoint));assert previous['equations']==pol;gb=previous['groebner']
else:gb=I.groebner_basis()
print('UNLOCALIZED',R.ideal(gb).dimension(),[(str(g.lm()),len(g.dict())) for g in gb],time.time()-st,flush=True)
save({'endpoints':[i,j],'relative_sheet':c,'equations':pol,'unit':H*Z*d*dd*n,'groebner':gb},str(out/('case_%d_unlocalized.sobj'%a.case)))
S=PolynomialRing(K,('inv','H','Z'),order='degrevlex');iv,hh,zz=S.gens();ph=R.hom([hh,zz],S);unit=strip(d*dd*n)
# Original H,Z and both finite nonzero forced-scale charts are necessary
# for an actual cover, by the separate B=0 and zero-scale exclusions.
pp=[ph(v) for v in gb]+[iv*hh*zz*ph(unit)-1];J=S.ideal(pp);b=J.groebner_basis();print('LOCALIZED',J.dimension(),[(str(v.lm()),len(v.dict())) for v in b],time.time()-st,flush=True)
save({'localized_equations':pp,'original':pol,'unit':unit,'case':a.case,'groebner':b,'status':'complete exact Groebner computation; transformation matrices not requested'},str(out/('case_%d_result.sobj'%a.case)))
if J.dimension()<0 and a.literal_lifts:
 mult=list(S.one().lift(J));assert sum(c*p for c,p in zip(mult,pp))==1
 # Also retain explicit expressions of the smaller generators in the
 # original three equations; no intermediate GB is an unverified input.
 gm=[list(v.lift(I)) for v in gb]
 assert all(sum(c*p for c,p in zip(row,pol))==v for row,v in zip(gm,gb))
 save({'localized_equations':pp,'multipliers':mult,'gb_multipliers':gm,'original':pol,'case':a.case},str(out/('case_%d_certificate.sobj'%a.case)))
 print('LITERAL_UNIT_PASS',a.case,flush=True)
