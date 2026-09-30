"""A verified NON-WITNESS illustrating why structural norm data do not decide
this problem. This quadratic is not asserted to arise from the actual source.
It even has the same pole bounds, residual degree140, root degree70 and
nonsquare top-scale class t*v. No original parameter point is supplied.
"""
from exact import ROOT,DATA,P as pcodes,t as tc,v as vc,power,pgcd,pder,ps
from extension import E,Poly,init
from residual import Curve,bp_add,bp_mul,bp_pow,bp_scale
import json

def run():
 init([0,1]);P=Poly(pcodes);Curve.Pbar=P
 zcode=power(25,390624//3);z=E(zcode)
 assert z**3==E(1) and z!=E(1) and E(1)+z+z*z==E(0)
 assert pgcd(pcodes,pder(pcodes))==[1]
 assert pgcd(ps(pcodes,[1]),pder(pcodes))==[1]
 ds=Curve([Poly(1),Poly(z*z),Poly(z)])
 aa=Poly(tc)*Poly(vc);xx=Poly([0]*40+[1])
 theta=[(ds+Curve(aa))*xx,Curve(3*aa*xx),Curve(aa*xx)]
 delta=ds*aa;hh=Curve(xx)
 assert theta[1]*theta[1]-4*theta[0]*theta[2]==delta*hh*hh
 a,b,c=[[p.c[j] for p in theta] for j in range(3)]
 rr=bp_add(bp_add(bp_pow(a,3),bp_scale(bp_pow(b,3),P)),bp_scale(bp_pow(c,3),P**2))
 rr=bp_add(rr,bp_scale(bp_mul(bp_mul(a,b),c),2*P))
 assert len(rr)==7 and rr[0].degree()==140 and all(r.degree()<140 for r in rr[1:])
 assert rr[6]==aa**3*Poly([0]*120+[1]) and rr[6].degree()==132
 jj=Poly([0]*60+[1])*(P-1)
 assert sum(rr,Poly())==jj*jj and jj.degree()==70
 out={'status':'verified_illustrative_non_witness','not_actual_family_witness':True,
  'zeta_K_code':zcode,'Theta_star':'x^40*(t*v*(tau-1)^2+(y-1)*(zeta*y-1))',
  'delta_star':'t*v*(y-1)*(zeta*y-1)','H_star':'x^40',
  'tau_value':1,'norm_square_root':'x^60*(P-1)',
  'root_coefficients':jj.records(),'residual_x_degrees_by_tau':[p.degree() for p in rr],
  'leading_tau_coefficient':'(t*v)^3*x^120 = t*v*(t*v*x^60)^2',
  'proved_scope':'Nonsplitting, pole bounds and the leading-scale square class do not alone imply norm nonsquareness; no original source equations are claimed.'}
 (ROOT/'evidence/norm_warning.json').write_text(json.dumps(out,indent=2)+'\n')
 print('NON-WITNESS VERIFIED: square norm at tau1 despite nonsquare discriminant, matching pole and degree bounds',flush=True)
 return out
if __name__=='__main__':run()
