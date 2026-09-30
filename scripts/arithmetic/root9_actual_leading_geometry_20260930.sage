"""The first two actual leading coefficients, with no scale specialization."""
import sys,time,json
from pathlib import Path
root=Path(sys.argv[1]);start=time.time();d=load(str(root/'actual_seven_rational_coefficients.sobj'))
R=d['ring'];H,q=R.gens();K=R.base_ring();a=K.gen();beta=-(a^4+2*a^3+a^2+2*a)/(a^3+a^2+1)
def dec(n):
 v=K.zero()
 for i in range(4):c=n%25;n//=25;v+=(K(c%5)+(c//5)*beta)*a^i
 return v
Psi=d['Psi'];D=d['D'];dd=dec(47171)+dec(357608)*q;sig=dec(112400)
N4=next(N for j,n,N,E in d['coefficients'] if (j,n)==(0,4));N5=next(N for j,n,N,E in d['coefficients'] if (j,n)==(1,5))
phis=[Psi-K(k)*sig*dd*H^3*q^2 for k in [1,2,3,4]]
prodphi=prod(phis);ratio=N5.lc()/prodphi.lc();assert N5==ratio*prodphi
P=PolynomialRing(K,'q');qq=P.gen();HH=PolynomialRing(P,'H');hh=HH.gen()
def hu(f):return HH([P(f.coefficient({H:i})(0,qq)) for i in range(f.degree(H)+1)])
projections=[]
for k in [2,3]:
 phi=phis[k-1];rr=P(hu(phi).resultant(hu(N4)));raw=rr
 units=qq*P(D(0,qq))*(qq-dec(10149))*(qq-dec(64426));removed=[]
 while True:
  g=gcd(rr,units)
  if g.degree()<=0:break
  rr//=g;removed.append(g)
 fac=rr.factor();projections.append({'k':k,'phi':phi,'raw':raw,'projection':rr,'removed':removed,'factors':fac})
 print(k,'raw degree',raw.degree(),'allowed',rr.degree(),'factor degrees',[(f.degree(),m) for f,m in fac],flush=True)
 save(dict(d,N4=N4,N5=N5,leading_product_scalar=ratio,leading_phis=phis,leading_projections=projections),str(root/'actual_leading_geometry'))
report={'scope':'common leading degeneration only, not actual scale existence','quartic_leading_degrees':list(map(int,N4.degrees())),'quintic_leading_four_factor_identity':True,'projections':[{'k':p['k'],'degree':int(p['projection'].degree()),'factor_degrees':[(int(f.degree()),int(m)) for f,m in p['factors']]} for p in projections],'seconds':time.time()-start}
(root/'actual_leading_geometry.json').write_text(json.dumps(report,indent=2,default=int)+'\n');print(report,flush=True)
