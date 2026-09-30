"""Exact Cramer reconstruction and verification of F0..F6 and ratio data."""
from exact import *
from laurent import *
from source import reconstruct,VARS
import json,time

def polyq(a,w):
 z=LP()
 for i,c in enumerate(a):z=z+c*w**(3*i)
 return z

def substitute_kernel(F,k1,k2,d):
 degree=max([m[2]+m[3] for m in F.d]+[0]);out=LP()
 for m,v in F.d.items():out=out+LP({(m[0],m[1],0,0):v})*k1**m[2]*k2**m[3]*d**(degree-m[2]-m[3])
 return out,degree

def build():
 start=time.time();path=ROOT/'evidence/source_affine.json'
 data=json.loads(path.read_text()) if path.exists() else reconstruct()
 h,w,k1,k2=[LP.var(i) for i in range(4)];z=div(2,epsilon)*w
 c=Ca*h+Cd*w;e=-c*z-LP(eta)/(LP(24)*z);f=-w*w/epsilon-LP(div(8,24))*z**5
 # eta/LP needs LP on the left.
 coords=[LP(1),h,w,e,f,k1,k2]
 coeff=[sum((a*b for a,b in zip(row,coords)),LP()) for row in data['coefficients']]
 G={i:{} for i in range(2,6)}
 for (n,i,j),a in zip(VARS,coeff):
  if n==2:
   cf=cmn(i,j+2)
   for jj in range(3):
    for ii,v0 in enumerate(cf[jj]):
     if v0:G[n][(ii,jj)]=G[n].get((ii,jj),LP())+a*v0
  else:G[n][(i,j)]=a
 N=7
 # Y^3 = sum P_i xi^(30-3i), with Y(0)=1.
 Y=[LP(1)]+[LP() for _ in range(N-1)]
 for j in range(1,N):
  rhs=P[10-j//3] if j%3==0 else 0
  Y[j]=(LP(rhs)-sp(Y,3,N)[j])/3
 def series(G,pole):
  out=[LP() for _ in range(N)]
  for (i,j),a in G.items():
   s=pole-3*i-10*j
   if s<0:raise AssertionError((i,j,pole))
   if s<N:out=sa(out,ss(sc(sp(Y,j,N),a),s,N),N)
  return out
 aa=sc(series(G[2],35),3);bb=sc(series(G[3],46),2);cc0=series(G[4],57)
 assert bb[0]==LP(mul(2,epsilon)) and aa[0]==0
 rho=[z]+[LP() for _ in range(N-1)]
 for j in range(1,N):
  rhs=sa(sa(sm(aa,sp(rho,2,N),N),sm(bb,rho,N),N),cc0,N)[j]
  rho[j]=-rhs/(mul(2,epsilon))
 assert not any(sa(sa(sm(aa,sp(rho,2,N),N),sm(bb,rho,N),N),cc0,N))
 qser=series({(i,0):LP(v0) for i,v0 in enumerate(Q) if v0},57)
 g5ser=series(G[5],70)
 t3=pp(t,3);tterm={}
 # t^3 y^10 = t^3 P^3 y.
 for i,v0 in enumerate(pm(t3,pp(P,3))):
  if v0:tterm[(i,1)]=LP(v0)
 F=sa(sm(sa(qser,ss(sp(rho,5,N),2,N),N),sa(g5ser,ss(sa(sm(aa,sp(rho,3,N),N),sc(sm(bb,sp(rho,2,N),N),2),N),2,N),N),N),series(tterm,127),N)
 assert all(F[i]==0 for i in range(4)),F[:4]
 m=[]
 for i in [4,5]:
  assert all(t[2]+t[3]<=1 for t in F[i].d)
  m.append([F[i].coeff([2,3],[0,0]),F[i].coeff([2,3],[1,0]),F[i].coeff([2,3],[0,1])])
 D=m[0][1]*m[1][2]-m[0][2]*m[1][1]
 d=polyq(DATA['d'],w)
 # Find the monomial relating our determinant to the supplied d.
 dm=min(t[1] for t in D.d)
 assert all(t[0]==t[2]==t[3]==0 for t in D.d)
 gamma=div(D.d[(0,dm,0,0)],DATA['d'][0]);factor=gamma*w**dm
 assert D==factor*d,(D.records(),dm,gamma)
 kn1=(m[0][2]*m[1][0]-m[0][0]*m[1][2])/factor
 kn2=(m[0][0]*m[1][1]-m[0][1]*m[1][0])/factor
 Gn={}
 for n in G:
  Gn[n]={}
  for ij,a in G[n].items():
   num,j=substitute_kernel(a,kn1,kn2,d)
   assert j<=1
   Gn[n][ij]=num*d**(1-j)
 for i in [4,5]:assert substitute_kernel(F[i],kn1,kn2,d)[0]==0
 F6,deg=substitute_kernel(F[6],kn1,kn2,d)
 expected=polyq(DATA['a0'],w)*h**3+polyq(DATA['b'],w)*h**2*w**-2+polyq(DATA['c'],w)*h*w**-4+polyq(DATA['e'],w)*w**-6
 assert F6*d==expected*d**deg,'F6 mismatch with given cubic'
 maxh=max(t[0] for n in Gn.values() for a in n.values() for t in a.d)
 assert maxh<=2,maxh
 result={'denominator':DATA['d'],'determinant_factor':{'gamma':gamma,'w_exponent':dm},
 'kernel_numerators':[kn1.records(),kn2.records()],
 'G':{str(n):[[i,j,a.records()] for (i,j),a in sorted(g.items()) if a] for n,g in Gn.items()},
 'F6_numerator':expected.records(),'Y_series':[a.records() for a in Y],
 'kernel_equations':[[a.records() for a in row] for row in m]}
 (ROOT/'evidence/cramer_source.json').write_text(json.dumps(result,separators=(',',':'))+'\n')
 print('F0..F5 vanish exactly. Cramer determinant =',gamma,'* w^',dm,'* d(w^3).',flush=True)
 print('F6 agrees identically with supplied a0,b,c,e,d; common source denominator d; max h degree',maxh,flush=True)
 print('source numerator terms',sum(len(a.d) for n in Gn.values() for a in n.values()),'; elapsed',round(time.time()-start,3),'seconds',flush=True)
 return result
if __name__=='__main__':build()
