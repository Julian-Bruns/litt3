"""Division-free quadratic-critical resultant and full residual construction."""
import argparse,json,time
from pathlib import Path
import numpy as np
import exact as E
from atlas import fixed_data
from sparse import Poly

def evaluate_chart(atlas,chart,h,w):
 F=E.F;values=[h,w,0,0];det=Poly.read(chart['det']).evaluate(values);psi=Poly.read(chart['Psi6']).evaluate(values)
 if not h or not w or not det or not psi:raise ValueError('point is outside the degree-140 nonzero-pivot open set')
 s=F.M(Poly.read(chart['s_num']).evaluate(values),F.I(det));u=F.M(Poly.read(chart['u_num']).evaluate(values),F.I(det));values=[h,w,s,u]
 fs=[Poly.read(f).evaluate(values) for f in chart['F']]
 assert fs[:6]==[0]*6 and fs[6]
 assert F.M(F.P(det,2),fs[6])==psi
 z=F.M(2,F.M(w,F.I(chart['epsilon'])))
 alpha=25;Cd=F.A(F.A(F.A(3,F.M(10,alpha)),F.P(alpha,2)),F.M(14,F.P(alpha,3)))
 Ca=F.A(F.A(F.A(18,F.M(14,alpha)),F.M(10,F.P(alpha,2))),F.M(19,F.P(alpha,3)))
 c=F.M(Cd,w) if atlas['root'] is None else F.A(F.M(Cd,w),F.M(Ca,h))
 e=F.N(F.A(F.M(c,z),F.M(chart['eta'],F.I(F.M(24,z)))))
 f=F.N(F.A(F.M(F.P(w,2),F.I(chart['epsilon'])),F.M(F.M(8,F.I(24)),F.P(z,5))))
 pars=[1,h,w,e,f,s,u];H=[E.czero() for _ in range(4)]
 for par,col in zip(pars,atlas['data']):
  for i in range(4):H[i]=E.cadd(H[i],E.cscale(tuple(E.poly(p) for p in col[i]),par))
 return H,{'h':h,'w':w,'s':s,'u':u,'det':det,'Psi6':psi,'F6':fs[6]}

def div_y_power(g,j,P):
 out=list(E.czero())
 for k,p in enumerate(g):
  ell=(k-j)%3;powerP=(j+ell-k)//3
  out[ell]=E.exactdiv(p,E.power(P,powerP)) if powerP>=0 else E.mul(p,E.power(P,-powerP))
 return tuple(out)

def translate(H):
 P,A,Q,B,L,t,Ct=fixed_data();H2,H3,H4,H5=H
 g2=div_y_power(H2,2,P)
 g3=div_y_power(E.csub(H3,E.cpoly(H2,E.scale(B,3))),3,P)
 g4=div_y_power(E.cadd(E.csub(H4,E.cpoly(H3,E.scale(B,2))),E.cpoly(H2,E.scale(E.power(B,2),3))),4,P)
 g5=div_y_power(E.csub(E.cadd(E.csub(H5,E.cpoly(H4,B)),E.cpoly(H3,E.power(B,2))),E.cpoly(H2,E.power(B,3))),5,P)
 Qbar=(E.poly(),E.exactdiv(E.sub(Q,E.power(B,5)),E.power(P,2)),E.poly())
 return [g2,g3,g4,g5],Qbar,(E.power(t,3),E.poly(),E.poly())

def resultant_coeffs(H,Q,T,P,v):
 """Return coefficients r0,r1,r2 in lambda, before cubic norm.
 Res_{10,2}(lambda*v*(Z^5+Q)^2+(Z^5+Q)*S+T, S')
 with S=H2*Z^3+H3*Z^2+H4*Z+H5.
 Identity uses no inverse of a curve polynomial.
 """
 add=E.cadd;sub=E.csub;sc=E.cscale
 def m(a,b):return E.cmul(a,b,P)
 def p(a,n):return E.cpow(a,n,P)
 A=sc(H[0],3);B=sc(H[1],2);C=H[2];H5=H[3]
 A2=p(A,2);A3=m(A2,A);A4=p(A,4);A5=m(A4,A)
 B2=p(B,2);B3=m(B2,B);B4=p(B,4);B5=m(B4,B)
 C2=p(C,2);C3=m(C2,C);C4=p(C,4);C5=m(C4,C)
 Dlt=add(B2,m(A,C));E0=add(sub(m(A5,p(Q,2)),m(B5,Q)),C5)
 K=sub(sc(m(A5,Q),2),B5)
 L=add(sub(B3,m(m(A,B),C)),sc(m(A2,H5),2))
 # W=(K L+Delta^4)/A^2, expanded without division.
 W=add(add(add(sc(m(B5,H5),3),m(B4,C2)),sc(m(m(A,B2),C3),4)),m(A2,C4))
 W=add(W,add(add(sc(m(m(A3,B3),Q),2),sc(m(m(m(A4,B),C),Q),3)),sc(m(m(A5,H5),Q),4)))
 # V=(L^2-Delta^3)/A^2, expanded without division.
 V=add(add(sc(m(B3,H5),4),sc(m(B2,C2),3)),add(m(m(m(A,B),C),H5),add(sc(m(A,C3),4),sc(m(A2,p(H5,2)),4))))
 r2=E.cpoly(p(E0,2),E.power(v,2))
 r1=E.cpoly(add(sc(m(E0,W),3),m(T,add(sc(m(A5,E0),2),p(Dlt,5)))),v)
 r0=add(m(A3,add(sc(m(E0,V),4),sc(m(T,sub(m(K,L),p(Dlt,4))),3))),m(p(A5,2),p(T,2)))
 return [r0,r1,r2]

