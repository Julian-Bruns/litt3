import argparse,json,glob,time
from pathlib import Path
import exact as E
from atlas import fixed_data
from sparse import Poly,sadd,smul,spow,shift

def series_Y(n):
 P,*_=fixed_data();rhs=[0]*n
 for i,c in enumerate(P[::-1]):
  if 3*i<n:rhs[3*i]=int(c)
 y=[Poly(1)]+[Poly() for _ in range(n-1)]
 for i in range(1,n):y[i]=(Poly(rhs[i])-spow(y,3,i+1)[i])*2 # 1/3=2
 return y

def gen_chart(data):
 F=E.F;n=9;h,w,s,u=[Poly.var(i) for i in range(4)];Y=series_Y(n);Yp=[spow(Y,j,n) for j in range(3)]
 eps=F.A(F.A(24,F.M(4,25)),F.M(23,F.P(25,3)))
 eta=F.A(F.A(11,F.M(18,F.P(25,2))),F.M(20,F.P(25,3)))
 Cd=F.A(F.A(F.A(3,F.M(10,25)),F.P(25,2)),F.M(14,F.P(25,3)))
 Ca=F.A(F.A(F.A(18,F.M(14,25)),F.M(10,F.P(25,2))),F.M(19,F.P(25,3)))
 c=w*Cd+(Poly() if data['root'] is None else h*Ca)
 z=w*F.M(2,F.I(eps))
 e=-c*z-z**(-1)*F.M(eta,F.I(24))
 f=-w*w*F.I(eps)-z**5*F.M(8,F.I(24))
 pars=[Poly(1),h,w,e,f,s,u]
 def scaledH(index,exponent):
  out=[Poly() for _ in range(n)]
  for par,col in zip(pars,data['data']):
   for j,p in enumerate(col[index]):
    for i,cf in enumerate(p):
     if not cf:continue
     d=exponent-3*i-10*j
     assert d>=0,(index,exponent,i,j)
     if d<n:out=sadd(out,[q*par*cf for q in shift(Yp[j],d,n)],n)
  return out
 AA=[q*3 for q in scaledH(0,35)];BB=[q*2 for q in scaledH(1,46)];CC=scaledH(2,57)
 assert BB[0]==Poly(F.M(2,eps));assert not AA[0]
 rho=[z]+[Poly() for _ in range(n-1)]
 for i in range(1,n):
  residual=sadd(sadd(smul(AA,spow(rho,2,i+1),i+1),smul(BB,rho,i+1),i+1),CC,i+1)
  rho[i]=-residual[i]*F.I(F.M(2,eps))
 # Check all coefficients of the critical equation.
 assert not any(sadd(sadd(smul(AA,spow(rho,2,n),n),smul(BB,rho,n),n),CC,n))
 P,A,Q,B,L,t,Ct=fixed_data();qseries=[Poly() for _ in range(n)]
 for i,cf in enumerate(Q):
  d=57-3*i
  if 0<=d<n:qseries[d]=Poly(int(cf))
 rp5=[Poly() for _ in range(n)]
 for i,r in enumerate(rho):
  if i*5<n:rp5[i*5]=r.frobenius()
 T=sadd(qseries,shift(rp5,2,n),n)
 H=sadd(scaledH(3,70),shift(sadd(smul(AA,spow(rho,3,n),n),[q*2 for q in smul(BB,spow(rho,2,n),n)],n),2,n),n)
 tpoly=E.mul(E.power(t,3),E.power(P,3));extra=[Poly() for _ in range(n)]
 for i,cf in enumerate(tpoly):
  d=127-3*i-10
  if d<n:extra=sadd(extra,[q*int(cf) for q in shift(Y,d,n)],n)
 Fs=sadd(smul(T,H,n),extra,n)
 assert not any(Fs[:4])
 def split_affine(f):
  a=f.coeffvar(2,1);b=f.coeffvar(3,1);p=f.coeffvar(2,0).coeffvar(3,0)
  assert f==a*s+b*u+p
  return a,b,p
 a11,a12,p4=split_affine(Fs[4]);a21,a22,p5=split_affine(Fs[5]);det=a11*a22-a12*a21
 ns=a12*p5-a22*p4;nu=a21*p4-a11*p5
 # Exact substitution of s=ns/det,u=nu/det into F6. No further coefficient is inverted.
 psi=Poly()
 for exp,cf in Fs[6].d.items():
  i,j=exp[2:];assert i+j<=2
  base=Poly({exp[:2]+(0,0):cf});psi=psi+base*ns**i*nu**j*det**(2-i-j)
 assert all(not any(k[2:]) for k in det.d)
 return {'root':data['root'],'variables':['h','w','s','u'],'epsilon':eps,'eta':eta,
  'F':[p.serial() for p in Fs], 'matrix':[[p.serial() for p in [a11,a12]],[p.serial() for p in [a21,a22]]],
  'constant':[p4.serial(),p5.serial()],'det':det.serial(),'s_num':ns.serial(),'u_num':nu.serial(),'Psi6':psi.serial()}

if __name__=='__main__':
 ap=argparse.ArgumentParser();ap.add_argument('--tables',required=True);ap.add_argument('--data',required=True);args=ap.parse_args();E.init(args.tables)
 for file in sorted(Path(args.data).glob('atlas_*.json')):
  t=time.time();data=json.loads(file.read_text());c=gen_chart(data);out=file.with_name(file.name.replace('atlas_','chart_'));out.write_text(json.dumps(c,separators=(',',':'))+'\n')
  print(file.name,'terms F4,F5,F6:',*[len(c['F'][i]) for i in [4,5,6]],'det:',c['det'],'Psi6 terms:',len(c['Psi6']),f'{time.time()-t:.2f}s',flush=True)
