#!/usr/bin/env sage
"""Exact low-order residual content at the marked cubic branch x=[9]."""
import argparse,json,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('data');p.add_argument('output');p.add_argument('--order',type=int,default=5);args=p.parse_args();out=Path(args.output);out.mkdir(parents=True,exist_ok=True)
Fp=GF(5);Aa=PolynomialRing(Fp,'a');a=Aa.gen();K=GF(5**8,name='a',modulus=a**8+a**6+2*a**3+4*a**2+2*a+2);a=K.gen()
beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(c):
 z=K.zero()
 for i in range(4):
  d=c%25;c//=25;z+=(d%5+(d//5)*beta)*a**i
 assert not c
 return z
R=PolynomialRing(K,('u','q'));u,q=R.gens();X=PolynomialRing(R,'x');x=X.gen()
P=X(list(map(dec,[11,22,18,5,19,20,15,16,9,22,1])));AA=X(list(map(dec,[1,21,14,22,13])))
Q=X(list(map(dec,[0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24])))
B0=X(list(map(dec,[8,14,19,2,10,19,3,24,18,16])))
def exact(f,g):
 z,r=f.quo_rem(g);assert not r;return z
t=exact(AA,dec(13)*(x-a));Qt=exact(Q-B0**5,P**2)
data=json.loads((Path(args.data)/'scaled_source.json').read_text())
def uq(row):return sum((dec(c)*u**i*q**j for i,j,c in row),R.zero())
G=[[X([uq(row) for row in component]) for component in gg] for gg in data['numerators_Gbar']]
den=uq(data['denominator_uq'])
G2=[G[0][2],q*exact(G[0][0],P),X.zero()]
G3=[q*exact(2*B0*G[0][j]+G[1][j],P) for j in range(3)]
T4=[3*B0**2*G[0][j]+3*B0*G[1][j]+G[2][j] for j in range(3)]
G4=[q*exact(T4[1],P),q*exact(T4[2],P),q**2*exact(T4[0],P**2)]
T5=[-B0**3*G[0][j]+B0**2*G[1][j]-B0*G[2][j]+G[3][j] for j in range(3)]
G5=[q*exact(T5[2],P),q**2*exact(T5[0],P**2),q**2*exact(T5[1],P**2)]
save({'numerators':[G2,G3,G4,G5],'denominator':den,'P':P,'Qbar_component':q**2*Qt,'t':t},str(out/'barred_source.sobj'))
N=args.order+1
S=PowerSeriesRing(R,'z',default_prec=N);z=S.gen();r=dec(9)
xx=S(r).add_bigoh(N)
for j in range(ceil(log(N,2))+1):xx=(xx-(P(xx)-q*z**3)/P.derivative()(xx)).add_bigoh(N)
assert (P(xx)-q*z**3).valuation()>=N
gs=[sum((gg[j](xx)*z**j for j in range(3)),S.zero()) for gg in [G2,G3,G4,G5]]
ev=q**3*t(xx)**3*den;qv=q**2*z*Qt(xx);vv=(xx-r)*den
def critical(g,ev,qv,vv):
 a=3*g[0];b=2*g[1];c=g[2];d=g[3]
 U=[S(2),-b]
 for n in range(2,8):U.append(-b*U[-1]-a*c*U[-2])
 a2=a**2;a3=a**3;a4=a**4;a5=a**5;a8=a**8;a9=a**9;a10=a**10
 b2=b**2;b3=b**3;b5=b**5;c2=c**2;c3=c**3
 k0=c**5-qv*b5+a5*qv**2
 nv=a2*d**2+a*(c3-b*c*d)+b3*d+2*b2*c2
 trv=b3-a*b*c+2*a2*d
 xv=c2*(b*U[3]-U[4])+d*U[5]+qv*a3*trv
 tt=b5**2-2*a5*c**5-2*a5*b5*qv+2*a10*qv**2
 yy=a3*b*U[7]-a4*c*U[6]+a5*d*U[5]+a8*qv*b*U[2]-a9*qv*c*U[1]+2*a10*qv*d
 return [a3*k0*nv+ev*yy+ev**2*a10,vv*(k0*xv+ev*tt),vv**2*k0**2]
st=time.time();rr=critical(gs,ev,qv,vv)
for i,rrr in enumerate(rr):
 assert rrr.valuation()>=3
 f=R(rrr[3]);save(f,str(out/('content_'+str(i)+'.sobj')))
 fac=f.factor() if f else []
 save(fac,str(out/('factor_content_'+str(i)+'.sobj')))
 print('CONTENT_ROW',i,'TERMS',len(f.dict()),'DEGREES',[f.degree(v) for v in R.gens()],'FACTOR_DEGREES',[([g.degree(v) for v in R.gens()],int(e)) for g,e in fac],flush=True)
 for j in range(4,N):save(R(rrr[j]),str(out/('coefficient_'+str(i)+'_'+str(j)+'.sobj')))
print('SECONDS',time.time()-st,flush=True)
B=PolynomialRing(K,('inv','u','q'),order='degrevlex');iv,uu,qq=B.gens();hh=R.hom([uu,qq],B)
fs=[hh(R(v[3])) for v in rr]+[iv*hh(q*den)-1];I=B.ideal(fs);gb=I.groebner_basis();save({'inputs':fs,'groebner':gb},str(out/'marked_incidence.sobj'))
print('INCIDENCE_DIM',I.dimension(),flush=True)
if I.dimension()<0:
 cs=B.one().lift(fs);assert sum((f*c for f,c in zip(fs,cs)),B.zero())==1
 save(cs,str(out/'marked_unit.sobj'));print('MARKED_CONTENT_EXCLUDED',flush=True)
