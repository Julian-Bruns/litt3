"""Division-free fixed-degree resultant and complete numerical square test."""
from reconstruct import *

def critical_resultant(a,b,c,d,Qc,C,lam):
 """Res_(10,2)(lam*(Z^5+Q)^2+(Z^5+Q)*S+C,S').
 a=3*S_3, b=2*S_2, c=S_1, d=S_0. All arguments curve functions.
 This polynomial identity remains valid for a=0 and/or lam=0.
 """
 a2=cpow(a,2);a3=cmul(a2,a);a4=cmul(a3,a);a5=cmul(a4,a);a10=cmul(a5,a5)
 b2=cpow(b,2);b3=cmul(b2,b);b4=cmul(b3,b);b5=cmul(b4,b)
 c2=cpow(c,2);c3=cmul(c2,c);c4=cmul(c3,c);c5=cmul(c4,c)
 ee=csub(cmul(a,d),cmul(b,c));delta=cadd(b2,cmul(a,c))
 T=cadd(csub(c5,cmul(Qc,b5)),cmul(cpow(Qc,2),a5))
 U=csub(cscale(cmul(Qc,a5),2),b5)
 V=csub(csub(csub(cneg(cmul(d,b5)),cscale(cmul(c2,b4),2)),cscale(cmul(cmul(a,b2),c3),3)),cscale(cmul(a2,c4),2))
 V=cadd(V,cmul(Qc,cadd(csub(cscale(cmul(a5,d),2),cmul(cmul(a4,b),c)),cmul(a3,b3))))
 W=cadd(cadd(cadd(csub(cmul(a2,cpow(d,2)),cmul(cmul(cmul(a,b),c),d)),cscale(cmul(b2,c2),2)),cmul(b3,d)),cmul(a,c3))
 M=csub(cmul(U,cadd(cscale(cmul(a,ee),2),cmul(b,delta))),cmul(a2,V))
 term2=cmul(cpow(lam,2),cpow(T,2))
 term1=cmul(lam,cadd(cmul(T,V),cmul(C,csub(cpow(U,2),cscale(cmul(a5,T),2)))))
 term0=cadd(cmul(a3,cadd(cmul(T,W),cmul(C,M))),cmul(cpow(C,2),a10))
 return cadd(cadd(term2,term1),term0)

def norm(a):
 a0,a1,a2=a
 return psub(padd(padd(ppow(a0,3),pmul(ppow(a1,3),P)),pmul(ppow(a2,3),ppow(P,2))),pscale(pmul(pmul(pmul(a0,a1),a2),P),3))

def barred(gs):
 g2=cdiv_y(gs[2],2)
 g3=cdiv_y(csub(gs[3],cscale(cmulpoly(gs[2],B0),3)),3)
 g4=cdiv_y(cadd(csub(gs[4],cscale(cmulpoly(gs[3],B0),2)),cscale(cmulpoly(gs[2],B2),3)),4)
 g5=cdiv_y(csub(cadd(csub(gs[5],cmulpoly(gs[4],B0)),cmulpoly(gs[3],B2)),cmulpoly(gs[2],B3)),5)
 qb=[[],pquo(psub(Q,ppow(B0,5)),ppow(P,2)),[]]
 return g2,g3,g4,g5,qb

def residual(h,w,lam,independent_check=False):
 data=make_chart(h,w);gs=data['G']
 g2,g3,g4,g5,qb=barred(gs)
 rb=critical_resultant(cscale(g2,3),cscale(g3,2),g4,g5,qb,frompoly(t3),constant(lam))
 R=pquo(norm(rb),ppow(t,15))
 if data['F6']:
  assert len(R)==141
  lead=power(mul(mul(3,power(h,3)),mul(power(EPS,8),data['F6'])),3)
  assert R[-1]==lead,(R[-1],lead)
 if independent_check:
  r=critical_resultant(cscale(gs[2],3),cscale(gs[3],2),gs[4],gs[5],frompoly(Q),cmulpoly(y10,t3),constant(lam))
  assert r==cmul(cpow(monomial(0,1),40),rb)
  assert norm(r)==pmul(pmul(ppow(P,40),ppow(t,15)),R)
 return R,data