def lambda_mul(a,b,P):
 out=[E.czero() for _ in range(len(a)+len(b)-1)]
 for i,x in enumerate(a):
  for j,y in enumerate(b):out[i+j]=E.cadd(out[i+j],E.cmul(x,y,P))
 return out

def norm_lambda(rs,P):
 # Compute norm as a^3+b^3*P+c^3*P^2-3abc*P, with coefficients polynomials in lambda.
 def lm(a,b):
  out=[E.poly() for _ in range(len(a)+len(b)-1)]
  for i,x in enumerate(a):
   for j,y in enumerate(b):out[i+j]=E.add(out[i+j],E.mul(x,y))
  return out
 def cube(a):return lm(lm(a,a),a)
 a,b,c=[[r[j] for r in rs] for j in range(3)]
 a3,b3,c3,abc=cube(a),cube(b),cube(c),lm(lm(a,b),c);P2=E.power(P,2)
 return [E.add(E.add(x,E.mul(y,P)),E.add(E.mul(z,P2),E.scale(E.mul(abc[i],P),2))) for i,(x,y,z) in enumerate(zip(a3,b3,c3))]

def residual_lambda(H,root,use_translation=True):
 P,A,Q,B,L,t,Ct=fixed_data();v=E.poly([1]) if root is None else E.poly([E.F.N(root),1])
 if use_translation:G,Qc,T=translate(H);den=E.mul(E.power(t,15),E.power(v,3))
 else:G=H;Qc=(Q,E.poly(),E.poly());T=(E.poly(),E.mul(E.power(t,3),E.power(P,3)),E.poly());den=E.mul(E.mul(E.power(P,40),E.power(t,15)),E.power(v,3))
 rs=resultant_coeffs(G,Qc,T,P,v);ns=norm_lambda(rs,P)
 return [E.exactdiv(c,den) for c in ns]

def evaluate_lambda(R,lam):
 p=E.poly()
 for c in R[::-1]:p=E.add(E.scale(p,lam),c)
 return p

def square_check(p):
 """Geometric square test: returns monic root of p/lc(p), or None."""
 if not len(p):return E.poly()
 d=len(p)-1
 if d%2:return None
 F=E.F;b=E.scale(p,F.I(int(p[-1])))[::-1];n=d//2;j=[1]
 for m in range(1,n+1):
  s=0
  for i in range(1,m):s=F.A(s,F.M(j[i],j[m-i]))
  j.append(F.M(3,F.A(int(b[m]),F.N(s))))
 out=E.poly(j[::-1])
 return out if not len(E.sub(E.power(out,2),E.poly(b[::-1]))) else None

if __name__=='__main__':
 ap=argparse.ArgumentParser();ap.add_argument('--tables',required=True);ap.add_argument('--data',required=True);ap.add_argument('--h',type=int,default=2);ap.add_argument('--w',type=int,default=1);ap.add_argument('--all',action='store_true');ap.add_argument('--compare',action='store_true');args=ap.parse_args();E.init(args.tables)
 files=sorted(Path(args.data).glob('atlas_*.json')) if args.all else [Path(args.data,'atlas_constant.json')]
 for fn in files:
  start=time.time();a=json.loads(fn.read_text());c=json.loads(fn.with_name(fn.name.replace('atlas_','chart_')).read_text());H,par=evaluate_chart(a,c,args.h,args.w)
  R=residual_lambda(H,a['root']);degrees=[len(x)-1 for x in R];assert max(degrees)==140 and degrees[0]==140 and all(d<140 for d in degrees[1:])
  expected=E.F.P(E.F.M(3,E.F.M(E.F.P(par['h'],3),E.F.M(E.F.P(c['epsilon'],8),par['F6']))),3)
  assert int(R[0][140])==expected
  if args.compare:
   original=residual_lambda(H,a['root'],False);assert all(not len(E.sub(x,y)) for x,y in zip(R,original))
  points=[]
  for lam in [1,2,3,4,5,25]:
   p=evaluate_lambda(R,lam);root=square_check(p);nz=[i for i,x in enumerate(p) if x and i%5]
   points.append({'lambda':lam,'square':root is not None,'nonzero_non5_coeffs':len(nz)})
  out={'root':a['root'],'parameters':par,'R_lambda':[x.tolist() for x in R],'degrees':degrees,'checks':points,'translated_matches_original':args.compare}
  Path(args.data,fn.name.replace('atlas_','residual_h'+str(args.h)+'w'+str(args.w)+'_')).write_text(json.dumps(out,separators=(',',':'))+'\n')
  print(fn.name,par,'lambda-coefficient degrees',degrees,points,f'{time.time()-start:.2f}s',flush=True)
