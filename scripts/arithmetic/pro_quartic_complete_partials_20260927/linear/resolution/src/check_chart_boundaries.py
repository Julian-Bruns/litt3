"""Exact boundary-control examples for the new cubic cover.

These are allowed SOURCE RATIO algebras, not square witnesses or exclusions.
Includes one dual-number degree-drop factorization.
"""
from __future__ import annotations
import json,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path[:0]=[str(ROOT/'src'),str(ROOT/'intersection/src')]
import field as F,poly as U
from critical_cover import xgcd
F.init()

def coprime_witness(p,q):
 g,s,t=xgcd(p,q);assert g==[1]
 return {'s':s,'t':t,'identity':'s*p+t*q=1'}

def main():
 if sys.flags.optimize:raise RuntimeError('Assertions must be enabled')
 D=json.loads((ROOT/'resolution/data/critical_coordinates.json').read_text())
 cf=D['cubic_f'];a0,d,b,c,e=[cf[k] for k in ['a0','d','b','c','e']]
 # The leading-u coefficient vanishes at q=1, s=a0(1)/d(1).
 q=1;s=F.div(U.evalp(a0,q),U.evalp(d,q)); assert s
 bv,cv,ev=[U.evalp(p,q) for p in [b,c,e]]
 assert bv and cv and ev
 disc=F.sub(F.powk(cv,2),F.scale(F.mul(bv,ev),4));assert disc
 finite_u=[ev,cv,bv]
 assert U.gcd(finite_u,U.deriv(finite_u))==[1]
 # The reciprocal chart has g=eta+b*z+c*z^2+e*z^3 over eta^2=0.
 def add(v,w):return [F.add(v[i],w[i]) for i in range(2)]
 def mul(v,w):return [F.mul(v[0],w[0]),F.add(F.mul(v[0],w[1]),F.mul(v[1],w[0]))]
 def pmul(f,g):
  out=[[0,0] for _ in range(len(f)+len(g)-1)]
  for i,x in enumerate(f):
   for j,y in enumerate(g):out[i+j]=add(out[i+j],mul(x,y))
  return out
 first=[[0,F.inv(bv)],[1,0]]
 second=[[bv,F.neg(F.div(cv,bv))],[cv,F.neg(F.div(ev,bv))],[ev,0]]
 actual=pmul(first,second)
 assert actual==[[0,1],[bv,0],[cv,0],[ev,0]]
 # Constant-u coefficient e(q)=0: eight allowed q values, and two finite
 # nonzero u values at s=1 for each. This is NOT a square-locus test.
 p=U.scale(U.exactdiv(e,[0,1]),F.inv(e[-1]));assert len(p)==9
 a=U.sub(a0,d)
 quad_disc=U.sub(U.powp(b,2),U.scale(U.mul(a,c),4))
 forbidden=[0,1]
 for r in [10149,118020,64426]:forbidden=U.mul(forbidden,[F.neg(r),1])
 certificates={
   'p_squarefree':coprime_witness(p,U.deriv(p)),
   'old_q_open':coprime_witness(p,forbidden),
   'a_unit':coprime_witness(p,a),
   'c_unit':coprime_witness(p,c),
   'quadratic_discriminant_unit':coprime_witness(p,quad_disc)}
 # Rational-point diagnostics of the coordinate inverse, including all four
 # charts that are present at each sample. Not a geometric square search.
 sys.path.insert(0,str(ROOT/'src'))
 import evaluate as E
 diagnostic=[]
 for h,w,mu in [(1,1,1),(2,3,4),(101,102,103),(251,12345,625)]:
  _,_,fs,_=E.cramer(h,w);qv=F.powk(w,3);H=F.div(h,w);u=F.mul(qv,H);sv=F.div(fs[6],F.powk(h,3))
  vals=[U.evalp(p,qv) for p in [e,c,b,U.sub(a0,U.scale(d,sv))]]
  assert U.evalp(vals,u)==0
  charts=[]
  for tau in [0,1,2,3]:
   ft=U.evalp(vals,tau)
   if not ft:continue
   z=F.inv(F.sub(u,tau));assert z and F.add(1,F.mul(tau,z))
   assert F.div(F.add(1,F.mul(tau,z)),F.mul(qv,z))==H
   # g_tau(z)=z^3*f(tau+1/z)=0.
   aa,bb,cc,ee=vals[3],vals[2],vals[1],vals[0]
   zz=[aa,F.add(F.scale(F.mul(aa,tau),3),bb),F.add(F.add(F.scale(F.mul(aa,F.powk(tau,2)),3),F.scale(F.mul(bb,tau),2)),cc),ft]
   assert U.evalp(zz,z)==0
   charts.append(tau)
  assert charts
  diagnostic.append({'h':h,'w':w,'mu':mu,'q':qv,'u':u,'s':sv,'valid_tau_charts':charts})
 # The residual is not an identical polynomial on the three sheets of the
 # new ratio map, even with the natural critical-value scale adjustment.
 import polynomial_model as PM
 sheets=[1,163151,211668];sheet_s=250993;sheet_records=[]
 for mode in ['mu=1','mu=H^3']:
  constants=[]
  for hv in sheets:
   assert U.evalp([U.evalp(p,1) for p in [e,c,b,U.sub(a0,U.scale(d,sheet_s))]],hv)==0
   mu=1 if mode=='mu=1' else F.powk(hv,3)
   rr=PM.evaluate_polynomial(hv,1,mu);assert len(rr)==141 and rr[-1]
   constants.append(F.div(rr[0],rr[-1]))
  assert len(set(constants))==3
  sheet_records.append({'scale_convention':mode,'normalized_constant_coefficients':constants})
 out={'scope':'Boundary control of ratio coordinates only. NOT square residual points or exclusions.',
   'leading_coefficient_boundary':{'q_K_code':1,'s_K_code':s,'finite_u_polynomial_ascending':finite_u,'two_distinct_nonzero_geometric_ratios':True,'old_open_satisfied':True},
   'dual_number_boundary':{'base':'K[eta]/eta^2','q_K_code':1,'s':'s_boundary-eta/d(1)','g_z_coefficients_ascending_dual_pairs':actual,'first_factor':first,'second_factor':second,'identity_checked':True,'interpretation':'Localizing z kills the infinitesimal infinity branch and retains the full rank-two finite-root algebra. No a-coefficient inversion is used.'},
   'constant_coefficient_boundary':{'s_K_code':1,'p_q_monic':p,'quadratic_u_coefficients_ascending_q':[c,b,a],
     'certificates':certificates,'geometric_ratio_count':16,'finite_etale_ratio_algebra_dimension':16,'main_square_test_performed':False},
   'coordinate_diagnostics':diagnostic,
   'three_sheet_nonidentity':{'q':1,'s':sheet_s,'H_values':sheets,'checks':sheet_records,
      'scope':'Exact counterexample to identical normalized residual descent in either displayed scale convention, NOT to descent of the square zero set and NOT a source witness.'},
   'square_locus_decision':'UNRESOLVED'}
 (ROOT/'resolution/data/chart_boundaries.json').write_text(json.dumps(out,indent=2)+'\n')
 print(json.dumps({'status':'PASS','leading_coefficient_drop_retains_two_ratios':True,'dual_number_identity':True,
  'constant_coefficient_drop_retains_16_ratios':True,'source_ratio_diagnostics':len(diagnostic),
  'no_square_test_or_new_fibre_exclusion':True},indent=2))
if __name__=='__main__':main()