def square_test(R):
 """Geometric square iff normalized monic square; scalar square root not needed."""
 if not R:return {'square':True,'normalized_root':[],'leading_coefficient':0}
 deg=len(R)-1
 if deg%2:return {'square':False,'reason':'odd degree','degree':deg}
 n=deg//2;C=R[-1];A=list(reversed(pscale(R,inv(C))));s=[1]
 for k in range(1,n+1):
  sm=0
  for i in range(1,k):sm=add(sm,mul(s[i],s[k-i]))
  s.append(div(sub(A[k],sm),2))
 sq=ppow(s,2);sq +=[0]*(len(A)-len(sq))
 err=[sub(sq[i],A[i]) for i in range(n+1,deg+1)]
 if any(err):
  i=next(i for i,c in enumerate(err) if c)
  return {'square':False,'degree':deg,'first_failed_reverse_coefficient':n+1+i,'error':err[i],'leading_coefficient':C}
 return {'square':True,'degree':deg,'normalized_root':list(reversed(s)),'leading_coefficient':C}

def ff_det(A):
 n=len(A);A=[r[:] for r in A];det=1
 for i in range(n):
  j=next((j for j in range(i,n) if A[j][i]),None)
  if j is None:return 0
  if j!=i:A[i],A[j]=A[j],A[i];det=neg(det)
  pivot=A[i][i];det=mul(det,pivot);iv=inv(pivot)
  for j in range(i+1,n):
   c=mul(A[j][i],iv)
   for k in range(i+1,n):A[j][k]=sub(A[j][k],mul(c,A[i][k]))
 return det

def sylvester_fixed(f,g,m,n):
 f=(list(f)+[0]*(m+1))[:m+1];g=(list(g)+[0]*(n+1))[:n+1]
 f=list(reversed(f));g=list(reversed(g));mat=[]
 for i in range(n):mat.append([0]*i+f+[0]*(n-1-i))
 for i in range(m):mat.append([0]*i+g+[0]*(m-1-i))
 return ff_det(mat)

def check_resultant_points():
 import random
 rng=random.Random(140)
 cases=[]
 for i in range(64):
  aa,bb,cc,dd,qq,CC,ll=[rng.randrange(QFIELD) for _ in range(7)]
  if i%4==0:aa=0
  if i%4==1:ll=0
  if i%8==2:aa=0;ll=0
  if i%8==3:bb=0
  S=[dd,cc,mul(3,bb),mul(2,aa)];U=[qq,0,0,0,0,1]
  f=padd(padd(pscale(ppow(U,2),ll),pmul(U,S)),[CC])
  expected=sylvester_fixed(f,[cc,bb,aa],10,2)
  got=critical_resultant(*[constant(v) for v in [aa,bb,cc,dd,qq,CC,ll]])
  assert got==constant(expected)
  cases.append({'inputs':[aa,bb,cc,dd,qq,CC,ll],'result':got[0][0] if got[0] else 0})
 return cases

if __name__=='__main__':
 import time
 st=time.time();cases=check_resultant_points();checks=[]
 for h,w,lam in [(1,2,1),(2,3,1),(25,6,25),(12345,67890,13579),(1,2,0)]:
  R,d=residual(h,w,lam,True);check=square_test(R)
  check.update({'h':h,'w':w,'lambda':lam,'H':d['H'],'q':d['q'],'F6':d['F6']})
  checks.append(check)
 print(json.dumps({'sylvester_checks':len(cases),'residual_checks':checks},sort_keys=True))
 (ROOT/'evidence/resultant_point_checks.json').write_text(json.dumps(cases,indent=2)+'\n')
 (ROOT/'evidence/residual_checks.json').write_text(json.dumps(checks,indent=2)+'\n')
 print('seconds',time.time()-st)
