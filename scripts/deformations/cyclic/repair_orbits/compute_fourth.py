# Adapted locally21 September2026; original audited source preserved outside the repo.
from base_setup import *
from as5 import AS,S,HS,H,SPHI
import json, math
from pathlib import Path
DATA=dict(DATA)
DATA['primary_repair']=DATA['preimage']
DATA['kernel_d'],DATA['kernel_b']=DATA['kernel']
DATA['hodge_matrix']=DATA['psi']
Qas=np.array(DATA['affine_Q_coefficients'],dtype=np.int64).T
VQ=v*peval(Qas,u)
shift=sum((Ser(ca(cc))*Z**e for cc,e in zip(DATA['shift_coefficients'],[-3,-1])),Ser(0))
# Characteristic-five solution, with the prescribed AS infinity shift.
tail=(VQ-(shift**5-Ser(H)*shift)).mod(5)
assert tail.valuation>=1
r=Ser(0)
for _ in range(6):r=((r**5-tail)*Ser(ci(H))).mod(5)
R=(shift+r).mod(5)
assert (R**5-Ser(H)*R-VQ).mod(5).cut(100).iszero()
WU=S+AS(R)
for _ in range(3): WU=WU-(WU**5-AS(HS)*WU-AS(VQ))/(5*WU**4-AS(HS))
err=(WU**5-AS(HS)*WU-AS(VQ)).cut(100)
assert err.prec>=100 and err.iszero(),('AS lift fails',err)
print('AS HENSEL', 'WU val',WU.valuation,'precision',WU.prec,'time',time.time()-start,flush=True)
# Work in the integral formal etale coefficient algebra s^5-Hs=0.
# The point of the repair plane can be changed through environment variables.
def parameter(text):
 vals=[int(x)%5 for x in text.split(',')]
 if len(vals)>DIM:raise ValueError('Too many field coefficients')
 return ca(vals)
DVAL=parameter(args.parameter_d)
BVAL=parameter(args.parameter_b)
coords=np.array(DATA['primary_repair'],dtype=np.int64)
base_matrix=np.array(DATA['hodge_matrix'],dtype=np.int64)[:3,:3,:]
base_delta=(BASE_RHO-np.array(DATA['rho'][:3],dtype=np.int64))%5
base_adjust5,_=linear_solve(base_matrix,base_delta)
base_adjust=np.array([cp(c,5**(DIM-1))%5 for c in base_adjust5])
coords[:3]=(coords[:3]+base_adjust)%5
print('ACTUAL REFERENCE ADJUSTMENT',base_adjust.tolist(),flush=True)
coords=(coords+np.array([cm(DVAL,ca(x)) for x in DATA['kernel_d']])+np.array([cm(BVAL,ca(x)) for x in DATA['kernel_b']]))%5
repair=AS(0)
for j in range(5):
 coeff=sum((Ser(coords[3*j+i])*Z**e for i,e in enumerate([-3,-1,1])),Ser(0))
 repair=repair+AS(coeff)*(WU**j)

# Torsor +xi has geometric overlap exp(5 xi_C D -25 xi D).
# Its top extension digit is fixed by the displayed exponential; changing it
# adds an image of Psi to the final obstruction and does not affect dual rows.
def der5(x):return AS(x).deriv()*AS(g.inv())
top=AS(0)
if args.fourth_index!=-1:
 assert 0<=args.fourth_index<15
 j,i=divmod(args.fourth_index,3)
 top=AS(Ser(parameter(args.fourth_coeff))*Z**[-3,-1,1][i])*(WU**j)
L=AS(5*xi)-25*repair-125*top

def LD(x):return L*der5(x)
def tau(x):
 x=AS(x);a=LD(x);b=LD(a);c=LD(b)
 return x+a+b*AS(Ser(ci(2)))+c*AS(Ser(ci(6)))

def amatrix(A):return [[AS(x) for x in row] for row in A]
def mm5(A,B):return [[sum((A[i][k]*B[k][j] for k in range(2)),AS(0)) for j in range(2)] for i in range(2)]
def mi5(M):
 dt=M[0][0]*M[1][1]-M[0][1]*M[1][0]
 return [[M[1][1]/dt,-M[0][1]/dt],[-M[1][0]/dt,M[0][0]/dt]]
