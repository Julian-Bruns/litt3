#!/usr/bin/env sage
"""One new111 orbit: native exact complete-Veronese certificate."""
import json,time,signal,struct,sys
from pathlib import Path
task_started=time.monotonic()
def budget_expired(signum,frame):raise TimeoutError('30-second native orbit budget expired; checkpoints retained')
signal.signal(signal.SIGALRM,budget_expired);signal.setitimer(signal.ITIMER_REAL,30)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
source=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_triple_kernel_map.sage').read_text().split('rank_records=[]')[0]
exec(compile(source,'triple_kernel_prefix','exec'))
indices=(0,3,7);hit={endpoints[i] for i in indices};contact=contact_matrix(hit)
kernel=contact.right_kernel_matrix();assert kernel.nrows()==5
sections=[]
for v in kernel.rows():
 fs=[[R.zero() for _ in range(3)] for _ in range(4)]
 for c,bas in zip(v,basis):
  if c:
   for j in range(4):fs[j]=add(fs[j],scale(bas[j],c))
 sections.append(fs)
cofactors=[]
for missing in range(5):
 cols=[i for i in range(5) if i!=missing]
 cofactors.append(scale(determinant([[sections[i][j] for i in cols] for j in range(4)]),(-1)**missing))
norms=[norm(f) for f in cofactors if any(f)];gcd=norms[0]
for g in norms[1:]:gcd=gcd.gcd(g)
poles=[max(3*h.degree()+10*c for c,h in enumerate(f) if h) for f in cofactors]
assert gcd.degree()==45 and max(poles)==82
out={'scope':'NEW111 orbit1 only; native rank-factorization of degree7 coordinates.',
     'field_modulus':meta['field_modulus'],'beta_coordinates':meta['beta_coordinates'],'omitted_A_root':coords(omitted),
     'relaxed_endpoint_indices':indices,'coefficient_kernel':[[coords(v) for v in row] for row in kernel.rows()],
     'sections':[[encoded(f) for f in fs] for fs in sections],'cofactors':[encoded(f) for f in cofactors],
     'common_norm_gcd':encoded([gcd.monic()])[0],'common_norm_gcd_degree':int(gcd.degree()),
     'cofactor_poles':list(map(int,poles)),'line_bundle_degree':37,'expected_rank':251}
output=folder/'111_native_orbit1.json'
def save():out['seconds']=time.monotonic()-task_started;output.write_text(json.dumps(out,indent=2,default=int)+'\n')
save();print('newcofactors saved; seconds',time.monotonic()-task_started,flush=True)
def exponents(n,slots=5):
 if slots==1:yield (n,);return
 for a in range(n+1):
  for tail in exponents(n-a,slots-1):yield (a,)+tail
cache={(0,0,0,0,0):[R.one(),R.zero(),R.zero()]}
for n in range(1,5):
 for tag in exponents(n):
  i=next(i for i,a in enumerate(tag) if a);parent=list(tag);parent[i]-=1
  cache[tag]=mul(cache[tuple(parent)],cofactors[i])
tags=list(exponents(7));columns=[]
for tag in tags:
 left=list(tag);right=[0]*5;remaining=3
 for i in range(5):
  moved=min(left[i],remaining);left[i]-=moved;right[i]+=moved;remaining-=moved
 columns.append(mul(cache[tuple(left)],cache[tuple(right)]))
maxdeg=max(h.degree() for f in columns for h in f if h)
rowtags=[(c,n) for c in range(3) for n in range(maxdeg+1)]
M=matrix(E,[[f[c][n] for f in columns] for c,n in rowtags])
out.update(matrix_rows=int(M.nrows()),matrix_columns=int(M.ncols()),column_exponents=tags);save()
print('matrix ready; seconds',time.monotonic()-task_started,flush=True)
sys.path.insert(0,'/Users/julian/Documents/litt3')
from scripts.atlases.native.atlas_native_rref import NativeRref
bridge=NativeRref(E);rr,combination=bridge.rref(M)
rank=rr.nrows();out.update(rank=int(rank),native_records=bridge.records,pivot_columns=list(rr.pivots()));save()
assert rank==251
# Compact exact lower-rank evidence: C*M[:,pivots]=I251.
# The native backend already verifies the stronger full C*M=R identity.
target=folder/'111_native_orbit1_row_combinations.bin'
with target.open('wb') as stream:
 stream.write(struct.pack('<IIII',24,int(combination.nrows()),int(combination.ncols()),len(out['pivot_columns'])))
 stream.write(bytes(meta['field_modulus']))
 stream.write(struct.pack('<'+'I'*len(out['pivot_columns']),*out['pivot_columns']))
 for v in combination.list():
  value=bytes(coords(v));stream.write(struct.pack('<I',len(value)));stream.write(value)
out.update(row_combination_certificate=target.name,complete_rank_factorization=True);save()
signal.setitimer(signal.ITIMER_REAL,0)
print('PASSneworbit1 rank',rank,'seconds',time.monotonic()-task_started,flush=True)
