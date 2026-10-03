#!/usr/bin/env sage
"""New source-only pole4 ramified no-b-singleton boundary."""
import json,time,signal
from pathlib import Path
from itertools import combinations
task_started=time.monotonic()
source=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_source_e_no_single.sage').read_text();setup=source[source.index('folder='):source.index('records=[]')]
exec(compile(setup,'pole4_branch_field_arithmetic','exec'))
def expired45(s,f):raise TimeoutError('pole4 branch source-e hard45s')
signal.signal(signal.SIGALRM,expired45);signal.setitimer(signal.ITIMER_REAL,max(.1,45-(time.monotonic()-task_started)))
q=poly([13,18,24]);q3=poly([1,22,9,1]);records=[];slope_drops=[]
for r0 in P.roots(multiplicities=False):
 assert q(r0);lam=-q3(r0)/q(r0);delta=q3+lam*q
 assert delta.is_squarefree() and delta.gcd(P).degree()==1 and delta.gcd(A).degree()==0
 K,rem=(Z*delta).quo_rem(P);assert delta.gcd(K).degree()==0
 others=[r for r in delta.roots(multiplicities=False) if r!=r0];assert len(others)==2
 yc1=cubes(others[0])[0]
 for yc2 in cubes(others[1]):
  gamma=R.lagrange_polynomial([(others[0],K(others[0])*yc1),(others[1],K(others[1])*yc2)])
  if gamma.degree()!=1:
   slope_drops.append({'branch_x':coords(r0),'c_sheets':[coords(yc1),coords(yc2)]});continue
  C0=R.lagrange_polynomial([(r0,E.zero()),(others[0],K(others[0])*yc1**2),(others[1],K(others[1])*yc2**2)])
  B0=2*C0;Nb=[B0,R.zero(),-2*K];Ne0=scale(add(pi(Nb,1),pi([delta,R.zero(),R.zero()],2)),-E.one())
  Nbcols=[[R.zero() for i in range(3)] for i in range(7)]+[[delta,R.zero(),R.zero()],[delta*x,R.zero(),R.zero()]]
  Necols=eta_basis+[scale(pi(f,1),-E.one()) for f in Nbcols[7:]]
  baserows=[];baserhs=[]
  for degree in [9,8]:
   baserows.append([E.zero()]*7+[((Z*delta)%P)[degree],((Z*delta*x)%P)[degree]]);baserhs.append(-((Z*B0)%P)[degree])
  for r,y in [(others[0],yc1),(others[1],yc2)]:
   baserows.append([ev(f,r,y) for f in Necols]);baserhs.append(-ev(Ne0,r,y))
  for char in ([0,1] if gamma(r0) else [0]):
   baserows.append([f[char](r0) for f in Necols]);baserhs.append(-Ne0[char](r0))
  for omitted in range(4):
   endpoints=[(r,y) for i,r in enumerate(aroots) if i!=omitted for y in cubes(r)]
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
   records.append({'branch_x':coords(r0),'lambda':coords(lam),'ordinary_c_sheets':[coords(yc1),coords(yc2)],'omitted_A_root_index':omitted,'gamma_at_branch_zero':not bool(gamma(r0)),'feasible_c_strata':len(strata),'max_c_zeros':max(len(s['zero_indices']) for s in strata),'consistent_strata':sum(s['consistent'] for s in strata),'strata':strata})
   out={'scope':'Source-only pole4 c, b constant y-coefficient zero, simple branch boundary. All branch parameters, relative ordinary c sheets and omissions. Ne branch order>=2 if hc2 (e pole1 allowed), order>=1 if hc1 (e pole2 allowed).','records':records,'slope_drops':slope_drops,'complete':len(records)+4*len(slope_drops)==120,'seconds':time.monotonic()-task_started,'sage_version':version()}
   (folder/'source_e_pole4_branch.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
   print('source-e pole4 branch',len(records),'maxJ',records[-1]['max_c_zeros'],'consistent',records[-1]['consistent_strata'],'seconds',time.monotonic()-task_started,flush=True)
signal.setitimer(signal.ITIMER_REAL,0)
