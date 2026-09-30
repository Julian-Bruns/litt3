"""Executed consistency checks of the fraction-free global source and all 70 tails.
The general identity is proved in REPORT.md; these are independent construction tests.
"""
from exact import ROOT,DATA,t as t_codes
from extension import E,Poly,init
from residual import Curve,resultant_coefficients,bp_add,bp_mul,bp_pow,bp_scale,make_residual,square_equations
import json

def check(name):
 C=json.loads((ROOT/'evidence'/('boundary_'+name+'.json')).read_text());init(C['modulus'])
 assert len(C['modulus'])==2
 q=E(C['q_image']);u=E(C['u_image']);d=Poly(DATA['d']).eval(q)
 old=make_residual(q,u)
 src=json.loads((ROOT/'evidence/global_source.json').read_text())
 P=Poly(DATA['P']);Q=Poly(DATA['Q']);t=Poly(t_codes);v=Poly([-E(DATA['r']),1]);Curve.Pbar=P*q*q
 G={}
 for n,terms in src['G_tilde'].items():
  dct=[{} for _ in range(3)]
  for iq,iu,ix,j,a in terms:
   c=E(a)*(q**iq)*(u**iu)
   dct[j][ix]=dct[j].get(ix,E(0))+c
  G[int(n)]=Curve([Poly([part.get(i,E(0)) for i in range(max(part,default=-1)+1)]) for part in dct])
 T=Curve([Poly(),(t**3)*(P**3)*(q*q*d),Poly()])
 rc=resultant_coefficients(3*G[2],2*G[3],G[4],G[5],Curve(Q),T,v)
 a,b,c=[[v.c[j] for v in rc] for j in range(3)]
 nn=bp_add(bp_add(bp_pow(a,3),bp_scale(bp_pow(b,3),Curve.Pbar)),bp_scale(bp_pow(c,3),Curve.Pbar**2))
 nn=bp_add(nn,bp_scale(bp_mul(bp_mul(a,b),c),2*Curve.Pbar))
 den=(P**40)*(t**15)*(v**3);new=[p/den for p in nn]
 scalar=(q**83)*(d**36);scale_unit=(q**3)*d
 assert new==[p*(scalar/(scale_unit**i)) for i,p in enumerate(old)]
 oldeq=square_equations(old,True);neweq=square_equations(new,True)
 for i,(a,b) in enumerate(zip(oldeq,neweq)):
  expected=Poly([c*(scalar**(63 if i<54 else 126))/(scale_unit**j) for j,c in enumerate(a.coeffs())])
  assert expected==b,(i,name)
 print(name,': fraction-free residual and all 70 transformed equations agree exactly.',flush=True)

if __name__=='__main__':
 for name in ['b_0','e_1','leading_boundary_0','leading_companion_0']:check(name)
