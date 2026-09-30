# Adapted locally21 September2026; original audited source preserved outside the repo.
from witt import *
# === INPUT AND CANONICAL FIRST LIFT ===
import time
start=time.time()
print('START',flush=True)
U=np.array([ca(0),ca(1)]).T
FC=ca(1).reshape(DIM,1)
for root in [ca(0),ca(1),ca(2),ca(3),T]:FC=pm(FC,np.array([-root,ca(1)]).T)
SC=ca(1).reshape(DIM,1)
for root in [ca(0),ca(1),ca(2),ca(3)]:SC=pm(SC,np.array([-root,ca(1)]).T)
RC=np.array([-T,ca(1)]).T
h=(4*T+ca(3))%MOD
HC=np.array([-h,ca(1)]).T
BC=pscale(np.array([-2*T-h,ca(3)]).T,ci(2))
AP=pm(RC,ppow(HC,2));BP=pm(SC,ppow(BC,2))
gcd,pc,qc=pxgcd(AP,BP)
assert np.array_equal(gcd,ca(1).reshape(DIM,1))
assert not np.any(padd(padd(pm(AP,pc),pm(BP,qc)),-ca(1).reshape(DIM,1))%5)
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
for power in [5,25,125]:
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
delta_ref=(fuz-Z**5).cut(MAX-50).divint(5)
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
mu=sol[0];xi_coefs=np.array([cp(c,5**(DIM-1))%5 for c in sol[1:]])
xi=sum((Ser(c)*Z**e for c,e in zip(xi_coefs,[-3,-1,1])),Ser(0))
print('XI',xi,flush=True)
assert np.array_equal(mu,tpoly([4,4])%5)
assert np.array_equal(xi_coefs,np.array([tpoly(c)%5 for c in [[2,4,1,3],[3,3,0,1],[4,0,0,3]]],dtype=np.int64)), 'Original marked C2 was changed'
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
zeta=Fu.deriv().cut(MAX-50).divint(5)/(v*FBv)
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
delta=num.cut(MAX-80).divint(5)
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

# Changing the coefficient field basis changes the coefficientwise lift of
# xi, hence the chosen smooth W3 reference by a legitimate last digit.
# Record its ACTUAL primary cohomology class, rather than reuse the old
# representative without the corresponding Psi-image correction.
rho_base=(Z*Gj[0][1].mod(25).cut(70).divint(5)).mod(5)
BASE_RHO,_,_=reduce_h1(rho_base,n=2)
assert BASE_RHO.shape==(3,DIM)
base_weights=[tpoly(cc)%5 for cc in [[1,1,3],[4,3],[3]]]
base_pair=sum((cm(c,w) for c,w in zip(BASE_RHO,base_weights)),start=ca(0))%5
assert np.array_equal(cm(base_pair,mu)%5,ONE),'Base obstruction changed outside Psi image'
