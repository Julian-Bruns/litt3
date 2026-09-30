"""Generate compact exact pencil certificates by coefficient matching."""
import json,sys,time
from pathlib import Path
from polynomial_core import *
ROOT=Path(__file__).resolve().parents[2]
out={'schema':'pencil-identities-v1','field':'F25; beta^2=beta+3; bracket-code coefficients',
     'variables':['x0','x1','x2'],'normalization':'epsilon_3=1',
     'status':'exact polynomial identities, not an endpoint search','certificates':[]}
N=norm_polynomial()
items=[(d,'norm',N) for d in [0,1,3]]
items += [(2,'norm_times_'+nm,mul(N,p)) for nm,p in residuals_d2().items()]
for d,nm,target in items:
 bound=max(0,degree(target)-2)
 while True:
  try:hs,stats=representation(quadrics(d),target,bound);break
  except ValueError:
   bound+=1
   if bound>10:raise
 out['certificates'].append({'relative_type':d,'name':nm,'target':serial(target),
                            'multipliers':[serial(h) for h in hs],'statistics':stats})
 print(d,nm,stats,flush=True)
p=ROOT/'structural/evidence/pencil_certificates.json'
p.write_text(json.dumps(out,indent=2)+'\n')
print('wrote',p,'bytes',p.stat().st_size)
