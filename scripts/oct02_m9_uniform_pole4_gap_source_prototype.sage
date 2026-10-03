#!/usr/bin/env sage
"""NEW pole4 source-e prototype on one exact degree12 gap factor, hard30s."""
import json,time,signal,argparse
from pathlib import Path
from itertools import product,combinations
parser=argparse.ArgumentParser();parser.add_argument('--factor-index',type=int,default=6);parser.add_argument('--omission-index',type=int,default=0);args=parser.parse_args()
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');started=time.monotonic();output=folder/('pole4_gap_source_factor%02d_omit%02d.json'%(args.factor_index,args.omission_index));stages=[];out={'scope':'One NEW pole4 marked-r0 gap-support representative. Full geometric selected c-zero strata, unrestricted source coefficients; no fourth moment or critical cancellation.','stages':stages}
def checkpoint(stage):stages.append({'stage':stage,'seconds':time.monotonic()-started});output.write_text(json.dumps(out,indent=2,default=int)+'\n');print(stage,stages[-1]['seconds'],flush=True)
def expired(s,f):out.update(hard_timeout=True,seconds=time.monotonic()-started);output.write_text(json.dumps(out,indent=2,default=int)+'\n');raise TimeoutError('pole4 large factor source prototype hard30s')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,30)
meta=json.loads((folder/'compact_norm_symbolic_prototype.json').read_text());gap=json.loads((folder/'source_e_pole4_uniform_gap.json').read_text());old=json.loads((folder/'same_fiber_zero_parameter_resultants.json').read_text());R5=PolynomialRing(GF(5),'t');F8=GF(5**8,'v',modulus=R5(meta['field_modulus']));R8=PolynomialRing(F8,'z');z=R8.gen();b8=F8(meta['beta'])
def code8(c):return F8(c%5)+F8(c//5)*b8
def poly8(cs):return R8([code8(c) for c in cs])
P8=poly8([11,22,18,5,19,20,15,16,9,22,1]);Z8=poly8([15,19,24,12,10,19,3,24,18,16]);q8=poly8([13,18,24]);q38=poly8([1,22,9,1]);aroots8=[F8(r['A_root']) for r in old['records']];pbase=P8(aroots8[0]);P8/=pbase;Z8/=pbase;rad=R8([F8(v) for v in gap['numerator']]);rad=rad//rad.gcd(rad.derivative());factors=sorted((f.monic() for f,m in rad.factor()),key=lambda f:(f.degree(),str(f)));factor8=factors[args.factor_index]
fielddegree=48 if factor8.degree()==1 else 576;fieldfile=folder/('pole4_gap_source_field_%d.json'%fielddegree)
if fieldfile.exists():
 fd=json.loads(fieldfile.read_text());E=GF(5**fielddegree,'e',modulus=R5(fd['modulus']));base_image=E(fd['base_generator_image'])
else:
 E=GF(5**fielddegree,'e',modulus='random');RE=PolynomialRing(E,'t');base_image=RE(meta['field_modulus']).roots(multiplicities=False)[0]
 fd={'modulus':[int(c) for c in E.modulus().list()],'base_generator_image':[int(c) for c in base_image.polynomial().list()]};fieldfile.write_text(json.dumps(fd,indent=2)+'\n')
emb=F8.hom([base_image],E);R=PolynomialRing(E,'x');x=R.gen()
def lift(g):return R([emb(v) for v in g.list()])
def coords(v):return [int(c) for c in v.polynomial().list()]
P=lift(P8);Z=lift(Z8);q=lift(q8);q3=lift(q38);aroots=[emb(r) for r in aroots8];checkpoint('native_field_and_embedding')
r0=lift(factor8).roots(multiplicities=False)[0];lam=-q3(r0)/q(r0);delta=q3+lam*q;K=(Z*delta).quo_rem(P)[0];assert delta.is_squarefree() and delta.gcd(P*K).degree()==0 and all(delta(r) for r in aroots)
others=[r for r in delta.roots(multiplicities=False) if r!=r0];assert len(others)==2
def cubes(r):return (x**3-P(r)).roots(multiplicities=False)
y0=cubes(r0)[0];bb=-2*K(r0)*y0;checkpoint('critical_roots_and_singleton_sheet')
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
 for a in range((13-10*char)//3+1):
  f=[R.zero()]*3;f[char]=x**a;eta.append(f)
records=[];gapzero=0;slope_drops=0
for y1,y2 in product(cubes(others[0]),cubes(others[1])):
 B0=R.lagrange_polynomial([(r0,-2*K(r0)*y0**2)]+[(r,2*K(r)*y**2-bb*y) for r,y in zip(others,[y1,y2])])
 if ((Z*B0)%P)[9]:continue
 gapzero+=1;gam=R.lagrange_polynomial([(r,K(r)*y) for r,y in zip(others,[y1,y2])])
 if gam.degree()<1:slope_drops+=1;continue
 C0=R.lagrange_polynomial([(r0,-K(r0)*y0**2-gam(r0)*y0)]+[(r,K(r)*y**2) for r,y in zip(others,[y1,y2])]);Nc=[C0,gam,K];Nb=[B0,R(bb),-2*K];Ne0=scale(add(pi(Nb,1),pi([delta,R.zero(),R.zero()],2)),-E.one());Nbcols=[[R.zero()]*3 for i in range(7)]+[[delta,R.zero(),R.zero()],[delta*x,R.zero(),R.zero()]];Necols=eta+[scale(pi(f,1),-E.one()) for f in Nbcols[7:]]
 poles=[(r0,y) for y in cubes(r0) if ev(Nc,r0,y)]+list(zip(others,[y1,y2]));rows=[];rhs=[]
 for j in [9,8]:rows.append([E.zero()]*7+[((Z*delta)%P)[j],((Z*delta*x)%P)[j]]);rhs.append(-((Z*B0)%P)[j])
 for r,y in poles:rows.append([ev(f,r,y) for f in Necols]);rhs.append(-ev(Ne0,r,y))
 omitted=aroots[args.omission_index];endpoints=[(r,y) for r in aroots if r!=omitted for y in cubes(r)];cb={pt:(K(pt[0])*pt[1]**2+C0(pt[0])+gam(pt[0])*pt[1])/delta(pt[0])-Z(pt[0])/pt[1] for pt in endpoints};zerosets={()}
 for pt in endpoints:zerosets.add(tuple(t for t in endpoints if t[0]==pt[0] and cb[t]==cb[pt]))
 for a,b in combinations(endpoints,2):
  if a[0]==b[0]:continue
  nu=(cb[a]-cb[b])/(b[0]-a[0]);mu=-cb[a]-nu*a[0];zerosets.add(tuple(pt for pt in endpoints if mu+nu*pt[0]+cb[pt]==0))
 erows={};erhs={}
 for pt in endpoints:
  aa=Z(pt[0])/pt[1];erows[pt]=[ev(n,*pt)+aa*ev(b,*pt) for n,b in zip(Necols,Nbcols)];erhs[pt]=-ev(Ne0,*pt)-aa*ev(Nb,*pt)-aa**2*delta(pt[0])
 strata=[]
 for hit in sorted(zerosets,key=lambda h:(len(h),str(h))):
  M=matrix(E,rows+[erows[pt] for pt in endpoints if pt not in hit]);aug=M.augment(vector(E,rhs+[erhs[pt] for pt in endpoints if pt not in hit]).column());rank=M.rank();arank=aug.rank();strata.append({'zero_indices':[endpoints.index(pt) for pt in hit],'rank':int(rank),'augmented_rank':int(arank),'consistent':rank==arank})
 records.append({'relative_c_sheets':[coords(y1),coords(y2)],'c_poles_at_b_singleton':len(poles)-2,'strata':strata,'maxJ':max(map(len,zerosets)),'consistent_strata':sum(v['consistent'] for v in strata)})
 checkpoint('source_system_%d'%len(records))
out.update(complete=True,factor_index=args.factor_index,factor_degree=int(factor8.degree()),omission_index=args.omission_index,field_degree=fielddegree,r0=coords(r0),lambda_value=coords(lam),gap_zero_relative_pairs=gapzero,c_slope_drops=slope_drops,records=records,all_inconsistent=all(r['consistent_strata']==0 for r in records),seconds=time.monotonic()-started)
output.write_text(json.dumps(out,indent=2,default=int)+'\n');signal.setitimer(signal.ITIMER_REAL,0);print('POLE4 GAP source prototype',args.factor_index,'pairs',gapzero,'drops',slope_drops,'inconsistent',out['all_inconsistent'],'seconds',out['seconds'],flush=True)
