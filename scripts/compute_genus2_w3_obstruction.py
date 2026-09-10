#!/usr/bin/env python3
"""Exact higher inverse-Cartier calculation for the pair in the accompanying answer.

Run: python compute_genus2_w3_obstruction.py
Dependency: numpy. No network, SageMath, external files, or floating-point arithmetic.

Coefficient tuples are in the basis (1,T,T^2,T^3) of
 (Z/125)[T]/(T^4+4*T^3+T^2+4*T+3).
The script constructs a genuine regular affine Frobenius lift, identifies the
canonical first curve lift using the flat extension, then computes the full
higher Taylor/jet transition. Formal Laurent precision is propagated.

The local nontrivial two-torsion double is retained using w^2=u-T and y=v/w.
The comparison frames are anti-invariant; the obstruction descends.

--frobenius-variant 1 changes the regular affine Frobenius lift, and
--precision 500 or 800 independently reproduces the same class and residue.

Main geometric formulas are explained in the accompanying answer. The input
block begins at FC=...; the finite-field parameter and tangent functional are
specialized to this example. The Cech/Taylor and residue procedures are reusable.
"""
import numpy as np
from functools import lru_cache
import argparse
parser=argparse.ArgumentParser(description="Exact W2-to-W3 Hodge obstruction for the specified genus-two pair")
parser.add_argument("--precision",type=int,default=800,help="Laurent workspace (default: 800; minimum: 500)")
parser.add_argument("--frobenius-variant",type=int,choices=[0,1],default=0,help="Use a different regular affine Frobenius lift")
args=parser.parse_args()
if args.precision<500:parser.error("--precision must be at least 500")
MOD=125
MAX=args.precision
Q=np.array([3,4,1,4,1],dtype=np.int64)

def ca(x):
 if isinstance(x,(int,np.integer)): return np.array([x%MOD,0,0,0],dtype=np.int64)
 a=np.zeros(4,dtype=np.int64); x=np.array(x,dtype=np.int64).ravel(); a[:len(x)]=x;return a%MOD
ONE=ca(1); T=ca([0,1]); ZERO=ca(0)
def cm(a,b):
 c=np.convolve(ca(a),ca(b))%MOD
 for i in range(6,3,-1):
  for j in range(4):c[i-4+j]-=c[i]*Q[j]
  c%=MOD
 return c[:4]
def cp(a,n):
 a=ca(a);o=ONE
 while n:
  if n&1:o=cm(o,a)
  a=cm(a,a);n//=2
 return o
@lru_cache(None)
def _ci(a):
 a=ca(a)
 if not np.any(a%5):raise ZeroDivisionError(a)
 x=cp(a,623)
 for _ in range(2):x=cm(x,(ca(2)-cm(a,x))%MOD)
 assert np.array_equal(cm(a,x),ONE)
 return x

def ci(a):return _ci(tuple(ca(a)))
def cdiv(a,b):return cm(a,ci(b))
def trim(a):
 a=np.array(a,dtype=np.int64)%MOD
 if a.ndim==1:a=a.reshape(4,1)
 ix=np.flatnonzero(np.any(a,axis=0))
 return a[:,:ix[-1]+1] if len(ix) else np.zeros((4,1),dtype=np.int64)
def pm(a,b):
 a=trim(a);b=trim(b);c=np.zeros((7,a.shape[1]+b.shape[1]-1),dtype=np.int64)
 for i in range(4):
  for j in range(4):c[i+j]+=np.convolve(a[i],b[j])
 c%=MOD
 for i in range(6,3,-1):
  for j in range(4):c[i-4+j]-=Q[j]*c[i]
  c%=MOD
 return trim(c[:4])
def padd(a,b):
 n=max(a.shape[1],b.shape[1]);c=np.zeros((4,n),dtype=np.int64);c[:,:a.shape[1]]+=a;c[:,:b.shape[1]]+=b;return trim(c)
def pneg(a):return (-a)%MOD

def pscale(a,b):return pm(a,ca(b).reshape(4,1))

