"""Eleven explicitly selected ratio slices; full geometric scaling excluded.
The choice of ratios is bounded. These certificates are NOT global exclusions.
"""
import subprocess
from reconstruct import *
from series import normalized_vector
from laurent import LP
from square_slice import slice_certificate
from verify_original import verify_original,test_resultant

def main():
 cases=json.loads((ROOT/'data/spaces.json').read_text())['cases'];chs=json.loads((ROOT/'data/charts.json').read_text())['cases'];bs=json.loads((ROOT/'data/boundary_series.json').read_text())['cases']
 out=[]
 for idx,(case,ch,bc) in enumerate(zip(cases,chs,bs)):
  for h in [1,2,3,4]:
   w=1;vals=[h,w,0,0];det=LP.load(ch['determinant']).eval(vals)
   if not det:continue
   s=div(LP.load(ch['s_numerator']).eval(vals),det);u=div(LP.load(ch['u_numerator']).eval(vals),det);vals=[h,w,s,u]
   F6=LP.load(bc['F']['6']).eval(vals)
   if F6:break
  else:raise RuntimeError('selected test ratios did not give degree140')
  assert not LP.load(bc['F']['4']).eval(vals) and not LP.load(bc['F']['5']).eval(vals)
  vec=[p.eval(vals) for p in normalized_vector(case)];H,k=unpack(vec);assert k==1
  for kap in [1,2,5]:verify_original(vec,case['root'],kap)
  v=[1] if case['root'] is None else [neg(case['root']),1]
  name=f'slice_{idx:02d}';inp=ROOT/'data'/f'{name}.txt';rp=ROOT/'data'/f'{name}_residual.json';cp=ROOT/'certificates'/f'{name}_bezout.json'
  rows=[P,Q,t,v]+[p for i in range(2,6) for p in H[i]]
  inp.write_text('\n'.join(' '.join(map(str,[len(p)]+p)) for p in rows)+'\n')
  res=subprocess.run([str(ROOT/'src/residual'),str(ROOT/'data'),str(inp),str(rp)],capture_output=True,text=True,check=True)
  (ROOT/'logs'/f'{name}_resultant.log').write_text(res.stdout+res.stderr)
  R=json.loads(rp.read_text());cert=slice_certificate(R['lambda_coefficients'],verbose=False)
  assert cert['excludes_all_nonzero_lambda'];cp.write_text(json.dumps(cert,indent=2)+'\n')
  checks=test_resultant(H,v,R)
  entry={'index':idx,'root':case['root'],'h':h,'w':w,'s':s,'u':u,'F6':F6,'normalized_vector':vec,'residual':str(rp.relative_to(ROOT)),'certificate':str(cp.relative_to(ROOT)),'original_checks_kappa':[1,2,5],'sylvester_specializations_checked':checks,'scope':'this fixed ratio slice, all nonzero geometric kappa'};out.append(entry)
  print('slice',idx,'root',case['root'],'h w s u',vals,'F6',F6,'Bezout gcd',cert['gcd'],'Sylvester checks',checks,flush=True)
 (ROOT/'data/slices.json').write_text(json.dumps({'status':'bounded choice of ratio slices; scaling exclusion is geometric, not finite-field sampling','cases':out},indent=2)+'\n')
 print('ALL ELEVEN SCALING-LINE EXCLUSIONS VERIFIED',flush=True)
if __name__=='__main__':main()
