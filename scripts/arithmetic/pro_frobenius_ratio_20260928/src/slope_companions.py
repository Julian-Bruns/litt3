#!/usr/bin/env python3
"""Close the *entire q-projection* of the two retained slope divisors.

The old certificates excluded one ratio branch. The new certificates
exclude its conjugate as well, making each degree-72 norm a genuine
q-unit in the full square algebra. No companion branch is silently lost.
"""
from pathlib import Path
import argparse,json,time
import ext
from ext import Element as E,EP
from ff import Poly
from residual import peval,RATIO,check_open,Tails
from residual_jet import residual_jet
ROOT=Path(__file__).resolve().parents[1]

def run(verify=False):
 start=time.time();dest=ROOT/'data/slope_companion_certificates';dest.mkdir(exist_ok=True);blocks=[];norms=[]
 for name in ['plus','minus']:
  model=json.loads((ROOT/f'data/slope_{name}_model.json').read_text());norms.append(Poly(model['norm_squarefree']))
  for i,fc in enumerate(model['factors']):
   t=time.time();f=Poly(fc);q=ext.context(f);b,c,e=[peval(RATIO[k],q)for k in ['b','c','e']];z=-peval(model['r0'],q)/peval(model['r1'],q);zc=3*c-z;u=zc/b
   assert z*z+2*c*z+3*b*e==0 and zc*zc+2*c*zc+3*b*e==0 and zc!=z
   check_open(q,u);_,A=residual_jet(q,u,72);ts=Tails(A,max_n=72);C71,C72=ts.tail(71),ts.tail(72);path=dest/f'{name}_{i}.json'
   if verify:
    cert=json.loads(path.read_text());assert cert['modulus']==fc and cert['case']==name and cert['factor_index']==i;assert cert['tail_indices']==[71,72];assert cert['tail_degrees']==[C71.degree(),C72.degree()]
    U,V=[EP([E(row)for row in a])for a in cert['bezout_coefficients']]
   else:
    g,U,V=C71.xgcd(C72);assert g==1,('extra tails needed',name,i,g.serialize())
    cert={'case':name,'factor_index':i,'modulus':fc,'u_formula':'(3*c+r0/r1)/b','tail_indices':[71,72],'tail_degrees':[C71.degree(),C72.degree()],'identity':'U*C71+V*C72=1','bezout_coefficients':[U.serialize(),V.serialize()]}
    path.write_text(json.dumps(cert,separators=(',',':'))+'\n')
   assert U*C71+V*C72==1
   block={'case':name,'factor_index':i,'degree':f.degree(),'tail_degrees':cert['tail_degrees'],'certificate':str(path.relative_to(ROOT)),'seconds':round(time.time()-t,3)};blocks.append(block);print('WHOLE_Q_SLOPE_COMPANION_VERIFIED',block,flush=True)
 assert len(blocks)==26 and sum(b['degree']for b in blocks)==144 and norms[0].gcd(norms[1])==1
 result={'status':'both entire degree-72 slope q-norm divisors excluded, using old and companion certificates','new_companion_certificate_blocks':26,'new_companion_geometric_ratios':144,'entire_geometric_q_fibres':144,'all_scales':True,'old_certificates_required':'data/slope_certificates, replayed by src/verify_slopes.py','blocks':blocks,'verification_mode':'certificate replay'if verify else'certificate generation and immediate product check','seconds':round(time.time()-start,3)}
 (ROOT/('checks/slope_companion_verification.json'if verify else'checks/slope_companion_generation.json')).write_text(json.dumps(result,indent=2)+'\n');print('WHOLE_Q_SLOPE_DIVISORS_CLOSED',json.dumps(result),flush=True)
 return result
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--verify',action='store_true');a=p.parse_args();run(a.verify)
