"""Find low-degree monic combinations using only exact leading coefficients.

Coefficients live in K[H,q,H^-1,q^-1,Psi^-1].  Only unit pivots are
divided by.  Lower coefficients are deliberately not expanded: a row
whose displayed part vanishes has degree below the cutoff, not value0.
The operation log recovers each full trace combination from the inputs.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);cut=int(sys.argv[2]) if len(sys.argv)>2 else 8
names=['global_multiplied','global_positive','global_companion'];start=time.time()
data=[load(str(root/(n+'_rational_coefficients.sobj'))) for n in names]
R=data[0]['ring'];H,q=R.gens();Psi=data[0]['Psi'];zero=R.zero();one=R.one()
powers={0:one}
def ps(n):
 if n not in powers:powers[n]=Psi^n
 return powers[n]
def norm(a):
 N,D=a;D=list(D)
 if not N:return(zero,(0,0,0))
 ee=list(N.dict());i=min(e[0] for e in ee);j=min(e[1] for e in ee)
 if i or j:
  N=R({(e[0]-i,e[1]-j):c for e,c in N.dict().items()});D[0]-=i;D[1]-=j
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
def unit_inverse(a):
 N,D=norm(a);D=list(D)
 if not N:return None
 while len(N.dict())>1:
  z,r=N.quo_rem(Psi)
  if r:return None
  N=z;D[2]-=1
 (i,j),c=next(iter(N.dict().items()))
 return(R(1/c),(int(i-D[0]),int(j-D[1]),int(-D[2])))

rows=[]
for name,d in zip(names,data):
 for j in range(3):
  coeff={int(n):(R(N),tuple(map(int,D))) for jj,n,N,D in d['coefficients'] if jj==j and n>=cut and N}
  rows.append({'label':name+':'+str(j),'coeff':coeff})
del data
ops=[];pivots=[];used=set();rounds=[]
def degree(row):return max(row['coeff'],default=cut-1)
def summary(row):
 dd=degree(row);N,D=row['coeff'].get(dd,(zero,(0,0,0)))
 return {'label':row['label'],'degree_or_upper_bound':dd,'leading_terms':len(N.dict()),
  'leading_degrees':[int(N.degree(H)),int(N.degree(q))] if N else None,
  'denominator':list(map(int,D)),'below_cutoff':dd<cut}

while True:
 available=[]
 for i,row in enumerate(rows):
  if i in used:continue
  d=degree(row)
  if d<cut:continue
  ui=unit_inverse(row['coeff'][d])
  if ui is not None:available.append((d,len(row['coeff'][d][0].dict()),i,ui))
 if not available:break
 deg,_,idx,ui=min(available);used.add(idx);pivots.append({'row':idx,'degree':deg,'inverse':ui})
 print('unit pivot',rows[idx]['label'],deg,'seconds',round(time.time()-start,2),flush=True)
 for j,row in enumerate(rows):
  if j==idx:continue
  while degree(row)>=deg:
   top=degree(row);fac=mul(row['coeff'][top],ui);shift=top-deg
   ops.append((j,idx,shift,fac))
   for n,p in rows[idx]['coeff'].items():
    if n+shift<cut:continue
    val=add(row['coeff'].get(n+shift,(zero,(0,0,0))),neg(mul(fac,p)))
    if val[0]:row['coeff'][n+shift]=val
    else:row['coeff'].pop(n+shift,None)
   assert degree(row)<top
  print('reduced',summary(row),flush=True)
 rounds.append({'pivot':idx,'degree':deg,'rows':[summary(r) for r in rows]})
 save({'ring':R,'Psi':Psi,'cutoff':cut,'rows':rows,'operations':ops,'pivots':pivots,'rounds':rounds},str(root/'trace_top_reduction'))
 # Previously used pivots were reduced too and may now provide lower units.
 used={idx}
 if len(pivots)>30:raise RuntimeError('unexpected nondecreasing reduction')

save({'ring':R,'Psi':Psi,'cutoff':cut,'rows':rows,'operations':ops,'pivots':pivots,'rounds':rounds},str(root/'trace_top_reduction'))
answer={'scope':'exact leading-unit reductions, not a common-zero decision','cutoff':cut,
 'pivot_degrees':[int(x['degree']) for x in pivots],'operation_count':len(ops),
 'rows':[summary(r) for r in rows],'seconds':time.time()-start}
(root/'trace_top_reduction.json').write_text(json.dumps(answer,indent=2)+'\n')
print(json.dumps(answer),flush=True)
