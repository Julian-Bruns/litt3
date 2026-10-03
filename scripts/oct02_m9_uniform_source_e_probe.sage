#!/usr/bin/env sage
"""New critical constant-coefficient necessary system; no U(c)=0 input."""
import json,time,signal,argparse
from pathlib import Path
from itertools import combinations
ap=argparse.ArgumentParser();ap.add_argument('--all-patterns',action='store_true');ap.add_argument('--small-root',action='store_true');args=ap.parse_args()
started=time.monotonic()
def expired(s,f):raise TimeoutError('source-e new probe hard50s')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,50)
E=GF(5**24,'e');R=PolynomialRing(E,'x');x=R.gen()
beta=(x*x-x-3).roots(multiplicities=False)[0]
def code(c):return E(c%5)+E(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
P=poly([11,22,18,5,19,20,15,16,9,22,1]);A=poly([1,21,14,22,13])
Z=poly([15,19,24,12,10,19,3,24,18,16]);d=poly([1,22,9,1]);K,rem=(Z*d).quo_rem(P)
roots=d.roots(multiplicities=False);aroots=A.roots(multiplicities=False)
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
e_numerator_bound=16 if args.small_root else 14
for char in range(3):
 for a in range((e_numerator_bound-10*char)//3+1):
  f=[R.zero() for i in range(3)];f[char]=x**a;eta_basis.append(f)
eta_dim=len(eta_basis);assert eta_dim==(9 if args.small_root else 7)
def coords(v):return [int(a) for a in v.polynomial().list()]
def encoded(g):return [coords(v) for v in g.list()]
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');records=[]
fibers=[code(8)] if not args.all_patterns else [code(8),next(r for r in roots if r!=code(8))]
for r0 in fibers:
 others=[r for r in roots if r!=r0];yc=cubes(r0)[0];gamma=K(r0)*yc
 choices=[(cubes(others[0])[0],cubes(others[1])[0])] if not args.all_patterns else [(a,b) for a in cubes(others[0]) for b in cubes(others[1])]
 for yb1,yb2 in choices:
  D1=R.lagrange_polynomial([(others[0],-2*K(others[0])*yb1),(others[1],-2*K(others[1])*yb2)])
  B0=R.lagrange_polynomial([(r0,2*K(r0)*yc**2-D1(r0)*yc),(others[0],-2*K(others[0])*yb1**2),(others[1],-2*K(others[1])*yb2**2)])
  C0=R.lagrange_polynomial([(r0,K(r0)*yc**2),(others[0],-gamma*yb1-K(others[0])*yb1**2),(others[1],-gamma*yb2-K(others[1])*yb2**2)])
  Nb=[B0,D1,-2*K]
  Ne0=scale(add(pi(Nb,1),pi([d,R.zero(),R.zero()],2)),-E.one())
  Nbcols=[[R.zero() for i in range(3)] for i in range(eta_dim)]+[[d,R.zero(),R.zero()],[d*x,R.zero(),R.zero()]]
  Necols=eta_basis+[scale(pi(f,1),-E.one()) for f in Nbcols[eta_dim:]]
  poles=[(r0,yc)]+[(others[0],y) for y in cubes(others[0]) if y!=yb1]+[(others[1],y) for y in cubes(others[1]) if y!=yb2]
  # The gap17 remainder of a*Nb has coefficient rem(Z*B4,P)[9].
  base_rows=[[E.zero()]*eta_dim+[((Z*d)%P)[9],((Z*d*x)%P)[9]]]
  base_rhs=[-((Z*B0)%P)[9]]
  for r,y in poles:
   base_rows.append([ev(f,r,y) for f in Necols]);base_rhs.append(-ev(Ne0,r,y))
  omissions=aroots if args.all_patterns else aroots[:1]
  for omitted in omissions:
   if args.all_patterns and args.small_root and not records:
    previous=json.loads((folder/'source_e_q3_small_prototype.json').read_text())
    assert previous['small_root'] and len(previous['records'])==1 and previous['records'][0]['consistent_strata']==0
    assert previous['records'][0]['c_fiber']==coords(r0) and previous['records'][0]['omitted']==coords(omitted)
    records.append(previous['records'][0]);continue
   endpoints=[(r,y) for r in aroots if r!=omitted for y in cubes(r)]
   cbase={pt:(K(pt[0])*pt[1]**2+C0(pt[0])+gamma*pt[1])/d(pt[0])-Z(pt[0])/pt[1] for pt in endpoints}
   zerosets={()};zerosets.update((pt,) for pt in endpoints)
   if args.small_root:
    zerosets={()}|{tuple(pt for pt in endpoints if cbase[pt]==value) for value in cbase.values()}
   else:
    for u,w in combinations(endpoints,2):
     if u[0]==w[0]:assert cbase[u]!=cbase[w];continue
     nu=(cbase[u]-cbase[w])/(w[0]-u[0]);mu=-cbase[u]-nu*u[0]
     if not nu:continue
     zerosets.add(tuple(pt for pt in endpoints if mu+nu*pt[0]+cbase[pt]==0))
    assert max(map(len,zerosets))<=2
   endpointrows={};endpointrhs={}
   for pt in endpoints:
    r,y=pt;aa=Z(r)/y
    endpointrows[pt]=[ev(nc,r,y)+aa*ev(bc,r,y) for nc,bc in zip(Necols,Nbcols)]
    endpointrhs[pt]=-ev(Ne0,r,y)-aa*ev(Nb,r,y)-aa**2*d(r)
   strata=[]
   for hit in sorted(zerosets,key=lambda h:(len(h),str(h))):
    rows=base_rows+[endpointrows[pt] for pt in endpoints if pt not in hit]
    rhs=base_rhs+[endpointrhs[pt] for pt in endpoints if pt not in hit]
    M=matrix(E,rows);aug=M.augment(vector(E,rhs).column());rank=M.rank();arank=aug.rank()
    strata.append({'zero_indices':[endpoints.index(pt) for pt in hit],'rank':int(rank),'augmented_rank':int(arank),'consistent':rank==arank})
   records.append({'c_fiber':coords(r0),'b_sheets':[coords(yb1),coords(yb2)],'omitted':coords(omitted),'D1':encoded(D1),'B0':encoded(B0),'C0':encoded(C0),'strata':strata,'consistent_strata':sum(s['consistent'] for s in strata)})
   print('source-e',len(records),'consistent',records[-1]['consistent_strata'],'of',len(strata),'seconds',time.monotonic()-started,flush=True)
   out={'scope':'Necessary source-e affine consistency at fixed q3; no critical numerator cancellation or annihilator equation imposed. Distinguished b support1/2 both retained by imposing only c-pole zeros.','small_root':args.small_root,'e_numerator_bound':e_numerator_bound,'all_patterns':args.all_patterns,'field_modulus':[int(c) for c in E.modulus().list()],'beta':coords(beta),'records':records,'seconds':time.monotonic()-started,'sage_version':version()}
   stem='source_e_q3_small' if args.small_root else 'source_e_q3'
   (folder/(stem+('_complete.json' if args.all_patterns else '_prototype.json'))).write_text(json.dumps(out,indent=2,default=int)+'\n')
signal.setitimer(signal.ITIMER_REAL,0)
