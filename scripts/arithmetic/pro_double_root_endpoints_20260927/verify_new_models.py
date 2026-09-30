"""Independent-reference checks for the new normalization, four global tails,
and compact norm model. These checks are not a search for square points.
The finite samples corroborate the global degree-bounded constructions; they
are not on their own claimed to prove identities of unbounded degree.
"""
import json,gzip,struct,ctypes as ct,hashlib,time,sys
from exact import ROOT,DATA,power,add,mul,code
from extension import E,Poly,init
from interpolate_global import library
from fibres_u import load_sample
from residual import Curve,sm,sf,bp_add,bp_pow,bp_mul,bp_scale
from norm_element import sample as source_theta

def global_eval(filename,meta,u0):
 raw=gzip.open(ROOT/'evidence'/filename,'rb').read()
 assert hashlib.sha256(raw).hexdigest()==meta['raw_sha256']
 flat=struct.unpack('<%dI'%(len(raw)//4),raw);n=meta['shape'][0];m=len(flat)//n
 out=(ct.c_int*m)();library().ff_evaluate_rows((ct.c_int*len(flat))(*flat),n,m,u0,out)
 return list(out)
def run():
 start=time.time();src=json.loads((ROOT/'evidence/global_source.json').read_text())
 pm=json.loads((ROOT/'evidence/global_prefix.json').read_text());nm=json.loads((ROOT/'evidence/norm_element.json').read_text())
 jets=json.loads(gzip.open(ROOT/'evidence/normalized_jets.json.gz','rb').read());records=[]
 for u0 in [1,2,24,132,1374]:
  mod=[0]*10
  for iq,iu,a in src['critical_monic']:mod[iq]=add(mod[iq],mul(a,power(u0,iu)))
  init(mod);q=E([0,1]);u=E(u0);d=Poly(DATA['d']).eval(q);assert q.inv() and d.inv() and u.inv()
  rr=struct.unpack('<%dI'%(7*141*9),load_sample(u0))
  R=[Poly([E(list(rr[(ti*141+ix)*9:(ti*141+ix+1)*9])) for ix in range(141)]) for ti in range(7)]
  aa=q**84*d**33*u**12;chi=q*q*d**3*u**3;bs=q*q*d**3*u
  Z=Poly(DATA['a0']).eval(q)*u*u+4*Poly(DATA['b']).eval(q)*u+2*Poly(DATA['c']).eval(q)
  assert R[0][140]/aa==(3*E(code(DATA['epsilon']))**8)**3*Z**3
  normjets=[]
  for n in range(75):
   coef=[]
   for i in range(7):
    expect=R[i][140-n]*(chi**n)/(aa*(bs**i))
    p=jets[n][i];val=[0]*9
    for iu in range(len(p)//9):
     for jq in range(9):val[jq]=add(val[jq],mul(p[9*iu+jq],power(u0,iu)))
    assert E(val)==expect,(u0,n,i)
    coef.append(expect)
   normjets.append(Poly(coef))
  pref=global_eval('global_prefix.bin.gz',pm,u0)
  # Reference uses the pre-existing general Python series circuit, not the
  # new specialized C++ prefix routine used to build the archived array.
  A=[Poly([p[140-n] for p in R]) for n in range(75)]
  A2=sm(A,A,75);A3=sm(A2,A,75)
  CC=sm(sm(A3,sf(A2,1,75),75),sf(A2,2,75),75)
  for h in range(4):
   actual=Poly([E(pref[(h*64+i)*9:(h*64+i+1)*9]) for i in range(64)])
   expected=Poly([CC[71+h][i]*(chi**(71+h))/(aa**63*bs**i) for i in range(CC[71+h].degree()+1)])
   assert actual==expected,(u0,h)
  # Norm element is separately regenerated from the actual source resultant.
  theta_values=global_eval('norm_element.bin.gz',nm,u0)
  fresh,theta=source_theta(u0);assert theta_values==fresh
  Curve.Pbar=Poly(DATA['P'])*q*q
  av,bv,cv=[[zz.c[i] for zz in theta] for i in range(3)]
  norm=bp_add(bp_add(bp_pow(av,3),bp_scale(bp_pow(bv,3),Curve.Pbar)),bp_scale(bp_pow(cv,3),Curve.Pbar**2))
  norm=bp_add(norm,bp_scale(bp_mul(bp_mul(av,bv),cv),2*Curve.Pbar))
  assert len(norm)==7 and all(norm[i]==R[i]*q**4 for i in range(7))
  records.append({'u_code':u0,'complete_ratio_algebra_length':9,'normalized_jet_coefficients_checked':75*7,'global_tails_checked':[71,72,73,74],'reference':'pre-existing Python Frobenius square circuit','norm_element':'fresh actual source resultant and direct norm agree with global residual','scale':'all coefficients; not specialized'})
  print('NEW MODELS verified at complete u algebra',u0,flush=True)
 result={'status':'passed','samples':records,'seconds':round(time.time()-start,3),'scope':'independent exact cross-checks supplement the proved global interpolation bounds; no new ratio exclusions'}
 (ROOT/'logs/new_models_checks.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result),flush=True)
if __name__=='__main__':run()
