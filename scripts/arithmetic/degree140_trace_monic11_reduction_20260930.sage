"""Apply the exact Laurent Bezout combination to the upper trace rows.

Only terms of scale degree at least eight are carried. A vanished upper
row asserts a degree bound, never vanishing of the full polynomial.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'trace_top_reduction.sobj'));b=load(str(root/'trace_leading_bezout.sobj'))
R=d['ring'];H,q=R.gens();Psi=d['Psi'];zero=R.zero();one=R.one();cut=int(d['cutoff'])
pc={0:one}
def ps(n):
 if n not in pc:pc[n]=Psi^n
 return pc[n]
def norm(v):
 N,D=v;D=list(D)
 if not N:return(zero,(0,0,0))
 ex=N.exponents();i=min(e[0] for e in ex);j=min(e[1] for e in ex)
 if i or j:N=R({(e[0]-i,e[1]-j):c for e,c in N.dict().items()});D[0]-=i;D[1]-=j
 return(N,tuple(D))
def add(a,b):
 if not a[0]:return b
 if not b[0]:return a
 D=tuple(max(a[1][i],b[1][i]) for i in range(3))
 def lift(v):
  N,E=v;return N*H^(D[0]-E[0])*q^(D[1]-E[1])*ps(D[2]-E[2])
 return norm((lift(a)+lift(b),D))
def mul(a,b):return norm((a[0]*b[0],tuple(a[1][i]+b[1][i] for i in range(3))))
def neg(a):return(-a[0],a[1])
rows=d['rows'];new={};combination=[]
(hh,qq),cc=next(iter(b['target'].dict().items()));assert hh==0
for idx,W in b['weights'].items():
 den=rows[idx]['coeff'][11][1]
 factor=norm((W/cc,(-den[0],int(qq)-den[1],-den[2])))
 combination.append((int(idx),factor))
 for n,p in rows[idx]['coeff'].items():new[n]=add(new.get(n,(zero,(0,0,0))),mul(factor,p))
assert new[11]==(one,(0,0,0))
new={n:p for n,p in new.items() if p[0]}
pivot=len(rows);rows.append({'label':'global_monic11_combination','coeff':new})
ops=[]
for idx,row in enumerate(rows[:-1]):
 while max(row['coeff'],default=cut-1)>=11:
  deg=max(row['coeff']);factor=row['coeff'][deg];shift=deg-11;ops.append((idx,pivot,shift,factor))
  for n,p in new.items():
   if n+shift<cut:continue
   v=add(row['coeff'].get(n+shift,(zero,(0,0,0))),neg(mul(factor,p)))
   if v[0]:row['coeff'][n+shift]=v
   else:row['coeff'].pop(n+shift,None)
  assert max(row['coeff'],default=cut-1)<deg
 print('reduced',idx,'degree',max(row['coeff'],default=cut-1),'seconds',round(time.time()-start,2),flush=True)
save({'ring':R,'Psi':Psi,'cutoff':cut,'rows':rows,'combination':combination,'operations':ops,
 'parent':'trace_top_reduction.sobj'},str(root/'trace_monic11_reduction'))
report=[]
for row in rows:
 deg=max(row['coeff'],default=cut-1);N,D=row['coeff'].get(deg,(zero,(0,0,0)))
 report.append({'label':row['label'],'degree_or_bound':int(deg),'terms':len(N.dict()),
 'H_degree':int(N.degree(H)),'q_degree':int(N.degree(q)),'denominator':list(map(int,D))})
(root/'trace_monic11_reduction.json').write_text(json.dumps({'rows':report,'seconds':time.time()-start},indent=2)+'\n')
print(json.dumps(report),flush=True)
