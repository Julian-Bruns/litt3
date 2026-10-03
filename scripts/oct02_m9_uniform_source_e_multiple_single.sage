#!/usr/bin/env sage
"""NEW source-e10 on the cubic/sextic G-collision strata, hard15s."""
import json,time,signal,argparse
from pathlib import Path
from itertools import combinations
parser=argparse.ArgumentParser();parser.add_argument('--all-patterns',action='store_true');args=parser.parse_args();started=time.monotonic();signal.signal(signal.SIGALRM,lambda s,f:(_ for _ in ()).throw(TimeoutError('multiple singleton source-e hard15s')));signal.setitimer(signal.ITIMER_REAL,15)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');fd=json.loads((folder/'source_e_repeated_prototype.json').read_text());data=json.loads((folder/'critical_G_collision_support.json').read_text());R5=PolynomialRing(GF(5),'t');E=GF(5**72,'e',modulus=R5(fd['field_modulus']));R=PolynomialRing(E,'x');x=R.gen();beta=E(fd['beta'])
def code(c):return E(c%5)+E(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
P=poly([11,22,18,5,19,20,15,16,9,22,1]);Z=poly([15,19,24,12,10,19,3,24,18,16]);A=poly([1,21,14,22,13]);q=poly([13,18,24]);q3=poly([1,22,9,1]);aroots=A.roots(multiplicities=False)
def cubes(r):return (x**3-P(r)).roots(multiplicities=False)
def add(f,g):return [f[i]+g[i] for i in range(3)]
def scale(f,c):return [c*h for h in f]
def ev(f,r,y):return sum((f[i](r)*y**i for i in range(3)),E.zero())
def pi(f,n):
 result=[R.zero()]*3
 for char,h in enumerate(f):
  quotient,target=divmod(char-n,3);raw=Z**n*h;result[target]+=raw*P**quotient if quotient>=0 else raw.quo_rem(P**(-quotient))[0]
 return result
eta=[]
for char in range(2):
 for a in range((14-10*char)//3+1):
  f=[R.zero()]*3;f[char]=x**a;eta.append(f)
def coords(v):return [int(c) for c in v.polynomial().list()]
def encoded(g):return [coords(v) for v in g.list()]
records=[];output=folder/('source_e_multiple_single_complete.json' if args.all_patterns else 'source_e_multiple_single_prototype.json')
for stored in (data['factors'] if args.all_patterns else data['factors'][:1]):
 factor=R([E(v[0])+(E(v[1])*beta if len(v)>1 else 0) for v in stored['polynomial']]);lam=factor.roots(multiplicities=False)[0];delta=q3+lam*q;K,rem=(Z*delta).quo_rem(P);assert delta.is_squarefree() and delta.gcd(P*K*A).degree()==0
 roots=delta.roots(multiplicities=False);assert len(roots)==3
 groups={}
 for r in roots:groups.setdefault(K(r)**3*P(r),[]).append(r)
 assert sorted(map(len,groups.values()))==[1,2],'Triple equal-G stratum must be retained'
 singles=next(rs for rs in groups.values() if len(rs)==2);r2=next(rs[0] for rs in groups.values() if len(rs)==1);common=K(singles[0])**3*P(singles[0]);gamma=(x**3-common).roots(multiplicities=False)[0];cy=[gamma/K(r) for r in singles];assert all(y**3==P(r) for r,y in zip(singles,cy))
 for by in (cubes(r2) if args.all_patterns else cubes(r2)[:1]):
  D10=R(-2*K(r2)*by);D11=x-r2
  B00=R.lagrange_polynomial([(r,2*K(r)*y**2-D10(r)*y) for r,y in zip(singles,cy)]+[(r2,-2*K(r2)*by**2)])
  B01=R.lagrange_polynomial([(r,-D11(r)*y) for r,y in zip(singles,cy)]+[(r2,E.zero())])
  C0=R.lagrange_polynomial([(r,K(r)*y**2) for r,y in zip(singles,cy)]+[(r2,-K(r2)*by**2-gamma*by)])
  Nb=[B00,D10,-2*K];alphaNb=[B01,D11,R.zero()];Ne0=scale(add(pi(Nb,1),pi([delta,R.zero(),R.zero()],2)),-E.one());Nbcols=[[R.zero()]*3 for i in range(7)]+[[delta,R.zero(),R.zero()],[delta*x,R.zero(),R.zero()],alphaNb];Necols=eta+[scale(pi(f,1),-E.one()) for f in Nbcols[7:]]
  rows=[[E.zero()]*7+[((Z*delta)%P)[9],((Z*delta*x)%P)[9],((Z*B01)%P)[9]]];rhs=[-((Z*B00)%P)[9]]
  poles=list(zip(singles,cy))+[(r2,y) for y in cubes(r2) if y!=by]
  for r,y in poles:rows.append([ev(f,r,y) for f in Necols]);rhs.append(-ev(Ne0,r,y))
  for omitted in (aroots if args.all_patterns else aroots[:1]):
   if args.all_patterns and not records:
    previous=json.loads((folder/'source_e_multiple_single_prototype.json').read_text());assert previous['records'][0]['consistent_strata']==0;records.append(previous['records'][0]);continue
   endpoints=[(r,y) for r in aroots if r!=omitted for y in cubes(r)];cb={pt:(K(pt[0])*pt[1]**2+C0(pt[0])+gamma*pt[1])/delta(pt[0])-Z(pt[0])/pt[1] for pt in endpoints};zerosets={()}
   for pt in endpoints:zerosets.add(tuple(t for t in endpoints if t[0]==pt[0] and cb[t]==cb[pt]))
   for a,b in combinations(endpoints,2):
    if a[0]==b[0]:continue
    nu=(cb[a]-cb[b])/(b[0]-a[0]);mu=-cb[a]-nu*a[0]
    if nu:zerosets.add(tuple(pt for pt in endpoints if mu+nu*pt[0]+cb[pt]==0))
   erows={};erhs={}
   for pt in endpoints:
    aa=Z(pt[0])/pt[1];erows[pt]=[ev(n,*pt)+aa*ev(b,*pt) for n,b in zip(Necols,Nbcols)];erhs[pt]=-ev(Ne0,*pt)-aa*ev(Nb,*pt)-aa**2*delta(pt[0])
   strata=[]
   for hit in sorted(zerosets,key=lambda h:(len(h),str(h))):
    M=matrix(E,rows+[erows[pt] for pt in endpoints if pt not in hit]);aug=M.augment(vector(E,rhs+[erhs[pt] for pt in endpoints if pt not in hit]).column());rank=M.rank();arank=aug.rank();strata.append({'zero_indices':[endpoints.index(pt) for pt in hit],'rank':int(rank),'augmented_rank':int(arank),'consistent':rank==arank})
   records.append({'parameter_factor_degree':stored['degree'],'lambda':coords(lam),'singleton_roots':[coords(r) for r in singles],'third_root':coords(r2),'gamma':coords(gamma),'third_b_sheet':coords(by),'omitted':coords(omitted),'D10':encoded(D10),'D11':encoded(D11),'B00':encoded(B00),'B01':encoded(B01),'strata':strata,'maxJ':max(map(len,zerosets)),'consistent_strata':sum(z['consistent'] for z in strata)})
   output.write_text(json.dumps({'scope':'NEWsource-only multiple c-single critical-fiber e10 systems on exact cubic/sextic G collision supports. Arbitrary b D1 slope and arbitrary geometric c shifts retained, all selected c-zero strata. No annihilator/cancellation input.','complete':args.all_patterns and len(records)==24,'field_modulus':fd['field_modulus'],'beta':fd['beta'],'records':records,'seconds':time.monotonic()-started},indent=2,default=int)+'\n');print('MULTIsource',len(records),'factor',stored['degree'],'maxJ',records[-1]['maxJ'],'consistent',records[-1]['consistent_strata'],'seconds',time.monotonic()-started,flush=True)
signal.setitimer(signal.ITIMER_REAL,0)
