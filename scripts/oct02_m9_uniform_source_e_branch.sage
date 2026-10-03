#!/usr/bin/env sage
"""New source-e gamma-zero branch boundary; no annihilator hypotheses."""
import json,time,signal
from pathlib import Path
from itertools import combinations
task_started=time.monotonic()
prefix=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_source_e_no_single.sage').read_text().split('records=[]')[0]
exec(compile(prefix,'source_e_branch_normalization','exec'))
def expired45(s,f):raise TimeoutError('source-e gamma-zero branch hard45s')
signal.signal(signal.SIGALRM,expired45);signal.setitimer(signal.ITIMER_REAL,max(.1,45-(time.monotonic()-task_started)))
q=poly([13,18,24]);q3=poly([1,22,9,1]);records=[]
for r0 in P.roots(multiplicities=False):
 assert q(r0);lam=-q3(r0)/q(r0);delta=q3+lam*q
 assert delta.is_squarefree() and delta.gcd(P).degree()==1
 assert delta.gcd(A).degree()==0
 K,rem=(Z*delta).quo_rem(P);assert delta.gcd(K).degree()==0
 others=[r for r in delta.roots(multiplicities=False) if r!=r0];assert len(others)==2
 # Simultaneous C3 fixes gamma=0 and represents the first ordinary b sheet.
 yb1=cubes(others[0])[0]
 for yb2 in cubes(others[1]):
  D1=R.lagrange_polynomial([(others[0],-2*K(others[0])*yb1),(others[1],-2*K(others[1])*yb2)])
  B0=R.lagrange_polynomial([(r0,E.zero()),(others[0],-2*K(others[0])*yb1**2),(others[1],-2*K(others[1])*yb2**2)])
  C0=R.lagrange_polynomial([(r0,E.zero()),(others[0],-K(others[0])*yb1**2),(others[1],-K(others[1])*yb2**2)])
  Nb=[B0,D1,-2*K];Ne0=scale(add(pi(Nb,1),pi([delta,R.zero(),R.zero()],2)),-E.one())
  Nbcols=[[R.zero() for i in range(3)] for i in range(7)]+[[delta,R.zero(),R.zero()],[delta*x,R.zero(),R.zero()]]
  Necols=eta_basis+[scale(pi(f,1),-E.one()) for f in Nbcols[7:]]
  poles=[(others[0],y) for y in cubes(others[0]) if y!=yb1]+[(others[1],y) for y in cubes(others[1]) if y!=yb2]
  baserows=[[E.zero()]*7+[((Z*delta)%P)[9],((Z*delta*x)%P)[9]]];baserhs=[-((Z*B0)%P)[9]]
  for r,y in poles+[(r0,E.zero())]:
   baserows.append([ev(f,r,y) for f in Necols]);baserhs.append(-ev(Ne0,r,y))
  for omitted in range(4):
   endpoints=[(r,y) for i,r in enumerate(aroots) if i!=omitted for y in cubes(r)]
   crows=[];crhs=[];erows=[];erhs=[]
   for r,y in endpoints:
    aa=Z(r)/y
    crows.append([delta(r),delta(r)*r]);crhs.append(delta(r)*aa-K(r)*y*y-C0(r))
    erows.append([ev(n,r,y)+aa*ev(b,r,y) for n,b in zip(Necols,Nbcols)])
    erhs.append(-ev(Ne0,r,y)-aa*ev(Nb,r,y)-aa**2*delta(r))
   strata=[]
   for size in range(10):
    for hit in combinations(range(9),size):
     M=matrix(E,[crows[i] for i in hit],ncols=2);rhs=vector(E,[crhs[i] for i in hit]);aug=M.augment(rhs.column())
     if M.rank()!=aug.rank():continue
     sol=M.solve_right(rhs);ker=M.right_kernel_matrix()
     if sol[1]==0 and all(v[1]==0 for v in ker.rows()):continue
     outside=[i for i in range(9) if i not in hit]
     N=matrix(E,baserows+[erows[i] for i in outside]);right=vector(E,baserhs+[erhs[i] for i in outside]);Naug=N.augment(right.column())
     rank=N.rank();arank=Naug.rank()
     strata.append({'zero_indices':list(hit),'rank':int(rank),'augmented_rank':int(arank),'consistent':rank==arank})
   records.append({'branch_x':coords(r0),'lambda':coords(lam),'ordinary_b_sheets':[coords(yb1),coords(yb2)],'omitted_A_root_index':omitted,'D1_at_branch_zero':not bool(D1(r0)),'feasible_c_strata':len(strata),'max_c_zeros':max(len(s['zero_indices']) for s in strata),'consistent_strata':sum(s['consistent'] for s in strata),'strata':strata})
   out={'scope':'Source-only c pole3, gamma0 simple branch boundary; all ten P roots, all relative ordinary b sheet choices and all omissions. Branch e pole2 allowed by imposing only Ne value zero. No rho/U hypotheses.','records':records,'complete':len(records)==120,'seconds':time.monotonic()-task_started,'sage_version':version()}
   (folder/'source_e_gamma_zero_branch.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
   print('source-e branch',len(records),'feasible',records[-1]['feasible_c_strata'],'maxJ',records[-1]['max_c_zeros'],'consistent',records[-1]['consistent_strata'],'seconds',time.monotonic()-task_started,flush=True)
signal.setitimer(signal.ITIMER_REAL,0)
