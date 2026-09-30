"""Compress the degree-certified exact grid, preserving every denominator."""
import sys,json,time
from pathlib import Path
import numpy as np
root=Path(sys.argv[1]);start=time.time()
F5=GF(5);Z=PolynomialRing(F5,'z');z=Z.gen()
K=GF(5^8,'alpha',modulus=Z([2,2,4,2,0,0,1,0,1]));a=K.gen()
beta=-(a^4+2*a^3+a^2+2*a)/(a^3+a^2+1)
small=[K(i%5)+(i//5)*beta for i in range(25)];basis=[a^i for i in range(4)];cache={0:K.zero()}
def dec(n):
 n=int(n)
 if n not in cache:
  v=K.zero();t=n
  for i in range(4):v+=small[t%25]*basis[i];t//=25
  cache[n]=v
 return cache[n]
R=PolynomialRing(K,['H','q']);H,q=R.gens()
def row(cs):return sum(dec(c)*q^i for i,c in enumerate(cs))
D=row([189890,9731]);a0=row([350365,93449]);b=row([90885,339126,362701,194731,371097,144818]);c=row([56518,278019,104390,351083,235630,246647,217983]);e=row([324104,260238,219737,136154,199269,240524,27757,108951,319279])
Psi=a0*H^3*q^2+b*H^2*q+c*H+e
meta=json.loads((root/'actual_seven_summary.json').read_text());nh,nq=meta['grid']
arr=np.fromfile(str(root/'actual_seven_coefficients.bin'),dtype='<i4').reshape(len(meta['coefficients']),nh,nq)
checkpoint=root/'actual_seven_rational_coefficients.sobj'
coeff=load(str(checkpoint))['coefficients'] if checkpoint.exists() else []
report=[{'j':j,'n':n,'degrees':list(map(int,N.degrees())),'terms':len(N.dict()),'denominator':list(D)} for j,n,N,D in coeff]
Pq=PolynomialRing(K,'r');rr=Pq.gen();Du=Pq(D(0,rr))
for k,info in enumerate(meta['coefficients']):
 if k<len(coeff):
  assert (info['j'],info['n'])==tuple(coeff[k][:2])
  continue
 j,n=info['j'],info['n'];den=list(map(int,info['denominator_H_q_Psi_D']));ii,jj=np.nonzero(arr[k]);N=R({(int(i),int(t)):dec(arr[k,i,t]) for i,t in zip(ii,jj)})
 if N:
  ex=N.exponents();mh=min(v[0] for v in ex);mq=min(v[1] for v in ex)
  N=R({(ex[0]-mh,ex[1]-mq):co for ex,co in N.dict().items()});den[0]-=mh;den[1]-=mq
  # D is univariate and linear. A gcd of the H-coefficients removes
  # its entire common power, avoiding hundreds of multivariate divisions.
  hs=[{} for _ in range(N.degree(H)+1)]
  for (hi,qi),co in N.dict().items():hs[hi][qi]=co
  hp=[Pq(v) for v in hs];common=Du^den[3]
  for pp in hp:
   if pp:common=common.gcd(pp)
   if common.degree()==0:break
  power=common.degree()
  if power:
   factor=Du^power;hp=[pp//factor for pp in hp];N=R({(hi,qi):co for hi,pp in enumerate(hp) for qi,co in pp.dict().items()});den[3]-=power
  while den[2]>0:
   nn,rem=N.quo_rem(Psi)
   if rem:break
   N=nn;den[2]-=1
 else:den=[0,0,0,0]
 coeff.append((int(j),int(n),N,tuple(den)))
 report.append({'j':int(j),'n':int(n),'degrees':list(map(int,N.degrees())),'terms':len(N.dict()),'denominator':den})
 pending=root/'actual_seven_rational_coefficients_pending.sobj'
 save({'ring':R,'Psi':Psi,'D':D,'coefficients':coeff,'complete':k+1==len(meta['coefficients'])},str(pending))
 pending.replace(checkpoint)
 print(report[-1], 'seconds',time.time()-start,flush=True)
(root/'actual_seven_rational_coefficients.json').write_text(json.dumps({'scope':'exact global trace coefficients, not a zero-locus decision','coefficients':report,'seconds':time.time()-start},indent=2,default=int)+'\n')
print('COMPLETE',time.time()-start,flush=True)
