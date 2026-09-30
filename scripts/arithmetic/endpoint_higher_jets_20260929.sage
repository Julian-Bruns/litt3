#!/usr/bin/env sage
"""Extend the universal endpoint equation, retaining every resonant jet.

Exploratory exact calculation. A nonzero resonant residual is a necessary
condition, not an assertion of existence or an endpoint exclusion.
"""
import argparse,json,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--order',type=int,default=12);p.add_argument('--output',required=True)
args=p.parse_args();out=Path(args.output);out.mkdir(parents=True,exist_ok=True)
Fp=GF(5);Ra=PolynomialRing(Fp,'a');a=Ra.gen()
K=GF(5**8,name='a',modulus=a**8+a**6+2*a**3+4*a**2+2*a+2);a=K.gen()
beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(c):return K(c%5)+K(c//5)*beta
A=list(map(dec,[1,21,14,22,13]));P=list(map(dec,[11,22,18,5,19,20,15,16,9,22,1]))
Rx=PolynomialRing(K,'x');x=Rx.gen();AA=Rx(A);PP=Rx(P)
assert AA(a)==0
resonances=list(range(2,args.order+1,5))
R=PolynomialRing(K,['e']+['d'+str(i) for i in resonances]);e=R.gen(0)
free={n:R.gen(j+1) for j,n in enumerate(resonances)}
S=PowerSeriesRing(R,'t',default_prec=args.order+3);t=S.gen()
ap=AA.derivative()(a);p0=PP(a)
B=(K(3)*p0**2*ap**3/A[4]**3)**inverse_mod(29,5**8-1)
C=K(3)*B**3*p0**2
def ev(pol,u):
 z=S.zero()
 for c in reversed(pol):z=z*u+c
 return z
def get_u(z,n):
 z=z.add_bigoh(n+2)
 rhs=sum((A[m]*e**(4-m)*t**(13-3*m)*z**m for m in range(5)),S.zero()).add_bigoh(n+2)
 u=S(a).add_bigoh(n+2)
 for j in range(ceil(log(n+2,2))+1):
  u=(u-(ev(A,u)-rhs)/ev(list(AA.derivative()),u)).add_bigoh(n+2)
 assert (ev(A,u)-rhs).valuation()>=n+2
 return u
def equation(z,n):
 z=z.add_bigoh(n+1)
 u=get_u(z,n)
 ph=sum((P[m]*e**(10-m)*t**(30-3*m)*z**m for m in range(11)),S.zero())
 lhs=(t*z.derivative()-3*z)**3*ev(P,u)**2
 rhs=ph**2*u.derivative()**3
 return R((lhs-rhs)[n]),u
z=S(B);all_data=[];st=time.time()
for n in range(1,args.order+1):
 if n in free:z+=free[n]*t**n
 residual,u=equation(z,n)
 if n in free:
  save(residual,str(out/('resonance_'+str(n)+'.sobj')))
  print('RESONANCE',n,'TERMS',len(residual.dict()),'DEGREE',residual.total_degree(),'RESIDUAL',residual,flush=True)
  if residual:
   (out/'status.json').write_text(json.dumps({'status':'nonzero resonant obstruction','order':n,'terms':len(residual.dict())})+'\n')
   break
 else:
  zn=-residual*B/(C*K((2*n+1)%5));z+=zn*t**n
  check,_=equation(z,n);assert not check
 zn=R(z[n]);all_data.append(zn)
 print('JET',n,'TERMS',len(zn.dict()),'DEGREES',[zn.degree(v) for v in R.gens()],'SECONDS',time.time()-st,flush=True)
 save({'z':all_data,'variables':R.variable_names(),'order':n},str(out/'jets.sobj'))
else:
 (out/'status.json').write_text(json.dumps({'status':'all resonances vanish through bounded order','order':args.order})+'\n')
save(z,str(out/'Z_series.sobj'))
