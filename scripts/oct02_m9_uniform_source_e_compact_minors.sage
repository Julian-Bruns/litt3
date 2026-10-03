#!/usr/bin/env sage
"""New compact selected/gap minors for all fixed-line pole3/4 patterns."""
import json,time,signal
from pathlib import Path
from itertools import combinations
started=time.monotonic()
def expired(s,f):raise TimeoutError('compact source-e minors hard10s')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,10)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
original=json.loads((folder/'source_e_q3_complete.json').read_text());R5=PolynomialRing(GF(5),'t')
E=GF(5**24,'e',modulus=R5(original['field_modulus']));beta=E(original['beta']);R=PolynomialRing(E,'x');x=R.gen()
def code(c):return E(c%5)+E(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
P=poly([11,22,18,5,19,20,15,16,9,22,1]);A=poly([1,21,14,22,13]);Z=poly([15,19,24,12,10,19,3,24,18,16]);d=poly([1,22,9,1])
def cubes(r):return (x**3-P(r)).roots(multiplicities=False)
def coords(v):return [int(c) for c in v.polynomial().list()]
aroots=A.roots(multiplicities=False);Rd=(Z*d)%P;Rdx=(Z*d*x)%P;T=(Z**2*d)%P
output=folder/'source_e_compact_selected_minors.json';parts=folder/'source_e_compact_parts';parts.mkdir(exist_ok=True)
previous=json.loads(output.read_text()) if output.exists() else {'records':[]}
saved={(r['root_pole'],r['source_case_index']):r for r in previous['records']}
for f in parts.glob('case_*.json'):
 r=json.loads(f.read_text());saved[r['root_pole'],r['source_case_index']]=r
records=[]
for pole,filename in [(3,'source_e_q3_complete.json'),(4,'source_e_q3_pole4_complete.json')]:
 data=json.loads((folder/filename).read_text())
 for case,r in enumerate(data['records']):
  if (pole,case) in saved:
   records.append(saved[pole,case]);continue
  B0=R([E(v) for v in r['B0']]);R0=(Z*B0)%P;omitted=E(r['omitted']);ss=[s for s in aroots if s!=omitted]
  points=[(s,y) for s in ss for y in cubes(s)];minors=[]
  for ia,ib in combinations(range(9),2):
   s1,y1=points[ia];s2,y2=points[ib]
   if s1==s2:continue
   s0=next(s for s in ss if s not in [s1,s2]);sx=[s0,s1,s2];ys=[E.zero(),y1,y2]
   ell=[1/prod(sx[i]-sx[j] for j in range(3) if j!=i) for i in range(3)]
   rows=[[Rd(s0)/P(s0),Rdx(s0)/P(s0),-R0(s0)/P(s0)],
         [sum(ell[i]*ys[i]*Rd(sx[i])/P(sx[i]) for i in range(3)),
          sum(ell[i]*ys[i]*Rdx(sx[i])/P(sx[i]) for i in range(3)),
          sum(ell[i]*(T(sx[i])-ys[i]*R0(sx[i]))/P(sx[i]) for i in range(3))]]
   rows.append([Rd[9],Rdx[9],-R0[9]])
   if pole==4:rows.append([Rd[8],Rdx[8],-R0[8]])
   H=matrix(E,rows);rank=H.rank();assert rank>=2
   chosen=[];det=E.zero()
   for idx in combinations(range(len(rows)),3):
    candidate=H.matrix_from_rows(idx).det()
    if candidate:chosen=list(idx);det=candidate;break
   minors.append({'selected_c_zero_indices':[ia,ib],'augmented_rank':int(rank),'minor_rows':chosen,'nonzero_minor':coords(det)})
  records.append({'root_pole':pole,'source_case_index':case,'pair_minors':minors,'all_nonzero':all(m['nonzero_minor'] for m in minors)})
  (parts/('case_%d_%d.json'%(pole,case))).write_text(json.dumps(records[-1],indent=2,default=int)+'\n')
  if not records[-1]['all_nonzero']:print('compactFAIL',pole,case,flush=True)
 out={'scope':'New selected-only 3x3/4x3 source-e augmented minors; all27 cross-fiber c-zero pairs, all72 fixedq3 patterns for each rootpole3/4. No critical e-content rows.','field_modulus':original['field_modulus'],'beta':original['beta'],'records':records,'complete':len(records)==144,'all_nonzero':all(r['all_nonzero'] for r in records),'seconds':time.monotonic()-started}
 output.write_text(json.dumps(out,indent=2,default=int)+'\n')
 print('compact pole',pole,'cases',len(records),'allnonzero',out['all_nonzero'],'seconds',out['seconds'],flush=True)
signal.setitimer(signal.ITIMER_REAL,0)
