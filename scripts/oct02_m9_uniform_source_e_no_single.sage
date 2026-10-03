#!/usr/bin/env sage
"""Source-only ordinary no-C-singleton critical-root probe, all c zero strata."""
import json,time,signal,argparse
from pathlib import Path
from itertools import combinations
ap=argparse.ArgumentParser();ap.add_argument('--all-patterns',action='store_true');args=ap.parse_args()
started=time.monotonic()
def expired(s,f):raise TimeoutError('source-e no-single hard20s')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,20)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
data=json.loads((folder/'no_single_content_complete.json').read_text())
old=json.loads((folder/'same_fiber_zero_parameter_resultants.json').read_text())
proto=json.loads((folder/'no_single_content_quartic_prototype.json').read_text())
R5=PolynomialRing(GF(5),'t');E=GF(5**48,'u',modulus=R5(data['field_modulus']));R=PolynomialRing(E,'x');x=R.gen()
F8=GF(5**8,'v',modulus=R5(old['field_modulus']));emb=F8.hom([E(data['base_generator_image'])],E)
beta=emb(F8(old['beta_coordinates']))
def code(c):return E(c%5)+E(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
P=R([E(c) for c in data['normalized_P']]);Z=R([E(c) for c in data['normalized_Z']]);A=poly([1,21,14,22,13])
aroots=[E(v) for v in data['A_roots']]
def cubes(r):return (x**3-P(r)).roots(multiplicities=False)
def add(f,g):return [f[i]+g[i] for i in range(3)]
def scale(f,c):return [c*h for h in f]
def ev(f,r,y):return sum((f[i](r)*y**i for i in range(3)),E.zero())
def pi(f,n):
 out=[R.zero() for i in range(3)]
 for char,h in enumerate(f):
  quotient,target=divmod(char-n,3);raw=Z**n*h
  out[target]+=raw*P**quotient if quotient>=0 else raw.quo_rem(P**(-quotient))[0]
 return out
eta_basis=[]
for char in range(3):
 for a in range((14-10*char)//3+1):
  f=[R.zero() for i in range(3)];f[char]=x**a;eta_basis.append(f)
def coords(v):return [int(a) for a in v.polynomial().list()]
records=[]
parameters=data['records'] if args.all_patterns else data['records'][:1]
for stored in parameters:
 if args.all_patterns and stored is parameters[0]:
  previous=json.loads((folder/'source_e_no_single_prototype.json').read_text())
  assert len(previous['records'])==1 and previous['records'][0]['consistent_source_e_strata']==0
  records.append(previous['records'][0]);continue
 if 'stored_prototype' in stored:
  delta=R([E(v) for v in proto['delta']]);D1=R([E(v) for v in proto['records'][0]['D1']])
 else:delta=R([E(v) for v in stored['delta']]);D1=R([E(v) for v in stored['D1']])
 K,rem=(Z*delta).quo_rem(P);assert not (D1**3+8*K**3*P)%delta
 assert delta.is_squarefree() and delta.gcd(P*K*A).degree()==0
 B0=(-D1**2/2*K.inverse_mod(delta))%delta
 C00=(-D1**2/4*K.inverse_mod(delta))%delta;C01=(D1/2*K.inverse_mod(delta))%delta
 Nb=[B0,D1,-2*K];Ne0=scale(add(pi(Nb,1),pi([delta,R.zero(),R.zero()],2)),-E.one())
 Nbcols=[[R.zero() for i in range(3)] for i in range(7)]+[[delta,R.zero(),R.zero()],[delta*x,R.zero(),R.zero()]]
 Necols=eta_basis+[scale(pi(f,1),-E.one()) for f in Nbcols[7:]]
 def content(f):
  a=(K*f[1]+D1*f[2]/2)%delta;b=(K**2*f[0]-D1**2*f[2]/4)%delta
  return [a[i] for i in range(3)]+[b[i] for i in range(3)]
 const=content(Ne0);columns=[content(f) for f in Necols]
 baserows=matrix(E,columns).transpose().rows();baserhs=[-v for v in const]
 baserows=list(baserows)+[[E.zero()]*7+[((Z*delta)%P)[9],((Z*delta*x)%P)[9]]];baserhs+=[-((Z*B0)%P)[9]]
 omitted=stored['omitted_A_root_index'];endpoints=[(r,y) for i,r in enumerate(aroots) if i!=omitted for y in cubes(r)]
 crows=[];crhs=[];erows=[];erhs=[]
 for r,y in endpoints:
  aa=Z(r)/y
  crows.append([C01(r)+y,delta(r),delta(r)*r]);crhs.append(delta(r)*aa-K(r)*y*y-C00(r))
  erows.append([ev(n,r,y)+aa*ev(b,r,y) for n,b in zip(Necols,Nbcols)])
  erhs.append(-ev(Ne0,r,y)-aa*ev(Nb,r,y)-aa**2*delta(r))
 strata=[]
 for size in range(10):
  for hit in combinations(range(9),size):
   M=matrix(E,[crows[i] for i in hit],ncols=3);rhs=vector(E,[crhs[i] for i in hit]);aug=M.augment(rhs.column())
   if M.rank()!=aug.rank():continue
   sol=M.solve_right(rhs);ker=M.right_kernel_matrix()
   if sol[2]==0 and all(v[2]==0 for v in ker.rows()):continue
   others=[i for i in range(9) if i not in hit]
   N=matrix(E,baserows+[erows[i] for i in others]);right=vector(E,baserhs+[erhs[i] for i in others]);Naug=N.augment(right.column())
   rank=N.rank();arank=Naug.rank()
   strata.append({'zero_indices':list(hit),'source_e_rank':int(rank),'augmented_rank':int(arank),'consistent':rank==arank})
 records.append({'parameter_factor_degree':stored['parameter_factor_degree'],'omitted_A_root_index':omitted,'feasible_c_strata':len(strata),'max_c_zeros':max(len(s['zero_indices']) for s in strata),'consistent_source_e_strata':sum(s['consistent'] for s in strata),'strata':strata})
 out={'scope':'Source-only ordinary simple no-C-singleton necessary e systems on finite parameter support, arbitrary geometric c/e coefficients, all c-zero subsets with exact c infinity pole3. No annihilator used. Branch/repeated/Kzero boundaries not inherited.','records':records,'all_patterns':args.all_patterns,'seconds':time.monotonic()-started,'sage_version':version()}
 (folder/('source_e_no_single_complete.json' if args.all_patterns else 'source_e_no_single_prototype.json')).write_text(json.dumps(out,indent=2,default=int)+'\n')
 print('source-e noSingle',len(records),'feasible',records[-1]['feasible_c_strata'],'maxJ',records[-1]['max_c_zeros'],'consistent',records[-1]['consistent_source_e_strata'],'seconds',time.monotonic()-started,flush=True)
signal.setitimer(signal.ITIMER_REAL,0)