def pdiv(a,b,field=False):
 mod=5 if field else MOD
 a=trim(a%mod).copy();b=trim(b%mod);d=b.shape[1]-1
 if not np.any(b):raise ZeroDivisionError
 q=np.zeros((4,max(1,a.shape[1]-d)),dtype=np.int64)
 bi=ci(b[:,-1])%mod
 while np.any(a) and a.shape[1]>d:
  j=a.shape[1]-1-d;c=cm(a[:,-1],bi)%mod;q[:,j]=c
  a[:,j:j+d+1]=(a[:,j:j+d+1]-pscale(b,c))%mod
  a=trim(a)
 return trim(q),trim(a)

def pxgcd(a,b):
 a=trim(a%5);b=trim(b%5);s0=ca(1).reshape(4,1);s1=ca(0).reshape(4,1);t0=s1.copy();t1=s0.copy()
 while np.any(b):
  q,r=pdiv(a,b,True);a,b=b,r
  s0,s1=s1,padd(s0,-pm(q,s1))%5;t0,t1=t1,padd(t0,-pm(q,t1))%5
 c=ci(a[:,-1])%5
 return pscale(a,c)%5,pscale(s0,c)%5,pscale(t0,c)%5

def pd(a):return trim(a[:,1:]*np.arange(1,a.shape[1]))
def ppow(a,n):
 o=ca(1).reshape(4,1)
 while n:
  if n&1:o=pm(o,a)
  a=pm(a,a);n//=2
 return o

def peval(a,b):
 if isinstance(b,Ser):
  o=Ser(0)
  for c in a.T[::-1]:o=o*b+Ser(c)
  return o
 o=ca(0).reshape(4,1)
 for c in a.T[::-1]:o=padd(pm(o,b),c.reshape(4,1))
 return o

