"""Compress new scale resultants by original chart units, with checkpoints.

Specialization is only a quick upper bound for a unit valuation. Every
cancellation is an exact polynomial division over the full coefficient
field. No specialization is used to discard an algebraic solution.
"""
import sys,json,time
from pathlib import Path
import numpy as np
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'actual_resultant_inputs.sobj'));R=d['ring'];H,q=R.gens();K=R.base_ring();alpha=K.gen()
beta=-(alpha^4+2*alpha^3+alpha^2+2*alpha)/(alpha^3+alpha^2+1)
small=[K(i%5)+(i//5)*beta for i in range(25)];basis=[alpha^i for i in range(4)];cache={0:K.zero()}
def dec(n):
 n=int(n)
 if n not in cache:
  v=K.zero();t=n
  for i in range(4):v+=small[t%25]*basis[i];t//=25
  cache[n]=v
 return cache[n]
Pq=PolynomialRing(K,'r');r=Pq.gen();Du=Pq(d['D'](0,r));Ph=PolynomialRing(K,'u');u=Ph.gen()
def by_H(p):
 hp=[{} for _ in range(p.degree(H)+1)]
 for (hi,qi),co in p.dict().items():hp[hi][qi]=co
 return [Pq(v) for v in hp]
def to_bivariate(hp):return R({(hi,qi):co for hi,pp in enumerate(hp) for qi,co in pp.dict().items()})
def divide_by_H_polynomial(p,divisor):
 aa=by_H(p);bb=by_H(divisor);out=[Pq.zero()]*(len(aa)-len(bb)+1)
 for k in range(len(aa)-len(bb),-1,-1):
  z,rem=aa[k+len(bb)-1].quo_rem(bb[-1])
  if rem:return None
  out[k]=z
  for j,b in enumerate(bb):aa[k+j]-=z*b
 if any(aa):return None
 return to_bivariate(out)
rows=[];reports=[]
for idx in range(3):
 cp=root/f'actual_scale_resultant_compressed_{idx}.sobj'
 if cp.exists():
  v=load(str(cp));rows.append(v['polynomial']);reports.append(v['report']);continue
 raw=root/f'actual_scale_resultant_raw_{idx}.sobj'
 if raw.exists():p=load(str(raw))
 else:
  meta=json.loads((root/f'actual_scale_resultants_{idx}.json').read_text());nh,nq=meta['grid']
  arr=np.fromfile(str(root/f'actual_scale_resultants_{idx}.bin'),dtype='<i4').reshape(nh,nq)
  ii,jj=np.nonzero(arr);p=R({(int(i),int(j)):dec(arr[i,j]) for i,j in zip(ii,jj)})
  save(p,str(raw))
 original=p;ex=p.exponents();mh=min(v[0] for v in ex);mq=min(v[1] for v in ex)
 p=R({(hi-mh,qi-mq):co for (hi,qi),co in p.dict().items()})
 hp=by_H(p);g=Du^p.degree(q)
 for a in hp:
  if a:g=g.gcd(a)
  if g.degree()==0:break
 nd=int(g.degree());fac=Du^nd
 if nd:p=to_bivariate([a//fac for a in hp]);hp=by_H(p)
 print('row',idx,'H,q,D powers',mh,mq,nd,'degrees',p.degrees(),'seconds',time.time()-start,flush=True)
 # Determine a possible Psi power without large multivariate trial divisions.
 upper=p.degree(H)//d['Psi'].degree(H)
 for val in [K(2),K(3),alpha,alpha+1]:
  uu=Ph(d['Psi'](u,val));pp=Ph([a(val) for a in hp])
  if uu.degree()!=d['Psi'].degree(H) or not pp:continue
  nv=0
  while pp and pp.degree()>=uu.degree():
   quo,rem=pp.quo_rem(uu)
   if rem:break
   pp=quo;nv+=1
  upper=min(upper,nv)
  if not upper:break
 print('row',idx,'Psi upper',upper,'seconds',time.time()-start,flush=True)
 npower=int(upper)
 while npower:
  quo=divide_by_H_polynomial(p,d['Psi']^npower)
  if quo is not None:p=quo;break
  npower-=1
 removed=[int(mh),int(mq),int(npower),nd]
 assert original==p*H^mh*q^mq*d['Psi']^npower*d['D']^nd
 report={'index':idx,'removed_H_q_Psi_D':removed,'degrees':list(map(int,p.degrees())),'terms':len(p.dict())}
 save({'polynomial':p,'report':report},str(cp));rows.append(p);reports.append(report)
 print(report,'seconds',time.time()-start,flush=True)
save(dict(d,scale_resultants=rows,resultant_reports=reports),str(root/'actual_scale_resultants_compressed'))
def code(c):return sum(int(v)*5^i for i,v in enumerate(c.polynomial().list()))
with (root/'actual_scale_projection_inputs.txt').open('w') as f:
 f.write('3\n')
 for p in rows:
  f.write(f'{p.degree(H)} {p.degree(q)} {len(p.dict())}\n')
  for (hi,qi),co in p.dict().items():f.write(f'{hi} {qi} {code(co)}\n')
(root/'actual_scale_resultants_compressed.json').write_text(json.dumps({'scope':'necessary pairwise scale resultants; joint locus undecided','rows':reports,'seconds':time.time()-start},indent=2,default=int)+'\n')
