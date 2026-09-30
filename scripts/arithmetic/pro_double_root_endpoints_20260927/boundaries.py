"""Geometric, all-scale exclusions on four complete projection divisors.
Every irreducible factor over K is retained, so these are not K-point searches.
"""
from exact import ROOT,DATA
from extension import E,Poly,init
from residual import make_residual,square_equations,Curve
import json,time,subprocess,sys,hashlib

def cases():
 fac=json.loads((ROOT/'evidence/ratio_factorizations.json').read_text())
 out=[]
 for boundary in ['b','e','leading_boundary','leading_companion','zero_F_projection']:
  for i,(f,m) in enumerate(fac['leading_boundary' if boundary=='leading_companion' else boundary]['factors']):
   assert m==1
   out.append({'id':f'{boundary}_{i}','boundary':boundary,'modulus':f,'degree':len(f)-1})
 return out

def run(case,verify=False):
 start=time.time();mod=case['modulus'];init(mod)
 q=E([0,1]) if len(mod)>2 else -E(mod[0])
 # q is the residue of the polynomial variable; for a linear modulus, -constant.
 b,c,e,a0,d=[Poly(DATA[z]).eval(q) for z in ['b','c','e','a0','d']]
 boundary=case['boundary'];out=dict(case);out['q_image']=list(q.a)
 if not q or not d or any(q==E(v) for v in DATA['excluded_q']):
  out.update(status='outside_user_open',reason='removed q-fibre');return out
 if boundary=='b':
  assert not b and c and e;u=e/c
 elif boundary=='e':
  assert not e and b and c;u=3*c/b
 elif boundary in ['leading_boundary','leading_companion']:
  assert c*c+b*e==0 and b and c;u=(2 if boundary=='leading_boundary' else 1)*c/b
 else:
  if not b or not e:
   out.update(status='outside_new_certified_open',reason='b or e boundary already excluded');return out
  C=c*c-3*b*e
  if not C:
   out.update(status='outside_user_open',reason='triple-root fibre excluded by accepted input');return out
  pivot=2*(b*b-3*a0*c)
  assert pivot
  uf=(4*a0*e-b*c)/pivot
  assert a0*uf**3+b*uf*uf+c*uf+e==0
  assert b*uf*uf+2*c*uf+3*e==0
  u=3*c/b-uf
  out['excluded_zero_F_root']=list(uf.a)
 out['u_image']=list(u.a)
 assert b*u*u+2*c*u+3*e==0
 xi=b*u+c;F=a0*u**3+b*u*u+c*u+e
 if not u or not xi or not F:
  out.update(status='outside_user_open',reason='u, ordinary factor, or F6 is zero');return out
 s=F/(d*u**3);H=u/q
 out.update(s_image=list(s.a),H_image=list(H.a),ordinary_factor=list(xi.a),F_image=list(F.a))
 if boundary=='leading_boundary':assert a0-s*d==0
 R=make_residual(q,u,True);tails=square_equations(R,False,True)
 g,S,T=tails[0].xgcd(tails[1]);assert S*tails[0]+T*tails[1]==g
 if g==1:
  out.update(status='excluded_all_geometric_scales',tails=[p.records() for p in tails],bezout=[S.records(),T.records()])
 else:
  all_eq=square_equations(R,True,True);g0=all_eq[0]
  coefs=[Poly(1)]+[Poly() for _ in range(len(all_eq)-1)]
  for j in range(1,len(all_eq)):
   G,S,T=g0.xgcd(all_eq[j]);coefs=[p*S for p in coefs];coefs[j]=coefs[j]+T;g0=G
   if g0==1:break
  assert sum((p*v for p,v in zip(coefs,all_eq)),Poly())==g0
  if g0==1:out.update(status='excluded_all_geometric_scales',full_tails=[p.records() for p in all_eq],full_bezout=[p.records() for p in coefs])
  else:out.update(status='unresolved',common_scale_factor=g0.records())
 out['residual_digest']=hashlib.sha256(json.dumps([p.records() for p in R],separators=(',',':')).encode()).hexdigest()
 out['degrees_x']=[p.degree() for p in R]
 out['elapsed_seconds']=round(time.time()-start,3)
 print(case['id'],out['status'],'extension degree',case['degree'],'seconds',out['elapsed_seconds'],flush=True)
 target=ROOT/'evidence'/('boundary_'+case['id']+'.json')
 if verify:
  stored=json.loads(target.read_text())
  for k in out:
   if k!='elapsed_seconds':assert stored[k]==out[k],k
  print(case['id'],'stored reconstruction and certificate match',flush=True)
 else:target.write_text(json.dumps(out,separators=(',',':'))+'\n')
 return out

if __name__=='__main__':
 if len(sys.argv)>1 and sys.argv[1]!='all':
  case=next(c for c in cases() if c['id']==sys.argv[1]);out=run(case,'--verify' in sys.argv)
  if out['status'] in ['outside_user_open','outside_new_certified_open']:
   target=ROOT/'evidence'/('boundary_'+case['id']+'.json')
   if '--verify' in sys.argv:assert json.loads(target.read_text())==out
   else:target.write_text(json.dumps(out,separators=(',',':'))+'\n')
   print(case['id'],out['status'],out.get('reason',''),flush=True)
 else:
  for c in cases():subprocess.run([sys.executable,__file__,c['id']]+(['--verify'] if '--verify' in sys.argv else []),check=True)
