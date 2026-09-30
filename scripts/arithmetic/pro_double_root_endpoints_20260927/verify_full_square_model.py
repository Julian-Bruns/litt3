"""Independent actual-family checks of every normalized coefficient and the
complete exponent-13 square model; the scale remains a polynomial variable.
These finite algebra tests supplement exact global polynomial identities.
"""
import ctypes as ct,gzip,struct,json,time,hashlib,sys
from exact import ROOT,DATA,add,mul,power
from extension import E,Poly,init
from fibres_u import load_sample
from interpolate_global import library
from cartier_square import build,check_identities,equations
from residual import square_equations

def run(nodes):
 start=time.time();js=json.loads(gzip.open(ROOT/'evidence/normalized_full_jets.json.gz','rb').read())
 n=max(len(p)//9 for row in js for p in row);m=141*7*9
 inp=(ct.c_int*(n*m))()
 for t,row in enumerate(js):
  for i,p in enumerate(row):
   for ix,c in enumerate(p):
    iu,jq=divmod(ix,9);inp[iu*m+(t*7+i)*9+jq]=c
 out=(ct.c_int*m)();ev=library();src=json.loads((ROOT/'evidence/global_source.json').read_text());records=[]
 for u0 in nodes:
  mod=[0]*10
  for iq,iu,a in src['critical_monic']:mod[iq]=add(mod[iq],mul(a,power(u0,iu)))
  init(mod);q=E([0,1]);u=E(u0);d=Poly(DATA['d']).eval(q)
  aa=q**84*d**33*u**12;chi=q*q*d**3*u**3;bs=q*q*d**3*u
  ev.ff_evaluate_rows(inp,n,m,u0,out)
  A=[Poly([E(list(out[(t*7+i)*9:(t*7+i+1)*9])) for i in range(7)]) for t in range(141)]
  rr=struct.unpack('<%dI'%(7*141*9),load_sample(u0))
  for t in range(141):
   for i in range(7):
    rc=E(list(rr[(i*141+140-t)*9:(i*141+141-t)*9]))
    assert A[t][i]==rc*chi**t/(aa*bs**i),(u0,t,i)
  print('FULL141 JETS compared with actual residual at complete u algebra',u0,flush=True)
  model=build(A);res=check_identities(model);new=equations(model)
  # Compare directly with the inherited 70-equation reference, all scale coefficients.
  R=[Poly([A[140-x][i] for x in range(141)]) for i in range(7)]
  old=square_equations(R,True);L=A[0][0]
  oldnorm=[p/(L**63) for p in old[:54]]+[p/(L**126) for p in old[54:]]
  assert oldnorm[54:]==res[125:141]
  # Every canonical square-residual coefficient up through 124 is triangular
  # in the first54 tails with diagonal -2. Check the exact identity here.
  B=model['B']
  for n0 in range(71,125):
   ee=Poly()
   for j in range(71,n0+1):ee=ee-2*oldnorm[j-71]*B[n0-j]
   assert ee==res[n0]
  assert len(new)==len(old)==70
  record={'u_code':u0,'complete_algebra_length':9,'source_coefficients_checked':987,
   'scale':'all coefficients, never a scalar specialization',
   'canonical_root_matches_exponent63':True,'late16_match_original_exactly':True,
   'early54_match_triangular_unit_identity':True,
   'new_equation_scale_degrees':[p.degree() for p in new],
   'a_scale_degree':model['a_canonical'].degree(),'b_scale_degree':model['b_canonical'].degree()}
  records.append(record)
  print('FULL SQUARE MODELS AGREE at complete u algebra',u0,'max new scale degree',max(record['new_equation_scale_degrees']),flush=True)
 result={'status':'passed','samples':records,'seconds':round(time.time()-start,3),
  'scope':'bounded independent cross-checks; global validity comes from exact normalization and the universal proof'}
 path=ROOT/'logs'/('full_square_model_checks_'+('_'.join(map(str,nodes)))+'.json')
 path.write_text(json.dumps(result,indent=2)+'\n')
 return result
if __name__=='__main__':run([int(a) for a in sys.argv[1:]] or [1,132])
