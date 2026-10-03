#!/usr/bin/env sage
"""All81 triple spaces: weight-four at each selected endpoint outside J."""
import signal,time,os
from pathlib import Path
from itertools import combinations
task_started=time.monotonic()
limit=int(os.environ.get('M9_SELECTED_POLE_SECONDS','20'))
def budget_expired(signum,frame):raise TimeoutError('triple selected-pole hard budget; completed triples retained')
signal.signal(signal.SIGALRM,budget_expired);signal.setitimer(signal.ITIMER_REAL,limit)
source=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_triple_selected_poles.sage').read_text().split('\nrecords=[]\n')[0]
exec(compile(source,'selected_pole_prefix','exec'))
output=folder/'all_triple_selected_poles.json'
resume_index=int(os.environ.get('M9_SELECTED_POLE_RESUME','0'))
previous=json.loads(output.read_text()) if resume_index else None
records=previous['records'][:] if previous else [];kernels=previous['kernels'][:] if previous else []
assert len(kernels)==resume_index
pattern_index=0
def save():
 out={'scope':'All81 non-all-same-x triple zero patterns for one omitted root; each of six outside endpoints tested at weight4. Exactly-three-zero source strata only.',
      'field_modulus':data['field_modulus'],'beta_coordinates':data['beta_coordinates'],
      'omitted_A_root':data['omitted_A_root'],'selected_endpoints':data['selected_endpoints'],
      'completed_triples':len(kernels),'complete':len(kernels)==81,'kernels':kernels,'records':records,
      'seconds':time.monotonic()-task_started,'sage_version':version()}
 if previous:out['prior_seconds']=previous['seconds']
 output.write_text(json.dumps(out,indent=2,default=int)+'\n')
for indices in combinations(range(9),3):
 hit={endpoints[i] for i in indices}
 if len({pt[0] for pt in hit})==1:continue
 pattern_index+=1
 if pattern_index<=resume_index:continue
 contact=matrix(E,[row for pt in endpoints for (j,t),row in allrows[pt].items() if pt not in hit or t<2-j])
 kernel=contact.right_kernel_matrix();assert kernel.nrows()==5
 triple_records=[]
 for endpoint_index,pt in enumerate(endpoints):
  if endpoint_index in indices:continue
  constrained=(extra[pt]*kernel.transpose()).right_kernel_matrix()
  record={'triple_endpoint_indices':list(indices),'pole_endpoint_index':endpoint_index,'dimension':int(constrained.nrows())}
  if constrained.nrows()==1:
   coeff=constrained[0]*kernel
   p=[[R.zero() for _ in range(3)] for _ in range(4)]
   for c,bas in zip(coeff,basis):
    if c:
     for j in range(4):p[j]=add(p[j],scale(bas[j],c))
   norms=[norm(f) for f in p if any(f)];gcd=norms[0]
   for g in norms[1:]:gcd=gcd.gcd(g)
   gcd=gcd.monic()
   record.update({'line_in_triple':list(map(coords,constrained[0])),
                  'coefficient_norm_gcd':encode_poly(gcd),'coefficient_norm_gcd_degree':int(gcd.degree())})
  triple_records.append(record)
 records.extend(triple_records);kernels.append({'triple_endpoint_indices':list(indices),'coefficient_kernel':[[coords(v) for v in row] for row in kernel.rows()]});save()
 if len(kernels)%9==0:print('triples',len(kernels),'constraints',len(records),'seconds',time.monotonic()-task_started,flush=True)
signal.setitimer(signal.ITIMER_REAL,0)
print('DONE',len(kernels),'triples;',time.monotonic()-task_started,'seconds')
