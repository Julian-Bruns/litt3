#!/usr/bin/env sage
"""NEW Hermite/jet source-e tests for repeated critical c3, hard45s."""
import json,time,signal,argparse
from pathlib import Path
from itertools import combinations
parser=argparse.ArgumentParser();parser.add_argument('--all-patterns',action='store_true');args=parser.parse_args()
started=time.monotonic();signal.signal(signal.SIGALRM,lambda s,f:(_ for _ in ()).throw(TimeoutError('repeat source-e hard45s')));signal.setitimer(signal.ITIMER_REAL,45)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
previous=json.loads((folder/'source_e_repeated_prototype.json').read_text()) if args.all_patterns else None
# The degree-three repeated-root orbit lies over F5^6; its cubes need
# F5^18, while selected cubes need F5^24. Their compositum is F5^72.
R5=PolynomialRing(GF(5),'t');E=GF(5**72,'e',modulus=R5(previous['field_modulus']) if previous else 'random');R=PolynomialRing(E,'x');x=R.gen();beta=E(previous['beta']) if previous else (x*x-x-3).roots(multiplicities=False)[0]
def code(c):return E(c%5)+E(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
P=poly([11,22,18,5,19,20,15,16,9,22,1]);Z=poly([15,19,24,12,10,19,3,24,18,16]);A=poly([1,21,14,22,13]);q=poly([13,18,24]);q3=poly([1,22,9,1]);repeat=q3.derivative()*q-q3*q.derivative();aroots=A.roots(multiplicities=False)
def cubes(r):return (x**3-P(r)).roots(multiplicities=False)
def yd(r,y):return P.derivative()(r)*y/(3*P(r))
def add(f,g):return [f[i]+g[i] for i in range(3)]
def scale(f,c):return [c*h for h in f]
def ev(f,r,y):return sum((f[i](r)*y**i for i in range(3)),E.zero())
def derivative(f,r,y):return sum((f[j].derivative()(r)*y**j+(j*f[j](r)*y**(j-1)*yd(r,y) if j else 0) for j in range(3)),E.zero())
def pi(f,n):
 result=[R.zero() for i in range(3)]
 for char,h in enumerate(f):
  quotient,target=divmod(char-n,3);raw=Z**n*h
  result[target]+=raw*P**quotient if quotient>=0 else raw.quo_rem(P**(-quotient))[0]
 return result
def hermite(r,s,value,slope,last):return value+slope*(x-r)+(last-value-slope*(s-r))/(s-r)**2*(x-r)**2
eta=[]
for char in range(2):
 for a in range((14-10*char)//3+1):
  f=[R.zero()]*3;f[char]=x**a;eta.append(f)
def coords(v):return [int(c) for c in v.polynomial().list()]
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');output=folder/('source_e_repeated_complete.json' if args.all_patterns else 'source_e_repeated_prototype.json');records=[];parameters=[]
for r in repeat.roots(multiplicities=False):
 lam=-q3(r)/q(r);delta=q3+lam*q;assert not delta(r) and not delta.derivative()(r)
 assert delta.factor()[0][1] in [1,2]
 simple=delta//(x-r)**2;assert simple.degree()==1;s=-simple[0]/simple[1];assert s!=r
 K,rem=(Z*delta).quo_rem(P);assert delta.gcd(P*K*A).degree()==0
 assert K(r)**3*P(r)!=K(s)**3*P(s),'Additional distinct critical singleton collision must be retained'
 parameters.append((r,s,lam,delta,K))
assert len(parameters)==4
for r,s,lam,delta,K in (parameters if args.all_patterns else parameters[:1]):
 profiles=[]
 # A: repeated c-double / b-single, simple c-single. Fix repeated b
 # sheet by diagonal C3, and retain all three relative simple c sheets.
 br=cubes(r)[0]
 for cs in (cubes(s) if args.all_patterns else cubes(s)[:1]):profiles.append(('repeat_c_double',br,cs,None))
 # B: repeated tied c-single/b-single. Fix c sheet and retain two
 # distinct b sheets and all three relative simple b sheets.
 if args.all_patterns:
  cr=cubes(r)[0]
  for br in cubes(r):
   if br==cr:continue
   for bs in cubes(s):profiles.append(('repeat_tied_singles',br,bs,cr))
 for kind,br,other,cr in profiles:
  if kind=='repeat_c_double':
   cs=other;gamma=K(s)*cs;D1=-2*K(r)*br-2*(K.derivative()(r)*br+K(r)*yd(r,br))*(x-r)
   B0=hermite(r,s,-2*K(r)*br**2,-2*(K.derivative()(r)*br**2+2*K(r)*br*yd(r,br)),2*K(s)*cs**2-D1(s)*cs)
   C0=hermite(r,s,-K(r)*br**2-gamma*br,-K.derivative()(r)*br**2-2*K(r)*br*yd(r,br)-gamma*yd(r,br),K(s)*cs**2)
   conditions=[('value',s,cs)]+[(t,r,y) for y in cubes(r) if y!=br for t in ['value','derivative']]
  else:
   bs=other;gamma=K(r)*cr;D1=R.lagrange_polynomial([(r,-2*K(r)*br),(s,-2*K(s)*bs)])
   C0=hermite(r,s,K(r)*cr**2,-K.derivative()(r)*br**2-2*K(r)*br*yd(r,br)-gamma*yd(r,br),-K(s)*bs**2-gamma*bs)
   B0=hermite(r,s,-2*K(r)*br**2,2*K.derivative()(r)*cr**2+4*K(r)*cr*yd(r,cr)-D1.derivative()(r)*cr-D1(r)*yd(r,cr),-2*K(s)*bs**2)
   third=next(y for y in cubes(r) if y not in [cr,br]);Nc=[C0,R(gamma),K];assert ev(Nc,r,third)==0 and derivative(Nc,r,third)!=0
   conditions=[('value',r,cr),('derivative',r,cr),('value',r,third)]+[('value',s,y) for y in cubes(s) if y!=bs]
  Nb=[B0,D1,-2*K];Ne0=scale(add(pi(Nb,1),pi([delta,R.zero(),R.zero()],2)),-E.one());Nbcols=[[R.zero()]*3 for i in range(7)]+[[delta,R.zero(),R.zero()],[delta*x,R.zero(),R.zero()]];Necols=eta+[scale(pi(f,1),-E.one()) for f in Nbcols[7:]]
  rows=[[E.zero()]*7+[((Z*delta)%P)[9],((Z*delta*x)%P)[9]]];rhs=[-((Z*B0)%P)[9]]
  for t,rr,yy in conditions:
   fun=ev if t=='value' else derivative;rows.append([fun(f,rr,yy) for f in Necols]);rhs.append(-fun(Ne0,rr,yy))
  for omitted in (aroots if args.all_patterns else aroots[:1]):
   if args.all_patterns and not records:
    previous=json.loads((folder/'source_e_repeated_prototype.json').read_text());assert previous['records'][0]['consistent_strata']==0;records.append(previous['records'][0]);continue
   endpoints=[(a,y) for a in aroots if a!=omitted for y in cubes(a)];cb={pt:(K(pt[0])*pt[1]**2+C0(pt[0])+gamma*pt[1])/delta(pt[0])-Z(pt[0])/pt[1] for pt in endpoints};zerosets={()}
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
   records.append({'repeat_x':coords(r),'simple_x':coords(s),'lambda':coords(lam),'profile':kind,'b_repeat_sheet':coords(br),'other_sheet':coords(other),'c_repeat_sheet':coords(cr) if cr is not None else None,'omitted':coords(omitted),'strata':strata,'maxJ':max(map(len,zerosets)),'consistent_strata':sum(z['consistent'] for z in strata)})
   output.write_text(json.dumps({'scope':'NEWsource-only repeated c3 Hermite/jet e9 systems, all geometric selected root zero strata, both repeated c-double/simple-c-single and repeated tied-c/b-single/simple-c-double profiles. Strong singleton jet exclusion is scoped separately.','complete':args.all_patterns and len(records)==144,'field_modulus':[int(c) for c in E.modulus().list()],'beta':coords(beta),'records':records,'seconds':time.monotonic()-started},indent=2,default=int)+'\n');print('REPEATsource',len(records),kind,'maxJ',records[-1]['maxJ'],'consistent',records[-1]['consistent_strata'],'seconds',time.monotonic()-started,flush=True)
signal.setitimer(signal.ITIMER_REAL,0)
