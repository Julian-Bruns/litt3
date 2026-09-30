#!/usr/bin/env sage
"""Endpoint content in all three labelled endpoint fibres.

The moving endpoint sheet has coordinate Z, with q=P(b)/Z^3.
The critical variable is rescaled by Z before clearing denominators.
Only powers of the original nonzero endpoint coordinate are cleared.
"""
import argparse,json,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('marked_directory');p.add_argument('output');p.add_argument('--endpoint',type=int,default=0);p.add_argument('--order',type=int,default=7);p.add_argument('--jets-only',action='store_true');args=p.parse_args();out=Path(args.output)/str(args.endpoint);out.mkdir(parents=True,exist_ok=True)
src=load(str(Path(args.marked_directory)/'barred_source.sobj'));old=src['denominator'].parent();ou,oq=old.gens();K=old.base_ring();a=K.gen();beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(c):return sum((c//25**i%5+(c//25**i//5%5)*beta)*a**i for i in range(4))
X=PolynomialRing(K,'x');x=X.gen();P=X([old(c).constant_coefficient() for c in src['P']]);t=X([old(c).constant_coefficient() for c in src['t']]);b=t.roots(multiplicities=False)[args.endpoint];pb=P(b);assert pb
R=PolynomialRing(K,('H','Z'));H,Z=R.gens();N=args.order+1;S=PowerSeriesRing(R,'T',default_prec=N);T=S.gen();xx=S(b)+T
s=S.one().add_bigoh(N)
for _ in range(ceil(log(N,2))+1):s=(s-(s**3-P(xx)/pb)/(3*s**2)).add_bigoh(N)
M=6
for k,gg in enumerate(src['numerators']):
 for j,pol in enumerate(gg):
  for f in pol:
   for (i,l),c in f.dict().items():M=max(M,3*(i+l)-j-(k+2))
def convert(f,extra):
 return sum((c*H**i*pb**(i+j)*Z**(M-3*(i+j)+extra) for (i,j),c in old(f).dict().items()),R.zero())
gs=[]
for k,gg in enumerate(src['numerators']):
 g=S.zero()
 for j,pol in enumerate(gg):
  for n,f in enumerate(pol):
   if f:g+=convert(f,j+k+2)*xx**n*s**j
 gs.append(g.add_bigoh(N))
dd=convert(src['denominator'],0);ev=pb**3*Z*t(xx)**3*dd;vv=(xx-dec(9))*dd
qt=X([(c//oq**2).constant_coefficient() for c in src['Qbar_component']]);qv=pb**2*s*qt(xx)
def critical(g,ev,qv,vv):
 A=3*g[0];B=2*g[1];C=g[2];D=g[3];U=[S(2),-B]
 for n in range(2,8):U.append(-B*U[-1]-A*C*U[-2])
 A2=A**2;A3=A2*A;A4=A3*A;A5=A**5;A8=A5*A3;A9=A5*A4;A10=A5**2
 B2=B**2;B3=B2*B;B5=B**5;C2=C**2;C3=C2*C
 k0=C**5-qv*B5+A5*qv**2
 nv=A2*D**2+A*(C3-B*C*D)+B3*D+2*B2*C2
 trv=B3-A*B*C+2*A2*D
 xv=C2*(B*U[3]-U[4])+D*U[5]+qv*A3*trv
 tt=B5**2-2*A5*C**5-2*A5*B5*qv+2*A10*qv**2
 yy=A3*B*U[7]-A4*C*U[6]+A5*D*U[5]+A8*qv*B*U[2]-A9*qv*C*U[1]+2*A10*qv*D
 return [A3*k0*nv+ev*yy+ev**2*A10,vv*(k0*xv+ev*tt),vv**2*k0**2]
shift=K((-qv[0]).constant_coefficient())**(5**7)
assert shift**5+qv[0]==0
translated=[gs[0],3*gs[0]*shift+gs[1],3*gs[0]*shift**2+2*gs[1]*shift+gs[2],gs[0]*shift**3+gs[1]*shift**2+gs[2]*shift+gs[3]]
for i,g in enumerate(translated):
 for j in range(N):
  save(R(g[j]),str(out/('translated_'+str(i)+'_T'+str(j)+'.sobj')))
save([R(qv[j]) for j in range(N)],str(out/'phi_shift_coefficients.sobj'))
save([R(ev[j]) for j in range(N)],str(out/'constant_term_coefficients.sobj'))
if args.jets_only:
 print('JETS_ONLY_FINISHED',args.endpoint,N,flush=True)
 raise SystemExit(0)
st=time.time();rr=critical(gs,ev,qv,vv);print('ENDPOINT',args.endpoint,'CLEARING_POWER',M,'SECONDS',time.time()-st,flush=True)
for i,f in enumerate(rr):
 print('ROW',i,'VALUATION',f.valuation(),flush=True);assert f.valuation()>=5
 for j in range(5,N):
  ff=R(f[j]);save(ff,str(out/('row_'+str(i)+'_T'+str(j)+'.sobj')))
  if j==5:
   fac=ff.factor() if ff else [];save(fac,str(out/('content_factor_'+str(i)+'.sobj')))
   print('CONTENT',i,'TERMS',len(ff.dict()),'FACTORS',[([g.degree(v) for v in R.gens()],int(e)) for g,e in fac],flush=True)
save({'root':b,'P_root':pb,'clearing_power':M,'source_denominator':dd,'q_numerator':pb,'q_denominator':Z**3,'coordinate_ring':R},str(out/'coordinates.sobj'))
print('FINISHED',flush=True)
