"""Regression validation of the universal local endpoint formula against
independently recomputed residuals. These finite tests are not the universal proof.
"""
import json,time
import ext
from ext import Element as E,EP
from ff import Poly,mul,power
from residual import RATIO,residual,check_open
from endpoint_model import endpoint_data,eval_sp
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]

def run_checks(save=True):
 start=time.time();data=endpoint_data();summ=[]
 for qv in [1,2,3,4,5,17,29,101]:
  bv,cv,ev=[Poly(RATIO[k]).eval(qv) for k in ['b','c','e']]
  u=ext.context([mul(3,ev),mul(2,cv),bv]);q=E(qv);check_open(q,u)
  rr,A=residual(q,u)
  vv={n:eval_sp(s,u,q) for n,s in data.items()}
  ell=EP([vv['ell0_numerator']/vv['D0'],vv['ell1_numerator']/vv['D0']])
  at=EP([r.eval(9) for r in rr]);assert at==ell**3
  summ.append({'q':qv,'coefficient_algebra_degree':ext.D,'endpoint_cube_identity':True,'scale_degree':ell.degree()})
  print('endpoint identity q=',qv,'passed',flush=True)
 # A nonreduced q-family: q=1+z, u the Hensel lift of a quadratic root,
 # implemented via a single algebra on u whose polynomial is the square of
 # the q=1 quadratic. Implicitly solve q as a function of u to first order.
 qv=1
 b,c,e=[Poly(RATIO[k]) for k in ['b','c','e']]
 mod=Poly([mul(3,e.eval(qv)),mul(2,c.eval(qv)),b.eval(qv)]).monic()
 u=ext.context(mod*mod)
 def ev(row,q):
  out=E()
  for a in row[::-1]:out=out*q+a
  return out
 q=E(1)
 g=ev(b.tolist(),q)*u*u+2*ev(c.tolist(),q)*u+3*ev(e.tolist(),q)
 gq=ev(b.derivative().tolist(),q)*u*u+2*ev(c.derivative().tolist(),q)*u+3*ev(e.derivative().tolist(),q)
 q=q-g/gq
 check_open(q,u)
 rr,A=residual(q,u)
 vv={n:eval_sp(s,u,q) for n,s in data.items()}
 ell=EP([vv['ell0_numerator']/vv['D0'],vv['ell1_numerator']/vv['D0']])
 assert EP([r.eval(9) for r in rr])==ell**3
 result={'status':'passed','finite_ratio_tests':summ,'nonreduced_test':{'algebra':'K[u]/g(u,1)^2; q lifted by one exact Newton correction','dimension':4,'identity':True},'elapsed_seconds':round(time.time()-start,3)}
 print(json.dumps(result,sort_keys=True),flush=True)
 if save:(ROOT/'checks/endpoint_model_check.json').write_text(json.dumps(result,indent=2)+'\n')
 return result
if __name__=='__main__':
 import argparse
 ap=argparse.ArgumentParser();ap.add_argument('--verify',action='store_true');args=ap.parse_args()
 from endpoint_model import serialize_model
 assert serialize_model()==json.loads((ROOT/'data/endpoint_model.json').read_text())
 run_checks(save=not args.verify)
