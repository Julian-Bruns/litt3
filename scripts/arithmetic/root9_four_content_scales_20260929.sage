#!/usr/bin/env sage
"""Complete rational-scale factorization on each root-nine content curve.

The identities are checked in the entire function field / polynomial
ring, not at finite samples. A zero other-sheet denominator forces a
second content sheet if that sheet's value vanishes; that incidence
was excluded independently.
"""
import json,sys
from pathlib import Path
base=Path(sys.argv[1]);receipts=[]
for i in range(3):
 d=base/str(i);co=load(str(d/'coordinates.sobj'));J=load(str(d/'content_gcd.sobj'))
 R=J.parent();H,Z=R.gens();K=R.base_ring();a=K.gen();beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
 def dec(c):return sum((c//25**j%5+(c//25**j//5%5)*beta)*a**j for j in range(4))
 Q=PolynomialRing(K,'z');z=Q.gen();U=PolynomialRing(Q.fraction_field(),'h');h=U.gen();hom=R.hom([h,U(z)],U);j=hom(J).monic()
 m0=load(str(d/'homogeneous_0_compact/model.sobj'))
 A=3*load(str(d/'translated_0_T0.sobj'));B=2*load(str(d/'translated_1_T0.sobj'));D=load(str(d/'translated_3_T0.sobj'));V=(co['root']-dec(9))*co['source_denominator']
 n1=A**3*B**3+A**5*D;d1=V*B**5;n0=m0['original_num'];d0=m0['original_den']
 rows=[load(str(d/('row_%d_T6.sobj'%k))) for k in range(3)]
 assert hom(rows[1]*d0*d1+rows[2]*(n0*d1+n1*d0))%j==0
 assert hom(rows[0]*d0*d1-rows[2]*n0*n1)%j==0
 assert hom(rows[2])%j!=0 and hom(n0*d1-n1*d0)%j!=0
 rr=[load(str(d/('row_%d_T5.sobj'%k))) for k in range(3)];assert rr[2]==0
 factor,rem=rr[1].quo_rem(d1);assert not rem and factor
 assert rr[0]+factor*n1==0
 for phase in [1,2]:
  rot=R.hom([H,dec(11)**phase*Z],R)
  assert rot(rr[0])+rot(factor)*rot(n1)==0 and rot(rr[1])==rot(factor)*rot(d1)
 receipts.append({'endpoint':int(i),'selected_quadratic_two_factors':True,'two_other_sheets_affine_factors':True,'denominator_zero_covered_by_two_sheet_content':True})
 print('FOUR_RATIONAL_CONTENT_SCALES_PASS',i,flush=True)
(base/'four_scale_factorization.json').write_text(json.dumps({'status':'PASS','scope':'Whole content curves and exact other-sheet polynomial identities','checks':receipts},indent=2)+'\n')
