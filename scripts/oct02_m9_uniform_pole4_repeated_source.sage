#!/usr/bin/env sage
"""NEW pole4 repeated critical Hermite/source-e9 systems, hard45s."""
import json,time,signal,argparse
from pathlib import Path
from itertools import combinations
parser=argparse.ArgumentParser();parser.add_argument('--all-patterns',action='store_true');parser.add_argument('--gap-only',action='store_true');args=parser.parse_args()
started=time.monotonic();folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');output=folder/('pole4_repeated_gap.json' if args.gap_only else 'pole4_repeated_source_complete.json' if args.all_patterns else 'pole4_repeated_source_prototype.json');records=[];stages=[]
out={'scope':'NEW source-only pole4 repeated critical Hermite tests. Full gap17/14, e_f local integrality, all geometric selected c-zero strata with unrestricted shifts; tied lower c poles retained by actual derivative.','records':records,'stages':stages}
def save():out['seconds']=time.monotonic()-started;output.write_text(json.dumps(out,indent=2,default=int)+'\n')
def expired(s,f):out['hard_timeout']=True;save();raise TimeoutError('pole4 repeated source hard45s')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,45)
previous=json.loads((folder/'source_e_repeated_prototype.json').read_text());R5=PolynomialRing(GF(5),'t');E=GF(5**72,'e',modulus=R5(previous['field_modulus']));R=PolynomialRing(E,'x');x=R.gen();beta=E(previous['beta'])
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
 result=[R.zero()]*3
 for char,h in enumerate(f):
  quotient,target=divmod(char-n,3);raw=Z**n*h;result[target]+=raw*P**quotient if quotient>=0 else raw.quo_rem(P**(-quotient))[0]
 return result
