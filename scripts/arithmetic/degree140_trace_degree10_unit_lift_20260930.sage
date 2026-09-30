"""Recover an explicit monic degree-ten combination from a coefficient ideal.

All certificate multipliers are retained. Only q, H and Psi may be
inverted; a target monomial is sought first to avoid unnecessary poles.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'trace_degree10_leading_basis.sobj'));R=d['ring'];H,q=R.gens()
rows=d['inputs'];polys=[N for i,N in rows];I=R.ideal(polys)
G=d['ideal_basis'];J=R.ideal(G)
target=None
for total in range(0,41):
 choices=[]
 for a in range(total+1):
  p=H^a*q^(total-a)
  if J.reduce(p)==0:choices.append((int(a),p))
 if choices:
  # Prefer only q when possible, then a smaller H power.
  a,target=min(choices,key=lambda v:v[0]);break
if target is None:raise RuntimeError('No monomial unit through total degree40; inspect basis before extension')
print('unit target',str(target),'seconds',round(time.time()-start,2),flush=True)
print('basis supports',[(p.degree(),len(p.dict())) for p in G],flush=True)
weights=list(target.lift(I))
assert sum((w*p for w,p in zip(weights,polys)),R.zero())==target
out={'ring':R,'target':target,'weights':[(int(rows[i][0]),w) for i,w in enumerate(weights) if w],
 'inputs':rows,'parent':'trace_monic11_reduction.sobj'}
save(out,str(root/'trace_degree10_unit_lift'))
report={'scope':'exact leading-coefficient lift, not full-locus decision','target':str(target),
 'weights':[{'row':int(i),'terms':len(w.dict()),'H_degree':int(w.degree(H)),
 'q_degree':int(w.degree(q))} for i,w in out['weights']], 'seconds':time.time()-start}
(root/'trace_degree10_unit_lift.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
