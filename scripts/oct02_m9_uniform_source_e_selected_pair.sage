#!/usr/bin/env sage
"""NEW source-e equations on certified selected-double supports, hard45s."""
import json,time,signal,argparse
from pathlib import Path
from itertools import combinations,product
parser=argparse.ArgumentParser();parser.add_argument('--all-patterns',action='store_true');args=parser.parse_args()
started=time.monotonic();signal.signal(signal.SIGALRM,lambda s,f:(_ for _ in ()).throw(TimeoutError('selected-pair source-e hard45s')));signal.setitimer(signal.ITIMER_REAL,45)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');data=json.loads((folder/'same_fiber_zero_parameter_resultants.json').read_text());fd=json.loads((folder/'four_zero_degree8_prototype.json').read_text())
R5=PolynomialRing(GF(5),'t');E8=GF(5**8,'v',modulus=R5(data['field_modulus']));E64=GF(5**64,'u',modulus=R5(fd['absolute_field_modulus']));emb=E8.hom([E64(fd['base_generator_image'])],E64)
beta=emb(E8(data['beta_coordinates']));R64=PolynomialRing(E64,'x');xx=R64.gen()
def code(c):return E64(c%5)+E64(c//5)*beta
def poly(cs):return R64([code(c) for c in cs])
P64=poly([11,22,18,5,19,20,15,16,9,22,1]);Z64=poly([15,19,24,12,10,19,3,24,18,16]);A64=poly([1,21,14,22,13]);q64=poly([13,18,24]);q364=poly([1,22,9,1]);aroots=[emb(E8(d['A_root'])) for d in data['records']];pbase=P64(aroots[0]);P64/=pbase;Z64/=pbase
record=data['records'][1];endpoint=R64([emb(E8(v)) for v in record['endpoint_cubic_zero_factor']]).monic();results=[]
zeta=(xx**2+xx+1).roots(multiplicities=False)[0]
def coords(v):return [int(a) for a in v.polynomial().list()]
def encode(v):return [coords(E64(c)) for c in v.lift().list()] if hasattr(v,'lift') else coords(v)
output=folder/('source_e_selected_pair_complete.json' if args.all_patterns else 'source_e_selected_pair_prototype.json')
for stored in record['factors']:
 factor=R64([emb(E8(v)) for v in stored['polynomial']]).monic()
 if factor==endpoint:continue
 if not args.all_patterns and results:break
 lam=factor.roots(multiplicities=False)[0];delta64=q364+lam*q64;K64,rem64=(Z64*delta64).quo_rem(P64)
 gamma64=-rem64(aroots[1])*(xx**3-P64(aroots[1])).roots(multiplicities=False)[0]/P64(aroots[1]);g=delta64.gcd(K64**3*P64-gamma64**3);assert g.degree()==1
 r0=-g[0]/g[1];yc64=gamma64/K64(r0);assert yc64**3==P64(r0)
 others=[r for r in delta64.roots(multiplicities=False) if r!=r0];assert len(others)==2
 noncube=next(r for r in others if not (xx**3-P64(r)).roots(multiplicities=False))
 C=R64.quotient(xx**3-P64(noncube),'w');assert C.is_field();w=C.gen();R=PolynomialRing(C,'x');x=R.gen()
 def lift(g):return R([C(v) for v in g.list()])
 P=lift(P64);Z=lift(Z64);delta=lift(delta64);K=lift(K64);gamma=C(gamma64);yc=C(yc64)
 root_exponents={}
 def root_y(r):
  for exponent in range(3):
   roots=(xx**3-P64(r)/P64(noncube)**exponent).roots(multiplicities=False)
   if roots:root_exponents[r]=exponent;return C(roots[0])*w**exponent
  raise AssertionError('Cubic residue class missing')
 def cubes(r):
  y=root_y(r);return [y*C(zeta)**j for j in range(3)]
 def add(f,g):return [f[i]+g[i] for i in range(3)]
 def scale(f,c):return [c*h for h in f]
 def ev(f,r,y):return sum((f[i](r)*y**i for i in range(3)),C.zero())
 def pi(f,n):
  result=[R.zero() for i in range(3)]
  for char,h in enumerate(f):
   quotient,target=divmod(char-n,3);raw=Z**n*h
   result[target]+=raw*P**quotient if quotient>=0 else raw.quo_rem(P**(-quotient))[0]
  return result
 eta=[]
 for char in range(2):
  for a in range((14-10*char)//3+1):
   f=[R.zero()]*3;f[char]=x**a;eta.append(f)
 assert len(eta)==7
 cube1,cube2=cubes(others[0]),cubes(others[1]);e1,e2=[root_exponents[r] for r in others]
 unseen=set(product(range(3),repeat=2));orbit_reps=[]
 while unseen:
  a,b=min(unseen);orbit={( (a+k*e1)%3,(b+k*e2)%3) for k in range(3)};assert len(orbit)==3
  orbit_reps.append((a,b));unseen-=orbit
 selections=orbit_reps if args.all_patterns else [(0,0)]
 for sheet1,sheet2 in selections:
  yb1,yb2=cube1[sheet1],cube2[sheet2]
  D1=R.lagrange_polynomial([(C(others[0]),-2*K(others[0])*yb1),(C(others[1]),-2*K(others[1])*yb2)])
  B0=R.lagrange_polynomial([(C(r0),2*K(r0)*yc**2-D1(r0)*yc),(C(others[0]),-2*K(others[0])*yb1**2),(C(others[1]),-2*K(others[1])*yb2**2)])
  C0=R.lagrange_polynomial([(C(r0),K(r0)*yc**2),(C(others[0]),-gamma*yb1-K(others[0])*yb1**2),(C(others[1]),-gamma*yb2-K(others[1])*yb2**2)])
  Nb=[B0,D1,-2*K];Ne0=scale(add(pi(Nb,1),pi([delta,R.zero(),R.zero()],2)),-C.one())
  Nbcols=[[R.zero()]*3 for i in range(7)]+[[delta,R.zero(),R.zero()],[delta*x,R.zero(),R.zero()]]
  Necols=eta+[scale(pi(f,1),-C.one()) for f in Nbcols[7:]]
  poles=[(r0,yc)]+[(others[0],y) for y in cubes(others[0]) if y!=yb1]+[(others[1],y) for y in cubes(others[1]) if y!=yb2]
  baserows=[[C.zero()]*7+[((Z*delta)%P)[9],((Z*delta*x)%P)[9]]];baserhs=[-((Z*B0)%P)[9]]
  for r,y in poles:baserows.append([ev(f,r,y) for f in Necols]);baserhs.append(-ev(Ne0,r,y))
  omitteds=[r for r in aroots if r!=aroots[1]] if args.all_patterns else [aroots[0]]
  for omitted in omitteds:
   if args.all_patterns and stored['degree']==1 and sheet1==sheet2==0 and omitted==aroots[0]:
    previous=json.loads((folder/'source_e_selected_pair_prototype.json').read_text());assert len(previous['records'])==1 and previous['records'][0]['consistent_strata']==0
    results.append(previous['records'][0]);continue
   endpoints=[(r,y) for r in aroots if r!=omitted for y in cubes(r)]
   assert delta.gcd(P*lift(A64)*K).degree()==0
   cb={pt:(K(pt[0])*pt[1]**2+C0(pt[0])+gamma*pt[1])/delta(pt[0])-Z(pt[0])/pt[1] for pt in endpoints}
   zerosets={()}
   for pt in endpoints:zerosets.add(tuple(t for t in endpoints if t[0]==pt[0] and cb[t]==cb[pt]))
   for a,b in combinations(endpoints,2):
    if a[0]==b[0]:continue
    nu=(cb[a]-cb[b])/C(b[0]-a[0]);mu=-cb[a]-nu*C(a[0])
    if nu:zerosets.add(tuple(pt for pt in endpoints if mu+nu*C(pt[0])+cb[pt]==0))
   erows={};erhs={}
   for pt in endpoints:
    r,y=pt;aa=Z(r)/y;erows[pt]=[ev(n,r,y)+aa*ev(b,r,y) for n,b in zip(Necols,Nbcols)];erhs[pt]=-ev(Ne0,r,y)-aa*ev(Nb,r,y)-aa**2*delta(r)
   strata=[]
   for hit in sorted(zerosets,key=lambda h:(len(h),str(h))):
    M=matrix(C,baserows+[erows[pt] for pt in endpoints if pt not in hit]);aug=M.augment(vector(C,baserhs+[erhs[pt] for pt in endpoints if pt not in hit]).column())
    rank=M.rank();arank=aug.rank();strata.append({'zero_indices':[endpoints.index(pt) for pt in hit],'rank':int(rank),'augmented_rank':int(arank),'consistent':rank==arank})
   results.append({'parameter_factor_degree':stored['degree'],'omitted_A_index':aroots.index(omitted),'b_phase_indices':[sheet1,sheet2],'relative_cubic_Frobenius_step':[e1,e2],'b_sheets':[encode(yb1),encode(yb2)],'strata':strata,'maxJ':max(map(len,zerosets)),'consistent_strata':sum(s['consistent'] for s in strata)})
   output.write_text(json.dumps({'scope':'NEWsource-only e9 systems on selected-double Es ordinary factors; arbitrary geometric mu/nu with nu nonzero, all selected zero strata, all critical complementary b sheets via three relative cubic Frobenius orbits. No annihilator or critical cancellation input.','complete':args.all_patterns and len(results)==18,'records':results,'seconds':time.monotonic()-started},indent=2,default=int)+'\n')
   print('PAIRsourceE',len(results),'factor',stored['degree'],'maxJ',results[-1]['maxJ'],'consistent',results[-1]['consistent_strata'],'seconds',time.monotonic()-started,flush=True)
signal.setitimer(signal.ITIMER_REAL,0)
