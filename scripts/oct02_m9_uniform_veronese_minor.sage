#!/usr/bin/env sage
"""Complete one embedding certificate using only stored251 pivot columns."""
import json,time,signal
from pathlib import Path
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
rank_data=json.loads((folder/'veronese111_embedding.json').read_text())
source=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_veronese_embedding.sage').read_text().split('tags=list(exponent_vectors(7))')[0]
exec(compile(source,'veronese_generation_prefix','exec'))
tags=[tuple(rank_data['column_exponents'][i]) for i in rank_data['pivot_columns']]
columns=[]
for exponents in tags:
 left=list(exponents);right=[0]*5;remaining=3
 for i in range(5):
  moved=min(left[i],remaining);left[i]-=moved;right[i]+=moved;remaining-=moved
 columns.append(mul(cache[tuple(left)],cache[tuple(right)]))
maxdeg=max(h.degree() for f in columns for h in f if h)
rowtags=[(c,n) for c in range(3) for n in range(maxdeg+1)]
C=matrix(E,[[f[c][n] for f in columns] for c,n in rowtags])
assert C.ncols()==251
rank_data.update({'minor_generation_rows':int(C.nrows()),'minor_generation_columns':251,'minor_generation_seconds':time.time()-started})
output=folder/'veronese111_embedding.json';output.write_text(json.dumps(rank_data,indent=2,default=int)+'\n')
print('restricted251columns generated; seconds',time.time()-started,flush=True)
pivrows=list(C.transpose().pivots());assert len(pivrows)==251
rank_data.update({'pivot_rows':pivrows,'pivot_row_tags':[rowtags[i] for i in pivrows],'seconds_at_row_selection':time.time()-started})
output.write_text(json.dumps(rank_data,indent=2,default=int)+'\n')
print('independent251rows saved; seconds',time.time()-started,flush=True)
def certificate_budget_expired(signum,frame):raise TimeoutError('40-second certificate budget; row selection remains saved')
signal.signal(signal.SIGALRM,certificate_budget_expired)
signal.setitimer(signal.ITIMER_REAL,max(0.01,40-(time.time()-started)))
minor=C.matrix_from_rows(pivrows).det();assert minor
signal.setitimer(signal.ITIMER_REAL,0)
rank_data.update({'minor':coords(minor),'nonzero_minor':True,'minor_completion_seconds':time.time()-started})
output.write_text(json.dumps(rank_data,indent=2,default=int)+'\n')
print('PASS nonzero251minor; seconds',time.time()-started,flush=True)
