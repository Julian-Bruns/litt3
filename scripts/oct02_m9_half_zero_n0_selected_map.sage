#!/usr/bin/env sage
"""New fixed 3x2 selected leading map, four omissions, one CPU core."""
import json,time,signal
from pathlib import Path
started=time.monotonic()
signal.signal(signal.SIGALRM,lambda s,f:(_ for _ in ()).throw(TimeoutError('fixed map hard10s')))
signal.setitimer(signal.ITIMER_REAL,10)
E=GF(5**8,'e'); R=PolynomialRing(E,'x'); x=R.gen()
beta=(x*x-x-3).roots(multiplicities=False)[0]
def code(c):return E(c%5)+E(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
def enc(c):return [int(a) for a in E(c).polynomial().list()]
def encp(p):return [enc(c) for c in p.list()]
P=poly([11,22,18,5,19,20,15,16,9,22,1])
Z=poly([15,19,24,12,10,19,3,24,18,16])
A=poly([1,21,14,22,13]);q=poly([13,18,24]);q3=poly([1,22,9,1])
Rq=(Z*q)%P;R3=(Z*q3)%P
roots=A.roots(multiplicities=False);assert len(roots)==4
records=[]
for omitted in roots:
 t=A//(x-omitted)
 cols=[(2*q3*Rq-3*q*R3)%t,(-q*Rq)%t]
 M=matrix(E,[[cols[j][i] for j in range(2)] for i in range(3)])
 minors=[((i,j),M.matrix_from_rows([i,j]).det()) for i in range(3) for j in range(i+1,3)]
 nonzero=[item for item in minors if item[1]]
 rec={'omitted':enc(omitted),'t':encp(t),'matrix':[[enc(c) for c in row] for row in M.rows()],'rank':int(M.rank()),'nonzero_minor_rows':list(nonzero[0][0]) if nonzero else None,'nonzero_minor':enc(nonzero[0][1]) if nonzero else None}
 records.append(rec)
 print('FIXED SELECTED MAP',len(records),'rank',rec['rank'],flush=True)
out=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform/half_zero_n0_selected_leading_map.json')
out.write_text(json.dumps({'scope':'NEW fixed selected leading map on all four omissions; no inverse of delta3 and no selected-critical boundary removed.','field_modulus':[int(c) for c in E.modulus().list()],'beta':enc(beta),'Rq':encp(Rq),'R3':encp(R3),'records':records,'complete':len(records)==4,'all_injective':all(r['rank']==2 for r in records),'seconds':time.monotonic()-started},indent=2)+'\n')
signal.setitimer(signal.ITIMER_REAL,0)
print('DONE',time.monotonic()-started,flush=True)
