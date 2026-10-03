#!/usr/bin/env sage
"""New fixed-q3 pole-four rational critical-root source-e system."""
import json,time,signal,argparse
from pathlib import Path
from itertools import combinations
ap=argparse.ArgumentParser();ap.add_argument('--all-patterns',action='store_true');args=ap.parse_args()
started=time.monotonic()
def expired(s,f):raise TimeoutError('source-e pole4 hard40s')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,40)
source=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_source_e_probe.sage').read_text()
setup=source[source.index("E=GF(5**24"):source.index('eta_basis=[]')]
exec(compile(setup,'source_e_fixed_q3_arithmetic','exec'))
eta_basis=[]
for char in range(3):
 for a in range((13-10*char)//3+1):
  f=[R.zero() for i in range(3)];f[char]=x**a;eta_basis.append(f)
assert len(eta_basis)==7
def coords(v):return [int(a) for a in v.polynomial().list()]
def encoded(g):return [coords(v) for v in g.list()]
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');records=[]
fibers=[code(8)] if not args.all_patterns else [code(8),next(r for r in roots if r!=code(8))]
for r0 in fibers:
 others=[r for r in roots if r!=r0];yb0=cubes(r0)[0];gammaf=K(r0)*yb0
 choices=[(cubes(others[0])[0],cubes(others[1])[0])] if not args.all_patterns else [(a,b) for a in cubes(others[0]) for b in cubes(others[1])]
 for yc1,yc2 in choices:
  gammac=R.lagrange_polynomial([(others[0],K(others[0])*yc1),(others[1],K(others[1])*yc2)])
  assert gammac.degree()==1
  D1=R(-2*gammaf)
  B0=-2*R.lagrange_polynomial([(r0,K(r0)*yb0**2),(others[0],-gammaf*yc1-K(others[0])*yc1**2),(others[1],-gammaf*yc2-K(others[1])*yc2**2)])
  C0=R.lagrange_polynomial([(r0,-gammac(r0)*yb0-K(r0)*yb0**2),(others[0],K(others[0])*yc1**2),(others[1],K(others[1])*yc2**2)])
  poles=[(r0,y) for y in cubes(r0) if K(r0)*y*y+gammac(r0)*y+C0(r0)!=0]+[(others[0],yc1),(others[1],yc2)]
  assert len(poles) in [3,4] and (r0,yb0) not in poles
  Nb=[B0,D1,-2*K];Ne0=scale(add(pi(Nb,1),pi([d,R.zero(),R.zero()],2)),-E.one())
  Nbcols=[[R.zero() for i in range(3)] for i in range(7)]+[[d,R.zero(),R.zero()],[d*x,R.zero(),R.zero()]]
  Necols=eta_basis+[scale(pi(f,1),-E.one()) for f in Nbcols[7:]]
  baserows=[];baserhs=[]
  for degree in [9,8]:
   baserows.append([E.zero()]*7+[((Z*d)%P)[degree],((Z*d*x)%P)[degree]]);baserhs.append(-((Z*B0)%P)[degree])
  for r,y in poles:
   baserows.append([ev(f,r,y) for f in Necols]);baserhs.append(-ev(Ne0,r,y))
  for omitted in (aroots if args.all_patterns else aroots[:1]):
   if args.all_patterns and not records:
    previous=json.loads((folder/'source_e_q3_pole4_prototype.json').read_text())
    assert previous['records'][0]['consistent_strata']==0
    records.append(previous['records'][0]);continue
   endpoints=[(r,y) for r in aroots if r!=omitted for y in cubes(r)]
   crows=[];crhs=[];erows=[];erhs=[]
   for r,y in endpoints:
    aa=Z(r)/y
    crows.append([d(r),d(r)*r]);crhs.append(d(r)*aa-K(r)*y*y-gammac(r)*y-C0(r))
    erows.append([ev(n,r,y)+aa*ev(b,r,y) for n,b in zip(Necols,Nbcols)])
    erhs.append(-ev(Ne0,r,y)-aa*ev(Nb,r,y)-aa**2*d(r))
   strata=[]
   for size in range(10):
    for hit in combinations(range(9),size):
     M=matrix(E,[crows[i] for i in hit],ncols=2);rhs=vector(E,[crhs[i] for i in hit]);aug=M.augment(rhs.column())
     if M.rank()!=aug.rank():continue
     outside=[i for i in range(9) if i not in hit]
     N=matrix(E,baserows+[erows[i] for i in outside]);right=vector(E,baserhs+[erhs[i] for i in outside]);Naug=N.augment(right.column())
     rank=N.rank();arank=Naug.rank()
     strata.append({'zero_indices':list(hit),'rank':int(rank),'augmented_rank':int(arank),'consistent':rank==arank})
   records.append({'b_single_fiber':coords(r0),'c_single_sheets':[coords(yc1),coords(yc2)],'omitted':coords(omitted),'c_poles':[[coords(r),coords(y)] for r,y in poles],'gammac':encoded(gammac),'B0':encoded(B0),'C0':encoded(C0),'feasible_c_strata':len(strata),'max_c_zeros':max(len(s['zero_indices']) for s in strata),'consistent_strata':sum(s['consistent'] for s in strata),'strata':strata})
   out={'scope':'Source-only fixed-q3 rational critical c pole4; b pole3, e<=4, all selected c-zero subsets, two remainder gap rows. No annihilator input.','all_patterns':args.all_patterns,'field_modulus':[int(v) for v in E.modulus().list()],'beta':coords(beta),'records':records,'seconds':time.monotonic()-started,'sage_version':version()}
   (folder/('source_e_q3_pole4_complete.json' if args.all_patterns else 'source_e_q3_pole4_prototype.json')).write_text(json.dumps(out,indent=2,default=int)+'\n')
   print('source-e pole4',len(records),'maxJ',records[-1]['max_c_zeros'],'consistent',records[-1]['consistent_strata'],'seconds',time.monotonic()-started,flush=True)
signal.setitimer(signal.ITIMER_REAL,0)
