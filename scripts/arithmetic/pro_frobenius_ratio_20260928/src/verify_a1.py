"""Read-only replay of the complete a_1=0 boundary exclusion.
Runs in a separate process from endpoint_model (which uses Sparse.N=2).
"""
import json,time,argparse
from pathlib import Path
from ff import Poly,X,power,mul
import ext
from ext import Element as E,EP
from residual import RATIO,peval,check_open,Tails,residual
from residual_jet import residual_jet
from factor import irreducible
import a1_boundary,reduce_a1
ROOT=Path(__file__).resolve().parents[1]

def run_checks():
 start=time.time()
 raw=json.loads((ROOT/'data/a1_model.json').read_text())
 _,common,recomputed=a1_boundary.compute(save=False)
 for key,val in recomputed.items():
  if key not in ('elapsed_seconds','status'):assert raw[key]==val,('a1_model',key)
 d=Poly(RATIO['d']);assert common==d.monic()**3
 assert raw['cleared_Cramer_d_power']==9 and raw['removed_monomial_exponents_u_q']==[6,-14]
 model=json.loads((ROOT/'data/a1_reduced.json').read_text())
 rec=reduce_a1.main(save=False)
 for key,val in rec.items():assert model[key]==val,('reduced',key)
 N=Poly(model['norm_after_old_units']);assert N==Poly(model['norm_squarefree']) and N.degree()==153
 assert N.gcd(N.derivative())==1 and N.gcd(Poly(model['A1']))==1
 assert model['common_q_factor']==[1] and model['new_common_factor']==[1]
 assert Poly(model['norm_numerator'])==N*Poly(model['norm_removed_old_factors'])
 assert N.gcd(Poly(model['old_unit_product']))==1
 # The raw norm's remaining support is therefore exactly the finite algebra N.
 factors=[Poly(f) for f in model['factorization']];prod=Poly(1)
 for f in factors:
  assert irreducible(f);prod=prod*f
 assert prod==N
 assert [f.degree() for f in factors]==[2,2,2,4,8,8,127]
 print('a1 model and complete divisor coverage verified',flush=True)
 rows=[Poly(p) for p in raw['a1_numerator_q_rows_ascending_u']]
 # Independent coefficient checks use the full norm/resultant computation.
 coeff_checks=[]
 for qv in [1,2,3,17,29]:
  bv,cv,ev=[Poly(RATIO[n]).eval(qv) for n in ['b','c','e']]
  u=ext.context([mul(3,ev),mul(2,cv),bv]);q=E(qv);check_open(q,u)
  _,A=residual(q,u)
  aa,b,c,e,dd=[peval(RATIO[n],q) for n in ['a0','b','c','e','d']]
  V=aa*u**3+b*u*u+c*u+e
  from reconstruct import epsilon
  M0=mul(3,power(epsilon,8))*u**3*V/(q**4*dd)
  theta=E()
  for row in rows[::-1]:theta=theta*u+peval(row.tolist(),q)
  predicted=u**6*q**-14*peval(common.tolist(),q)*theta/(dd**9*M0**3)
  assert A[1]==EP(predicted)
  assert predicted==215811*theta/(q**2*u**3*dd**3*V**3)
  coeff_checks.append(qv)
 blocks=[]
 for i,f in enumerate(factors):
  t=time.time();print('replay a1_zero',i,'degree',f.degree(),flush=True)
  cert=json.loads((ROOT/f'data/a1_certificates/a1_zero_{i}.json').read_text())
  assert cert['modulus']==f.tolist() and cert['factor_index']==i and cert['tail_indices']==[71,72]
  assert cert['mu_power']==0 and cert['a1_identically_zero']
  q=ext.context(f);u=-peval(model['A0'],q)/peval(model['A1'],q);check_open(q,u)
  assert peval(model['old_unit_product'],q).inverse()*peval(model['old_unit_product'],q)==1
  theta=E()
  for row in rows[::-1]:theta=theta*u+peval(row.tolist(),q)
  assert not theta
  _,A=residual_jet(q,u,72,verbose=(f.degree()>100));assert not A[1]
  ts=Tails(A,max_n=72);lhs=EP()
  for n,cs,degree in zip(cert['tail_indices'],cert['bezout_coefficients'],cert['tail_degrees']):
   tail=ts.tail(n);assert tail.degree()==degree
   lhs=lhs+EP([E(row) for row in cs])*tail
  assert lhs==1
  blocks.append({'factor':i,'degree':f.degree(),'identity':'U*C71+V*C72=1','elapsed_seconds':round(time.time()-t,3)})
  print('identity verified',blocks[-1],flush=True)
 out={'status':'verified complete a1=0 exclusion after already certified boundaries','factor_degrees':[f.degree() for f in factors],
 'geometric_ratios_excluded':153,'distinct_geometric_q_values':153,'certificate_blocks':7,
 'all_scales':'arbitrary geometric scales; polynomial identity 1',
 'full_residual_a1_regressions':coeff_checks,'blocks':blocks,'elapsed_seconds':round(time.time()-start,3)}
 print('A1_VERIFICATION_SUMMARY_JSON='+json.dumps(out,sort_keys=True),flush=True)
 return out
if __name__=='__main__':
 ap=argparse.ArgumentParser();ap.add_argument('--save-summary',action='store_true');args=ap.parse_args()
 out=run_checks()
 if args.save_summary:(ROOT/'checks/a1_verification.json').write_text(json.dumps(out,indent=2)+'\n')
