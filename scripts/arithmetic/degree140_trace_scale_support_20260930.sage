"""Choose a Laurent scale using the already constructed exact coefficients.

This is support optimization, not a locus decision.  All changes are by
units on H*q*Psi != 0.  No incoming certificate is replayed.
"""
import json, sys, time
from pathlib import Path

root=Path(sys.argv[1]); name=sys.argv[2] if len(sys.argv)>2 else 'global_multiplied'
d=load(str(root/(name+'_rational_coefficients.sobj')))
R=d['ring']; H,q=R.gens(); start=time.time()
rows=[]
for j,n,N,D in d['coefficients']:
    ex=list(N.dict())
    rows.append({'j':int(j),'n':int(n),'dh':int(D[0]),'dq':int(D[1]),'dp':int(D[2]),
                 'Hmax':max(e[0] for e in ex),'Hmin':min(e[0] for e in ex),
                 'qmax':max(e[1] for e in ex),'qmin':min(e[1] for e in ex)})

results=[]
for a in range(-2,16):
 for b in range(-9,3):
  for c in range(-15,10):
   sizes=[]
   for j in range(3):
    rr=[r for r in rows if r['j']==j]
    dh=max(r['dh']-a*r['n']-r['Hmin'] for r in rr)
    dq=max(r['dq']-c*r['n']-r['qmin'] for r in rr)
    dp=max(r['dp']-b*r['n'] for r in rr)
    hh=max(r['Hmax']+dh-r['dh']+a*r['n']+dp-r['dp']+b*r['n'] for r in rr)
    qq=max(r['qmax']+dq-r['dq']+c*r['n']+7*(dp-r['dp']+b*r['n']) for r in rr)
    sizes.append((int(hh),int(qq),int(dh),int(dq),int(dp)))
   cost=sum((s[0]+1)*(s[1]+1) for s in sizes)
   results.append((int(cost),int(a),int(b),int(c),sizes))
results.sort()
answer={'status':'support_optimization_only','scale':'mu=H^a*Psi^b*q^c*u',
 'best':results[:30],'seconds':time.time()-start}
(root/(name+'_scale_support.json')).write_text(json.dumps(answer,indent=2)+'\n')
print(json.dumps(answer,indent=2),flush=True)
for j,n,N,D in d['coefficients']:
 if n>=8:
  print('top_coefficient',j,n,'den',D,'factor',N.factor(),flush=True)
