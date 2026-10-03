#!/usr/bin/env sage
"""New selected-only affine obstruction diagnostic, no critical e rows."""
import json,time
from pathlib import Path
task_started=time.monotonic();folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
stored=json.loads((folder/'source_e_q3_prototype.json').read_text());R5=PolynomialRing(GF(5),'t')
E=GF(5**24,'e',modulus=R5(stored['field_modulus']));beta=E(stored['beta']);R=PolynomialRing(E,'x');x=R.gen()
def code(c):return E(c%5)+E(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
P=poly([11,22,18,5,19,20,15,16,9,22,1]);A=poly([1,21,14,22,13]);Z=poly([15,19,24,12,10,19,3,24,18,16]);d=poly([1,22,9,1]);K,rem=(Z*d).quo_rem(P)
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
r=stored['records'][0];B0=R([E(v) for v in r['B0']]);D1=R([E(v) for v in r['D1']]);omitted=E(r['omitted'])
Nb=[B0,D1,-2*K];Ne0=scale(add(pi(Nb,1),pi([d,R.zero(),R.zero()],2)),-E.one())
Nbcols=[[R.zero() for i in range(3)] for i in range(7)]+[[d,R.zero(),R.zero()],[d*x,R.zero(),R.zero()]]
Necols=eta_basis+[scale(pi(f,1),-E.one()) for f in Nbcols[7:]]
endpoints=[(s,y) for s in A.roots(multiplicities=False) if s!=omitted for y in cubes(s)]
erows=[];erhs=[]
for s,y in endpoints:
 aa=Z(s)/y;erows.append([ev(n,s,y)+aa*ev(b,s,y) for n,b in zip(Necols,Nbcols)]);erhs.append(-ev(Ne0,s,y)-aa*ev(Nb,s,y)-aa**2*d(s))
gaprow=[E.zero()]*7+[((Z*d)%P)[9],((Z*d*x)%P)[9]];gaprhs=-((Z*B0)%P)[9]
records=[]
for stratum in r['strata']:
 hit=stratum['zero_indices'];outside=[i for i in range(9) if i not in hit]
 M=matrix(E,[gaprow]+[erows[i] for i in outside]);rhs=vector(E,[gaprhs]+[erhs[i] for i in outside]);aug=M.augment(rhs.column())
 records.append({'zero_indices':hit,'rank':int(M.rank()),'augmented_rank':int(aug.rank()),'consistent':M.rank()==aug.rank()})
out={'scope':'New selected e zero plus gap17 subsystem only at one fixed-q3 prototype; all37 c-zero strata. Critical e-content rows omitted.','records':records,'consistent':sum(r['consistent'] for r in records),'seconds':time.monotonic()-task_started}
(folder/'source_e_selected_compression_prototype.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
print('selected-only consistent',out['consistent'],'of',len(records),'ranks',sorted(set((r['rank'],r['augmented_rank']) for r in records)),'seconds',out['seconds'])
