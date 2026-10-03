#!/usr/bin/env sage
"""Source-only ordinary pole4, b has no singleton critical fiber."""
import json,time,signal,argparse
from pathlib import Path
from itertools import combinations
ap=argparse.ArgumentParser();ap.add_argument('--all-patterns',action='store_true');args=ap.parse_args()
task_started=time.monotonic()
source=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_source_e_no_single.sage').read_text()
setup=source[source.index('folder='):source.index('records=[]')]
exec(compile(setup,'pole4_no_single_field_arithmetic','exec'))
def expired20(s,f):raise TimeoutError('pole4 no-single source-e hard20s')
signal.signal(signal.SIGALRM,expired20);signal.setitimer(signal.ITIMER_REAL,max(.1,20-(time.monotonic()-task_started)))
records=[]
for stored in (data['records'] if args.all_patterns else data['records'][:1]):
 if args.all_patterns and not records:
  previous=json.loads((folder/'source_e_pole4_no_single_prototype.json').read_text())
  assert previous['records'][0]['consistent_strata']==0
  records.append(previous['records'][0]);continue
 if 'stored_prototype' in stored:
  delta=R([E(v) for v in proto['delta']]);oldD1=R([E(v) for v in proto['records'][0]['D1']])
 else:delta=R([E(v) for v in stored['delta']]);oldD1=R([E(v) for v in stored['D1']])
 gamma=-oldD1/2;K,rem=(Z*delta).quo_rem(P)
 assert gamma.degree()==1 and not (gamma**3-K**3*P)%delta
 assert delta.is_squarefree() and delta.gcd(P*K*A).degree()==0
 C0=(gamma**2*K.inverse_mod(delta))%delta
 B00=2*C0;B01=(-gamma*K.inverse_mod(delta))%delta
 Nb=[B00,R.zero(),-2*K];Ne0=scale(add(pi(Nb,1),pi([delta,R.zero(),R.zero()],2)),-E.one())
 Nbcols=[[R.zero() for i in range(3)] for i in range(7)]+[[delta,R.zero(),R.zero()],[delta*x,R.zero(),R.zero()],[B01,R.one(),R.zero()]]
 Necols=eta_basis+[scale(pi(f,1),-E.one()) for f in Nbcols[7:]]
 def content(f):
  g=(K**2*f[0]+K*gamma*f[1]+gamma**2*f[2])%delta
  return [g[i] for i in range(3)]
 columns=[content(f) for f in Necols];const=content(Ne0)
 baserows=list(matrix(E,columns).transpose().rows());baserhs=[-v for v in const]
 for degree in [9,8]:
  baserows.append([E.zero()]*7+[((Z*delta)%P)[degree],((Z*delta*x)%P)[degree],((Z*B01)%P)[degree]])
  baserhs.append(-((Z*B00)%P)[degree])
 omitted=stored['omitted_A_root_index'];endpoints=[(r,y) for i,r in enumerate(aroots) if i!=omitted for y in cubes(r)]
 crows=[];crhs=[];erows=[];erhs=[]
 for r,y in endpoints:
  aa=Z(r)/y
  crows.append([delta(r),delta(r)*r]);crhs.append(delta(r)*aa-K(r)*y*y-gamma(r)*y-C0(r))
  erows.append([ev(n,r,y)+aa*ev(b,r,y) for n,b in zip(Necols,Nbcols)])
  erhs.append(-ev(Ne0,r,y)-aa*ev(Nb,r,y)-aa**2*delta(r))
 strata=[]
 for size in range(10):
  for hit in combinations(range(9),size):
   M=matrix(E,[crows[i] for i in hit],ncols=2);rhs=vector(E,[crhs[i] for i in hit]);aug=M.augment(rhs.column())
   if M.rank()!=aug.rank():continue
   outside=[i for i in range(9) if i not in hit]
   N=matrix(E,baserows+[erows[i] for i in outside]);right=vector(E,baserhs+[erhs[i] for i in outside]);Naug=N.augment(right.column())
   rank=N.rank();arank=Naug.rank()
   strata.append({'zero_indices':list(hit),'rank':int(rank),'augmented_rank':int(arank),'consistent':rank==arank})
 records.append({'parameter_factor_degree':stored['parameter_factor_degree'],'omitted_A_root_index':omitted,'feasible_c_strata':len(strata),'max_c_zeros':max(len(s['zero_indices']) for s in strata),'consistent_strata':sum(s['consistent'] for s in strata),'strata':strata})
 out={'scope':'Source-only ordinary simple pole4 c, b-double/c-single at all critical fibers. All geometric selected c-zero subsets and arbitrary constant b y-coefficient; no annihilator hypotheses. Branch/repeated boundaries separate.','records':records,'complete':args.all_patterns and len(records)==8,'seconds':time.monotonic()-task_started,'sage_version':version()}
 (folder/('source_e_pole4_no_single_complete.json' if args.all_patterns else 'source_e_pole4_no_single_prototype.json')).write_text(json.dumps(out,indent=2,default=int)+'\n')
 print('source-e pole4 noSingle',len(records),'maxJ',records[-1]['max_c_zeros'],'consistent',records[-1]['consistent_strata'],'seconds',time.monotonic()-task_started,flush=True)
signal.setitimer(signal.ITIMER_REAL,0)