def mtau(A):return [[tau(x) for x in row] for row in A]
IU5=amatrix(IU);IO5=amatrix(IO)
Az=AS(1)+der5(L)+AS(Ser(ci(2)))*der5(L*der5(L))+AS(Ser(ci(6)))*der5(L*der5(L*der5(L)))
a1=Az-1
qz=AS(Z)*(1+AS(Ser(ci(2)))*a1-AS(Ser(ci(8)))*a1**2+AS(Ser(ci(16)))*a1**3)
tz=tau(Z)
eta_check=(Az-AS(g).inv()*tau(g)*tz.deriv()).mod(625).cut(30)
assert eta_check.prec>=30 and eta_check.iszero(),('eta',eta_check)
Delta=(tau(fuz)-tz.frob()).divint(5)
bg=tau(g).frob();bgp=tau(g.deriv()).frob()
# This is inverse Cartier at order25, before correcting its Hodge generators.
mt=-(bg*Delta+AS(Ser(cm(5,ci(2))))*bgp*Delta**2)
j11=qz.inv().frob();j22=qz.frob();j21=(-5*der5(qz)/Az).frob()
G2=[[j11,j11*mt],[j21,j21*mt+j22]]
GG2=mm5(mm5(mi5(IO5),G2),mtau(IU5))
rho2=(AS(Z)*GG2[0][1].mod(25).divint(5)).mod(5)
print('RHO2 FORMAL',rho2.valuation,rho2.prec,'time',time.time()-start,flush=True)

# Return exact cohomology coordinates and genuine affine/formal boundary lifts.
# Coefficients are first moved from s to w_U using w_U=s+R mod5.
powR=[(-R)**j for j in range(5)]
powWU=[WU**j for j in range(5)]
u_powers={0:Ser(1)}
def umon(n):
 if n not in u_powers:u_powers[n]=u**n
 return u_powers[n]
