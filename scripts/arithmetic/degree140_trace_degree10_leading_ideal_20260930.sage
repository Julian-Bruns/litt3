"""Inspect the next leading ideal before any full elimination.

The ideal is only the coefficient ideal in scale degree ten. Its result
must not be interpreted as a decision of the full trace system.
"""
import sys,time,json
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'trace_monic11_reduction.sobj'));R=d['ring'];H,q=R.gens();Psi=d['Psi']
rows=[]
for i,row in enumerate(d['rows']):
 if max(row['coeff'],default=0)!=10:continue
 N,D=row['coeff'][10];removed=0
 while N:
  z,r=N.quo_rem(Psi)
  if r:break
  N=z;removed+=1
 rows.append((i,N))
 print('input',i,'terms',len(N.dict()),'degrees',N.degree(H),N.degree(q),'Psi removed',removed,flush=True)
g=R.zero()
for i,N in rows:
 g=g.gcd(N)
 print('cumulative gcd',i,'degree',g.degree(),'terms',len(g.dict()),'seconds',round(time.time()-start,2),flush=True)
save({'ring':R,'Psi':Psi,'rows':rows,'gcd':g},str(root/'trace_degree10_leading_inputs'))
print('starting coefficient ideal standard basis',flush=True)
I=R.ideal([N for i,N in rows]);G=I.groebner_basis()
save({'ring':R,'ideal_basis':list(G),'inputs':rows},str(root/'trace_degree10_leading_basis'))
print('basis',len(G),'degrees',[p.degree() for p in G],'seconds',round(time.time()-start,2),flush=True)
sat=I.saturation(R.ideal(H*q*Psi))[0]
SG=sat.groebner_basis();save({'ring':R,'basis':list(SG)},str(root/'trace_degree10_leading_saturated'))
report={'scope':'coefficient ideal of degree-ten terms only','basis_size':len(G),
 'basis_degrees':[int(p.degree()) for p in G],'localized_unit_ideal':bool(R.one() in sat),
 'saturated_basis_degrees':[int(p.degree()) for p in SG], 'seconds':time.time()-start}
(root/'trace_degree10_leading_ideal.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