# Laurent series, truncation up to a common high order, chosen large for low-order computations.
INF = 10**9
class Ser:
 """Laurent series over the unramified coefficient ring, with z-adic precision.

 ``prec`` is an absolute, exclusive precision: all coefficients below it
 are certified. Finite Laurent polynomials have infinite precision until
 the configured workspace truncates them. Arithmetic propagates precision.
 """
 def __init__(self,a=0,l=0,prec=INF):
  if isinstance(a,Ser):
   self.a=a.a.copy();self.l=a.l;self.prec=min(a.prec,prec);return
  ar=np.array(a,dtype=np.int64)
  if ar.ndim==0:ar=ca(int(ar)).reshape(4,1)
  elif ar.ndim==1:ar=ca(ar).reshape(4,1)
  ar=ar%MOD; self.prec=int(prec)
  ix=np.flatnonzero(np.any(ar,axis=0))
  if not len(ix):self.a=np.zeros((4,1),dtype=np.int64);self.l=0;return
  if ix[-1]+l>=MAX:self.prec=min(self.prec,MAX)
  first=int(ix[0]);last=min(int(ix[-1])+1,MAX-l,self.prec-l)
  if last<=first:self.a=np.zeros((4,1),dtype=np.int64);self.l=0;return
  self.a=ar[:,first:last].copy();self.l=int(l+first)
 @property
 def valuation(self):return self.l if np.any(self.a) else self.prec
 def __add__(self,b):
  b=Ser(b);lo=min(self.l,b.l);hi=max(self.end,b.end)
  ar=np.zeros((4,hi-lo),dtype=np.int64)
  for s in [self,b]:ar[:,s.l-lo:s.end-lo]+=s.a
  return Ser(ar,lo,min(self.prec,b.prec))
 __radd__=__add__
 def __neg__(self):return Ser(-self.a,self.l,self.prec)
 def __sub__(self,b):return self+-Ser(b)
 def __rsub__(self,b):return Ser(b)+-self
 def __mul__(self,b):
  b=Ser(b)
  precision=min(self.prec+b.valuation,b.prec+self.valuation,INF)
  return Ser(pm(self.a,b.a),self.l+b.l,precision)
 __rmul__=__mul__
 def __pow__(self,n):
  if n<0:return self.inv()**(-n)
  a=self;o=Ser(1)
  while n:
   if n&1:o=o*a
   a=a*a;n//=2
  return o
 def as_poly(self):
  """Treat a finite Newton approximation as a Laurent polynomial."""
  return Ser(self.a,self.l)
 def inv(self):
  if self.iszero():raise ZeroDivisionError('zero Laurent series')
  if not np.any(self.a[:,0]%5):
   # A nilpotent polar tail can precede the first unit coefficient.
   # Invert the mod-5 part and use the finite nilpotent geometric series.
   base=self.mod(5);iv=base.inv();e=(self-base)*iv
   return iv*(Ser(1)-e+e*e)
  a=Ser(self.a,0,self.prec-self.l)
  work=min(MAX,self.prec-self.l)
  if work<=0:raise ArithmeticError('Insufficient precision for inversion')
  out=Ser(ci(self.a[:,0]));n=1
  while n<work:
   n=min(2*n,work)
   out=(out*(2-a*out)).cut(n).as_poly()
  precision=min(self.prec-2*self.l,work-self.l)
  return Ser(out.a,-self.l,precision)
 def __truediv__(self,b):return self*Ser(b).inv()
 def __rtruediv__(self,b):return Ser(b)*self.inv()
 @property
 def end(self):return self.l+self.a.shape[1]
 def iszero(self):return not np.any(self.a)
 def shift(self,n):return Ser(self.a,self.l+n,min(INF,self.prec+n))
 def cut(self,n):return Ser(self.a,self.l,min(self.prec,n))
 def coef(self,n):
  if n>=self.prec:raise ArithmeticError(f'Coefficient {n} requested at precision {self.prec}')
  return self.a[:,n-self.l].copy() if self.l<=n<self.end else ca(0)
 def deriv(self):return Ser(self.a*np.arange(self.l,self.end),self.l-1,self.prec-1)
 def mod(self,n):return Ser(self.a%n,self.l,self.prec)
 def divint(self,n):
  if not np.all(self.a%n==0):raise ArithmeticError(f'Nonintegral division by {n}')
  return Ser(self.a//n,self.l,self.prec)
 def sigma(self):return Ser(SIGMAT@self.a%MOD,self.l,self.prec)
 def frob(self):
  ar=np.zeros((4,5*(self.a.shape[1]-1)+1),dtype=np.int64)
  ar[:,::5]=SIGMAT@self.a%MOD
  return Ser(ar,5*self.l,min(INF,5*self.prec))
 def sqrt1(self):
  assert self.l==0 and np.array_equal(self.coef(0),ONE)
  out=Ser(1);n=1;work=min(MAX,self.prec)
  while n<work:
   n=min(n*2,work)
   out=((out+self/out)*Ser(ci(2))).cut(n).as_poly()
  return Ser(out.a,0,work)
 def __repr__(self):
  terms=[]
  for i,c in enumerate(self.a.T):
   if np.any(c):terms.append(f'{tuple(map(int,c))}*z^{i+self.l}')
   if len(terms)>6:terms.append('...');break
  return ' + '.join(terms) or '0'

SIGT=cp(T,5)
for _ in range(3):
 qq=sum((cp(SIGT,i)*Q[i] for i in range(5)),start=ca(0))%MOD
 dq=sum((cp(SIGT,i-1)*(i*Q[i]) for i in range(1,5)),start=ca(0))%MOD
 SIGT=(SIGT-cdiv(qq,dq))%MOD
SIGMAT=np.array([cp(SIGT,i) for i in range(4)]).T
Z=Ser(1,1)

def linear_solve(A,b):
 # coefficients: A rows x cols x 4, b rows x 4
 A=np.asarray(A,dtype=np.int64)%5;b=np.asarray(b,dtype=np.int64)%5
 nr,nc,_=A.shape;M=np.concatenate([A,b[:,None,:]],axis=1);pivs=[];r=0
 for c in range(nc):
  rr=next((j for j in range(r,nr) if np.any(M[j,c])),None)
  if rr is None:continue
  M[[r,rr]]=M[[rr,r]];iv=ci(M[r,c])%5
  M[r]=np.array([cm(x,iv)%5 for x in M[r]])
  for j in range(nr):
   if j!=r and np.any(M[j,c]):M[j]=(M[j]-np.array([cm(M[j,c],x)%5 for x in M[r]]))%5
  pivs.append(c);r+=1
 for j in range(r,nr):
  if np.any(M[j,-1]):raise ValueError(('inconsistent',j,M[j]))
 x=np.zeros((nc,4),dtype=np.int64)
 for j,c in enumerate(pivs):x[c]=M[j,-1]
 return x,pivs

# === INPUT AND CANONICAL FIRST LIFT ===
import time
start=time.time()
print('START',flush=True)
U=np.array([ca(0),ca(1)]).T
FC=ca(1).reshape(4,1)
for root in [ca(0),ca(1),ca(2),ca(3),T]:FC=pm(FC,np.array([-root,ca(1)]).T)
SC=ca(1).reshape(4,1)
for root in [ca(0),ca(1),ca(2),ca(3)]:SC=pm(SC,np.array([-root,ca(1)]).T)
RC=np.array([-T,ca(1)]).T
h=(4*T+ca(3))%MOD
HC=np.array([-h,ca(1)]).T
BC=pscale(np.array([-2*T-h,ca(3)]).T,ci(2))
AP=pm(RC,ppow(HC,2));BP=pm(SC,ppow(BC,2))
gcd,pc,qc=pxgcd(AP,BP)
assert np.array_equal(gcd,ca(1).reshape(4,1))
assert not np.any(padd(padd(pm(AP,pc),pm(BP,qc)),-ca(1).reshape(4,1))%5)
print('bezout',pc.shape[1]-1,qc.shape[1]-1,flush=True)
rev=FC[:,::-1]
s=Z**2
for _ in range(10):s=s-(s-Z**2*peval(rev,s))/(1-Z**2*peval(pd(rev),s))
u=s.inv();v=u**2/Z
g=-Z*s.deriv();Dz=g.inv()
w=(((1-Ser(T)*s)/(s/Z**2)).sqrt1())/Z
y=v/w
a=w*(u-Ser(h));b=y*peval(BC,u)
c=-b*peval(qc,u);d=a*peval(pc,u)
print('series',time.time()-start, 'D a check',(a.deriv()/g-b).cut(30),flush=True)
print('det check',(a*d-b*c-1).mod(5).cut(40),flush=True)
# target extension f
f_target=(Z*d-Dz*c)/(Z*b-Dz*a)
# reference Frobenius
Fsig=SIGMAT@FC%MOD
Fder5=ppow(pd(FC)%5,5)%5
F3=ppow(FC,3)%5
_,Finv,_=pxgcd(Fder5,F3)
fu=ppow(U,5);bv=ppow(FC,2)
for power in [5,25]:
 err=padd(peval(Fsig,fu),-pm(FC,ppow(bv,2)))
 assert np.all(err%power==0),('not divisible err',power)
 e=(err//power)%5
 ac=pdiv(-pm(e,Finv)%5,F3,True)[1]
 if power==5 and args.frobenius_variant:ac=padd(ac,F3)%5
 numer=padd(e,pm(Fder5,ac))%5
 bc,rem=pdiv(numer,pscale(F3,ca(2))%5,True)
 assert not np.any(rem)
 fu=padd(fu,power*ac);bv=padd(bv,power*bc)
 print('F lift',power,'deg',fu.shape[1]-1,bv.shape[1]-1,flush=True)
err=padd(peval(Fsig,fu),-pm(FC,ppow(bv,2)))
assert not np.any(err)
Fu=peval(fu,u);FBv=peval(bv,u)
fuz=Fu**2/(v*FBv)
bad=fuz.mod(5)-Z**5
print('FZ mod5 error',bad.mod(5),flush=True)
delta_ref=(fuz-Z**5).cut(350).divint(5)
f_ref=-(g.frob()*delta_ref).mod(5)
print('F series',time.time()-start,'val',f_ref.l,'target val',f_target.mod(5).l,flush=True)
# Basis reduction modulo A+z^n series. Coeffs reduced modulo 5.
u5=u.mod(5);v5=v.mod(5)
powers={0:Ser(1)}
def upow(n):
 if n not in powers:powers[n]=u5**n
 return powers[n]

def reduce_h1(f,n=10):
 f=f.mod(5);part=Ser(0)
 lower=f.l
 for e in range(lower,1):
  cc=f.coef(e)%5
  if not np.any(cc):continue
  if e<=-5 and e%2:
   k=(-e-5)//2;basis=v5*upow(k)
  elif e<=0 and e%2==0:
   k=-e//2;basis=upow(k)
  else:continue
  cf=cdiv(cc,basis.coef(e))%5
  term=Ser(cf)*basis
  f=(f-term).mod(5);part=(part+term).mod(5)
 inds=[-3,-1]+list(range(1,n))
 vec=np.array([f.coef(i)%5 for i in inds])
 return vec,part,f

cols=[reduce_h1(f_target)[0]]+[ -reduce_h1(Z**j)[0]%5 for j in [-15,-5,5]]
AA=np.stack(cols,axis=1)
rhs=reduce_h1(f_ref)[0]
sol,pivs=linear_solve(AA,rhs)
print('SOLUTION mu, xi_frob',sol.tolist(),'pivs',pivs,flush=True)
mu=sol[0];xi_coefs=np.array([cp(c,125)%5 for c in sol[1:]])
xi=sum((Ser(c)*Z**e for c,e in zip(xi_coefs,[-3,-1,1])),Ser(0))
print('XI',xi,flush=True)
f_actual=(f_ref+xi**5).mod(5)
diff=(Ser(mu)*f_target-f_actual).mod(5)
rr,qU,remainder=reduce_h1(diff)
print('diff cohom',rr.tolist(),flush=True)
assert not np.any(rr)
qO=-(remainder/Z**10).mod(5)
print('qO valuation',qO.l,'qU pole',qU.l,'time',time.time()-start,flush=True)

# === HIGHER INVERSE CARTIER AND OBSTRUCTION ===
Pcoeff=np.array([(2*cp(T,3)+4*cp(T,2)+4*T+ca(4))%MOD,(3*cp(T,2)+ca(3))%MOD,(2*T+ca(3))%MOD,ca(2)]).T
P=peval(Pcoeff,u)
horizontal_check=(b.deriv()/g-P*a).mod(5).cut(100)
assert horizontal_check.prec>=100 and horizontal_check.iszero()
beta=d*c.deriv()-c*d.deriv()+(-d*d+P*c*c)*g
zeta=Fu.deriv().cut(300).divint(5)/(v*FBv)
conncheck=(Ser(mu)*beta-qU.deriv()+zeta).mod(5).cut(100)
assert conncheck.prec>=100 and conncheck.iszero()
print('CONNECTION CHECK',conncheck,flush=True)
# psi formal gluing automorphism phi=exp(5 xi D), modulo125
def der(f):return f.deriv()/g
def XD(f):return xi*der(f)
def phi(f):return f+5*XD(f)+Ser(cm(ca(25),ci(2)))*XD(XD(f))
phiz=phi(Z)
# d phi eta / eta: eta=-z ds in reference coordinates; phi is Lie exp
# phi^* eta=eta+5 dxi +(25/2) d(XD(xi))
A=1+5*der(xi)+Ser(cm(ca(25),ci(2)))*der(XD(xi))
# q=z sqrt(A), A=1 mod5. compute binomial sqrt exact truncated
am=A-1
q=Z*(1+Ser(ci(2))*am-Ser(ci(8))*am**2)
# comparison of local Frobenius maps on overlap
num=phi(fuz)-phiz.frob()
delta=num.cut(250).divint(5)
B_g=phi(g).frob()
B_gp=phi(g.deriv()).frob()
m=-(B_g*delta+Ser(cm(ca(5),ci(2)))*B_gp*delta**2).mod(25)
# T_n operator tilde gluing: diag(q^-1,q) and bottom-left -5 A^-1 Dq
j11=q.inv().frob();j22=q.frob();j21=(-5*der(q)/A).frob()
G=[[j11,j11*m],[j21,j21*m+j22]]
# Check G0 equals predicted actual first inverse Cartier
assert (G[0][0]-Z**-5).mod(5).cut(70).iszero()
assert (G[1][1]-Z**5).mod(5).cut(70).iszero()
assert (Z**5*G[0][1]-f_actual).mod(5).cut(70).iszero()
print('G0 diag check',(G[0][0]-Z**-5).mod(5).cut(70),(G[1][1]-Z**5).mod(5).cut(70),flush=True)
print('G0 extension check',(Z**5*G[0][1]-f_actual).mod(5).cut(70),flush=True)
# Jet-to-actual comparison matrices; U has S_U=[[a,mu c],[b,mu d]], M_U unipotent(qU)
# qU must be lifted as an actual function in A, not coefficientwise Laurent lift!
# Stage1 reduction qU only stored as Laurent mod5, reconstruct it using affine monomials.
def affine_lift(f):
 f=f.mod(5);poly=Ser(0)
 for e in range(f.l,1):
  coeff=f.coef(e)%5
  if not np.any(coeff):continue
  if e<=-5 and e%2:basis=v*u**((-e-5)//2)
  elif e<=0 and e%2==0:basis=u**(-e//2)
  else:continue
  cc=cdiv(coeff,basis.coef(e))%5;term=Ser(cc)*basis
  poly=poly+term;f=(f-term).mod(5)
 assert f.cut(80).iszero(),('not regular',f.cut(80))
 return poly
qUlift=affine_lift(qU)
qOlift=qO
# matrix helpers
def mm(A,B):return [[sum((A[i][k]*B[k][j] for k in range(2)),Ser(0)) for j in range(2)]for i in range(2)]
def mi(M):
 dt=M[0][0]*M[1][1]-M[0][1]*M[1][0]
 return [[M[1][1]/dt,-M[0][1]/dt],[-M[1][0]/dt,M[0][0]/dt]]
def mp(M):return [[phi(x) for x in row] for row in M]
MU=[[Ser(1),qUlift],[Ser(0),Ser(1)]]
MO=[[Ser(1),qOlift],[Ser(0),Ser(1)]]
SU=[[a,Ser(mu)*c],[b,Ser(mu)*d]]
aO=Z**4*a;bO=Z**5*(Z*b-Dz*a)
SO=[[aO,-Ser(mu)/bO],[bO,Ser(0)]]
IU=mm(MU,mi(SU));IO=mm(MO,mi(SO))
Gj=mm(mm(mi(IO),G),mp(IU))
print('Gj0 check',flush=True)
J0=[[1/Z,Ser(0)],[-Dz,Z]]
for i in range(2):
 for j in range(2):
  check=(Gj[i][j]-J0[i][j]).mod(5).cut(60)
  assert check.prec>=60 and check.iszero()
  print(i,j,check,flush=True)
b12=Gj[0][1].mod(25).cut(70)
rho=Z*b12.divint(5)
# reduce H1(T)
def redT(f):
 f=f.mod(5)
 for e in range(f.l,1):
  cc=f.coef(e)%5
  if not np.any(cc):continue
  if e<=-5 and e%2:bs=v*u**((-e-5)//2)
  elif e<=0 and e%2==0:bs=u**(-e//2)
  else:continue
  f=(f-Ser(cdiv(cc,bs.coef(e))%5)*bs).mod(5)
 return [f.coef(e)%5 for e in [-3,-1,1]],f
abc,red=redT(rho)
assert rho.prec>2
print('Certified rho precision:',rho.prec,flush=True)
print('RHO COEFS',np.array(abc).tolist(),flush=True)
weights=[(3*cp(T,2)+T+ca(1))%5,(3*T+ca(4))%5,ca(3)]
lam=sum((cm(a,c) for a,c in zip(weights,abc)),start=ca(0))%5
print('LAMBDA',lam,'TIME',time.time()-start,flush=True)

# === INDEPENDENT RESIDUE AND VARIATION CHECKS ===
weights=[(3*cp(T,2)+T+ca(1))%5,(3*T+ca(4))%5,ca(3)]

def residue_of_rho(rh):
 return (rh*(u*u+Ser(T+ca(3))*u+Ser(2*cp(T,2)+ca(4)))*g).mod(5).coef(-1)%5

def obstruction_from_G(GG):
 gg=mm(mm(mi(IO),GG),mp(IU))
 rr=Z*gg[0][1].mod(25).cut(60).divint(5)
 abc,red=redT(rr)
 la=sum((cm(a,c) for a,c in zip(weights,abc)),start=ca(0))%5
 return la,abc,rr
print('DIRECT RESIDUE',residue_of_rho(rho),flush=True)
for j in [-3,-1,1]:
 chi=Z**j
 dg=[[Ser(0),5*Z**-5*chi**5],[Ser(0),Ser(0)]]
 gg=[[G[i][j]+dg[i][j] for j in range(2)]for i in range(2)]
 la,ab,_=obstruction_from_G(gg)
 assert np.array_equal(la,lam)
 print('C3 variation',j,'lambda',la,'delta rho',(np.array(ab)-np.array(abc))%5,flush=True)
# isolate the nontrivial order-5 terms of actual higher inverse Cartier
nojet=[[j11,j11*m],[Ser(0),j22]]
lt,_,_=obstruction_from_G(nojet)
assert not np.any(lt)
print('WITHOUT JET TERM',lt,'JET CONTRIBUTION',(lam-lt)%5,flush=True)
monly=-(B_g*delta).mod(25)
notaylor=[[j11,j11*monly],[j21,j21*monly+j22]]
lt,_,_=obstruction_from_G(notaylor)
print('WITHOUT QUADRATIC TAYLOR',lt,'QUAD CONTRIBUTION',(lam-lt)%5,flush=True)
# the variation G under a change of local Frobenius lift F_U(z) by25 f_z
# choose globally regular derivation in rational frame eta^-1, delta m=-5 g^5* (chi_Dz)^5.
# for chi regular on U = 1,u,v, the scalar residue must be unchanged
for chi in [Ser(1),u,v]:
 dg=[[Ser(0),5*Z**-5*chi**5],[Ser(0),Ser(0)]]
 gg=[[G[i][j]+dg[i][j] for j in range(2)]for i in range(2)]
 la,ab,_=obstruction_from_G(gg)
 assert np.array_equal(la,lam)
 assert not np.any((np.array(ab)-np.array(abc))%5)
 print('Frobenius local variation',chi.l,'lambda',la,'delta rho',(np.array(ab)-np.array(abc))%5,flush=True)

BO=IO[0][1].mod(5)
rho_jet=(Ser(mu)*Z**7*Dz**5*BO**2).mod(5)
abc_jet,_=redT(rho_jet)
print("JET RHO COEFFICIENTS",np.array(abc_jet).tolist())
print("NONJET RHO COEFFICIENTS",((np.array(abc)-np.array(abc_jet))%5).tolist())
print("HODGE LOCAL B COEFFICIENTS",[BO.coef(n).tolist() for n in [0,2,4]])
expected=np.array([[1,4,2,0],[1,1,0,1],[0,1,2,2]],dtype=np.int64)
assert np.array_equal(np.array(abc),expected)
assert np.array_equal(lam,np.array([3,4,4,3],dtype=np.int64))
assert np.array_equal(cm(mu,lam)%5,ONE)
assert np.array_equal(residue_of_rho(rho),lam)
print("PASS: lambda = 3 + 4*t + 4*t^2 + 3*t^3 = 1/(4+4*t), nonzero.")
