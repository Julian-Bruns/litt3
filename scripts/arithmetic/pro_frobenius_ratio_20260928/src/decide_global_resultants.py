#!/usr/bin/env python3
"""Find a global Bezout certificate in the three reconstructed resultants.

Only previously proved q-units and the now-closed complete slope q-divisors
may be removed. No generic minor or unexamined factor is inverted.
"""
from pathlib import Path
import json,time,hashlib
import numpy as np
from ff import Poly
from half_gcd import xgcd
from gmp_poly import install
from known_unit_factorization import factor_known,rebuild
install()
ROOT=Path(__file__).resolve().parents[1]

def known_factors():
 fs=[Poly(f)for f in json.loads((ROOT/'data/zero_scale_compact.json').read_text())['unit_factors']]
 refs=[{'source':'data/zero_scale_compact.json','index':i}for i in range(len(fs))]
 for name in ['plus','minus']:
  d=json.loads((ROOT/f'data/slope_{name}_model.json').read_text());p=Poly(1)
  for i,f in enumerate(d['factors']):fs.append(Poly(f));refs.append({'source':f'data/slope_{name}_model.json','index':i});p=p*Poly(f)
  assert p==Poly(d['norm_squarefree'])
 prod=Poly(1)
 for f in fs:assert prod.gcd(f)==1;prod=prod*f
 assert len(fs)==51
 return fs,refs

def digest(p):return hashlib.sha256(p.a.astype('<u4').tobytes()).hexdigest()

def run():
 t=time.time();P=np.load(ROOT/'scratch/global_resultants.npz');ps={n:Poly(P[str(n)])for n in (72,73,74)};fs,refs=known_factors();certfile=ROOT/'data/global_resultant_bezout.npz';stagefile=ROOT/'scratch/global_gcd12.npz'
 if stagefile.exists():
  st=np.load(stagefile);g,U,V=[Poly(st[k])for k in ['g','U','V']];assert U*ps[72]+V*ps[73]==g
 else:
  print('GLOBAL_RESULTANT_XGCD_START',ps[72].degree(),ps[73].degree(),flush=True);g,U,V=xgcd(ps[72],ps[73]);assert U*ps[72]+V*ps[73]==g;np.savez_compressed(stagefile,g=g.a,U=U.a,V=V.a)
 print('GLOBAL_RESULTANT_XGCD12_VERIFIED',g.degree(),'Bezout degrees',U.degree(),V.degree(),'seconds',round(time.time()-t,3),flush=True)
 arrays={'U':U.a,'V':V.a};stages=[{'left':72,'right':73,'gcd_degree':g.degree(),'gcd_sha256':digest(g),'coefficient_degrees':[U.degree(),V.degree()]}];used=[72,73]
 try:fact=factor_known(g,fs)
 except (ArithmeticError,AssertionError)as exc:
  print('FIRST_GCD_HAS_UNCERTIFIED_FACTOR',repr(exc),flush=True);g12=g;g,Z,W=xgcd(g,ps[74]);assert Z*g12+W*ps[74]==g;arrays.update(Z=Z.a,W=W.a);stages.append({'left':'gcd12','right':74,'gcd_degree':g.degree(),'gcd_sha256':digest(g),'coefficient_degrees':[Z.degree(),W.degree()]});used.append(74)
  print('GLOBAL_RESULTANT_XGCD123_VERIFIED',g.degree(),'seconds',round(time.time()-t,3),flush=True)
  try:fact=factor_known(g,fs)
  except (ArithmeticError,AssertionError)as exc2:
   np.savez_compressed(ROOT/'scratch/global_gcd123.npz',g=g.a,**arrays);(ROOT/'checks/global_resultant_decision.json').write_text(json.dumps({'status':'unresolved common q-factor remains','stages':stages,'factorization_failure':repr(exc2)},indent=2)+'\n');print('UNRESOLVED_GLOBAL_COMMON_FACTOR',g.degree(),repr(exc2),flush=True);return
 assert rebuild(fact,fs)==g
 np.savez_compressed(certfile,**arrays)
 cert={'status':'global ordinary-double-root square ideal is the unit ideal','resultant_indices':used,'tail_indices':[71]+used,'stages':stages,'unit_factor_sources':refs,'unit_gcd_factorization':fact,'bezout_array_file':str(certfile.relative_to(ROOT)),'reconstructed_resultant_hashes':{n:digest(ps[n])for n in used},'reconstructed_resultant_degrees':{n:ps[n].degree()for n in used},'proof_dependencies':['REPORT.md Sections 26-29','data/resultant_pole_bounds.json','data/slope_companion_certificates','data/slope_certificates'],'seconds':round(time.time()-t,3)}
 (ROOT/'data/global_resultant_certificate.json').write_text(json.dumps(cert,indent=2)+'\n');(ROOT/'checks/global_resultant_decision.json').write_text(json.dumps(cert,indent=2)+'\n');print('GLOBAL_SQUARE_IDEAL_UNIT_CERTIFICATE_VERIFIED='+json.dumps(cert),flush=True)
if __name__=='__main__':run()
