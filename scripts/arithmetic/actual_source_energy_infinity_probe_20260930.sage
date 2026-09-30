"""New direct source-energy residues, without a critical normalization.

Reads the accepted exported source. This is a new formula probe, not a
reconstruction or replay of an incoming square-locus certificate.
"""
import sys,json,time
from pathlib import Path
st=time.time();src=Path(sys.argv[1]);out=Path(sys.argv[2]);out.mkdir(parents=True,exist_ok=True)
hcode=int(sys.argv[3]);wcode=int(sys.argv[4]);ellcode=int(sys.argv[5]);prec=int(sys.argv[6]) if len(sys.argv)>6 else 1500
F5=GF(5);Z=PolynomialRing(F5,'z');z=Z.gen()
K=GF(5**8,'a',modulus=z**8+z**6+2*z**3+4*z**2+2*z+2);alpha=K.gen()
beta=-(alpha**4+2*alpha**3+alpha**2+2*alpha)/(alpha**3+alpha**2+1)
def dec(n):
 n=int(n);ans=K.zero()
 for i in range(4):
  c=n%25;n//=25;ans+=(K(c%5)+K(c//5)*beta)*alpha**i
 return ans
def pv(c):return vector(F5,[K(c).polynomial()[i] for i in range(8)])
change=matrix(F5,[pv(beta**j*alpha**i) for i in range(4) for j in range(2)]).transpose().inverse()
def enc(c):
 z=change*pv(c);return int(sum(ZZ(z[2*i])*25**i+ZZ(z[2*i+1])*5*25**i for i in range(4)))
PX=PolynomialRing(K,'x');x=PX.gen()
P=PX(list(map(dec,[11,22,18,5,19,20,15,16,9,22,1])))
A=PX(list(map(dec,[1,21,14,22,13])))
Q=PX(list(map(dec,[0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24])))
t,rem=A.quo_rem(x-alpha);assert not rem;t/=dec(13)
L0=PX(list(map(dec,[18,20,20,15])))
values=iter(src.read_text().split());gs=[];h=dec(hcode);w=dec(wcode)
for j in range(4):
 n=int(next(values));nd=int(next(values));rows=[]
 for i in range(n):rows.append(tuple(int(next(values)) for z in range(5)))
 den=K.zero()
 for i in range(nd):
  he,we,c=(int(next(values)) for z in range(3));den+=dec(c)*h**he*w**we
 g=[PX.zero() for z in range(3)]
 for i,jj,he,we,c in rows:g[jj]+=dec(c)*h**he*w**we/den*x**i
 gs.append(g)
S=LaurentSeriesRing(K,'u',default_prec=prec);u=S.gen();xx=u**(-3)
pbar=sum(P[i]*u**(30-3*i) for i in range(11))
Y=S(1).add_bigoh(prec)
for j in range(ceil(log(prec,2))+1):Y=(2*Y+pbar/(Y**2))/3
yy=u**(-10)*Y;tt=S(t(xx));qq=(S(Q(xx))-S(L0(xx))**5)/(yy**5)
def cv(g):return sum(S(g[j](xx))*yy**j for j in range(3))
g2,g3,g4,g5=list(map(cv,gs));l=S(L0(xx))
aa=g2/yy**2;bb=(g3-3*l*g2)/yy**3
cc=(g4-2*l*g3+3*l**2*g2)/yy**4
ee=(g5-l*g4+l**2*g3-l**3*g2)/yy**5
tau=tt**3;leading=dec(ellcode)*(xx-dec(9))
PW=PolynomialRing(S,'W');W=PW.gen();phi=W**5+qq
sp=aa*W**3+bb*W**2+cc*W+ee;D=sp.derivative()
F=leading*phi**2+phi*sp+tau;Fm=F/leading
Fu=PW([f.derivative() for f in F])
print('series initialized',time.time()-st,flush=True)
quo,R=F.quo_rem(D);r0=R[0];r1=R[1]
norm=r0**2-r0*r1*D[1]/D[2]+r1**2*D[0]/D[2]
si=(r0-r1*D[1]/D[2]-r1*W)/norm
V,rem=(1-si*F).quo_rem(D)
assert all(not c for c in rem)
N=(Fu**2*(leading*phi+sp)**2*V).quo_rem(Fm)[1]/tau**2
energy=N[9]/leading
corrected=tt*(energy-qq.derivative()*aa.derivative()/tau-aa*qq.derivative()*tau.derivative()/tau**2)
delta_u=4*u**(-16)*Y**2
tests=[(0,0),(1,0),(2,0),(0,1),(3,0),(4,0),(1,1)]
res=[];bounds=[]
for i,j in tests:
 v=xx**i*yy**j*corrected*delta_u
 assert v.prec()>0
 res.append(enc(v[-1]));bounds.append(int(v.prec()))
report={'h':hcode,'w':wcode,'ell':ellcode,'input_precision':prec,'residues':res,'proven_series_precisions':bounds,'energy_valuation':int(energy.valuation()),'corrected_valuation':int(corrected.valuation()),'seconds':time.time()-st,'scope':'direct Laurent source-energy computation at one coefficient/scale specialization; not a geometric parameter exclusion'}
(out/f'probe_{hcode}_{wcode}_{ellcode}.json').write_text(json.dumps(report,indent=2)+'\n')
print(report,flush=True)