def hermite(r,s,value,slope,last):return value+slope*(x-r)+(last-value-slope*(s-r))/(s-r)**2*(x-r)**2
def coords(v):return [int(c) for c in v.polynomial().list()]
eta=[]
for char in range(2):
 for a in range((13-10*char)//3+1):
  f=[R.zero()]*3;f[char]=x**a;eta.append(f)
parameters=[]
for r in repeat.roots(multiplicities=False):
 lam=-q3(r)/q(r);delta=q3+lam*q;simple=delta//(x-r)**2;s=-simple[0]/simple[1];K=(Z*delta).quo_rem(P)[0]
 assert delta(r)==delta.derivative()(r)==0 and simple.degree()==1 and s!=r and delta.gcd(P*K*A).degree()==0
 assert K(r)**3*P(r)!=K(s)**3*P(s)
 parameters.append((r,s,lam,delta,K))
assert len(parameters)==4
completed_keys=set()
if args.all_patterns and not args.gap_only:
 proto=folder/'pole4_repeated_source_prototype.json'
 if proto.exists():
  prev=json.loads(proto.read_text())
  if prev.get('complete'):
   records.extend(prev['records']);completed_keys.update(z['key'] for z in prev['records'])
for parameter_index,(r,s,lam,delta,K) in enumerate(parameters if args.all_patterns or args.gap_only else parameters[:1]):
 profiles=[];cr=cubes(r)[0]
 # A: repeat b-double/c-single. Its complementary c numerator has
 # two FULL double zeros, so gamma has the prescribed first jet.
 for bs in cubes(s):profiles.append(('repeat_b_double',cr,bs,None))
 # C: repeat tied c-single/b-single with possible lower c pole.
 for br in cubes(r):
  if br==cr:continue
  for cs in cubes(s):profiles.append(('repeat_tied_singles',cr,cs,br))
 for profile_index,(kind,cr,other,br) in enumerate(profiles if args.all_patterns or args.gap_only else profiles[:1]):
  if kind=='repeat_b_double':
   bs=other;bb=-2*K(s)*bs;gam=K(r)*cr+(K.derivative()(r)*cr+K(r)*yd(r,cr))*(x-r)
   C0=hermite(r,s,K(r)*cr**2,K.derivative()(r)*cr**2+2*K(r)*cr*yd(r,cr),-K(s)*bs**2-gam(s)*bs)
   B0=hermite(r,s,2*K(r)*cr**2-bb*cr,2*K.derivative()(r)*cr**2+4*K(r)*cr*yd(r,cr)-bb*yd(r,cr),-2*K(s)*bs**2)
   Nc=[C0,gam,K];conditions=[('value',r,cr),('derivative',r,cr)]+[('value',s,y) for y in cubes(s) if ev(Nc,s,y)]
  else:
   cs=other;bb=-2*K(r)*br;gam=R.lagrange_polynomial([(r,K(r)*cr),(s,K(s)*cs)])
   C0=hermite(r,s,K(r)*cr**2,-K.derivative()(r)*br**2-2*K(r)*br*yd(r,br)-gam.derivative()(r)*br-gam(r)*yd(r,br),K(s)*cs**2)
   B0=hermite(r,s,-2*K(r)*br**2,2*K.derivative()(r)*cr**2+4*K(r)*cr*yd(r,cr)-bb*yd(r,cr),2*K(s)*cs**2-bb*cs)
   Nc=[C0,gam,K];third=next(y for y in cubes(r) if y not in [cr,br]);assert ev(Nc,r,third)==0
   conditions=[('value',r,cr),('derivative',r,cr),('value',s,cs)]
   if derivative(Nc,r,third):conditions.append(('value',r,third))
  gap17=((Z*B0)%P)[9]
  if args.gap_only:
   records.append({'parameter_index':parameter_index,'profile_index':profile_index,'profile':kind,'gap17':coords(gap17),'gap17_nonzero':bool(gap17),'gamma_slope_nonzero':gam.degree()==1});save();continue
  Nb=[B0,R(bb),-2*K];Ne0=scale(add(pi(Nb,1),pi([delta,R.zero(),R.zero()],2)),-E.one());Nbcols=[[R.zero()]*3 for i in range(7)]+[[delta,R.zero(),R.zero()],[delta*x,R.zero(),R.zero()]];Necols=eta+[scale(pi(f,1),-E.one()) for f in Nbcols[7:]]
  rows=[];rhs=[]
  for j in [9,8]:rows.append([E.zero()]*7+[((Z*delta)%P)[j],((Z*delta*x)%P)[j]]);rhs.append(-((Z*B0)%P)[j])
  for t,rr,yy in conditions:
   fun=ev if t=='value' else derivative;rows.append([fun(f,rr,yy) for f in Necols]);rhs.append(-fun(Ne0,rr,yy))
  for omission_index,omitted in enumerate(aroots if args.all_patterns else aroots[:1]):
   key='%d:%d:%d'%(parameter_index,profile_index,omission_index)
   if key in completed_keys:continue
   if gam.degree()<1:
    records.append({'key':key,'profile':kind,'gamma_slope_drop':True,'excluded_by':'exact pole4 / already proved pole3 exclusion','consistent_strata':0});save();continue
   endpoints=[(a,y) for a in aroots if a!=omitted for y in cubes(a)];cb={pt:(K(pt[0])*pt[1]**2+C0(pt[0])+gam(pt[0])*pt[1])/delta(pt[0])-Z(pt[0])/pt[1] for pt in endpoints};zerosets={()}
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
   records.append({'key':key,'repeat_x':coords(r),'simple_x':coords(s),'lambda':coords(lam),'profile':kind,'c_repeat_sheet':coords(cr),'other_sheet':coords(other),'b_repeat_sheet':coords(br) if br is not None else None,'omitted':coords(omitted),'conditions':[(t,coords(rr),coords(yy)) for t,rr,yy in conditions],'strata':strata,'maxJ':max(map(len,zerosets)),'consistent_strata':sum(z['consistent'] for z in strata)})
   save();print('POLE4repeat',len(records),kind,'consistent',records[-1]['consistent_strata'],'seconds',out['seconds'],flush=True)
   if records[-1]['consistent_strata']:out['stopped']='consistent stratum: inspect';save();signal.setitimer(signal.ITIMER_REAL,0);raise SystemExit(2)
out.update(complete=True,all_inconsistent=all(r.get('consistent_strata',0)==0 for r in records),all_gap17_nonzero=all(r.get('gap17_nonzero',False) for r in records) if args.gap_only else None,field_modulus=[int(c) for c in E.modulus().list()],beta=coords(beta));save();signal.setitimer(signal.ITIMER_REAL,0)
