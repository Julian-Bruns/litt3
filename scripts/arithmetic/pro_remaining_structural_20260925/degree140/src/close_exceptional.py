"""Close finite nonzero F6 exceptions from an interpolated resultant certificate.
This script acts only when the gcd is (R^3+c)^5 and its three roots lie in K.
Other gcd shapes are explicitly rejected, not silently discarded.
"""
import json,subprocess,sys
from reconstruct import *
from square_slice import slice_certificate
from verify_original import verify_original,test_resultant

def main(index=3,sign=0):
 name=f'exceptional_param_{index}_{sign}'
 result=json.loads((ROOT/'certificates'/f'exceptional_branch_{index}_{sign}.json').read_text())
 g=result['cofactor_gcd'];assert len(g)==16 and g[-1]==1 and not any(g[1:15]) and g[0]
 c=powf(g[0],5**7);rad=[c,0,0,1];assert ppow(rad,5)==g
 q=neg(c);assert LOG[q]%3==0
 r0=EXP[LOG[q]//3];z=EXP[390624//3];roots=[mul(r0,powf(z,i)) for i in range(3)]
 assert ppow([1],0)==[1]
 prod=[1]
 for r in roots:prod=pmul(prod,[neg(r),1])
 assert prod==rad
 md=json.loads((ROOT/'data'/f'{name}_metadata.json').read_text());parR=json.loads((ROOT/'data'/f'{name}.json').read_text())['lambda_coefficients'];out=[]
 for j,r in enumerate(roots):
  vec=vadd(np.array(md['vector_constant'],np.int32),vmul(np.array(md['vector_R'],np.int32),r)).tolist()
  for kap in [1,2,5]:verify_original(vec,md['root'],kap)
  H,k=unpack(vec);assert k==1;v=[neg(md['root']),1]
  nm=f'exceptional_{index}_{sign}_finite_{j}'
  inp=ROOT/'data'/f'{nm}.txt';rp=ROOT/'data'/f'{nm}_residual.json';cp=ROOT/'certificates'/f'{nm}_bezout.json'
  rows=[P,Q,t,v]+[p for i in range(2,6) for p in H[i]]
  inp.write_text('\n'.join(' '.join(map(str,[len(p)]+p)) for p in rows)+'\n')
  run=subprocess.run([str(ROOT/'src/residual'),str(ROOT/'data'),str(inp),str(rp)],capture_output=True,text=True,check=True)
  (ROOT/'logs'/f'{nm}_resultant.log').write_text(run.stdout+run.stderr)
  R=json.loads(rp.read_text())
  for lam,p in enumerate(parR):
   qpoly=[0]*141
   for ix,cx in enumerate(p):
    if cx:
     power,x=divmod(ix,1024);qpoly[x]=add(qpoly[x],mul(cx,powf(r,power)))
   assert trim(qpoly)==R['lambda_coefficients'][lam]
  cert=slice_certificate(R['lambda_coefficients'],verbose=False);assert cert['excludes_all_nonzero_lambda']
  cp.write_text(json.dumps(cert,indent=2)+'\n');nsyl=test_resultant(H,v,R)
  out.append({'R_value':r,'normalized_vector':vec,'residual':str(rp.relative_to(ROOT)),'certificate':str(cp.relative_to(ROOT)),'tail_indices':[e['n'] for e in cert['tail_errors']],'tail_lambda_degrees':[len(e['polynomial'])-1 for e in cert['tail_errors']],'sylvester_checks':nsyl})
  print('finite R exception',r,'tail lambda degrees',out[-1]['tail_lambda_degrees'],'gcd',cert['gcd'],'original equations and Sylvester verified',flush=True)
 closure={'index':index,'sign':sign,'root':md['root'],'h':md['h'],'w':md['w'],'H':md['H'],'radical_polynomial':rad,'R_roots':roots,'finite_exceptions':out,'status':'complete_exclusion_on_this_exceptional_H_branch_for_all_nonzero_R_and_lambda','cubic_automorphism_extends_to_all_three_w_roots':True}
 (ROOT/'certificates'/f'exceptional_closure_{index}_{sign}.json').write_text(json.dumps(closure,indent=2)+'\n')
 print('FULL TWO-PARAMETER BRANCH EXCLUDED, INCLUDING FINITE RESULTANT EXCEPTIONS.',flush=True)
 return closure
if __name__=='__main__':main(*(map(int,sys.argv[1:])) if len(sys.argv)>1 else (3,0))