def affbs(e):
 if e<=-5 and e%2:return v*umon((-e-5)//2)
 if e<=0 and e%2==0:return umon(-e//2)
 return None

def split_cohom(x):
 x=AS(x).mod(5)
 wc=[sum((x.c[j]*powR[j-i]*math.comb(j,i) for j in range(i,5)),Ser(0)).mod(5) for i in range(5)]
 affine=AS(0);form=[Ser(0) for _ in range(5)];can=[None]*5; records=[]
 for j in range(4,-1,-1):
  f=wc[j].mod(5);apart=Ser(0)
  for e in range(min(f.valuation,0),1):
   bs=affbs(e)
   if bs is None:continue
   cc=f.coef(e)%5
   if not np.any(cc):continue
   scalar=cdiv(cc,bs.coef(e))%5
   records.append(dict(w_degree=j, v_degree=int(e%2!=0),
                       u_degree=int((-e-5)//2 if e%2 else -e//2),
                       coefficient=scalar.tolist()))
   term=Ser(scalar)*bs
   apart=apart+term;f=(f-term).mod(5)
  affine=affine+AS(apart)*powWU[j]
  can[j]=np.array([f.coef(e)%5 for e in [-3,-1,1]])
  canonical=sum((Ser(c)*Z**e for c,e in zip(can[j],[-3,-1,1])),Ser(0))
  ftail=(f-canonical).mod(5)
  assert ftail.valuation>=2,(j,ftail)
  assert ftail.prec>3*j+20,('low tail precision',j,ftail.prec)
  form[j]=ftail/Z**2
  # Subtract the complete infinity coboundary ftail*s^j from wc.
  for i in range(j):wc[i]=(wc[i]-math.comb(j,i)*powR[j-i]*ftail).mod(5)
 ans=np.concatenate(can)
 formal=AS(form)
 cc=AS(0)
 for j in range(5):
  cc=cc+AS(sum((Ser(c)*Z**e for c,e in zip(can[j],[-3,-1,1])),Ser(0)))*powWU[j]
 ck=(x-affine-AS(Z**2)*formal-cc).mod(5).cut(30)
 assert ck.prec>=30 and ck.iszero(),('split fails',ck)
 split_cohom.last_records=records
 return ans,affine,formal

co2,aff2,fo2=split_cohom(rho2)
first_affine_records=[dict(x,coefficient=[(-c)%5 for c in x["coefficient"]]) for x in split_cohom.last_records]
print('PRIMARY NORMAL CLASS',co2.tolist(),flush=True)
assert not np.any(co2),'Chosen sign or repair wrong'
uU=-aff2;uO=fo2
print('HODGE PRIMITIVES',uU.valuation,uO.valuation,'precision',uU.prec,uO.prec,'time',time.time()-start,flush=True)
# Correct the actual local Hodge generators, and normalize their Wronskians.
# The local H2 connection modulo25 has only its upper right entry.
zetaU=zeta  # exact d F_U(u) / (5 F_U(v))
zetaO=Z**4*(g/Z**2).frob()

def corrected(Ii,ui,zetai,di):
 hh=[Ii[i][1]+5*ui*Ii[i][0] for i in range(2)]
 # di is the coefficient of the local dual differential relative to d/dz.
 def cov(hh):return [(hh[0].deriv()-AS(zetai)*hh[1])*AS(di),hh[1].deriv()*AS(di)]
 ch=[-x for x in cov(hh)]
 wr=ch[0]*hh[1]-ch[1]*hh[0]
 excess=AS(Ser(mu))*wr-1
 assert excess.mod(5).cut(40).iszero(),('Wronskian mod5',excess.mod(5))
 # The chosen regular lift is enough through125; binomial denominators are units.
 scale=1-AS(Ser(ci(2)))*excess+AS(Ser(cm(3,ci(8))))*excess**2
 hh=[(scale*x).mod(125) for x in hh]
 ch=[(-x).mod(125) for x in cov(hh)]
 M=[[ch[0],hh[0]],[ch[1],hh[1]]]
 ck=(AS(Ser(mu))*(ch[0]*hh[1]-ch[1]*hh[0])-1).mod(125).cut(30)
 assert ck.prec>=30 and ck.iszero(),('normalized det',ck)
 for i in range(2):
  for j in range(2):
   ck=(M[i][j]-Ii[i][j]).mod(5).cut(30)
   assert ck.prec>=30 and ck.iszero(),('frame mod5',i,j,ck)
 return M

I2U=corrected(IU5,uU,zetaU,g.inv())
I2O=corrected(IO5,uO,zetaO,Z**2/g)
GG2c=mm5(mm5(mi5(I2O),G2),mtau(I2U))
ck=GG2c[0][1].mod(25).cut(30)
assert ck.prec>=30 and ck.iszero(),('corrected Hodge fails',ck)

Jexpected=[[qz.inv(),AS(0)],[-der5(qz)/Az,qz]]
for i in range(2):
 for j in range(2):
  chkj=(GG2c[i][j]-Jexpected[i][j]).mod(25).cut(20)
  assert chkj.prec>=20 and chkj.iszero(),('corrected full jet',i,j,chkj)
print('FULL CORRECTED JET CHECK PASS',flush=True)
print('COMPATIBLE THIRD HODGE CHECK PASS',time.time()-start,flush=True)
# Full order125 Taylor, including the old oper potential and the cubic term.
bpg2=tau(P*g*g).frob()
cubic=tau(g.deriv().deriv()+P*g**3).frob()
mfull=-(bg*Delta+AS(Ser(cm(5,ci(2))))*bgp*Delta**2+AS(Ser(cm(25,ci(6))))*cubic*Delta**3)
diag=1+AS(Ser(cm(25,ci(2))))*bpg2*Delta**2
lower=-25*tau(P*g).frob()*Delta
TAY=[[diag,mfull],[lower,diag]]
JT=[[j11,AS(0)],[j21,j22]]
G3=mm5(JT,TAY)
GG3=mm5(mm5(mi5(I2O),G3),mtau(I2U))
rho4=(AS(Z)*GG3[0][1].mod(125).divint(25)).mod(5)
print('RHO4 FORMAL',rho4.valuation,rho4.prec,'time',time.time()-start,flush=True)
co4,af4,fo4=split_cohom(rho4)
dual=np.array(DATA['obstruction_dual_rows'],dtype=np.int64)
E=[sum((cm(a,b) for a,b in zip(row,co4)),start=ca(0))%5 for row in dual]
print('FOURTH RHO',co4.tolist(),flush=True)
print('E(d,b)',E,'d',DVAL,'b',BVAL,'time',time.time()-start,flush=True)
# Independent trace-residue evaluation.
qLambda=u*u+Ser(T+ca(3))*u+Ser(2*cp(T,2)+ca(4))
traceRes=(rho4.trace()*qLambda*g).mod(5).coef(-1)%5
print('TRACE RESIDUE',traceRes,flush=True)
assert np.array_equal(traceRes,E[0])
print('COMPLETED POINT',flush=True)
# Independent Riccati formula in the unnormalized corrected line frames.
N3=mm5(mm5(mi5(IO5),G3),mtau(IU5))
tuU=tau(uU)
Ccarry=(AS(Z)*N3[0][1].mod(125).divint(5)+tuU-AS(Z**2)*uO).mod(25).divint(5).mod(5)
a11=(N3[0][0]-AS(1/Z)).mod(25).divint(5)
a22=(N3[1][1]-AS(Z)).mod(25).divint(5)
Cmixed=(AS(Z)*(a11*uU-uO*a22)).mod(5)
Csquare=(AS(Z*Dz)*uO*uU).mod(5)
def trace_pair(x):return (x.trace()*qLambda*g).mod(5).coef(-1)%5
print('TRACE DECOMPOSITION carry,mixed,square',[trace_pair(x).tolist() for x in [Ccarry,Cmixed,Csquare]],flush=True)
rawrho=(Ccarry+Cmixed+Csquare).mod(5)
rawco,_,_=split_cohom(rawrho)
rawE=[sum((cm(a,b) for a,b in zip(row,rawco)),start=ca(0))%5 for row in dual]
assert all(np.array_equal(a,b) for a,b in zip(rawE,E))
print('RICCATI DUAL CHECK', [a.tolist() for a in rawE],flush=True)
# Check horizontality of the complete higher transition (mod125).
PO=(Z**4*P-Z**3*der(Dz)).mod(5)
assert PO.valuation>=0
BU3=[[AS(0),AS(-zetaU)],[-25*AS((P.mod(5)**5)*zetaU),AS(0)]]
BO3=[[AS(0),AS(-zetaO)],[-25*AS(PO.frob()*zetaO),AS(0)]]
BUP=[[tau(x)*tz.deriv() for x in row] for row in BU3]
aHor=mm5(BO3,G3);bHor=mm5(G3,BUP)
for i in range(2):
 for j in range(2):
  hcheck=(G3[i][j].deriv()+aHor[i][j]-bHor[i][j]).mod(125).cut(20)
  assert hcheck.prec>=20 and hcheck.iszero(),('horizontal third IC',i,j,hcheck)
print('FULL HIGHER HORIZONTALITY PASS',flush=True)

# Retain arithmetic Frobenius on the full formal etale branch algebra.
ss=S
for _ in range(DIM):ss=ss.frob()
assert (ss+S).iszero()
for _ in range(DIM):ss=ss.frob()
assert (ss-S).iszero()
assert args.fourth_index==-1,'Generic fourth-digit replay requires a saved reference receipt'
if DATA['cover_orbit']=='rational':
 assert np.array_equal(E[0],tpoly([4,2,2,4])%5)
 assert np.array_equal(cm(E[0],mu)%5,ca(3))
print('WITT FROBENIUS AND BRANCH TRANSPORT PASS',flush=True)
receipt=dict(status='PASS: exact fourth obstruction point calculation',
 coefficient_modulus=Q.tolist(),coefficient_degree=DIM,
 cover_orbit=DATA['cover_orbit'],embedded_tau_mod625=T.tolist(),
 actual_base_reference_rho=BASE_RHO.tolist(),primary_reference_adjustment=base_adjust.tolist(),
 primary_repair_used=coords.tolist(),
 parameter_d=DVAL.tolist(),parameter_b=BVAL.tolist(),
 fourth_index=args.fourth_index,fourth_coefficient=parameter(args.fourth_coeff).tolist(),
 laurent_workspace=MAX,frobenius_variant=args.frobenius_variant,
 witt_frobenius_mod625=SIGT.tolist(),
 rho4_certified_precision=rho4.prec,rho4_coordinates=co4.tolist(),
 obstruction_coordinates=[a.tolist() for a in E],trace_residue=traceRes.tolist(),
 trace_decomposition={name:trace_pair(x).tolist() for name,x in
 zip(['divided_carry','mixed_repairs','repair_product'],[Ccarry,Cmixed,Csquare])},
 primary_hodge_affine_generator_uU=first_affine_records,
 primary_hodge_formal_generator_uO={'meaning':'coefficients of s^j; s^5=H*s; unrecorded tail defined by (rho2+uU)/z^2 in the characteristic-five formal algebra',
 'precision':uO.prec,'coefficients_0_through_39':[[a.coef(i).tolist() for i in range(40)] for a in uO.c]},
 checks=['actual Artin-Schreier Hensel algebra','fixed base marking and original nonsplit flat line',
 'vanishing repaired primary normal class','full normalized corrected jet transition modulo25',
 'full higher inverse-Cartier horizontality modulo125','15-coordinate Cech reduction',
 'independent ordinary-trace residue','independent Riccati obstruction formula',
 'unramified coefficient Frobenius','non-split branch Frobenius transport'],
 seconds=time.time()-start)
import hashlib
receipt['source_sha256']={p.name:hashlib.sha256(p.read_bytes()).hexdigest()
 for p in Path(__file__).parent.glob('*.py') if p.name!='replay.py'}
if args.output:Path(args.output).write_text(json.dumps(receipt,indent=2)+'\n')
print('PASS: exact fourth obstruction; trace nonzero =',bool(np.any(E[0])),flush=True)
