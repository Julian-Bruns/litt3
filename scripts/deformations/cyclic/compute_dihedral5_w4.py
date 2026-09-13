#!/usr/bin/env python3
"""Actual fourth-Witt comparison for an explicitly constructed D10 quotient.

Adapted from the fully replayed returned selected-cover certificate. Models
are constructed by construct_dihedral5_family_models.py. This worker computes
one compatible third lift; independence of its parameter is a separate theorem.
DIHEDRAL5_MODEL names its input JSON; NEUTRAL5_RUN_DIR names fresh output.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
from scripts.deformations.cyclic.neutral5_witt_algebra import *
import json, time, os
from pathlib import Path
start=time.time()
RUN_DIR=Path(os.environ.get('NEUTRAL5_RUN_DIR','runs/base'))
RUN_DIR.mkdir(parents=True,exist_ok=True)
FIELD_POWER=int(os.environ.get('NEUTRAL5_FIELD_POWER','0'))
PRIMITIVE_VARIANT=int(os.environ.get('NEUTRAL5_PRIMITIVE_VARIANT','0'))
KERNEL_VARIANT=int(os.environ.get('NEUTRAL5_KERNEL_VARIANT','0'))
if FIELD_POWER:
 for _ in range(FIELD_POWER):T=SIGMAT@T%MOD

def log(*s): print(round(time.time()-start,2),*s,flush=True)
model=json.load(open(os.environ['DIHEDRAL5_MODEL']))
assert model['neutral'], 'This scalar worker requires defect one'
hdata=model
if FIELD_POWER:
 def transport_coeff(cc):
  vv=ca(cc)
  for _ in range(FIELD_POWER):vv=SIGMAT@vv%5
  return vv.tolist()
 for key in ['numerator','denominator','hyperelliptic_polynomial','potential','double_polynomial','double_section','double_derivative','hodge_multiplier','obstruction_dual','kernel']:
  model[key]=[transport_coeff(cc) for cc in model[key]]
 model['mu']=transport_coeff(model['mu'])

def inp(key):return np.array(model[key],dtype=np.int64).T
def coeff_sqrt(a):
 a=ca(a)
 x=next((ca([j%5,(j//5)%5,(j//25)%5,j//125]) for j in range(625) if np.array_equal(cp(ca([j%5,(j//5)%5,(j//25)%5,j//125]),2)%5,a%5)),None)
 if x is None:raise ValueError(('not square',a))
 for _ in range(4):x=cm((x+cdiv(a,x))%MOD,ci(2))
 assert np.array_equal(cp(x,2),a)
 return x

def poly_exact(a,b,field=False):
 q,r=pdiv(a,b,field)
 assert not np.any(r), ('remainder',r)
 return q

def sub(a,b):return padd(a,-b)

genus=6; ell=genus-1
U=np.array([ca(0),ca(1)]).T
FC=inp('hyperelliptic_polynomial')
L0=inp('double_polynomial'); KC=inp('double_section')
BC=inp('double_derivative'); PC=inp('potential')
mu_expected=ca(model['mu'])%5
AT=pscale(pm(L0,ppow(KC,2)),ci(mu_expected))%5
assert np.array_equal(trim(AT),trim(np.array(hdata['hodge_multiplier']).T))
SC0=poly_exact(FC%5,L0,True)
assert not np.any(sub(padd(pm(SC0,pd(BC)),pscale(pm(pd(SC0),BC),ci(2))),pm(PC,KC))%5)
ldeg=L0.shape[1]-1
log('model',model['label'],'degrees L,K,B,P',ldeg,KC.shape[1]-1,BC.shape[1]-1,PC.shape[1]-1,'mu',mu_expected.tolist())
# Lift the ACTUAL unramified double by factor-Hensel on the original reference.
LC=L0.copy();SC=SC0.copy()
_,Sinv,_=pxgcd(SC0,L0)
for power in [5,25,125]:
 err=sub(FC,pm(LC,SC))
 assert np.all(err%power==0)
 ee=(err//power)%5
 dl=pdiv(pm(ee,Sinv)%5,L0,True)[1]
 ds=poly_exact(sub(ee,pm(SC0,dl))%5,L0,True)
 LC=padd(LC,power*dl);SC=padd(SC,power*ds)
assert not np.any(sub(FC,pm(LC,SC)))
AP=pm(LC,ppow(KC,2)); BP=pm(SC,ppow(BC,2))
gcd,pc,qc=pxgcd(AP,BP)
assert np.array_equal(gcd,ca(1).reshape(4,1))
log('bezout degrees',pc.shape[1]-1,qc.shape[1]-1)
# Laurent coordinate z=s^6/Y, with eta=ds/Y.
rev=FC[:,::-1]
x=Ser(FC[:,-1])*Z**2
for _ in range(13):x=x-(x-Z**2*peval(rev,x))/(1-Z**2*peval(pd(rev),x))
u=x.inv();v=u**genus/Z
g=-Z*x**(genus-2)*x.deriv();Dz=g.inv()
w2=peval(LC,u)*Z**(2*ldeg)
wconst=coeff_sqrt(w2.coef(0))
w=Ser(wconst)*(w2/Ser(cp(wconst,2))).sqrt1()/Z**ldeg
y=v/w
a=w*peval(KC,u);b=y*peval(BC,u)
c=-b*peval(qc,u);d=a*peval(pc,u)
P=peval(PC,u)
assert (a.deriv()/g-b).mod(5).cut(80).iszero()
assert (b.deriv()/g-P*a).mod(5).cut(80).iszero()
assert (a*d-b*c-1).mod(5).cut(80).iszero()
log('series prepared','g valuation',g.l,'a,b',a.l,b.l)
# Hodge data for the exact jet frame.
j=Z**ell
Dj=j.deriv()/g
aO=j**4*a;bO=j**5*(j*b-Dj*a)
use_b_chart=bO.mod(5).valuation==0
assert use_b_chart or aO.mod(5).valuation==0, 'No regular oper comparison chart'
f_target=(j*d-Dj*c)/(j*b-Dj*a) if use_b_chart else c/a
log('formal oper chart','b' if use_b_chart else 'a')
# Smooth affine Frobenius, through W4, with genuine coefficient Frobenius.
Fsig=SIGMAT@FC%MOD
Fder5=ppow(pd(FC)%5,5)%5;F3=ppow(FC,3)%5
_,Finv,_=pxgcd(Fder5,F3)
fu=ppow(U,5);bv=ppow(FC,2)
for power in [5,25,125]:
 err=padd(peval(Fsig,fu),-pm(FC,ppow(bv,2)))
 assert np.all(err%power==0), ('F error',power)
 ee=(err//power)%5
 ac=pdiv(-pm(ee,Finv)%5,F3,True)[1]
 if power==5 and args.frobenius_variant:ac=padd(ac,F3)%5
 bc=poly_exact(padd(ee,pm(Fder5,ac))%5,pscale(F3,ca(2))%5,True)
 fu=padd(fu,power*ac);bv=padd(bv,power*bc)
 log('F lift',power,'degrees',fu.shape[1]-1,bv.shape[1]-1)
assert not np.any(padd(peval(Fsig,fu),-pm(FC,ppow(bv,2))))
Fu=peval(fu,u);FBv=peval(bv,u)
fuz=Fu**genus/(v*FBv)
assert (fuz-Z**5).mod(5).cut(100).iszero()
delta_ref=(fuz-Z**5).divint(5)
f_ref=-(g.frob()*delta_ref).mod(5)
log('F reference', 'precision',f_ref.prec,'valuation',f_ref.l)
u5=u.mod(5);v5=v.mod(5)
powers={0:Ser(1)}
def upow(n):
 if n not in powers:powers[n]=u5**n
 return powers[n]

def reduce_h1(f,n=2*ell, anti=False, return_terms=False):
 f=f.mod(5);part=Ser(0);terms=[]
 for e in range(f.l,1):
  cc=f.coef(e)%5
  if not np.any(cc):continue
  if not anti:
   if e<=-(2*genus+1) and e%2:
    k=(-e-(2*genus+1))//2;bas=v5*upow(k);kind='v'
   elif e<=0 and e%2==0:k=-e//2;bas=upow(k);kind='u'
   else:continue
  else:
   if e<=-ldeg and (e+ldeg)%2==0:k=(-e-ldeg)//2;bas=w.mod(5)*upow(k);kind='w'
   elif e<=-(2*genus+1-ldeg) and (e+2*genus+1-ldeg)%2==0:k=(-e-(2*genus+1-ldeg))//2;bas=y.mod(5)*upow(k);kind='y'
   else:continue
  cf=cdiv(cc,bas.coef(e))%5;term=Ser(cf)*bas
  f=(f-term).mod(5);part=(part+term).mod(5);terms.append((kind,k,cf))
 inds=list(range(-(2*genus-1),0,2))+list(range(1,n))
 vec=np.array([f.coef(e)%5 for e in inds])
 return (vec,part,f,terms) if return_terms else (vec,part,f)

fullpowers={0:Ser(1)}
def ufull(n):
 if n not in fullpowers:fullpowers[n]=ufull(n-1)*u
 return fullpowers[n]

def lift_terms(terms):
 out=Ser(0)
 for kind,k,cf in terms:
  bas={'u':Ser(1),'v':v,'w':w,'y':y}[kind]*ufull(k)
  out=out+Ser(cf)*bas
 return out

def affine_lift(f,anti=False):
 _,part,rem,terms=reduce_h1(f,anti=anti,return_terms=True)
 assert rem.cut(80).iszero(),('not affine',rem.cut(80),anti)
 return lift_terms(terms)

texps=list(range(-(2*genus-1),0,2))+list(range(1,2*ell,2))
cols=[reduce_h1(f_target,10*ell)[0]]+[-reduce_h1(Z**(5*e),10*ell)[0]%5 for e in texps]
sol,pivs=linear_solve(np.stack(cols,axis=1),reduce_h1(f_ref,10*ell)[0])
mu=sol[0]
assert np.array_equal(mu,mu_expected),('mu mismatch',mu,mu_expected)
xi_coefs=np.array([cp(cc,125)%5 for cc in sol[1:]])
xi=sum((Ser(cc)*Z**e for cc,e in zip(xi_coefs,texps)),Ser(0))
log('first xi',xi_coefs.tolist(),'pivots',pivs)
f_actual=(f_ref+xi**5).mod(5)
diff=(Ser(mu)*f_target-f_actual).mod(5)
rr,qU,rem=reduce_h1(diff,10*ell)
assert not np.any(rr)
qO=-(rem/Z**(10*ell)).mod(5)
qUlift=affine_lift(qU);qOlift=qO
beta=d*c.deriv()-c*d.deriv()+(-d*d+P*c*c)*g
zeta=Fu.deriv().divint(5)/(v*FBv)
conncheck=(Ser(mu)*beta-qU.deriv()+zeta).mod(5).cut(80)
assert conncheck.prec>=80 and conncheck.iszero(),('connection',conncheck)
log('FIRST FL CONNECTION CHECK PASS','qU,qO valuations',qU.l,qO.l)
all_tangent_exponents=list(range(-(2*genus-1),0,2))+list(range(1,2*ell))
full_frobenius=np.stack([reduce_h1(Z**(5*ee),10*ell)[0] for ee in all_tangent_exponents],axis=1)
_,first_pivots=linear_solve(full_frobenius,np.zeros((full_frobenius.shape[0],4),dtype=np.int64))
assert len(first_pivots)==15
log('PASS full first-lift Frobenius injectivity: rank15; same marked T2')

# Save finite reproducibility data before next stage.
(RUN_DIR/'genus6_first_stage.json').write_text(json.dumps(dict(status='PASS first-stage only',precision=MAX,mu=mu.tolist(),first_lift_frobenius_rank=15,xi_exponents=texps,xi_coefficients=xi_coefs.tolist(),frobenius_T=SIGT.tolist(),potential=PC.T.tolist(),double_polynomial_lift=LC.T.tolist(),model_label=model['label']),indent=2)+'\n')

if os.environ.get('NEUTRAL5_FIRST_ONLY')=='1':
 log('PASS requested first-stage audit')
 raise SystemExit(0)

def der(f):return f.deriv()/g

def mm(A,B):return [[sum((A[i][k]*B[k][jj] for k in range(2)),Ser(0)) for jj in range(2)] for i in range(2)]
def mi(M):
 dt=M[0][0]*M[1][1]-M[0][1]*M[1][0]
 return [[M[1][1]/dt,-M[0][1]/dt],[-M[1][0]/dt,M[0][0]/dt]]
def mfun(A,f):return [[f(x) for x in row] for row in A]
MU=[[Ser(1),qUlift],[Ser(0),Ser(1)]]
MO=[[Ser(1),qOlift],[Ser(0),Ser(1)]]
SU=[[a,Ser(mu)*c],[b,Ser(mu)*d]]
aO=j**4*a;bO=j**5*(j*b-Dj*a)
SO=[[aO,-Ser(mu)/bO],[bO,Ser(0)]] if use_b_chart else [[aO,Ser(0)],[bO,Ser(mu)/aO]]
IU=mm(MU,mi(SU));IO=mm(MO,mi(SO));log("first comparison matrices constructed")
if PRIMITIVE_VARIANT:
 gu=Ser(T)+Ser(cp(T,2))*u
 go=Ser(T)*Z
 IU=mm(IU,[[Ser(1),5*gu],[Ser(0),Ser(1)]])
 IO=mm(IO,[[Ser(1),5*go],[Ser(0),Ser(1)]])
 log('changed regular Cech comparison lifts with coefficients outside F5')
chi=Ser(0)

def make_curve(chi):
 vv=5*xi-25*chi
 def V(f):return vv*der(f)
 def phi(f):return f+V(f)+Ser(ci(2))*V(V(f))+Ser(ci(6))*V(V(V(f)))
 A=1+der(vv)+Ser(ci(2))*der(V(vv))+Ser(ci(6))*der(V(V(vv)))
 am=A-1
 q=j*(1+Ser(ci(2))*am-Ser(ci(8))*am**2+Ser(ci(16))*am**3)
 return phi,A,q

def higher_G(chi,level):
 phi,A,q=make_curve(chi)
 log("curve gluing built",level)
 delta=(phi(fuz)-phi(Z).frob()).divint(5)
 log("Frobenius difference built",level,"prec",delta.prec,"valuation",delta.l)
 B_g=phi(g).frob();B_gp=phi(g.deriv()).frob()
 if level==2:
  m=-(B_g*delta+Ser(cm(ca(5),ci(2)))*B_gp*delta**2).mod(25)
  Taylor=[[Ser(1),m],[Ser(0),Ser(1)]]
 else:
  B_gpp=phi(g.deriv().deriv()).frob();B_P=phi(P).frob()
  md=Ser(cm(ca(25),ci(2)))*B_P*B_g**2*delta**2
  mup=-(B_g*delta+Ser(cm(ca(5),ci(2)))*B_gp*delta**2+Ser(cm(ca(25),ci(6)))*(B_gpp+B_P*B_g**3)*delta**3)
  mlo=-25*B_P*B_g*delta
  Taylor=mfun([[1+md,mup],[mlo,1+md]],lambda x:x.mod(125))
 log("Taylor built",level)
 j11=q.inv().frob();j22=q.frob();j21=(-5*der(q)/A).frob()
 JJ=[[j11,Ser(0)],[j21,j22]]
 GG=mm(JJ,Taylor)
 return GG,phi,A,q,Taylor

def rho_from(GG,phi,I_U,I_O,power):
 jet=mm(mm(mi(I_O),GG),mfun(I_U,phi))
 r=j*jet[0][1].mod(5*power).divint(power)
 return r,jet

G2,phi,A,q,Taylor2=higher_G(Ser(0),2)
J0=[[j.inv(),Ser(0)],[-Dj,j]]
jet0=mm(mm(mi(IO),G2),mfun(IU,phi))
for ii in range(2):
 for jj in range(2):
  ck=(jet0[ii][jj]-J0[ii][jj]).mod(5).cut(50)
  assert ck.prec>=50 and ck.iszero(),('jet mod5',ii,jj,ck)
log('G2 mod5 = original twisted jet PASS')
rho2,jet0=rho_from(G2,phi,IU,IO,5)
rvec,_,_=reduce_h1(rho2)
log('primary rho precision',rho2.prec,'vector',rvec.tolist())
# Exact semilinear primary repair, in the formal-patching coordinates just constructed.
AA=peval(AT,u).mod(5)
mcols=[reduce_h1(AA*Z**(5*e))[0] for e in texps]
M_z=np.stack(mcols,axis=1)
sol2,pivs2=linear_solve(M_z,rvec)
chicoefs=np.array([cp(cc,125)%5 for cc in sol2])
chi=sum((Ser(cc)*Z**e for cc,e in zip(chicoefs,texps)),Ser(0))
if KERNEL_VARIANT:
 kv=np.array(hdata['kernel'],dtype=np.int64)
 kreduced=reduce_h1(sum((Ser(cc)*v5*x.mod(5)**(i+1) for i,cc in enumerate(kv)),Ser(0)))[0]
 all_exps=list(range(-(2*genus-1),0,2))+list(range(1,2*ell))
 kernelpoly=sum((Ser(cc)*Z**e for cc,e in zip(kreduced,all_exps)),Ser(0))
 assert not np.any(reduce_h1(AA*kernelpoly**5)[0])
 chi=chi+Ser(T)*kernelpoly
 log('added t times the supplied kernel direction')
actual_chi_coefs=np.array([chi.coef(ee)%5 for ee in texps])
log('actual primary repair chi',actual_chi_coefs.tolist(),'rank',len(pivs2))
# Rebuild the actual smooth W3 with the primary repair; no abstract zero is substituted.
G2,phi,A,q,Taylor2=higher_G(chi,2)
rho2,jet2=rho_from(G2,phi,IU,IO,5)
rv,part,rem=reduce_h1(rho2)
assert not np.any(rv),('primary not repaired',rv)
uU=-affine_lift(part);uO=(rem/j**2).mod(5)
assert uO.l>=0 or uO.iszero()
log('actual primary normal cocycle is a coboundary','uU,uO valuations',uU.l,uO.l)
# Actual first corrected Hodge generators in the original inverse-Cartier frames.
hU=[IU[i][1]+5*uU*IU[i][0] for i in range(2)]
hO=[IO[i][1]+5*uO*IO[i][0] for i in range(2)]
zetaU=zeta.mod(25)
zetaO=(g/j**2).frob()*Z**4

def ds_comparison(h,zeta_local,e_local):
 h=[x.mod(25) for x in h]
 def negcov(h):return [(-h[0].deriv()+zeta_local*h[1])/e_local,-h[1].deriv()/e_local]
 c1=negcov(h)
 wr=(c1[0]*h[1]-c1[1]*h[0]).mod(25)
 scale=1+Ser(ci(2))*((1/(Ser(mu)*wr))-1)
 h=[(scale*x).mod(25) for x in h]
 c1=negcov(h)
 out=mfun([[c1[0],h[0]],[c1[1],h[1]]],lambda x:x.mod(25))
 ck=(out[0][0]*out[1][1]-out[1][0]*out[0][1]-1/Ser(mu)).mod(25).cut(60)
 assert ck.prec>=60 and ck.iszero(),('DS determinant',ck)
 return out
I2Uraw=ds_comparison(hU,zetaU,g)
I2Oraw=ds_comparison(hO,zetaO,g/j**2)
for lab,II,I1 in [('U',I2Uraw,IU),('O',I2Oraw,IO)]:
 for ii in range(2):
  for jj in range(2):
   ck=(II[ii][jj]-I1[ii][jj]).mod(5).cut(60)
   assert ck.prec>=60 and ck.iszero(),('DS mod5',lab,ii,jj,ck)
log('corrected Hodge generators and normalized DS frames constructed')

def lift_affine25(f,anti):
 f0=affine_lift(f.mod(5),anti=anti)
 digit=(f-f0).mod(25).divint(5)
 f1=affine_lift(digit,anti=anti)
 return f0+5*f1
I2U=mfun(I2Uraw,lambda f:lift_affine25(f,True))
I2O=mfun(I2Oraw,lambda f:f.mod(25))
for row in I2O:
 for f in row:assert f.l>=0 or f.iszero(),('O pole',f)
jetcheck=mm(mm(mi(I2O),G2),mfun(I2U,phi))
Jexact=[[q.inv(),Ser(0)],[-der(q)/A,q]]
for ii in range(2):
 for jj in range(2):
  ck=(jetcheck[ii][jj]-Jexact[ii][jj]).mod(25).cut(40)
  assert ck.prec>=40 and ck.iszero(),('W2 DS jet',ii,jj,ck)
log('FULL W2 JET TRANSITION CHECK PASS')
(RUN_DIR/'genus6_second_stage.json').write_text(json.dumps(dict(status='PASS through compatible Hodge line on W2',precision=MAX,chi_exponents=texps,chi_coefficients=actual_chi_coefs.tolist(),primary_reference_vector=rvec.tolist()),indent=2)+'\n')
# === ABSOLUTE FOURTH-WITT NORMAL COCYCLE ===
G3,phi3,A3,q3,Taylor3=higher_G(chi,3)
log('full next Taylor and jet assembled')
rho4,jet3=rho_from(G3,phi3,I2U,I2O,25)
log('fourth normal cocycle assembled','precision',rho4.prec,'valuation',rho4.l)
# The target functional is exactly the ordinary saved row, with no extra Frobenius.
dual=np.array(hdata['obstruction_dual'],dtype=np.int64)
x5=x.mod(5)
transport=np.stack([reduce_h1(v5*x5**i)[0] for i in range(1,12)],axis=1)
qdual=-Ser(ci(2))*sum((Ser(cc)*upow(i) for i,cc in enumerate(dual)),Ser(0))
def scalar(r):
 rv,_,_=reduce_h1(r)
 vec,pv=linear_solve(transport,rv)
 cc=sum((cm(aa,bb) for aa,bb in zip(dual,vec)),start=ca(0))%5
 residue=(r.mod(5)*qdual*g.mod(5)).mod(5).coef(-1)%5
 assert np.array_equal(cc,residue),('residue normalization',cc,residue)
 return cc,vec
c4,r4vec=scalar(rho4)
log('C4 EXACT',c4.tolist(),'R4',r4vec.tolist())
(RUN_DIR/'genus6_fourth_result.json').write_text(json.dumps(dict(status='Computed pending independent checks',precision=MAX,c4=c4.tolist(),rho4_vector=r4vec.tolist(),rho4_precision=rho4.prec,normalization='saved obstruction_dual ordinary row pairing; independently matched direct residue'),indent=2)+'\n')
# Export actual local matrices and cochains, so the comparison can be replayed.
def encser(f):return dict(low=f.l,precision=f.prec,coefficients=f.a.T.tolist())
(RUN_DIR/'genus6_local_comparison.json').write_text(json.dumps(dict(
 curve_gluing=dict(vector_field='5*xi*D-25*chi*D; exponential through its cubic term modulo625',xi=encser(xi),chi=encser(chi)),
 first_hodge_normal_U=encser(uU),first_hodge_normal_O=encser(uO),
 I2U=[[encser(f) for f in row] for row in I2U],
 I2O=[[encser(f) for f in row] for row in I2O],rho4=encser(rho4.mod(5))),indent=2)+'\n')
log('exact local comparison serialized')
# === GEOMETRIC STRUCTURE CHECKS AT THE NEW PRECISION ===
P_FU=peval(SIGMAT@PC%MOD,Fu)
PO=(j**4*P).mod(5)
KU=[[Ser(0),-zeta.mod(125)],[-25*P_FU*zeta,Ser(0)]]
KO=[[Ser(0),-zetaO],[-25*PO.frob()*zetaO,Ser(0)]]
phi_dz=phi3(Z).deriv()
KUp=mfun(KU,lambda f:phi3(f)*phi_dz)
KOG=mm(KO,G3);GKUp=mm(G3,KUp)
for ii in range(2):
 for jj in range(2):
  ck=(G3[ii][jj].deriv()+KOG[ii][jj]-GKUp[ii][jj]).mod(125).cut(20)
  assert ck.prec>=20 and ck.iszero(),('W3 flat Taylor gluing',ii,jj,ck)
log('PASS actual next flat-connection gluing modulo125')
# Independently build the three Taylor coefficients by iterating the p-connection.
K=[[Ser(0),g],[25*P*g,Ser(0)]]
QQ=[[Ser(1),Ser(0)],[Ser(0),Ser(1)]]
Taylor_rec=[[Ser(1),Ser(0)],[Ser(0),Ser(1)]]
ddlt=(phi3(fuz)-phi3(Z).frob()).divint(5)
for nn,fact in [(1,1),(2,2),(3,6)]:
 KQQ=mm(K,QQ)
 QQ=[[5*QQ[ii][jj].deriv()-KQQ[ii][jj] for jj in range(2)] for ii in range(2)]
 for ii in range(2):
  for jj in range(2):Taylor_rec[ii][jj]=Taylor_rec[ii][jj]+Ser(ci(fact))*phi3(QQ[ii][jj]).frob()*ddlt**nn
for ii in range(2):
 for jj in range(2):
  ck=(Taylor_rec[ii][jj]-Taylor3[ii][jj]).mod(125).cut(20)
  assert ck.prec>=20 and ck.iszero(),('iterated p-connection Taylor',ii,jj,ck)
log('PASS independent iterated p-connection Taylor formula')
# === RECORDED DECOMPOSITION OF THE ACTUAL COCHAIN ===
# Lift the mod-five comparisons on their actual affine/formal charts.
I0U=mfun(IU,lambda f:affine_lift(f.mod(5),anti=True))
I0O=mfun(IO,lambda f:f.mod(5))
nuU=[[affine_lift((I2U[ii][jj]-I0U[ii][jj]).mod(25).divint(5),anti=True) for jj in range(2)] for ii in range(2)]
nuO=[[(I2O[ii][jj]-I0O[ii][jj]).mod(25).divint(5) for jj in range(2)] for ii in range(2)]
for II,II0,nu in [(I2U,I0U,nuU),(I2O,I0O,nuO)]:
 for ii in range(2):
  for jj in range(2):
   ck=(II[ii][jj]-II0[ii][jj]-5*nu[ii][jj]).mod(125).cut(40)
   assert ck.prec>=40 and ck.iszero(),('linear lift decomposition',ii,jj,ck)
delta=(phi3(fuz)-phi3(Z).frob()).divint(5)
Bg=phi3(g).frob();Bgp=phi3(g.deriv()).frob()
m12=-(Bg*delta+Ser(cm(ca(5),ci(2)))*Bgp*delta**2)
j11=q3.inv().frob();j22=q3.frob();j21=(-5*der(q3)/A3).frob()
Gupper=mfun([[j11,j11*m12],[Ser(0),j22]],lambda f:f.mod(125))
base=mm(mm(mi(I0O),Gupper),mfun(I0U,phi3))
Uresp=mm(mm(mi(I0O),Gupper),mfun(nuU,phi3))
B=mm(mi(I0O),nuO)
Bbase=mm(B,base)
lin=[[base[ii][jj]+5*(Uresp[ii][jj]-Bbase[ii][jj]) for jj in range(2)] for ii in range(2)]
r_carry=j*lin[0][1].mod(125).divint(25)
B2base=mm(mm(B,B),base);BU=mm(B,Uresp)
r_quad=(j*(B2base[0][1]-BU[0][1])).mod(5)
I0U5=mfun(I0U,lambda f:f.mod(5));I0O5=mfun(I0O,lambda f:f.mod(5))

def extra_normal(Q):
 gg=mm(mm(mi(I0O5),Q),I0U5)
 return (j*gg[0][1]).mod(5)
d0=delta.mod(5);bg0=Bg.mod(5);pp0=P.frob().mod(5)
j1=j**-5;j2=j**5
jet25=j21.mod(125).divint(25).mod(5)
r_jet=extra_normal([[Ser(0),Ser(0)],[jet25,-jet25*bg0*d0]])
r_cubic=extra_normal([[Ser(0),-Ser(ci(6))*j1*g.deriv().deriv().frob().mod(5)*d0**3],[Ser(0),Ser(0)]])
dp=Ser(ci(2))*pp0*bg0**2*d0**2
r_previous=extra_normal([[j1*dp,-Ser(ci(6))*j1*pp0*bg0**3*d0**3],[-j2*pp0*bg0*d0,j2*dp]])
parts={'divided_linear_carry':r_carry,'quadratic_first_repairs':r_quad,'weighted_jet':r_jet,'cubic_Taylor_derivative':r_cubic,'preceding_oper_potential':r_previous}
part_values={};sumrho=Ser(0)
for name,r in parts.items():
 cv,rv=scalar(r)
 part_values[name]=dict(scalar=cv.tolist(),vector=rv.tolist())
 sumrho=sumrho+r
 log('DECOMPOSITION',name,cv.tolist())
ck=(sumrho-rho4).mod(5).cut(30)
assert ck.prec>=30 and ck.iszero(),('cochain decomposition',ck)
# Independent closed formula for the order-25 weighted-jet contribution.
BO=I0O[0][1].mod(5)
jet_degree=(Ser(mu)*j**7*(Z**4/g).frob()*BO**2).mod(5)
jet_marking=(Ser(mu)*j**7*(Ser(ci(2))*j*der(der(xi))).frob()*BO**2).mod(5)
ck=(jet_degree+jet_marking-r_jet).mod(5).cut(30)
assert ck.prec>=30 and ck.iszero(),('closed jet formula',ck)
for name,r in [('theta_degree_part',jet_degree),('marked_curve_part',jet_marking)]:
 cv,rv=scalar(r)
 part_values[name]=dict(scalar=cv.tolist(),vector=rv.tolist())
 log('INDEPENDENT JET FORMULA',name,cv.tolist())
(RUN_DIR/'genus6_decomposition.json').write_text(json.dumps(dict(status='PASS exact cochain decomposition and independent jet formula',c4=c4.tolist(),components=part_values),indent=2)+'\n')
log('PASS: fourth scalar, exact cochain decomposition, and independent weighted-jet coefficient')

result=json.loads((RUN_DIR/'genus6_fourth_result.json').read_text())
result.update(model_label=model['label'],status='PASS complete normal comparison, geometric structure checks, direct residue, and decomposition',frobenius_variant=args.frobenius_variant,field_power=FIELD_POWER,primitive_variant=PRIMITIVE_VARIANT,kernel_variant=KERNEL_VARIANT,first_lift_frobenius_rank=15)
(RUN_DIR/'genus6_fourth_result.json').write_text(json.dumps(result,indent=2)+'\n')
