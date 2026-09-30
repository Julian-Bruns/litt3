"""Rebuild the certificates from the input data. No finite-point search is used."""
from reconstruction import *
import platform, sys, time

def coded(T):
 """Convert an array with leading digit-axis 4 to portable E-integer codes."""
 return sum(T[j].astype(np.int64)*25**j for j in range(4)).tolist()

def uncoded(T):
 a=np.asarray(T,dtype=np.int64)
 return DIG[:,a]

def epquo(a,b):
 q,r=epdivmod(a,b)
 assert not r, ('not divisible',r)
 return q

def epder(a):return trim([emul(i%5,a[i]) for i in range(1,len(a))])
def egcd_poly(a,b):
 r0,r1=a,b;s0,s1=[1],[];t0,t1=[],[1]
 while r1:
  q,r=epdivmod(r0,r1)
  r0,r1=r1,r;s0,s1=s1,epsub(s0,epmul(q,s1));t0,t1=t1,epsub(t0,epmul(q,t1))
 if not r0:return [],[],[]
 z=einv(r0[-1]);return epscale(r0,z),epscale(s0,z),epscale(t0,z)

def bezout(a,b):
 g,s,t=egcd_poly(a,b)
 assert epadd(epmul(s,a),epmul(t,b))==g
 return {'a':a,'b':b,'gcd':g,'multiplier_a':s,'multiplier_b':t}

def getN(T,col):
 N=[[[] for _ in range(3)] for _ in range(6)]
 for idx,(i,r,a) in enumerate(VARS):N[i][r].append(enc(T[:,idx,col]))
 return [[trim(p) for p in nr] for nr in N]

def original_equations(T,tB):
 """Direct checks of the original (4), (5), and (6), not just the reduced matrix."""
 d=psub(Q,ppow(L,5));counts={'equation_4_remainders':0,'equation_5_remainders':0,'equation_6_weight_tests':0}
 for col in range(T.shape[2]):
  N=getN(T,col);kap=enc(T[:,195,col])
  for j in range(1,6):
   for r in range(min(3,j)):
    C=[]
    for i in range(j+1):
     c=math.comb(5-i,j-i)%5
     if c:C=epadd(C,epmul(N[i][r],pscale(ppow(pneg(B0),j-i),c)))
    assert not epmod(C,ppow(P,(j-r+2)//3)), ('4',col,j,r)
    counts['equation_4_remainders']+=1
  for j in range(5):
   for r in range(3):
    C=[]
    for i in range(6-j):
     c=math.comb(5-i,j)%5
     if c:C=epadd(C,epmul(N[i][r],pscale(ppow(pneg(L),5-i-j),c)))
    C=epmul(d,C)
    if j==0 and r==1:C=epadd(C,epscale(epmul(eppow(tB,3),ppow(P,3)),kap))
    assert not epmod(C,eppow(tB,5-j)), ('5',col,j,r)
    counts['equation_5_remainders']+=1
  for j in range(1,11):
   for r in range(3):
    C=N[j][r][:] if j<=5 else []
    if 0<=j-5<=5:C=epadd(C,epmul(Q,N[j-5][r]))
    if j==10 and r==1:C=epadd(C,epscale(epmul(eppow(tB,3),ppow(P,3)),kap))
    limit=10+12*j-max(0,j-5)
    assert all(not c or 3*a+10*r<=limit for a,c in enumerate(C)), ('6',col,j,r)
    counts['equation_6_weight_tests']+=1
 return counts

def linear_formula_basis(S2,S5,R10,tB):
 V=np.zeros((4,196,7),dtype=np.int16)
 # Columns: v=1,x,x^2,x^3,y; lambda=1; kappa=1 with v=lambda=0.
 for z,var in enumerate([(0,0,0),(0,0,1),(0,0,2),(0,0,3),(0,1,0)]):
  V[0,VARS.index(var),z]=1
  _,r,a=var
  for n,c in enumerate(Q):V[:,VARS.index((5,r,n+a)),z]=DIG[:,c]
 for n,c in enumerate(epmul(P,eppow(tB,2))):V[:,VARS.index((5,2,n)),5]=DIG[:,c]
 for j,R in [(3,S2),(4,S5),(5,R10)]:
  for n,c in enumerate(epmul(P,R)):V[:,VARS.index((j,1,n)),6]=DIG[:,c]
 V[0,195,6]=1
 return V

def infinity_matrix(tB):
 J=np.zeros((4,8,196),dtype=np.int16)
 specs=[(0,(5,1,20),1),(1,(3,1,12),Q[-1]),(2,(4,0,19),Q[-1]),(3,(5,2,16),Q[-1]),(4,(2,1,8),Q[-1]),(5,(3,0,15),Q[-1]),(6,(4,2,12),Q[-1]),(7,(5,1,19),Q[-1]),(7,(5,1,20),Q[-2])]
 for row,var,c in specs:J[0,row,VARS.index(var)]=c
 J[:,7,195]=DIG[:,emul(3,eadd(tB[-2],P[-2]))]
 return J

def extract_infinity_jets(T,tB):
 """Independent extraction from M_j, using t=x^3/y and x*t^3,y*t^10=1 mod t^3."""
 out=np.zeros((4,8,T.shape[2]),dtype=np.int16)
 for col in range(T.shape[2]):
  N=getN(T,col);kap=enc(T[:,195,col]);p0=[0]*11;p1=[0]*11
  for j in range(11):
   for r in range(3):
    C=N[j][r][:] if j<=5 else []
    if 0<=j-5<=5:C=epadd(C,epmul(Q,N[j-5][r]))
    if j==10 and r==1:C=epadd(C,epscale(epmul(eppow(tB,3),ppow(P,3)),kap))
    for a,c in enumerate(C):
     if not c:continue
     exponent=15+11*j-(3*a+10*r)
     assert exponent>=0
     if exponent==0:p0[10-j]=eadd(p0[10-j],c)
     if exponent==1:p1[10-j]=eadd(p1[10-j],c)
  assert all(c==0 for i,c in enumerate(p0) if i not in (0,1,2,5))
  assert all(c==0 for i,c in enumerate(p1) if i>3)
  for row,i in enumerate([5,2,1,0]):out[:,row,col]=DIG[:,p0[i]]
  for row,i in enumerate([3,2,1,0],4):out[:,row,col]=DIG[:,p1[i]]
 return out

def solveE(A,b):
 R,piv=rrefE(np.concatenate([A,b[:,:,None]],axis=2));n=A.shape[2]
 assert n not in piv, 'inconsistent system'
 x=np.zeros((4,n,1),dtype=np.int16)
 for row,p in enumerate(piv):
  if p<n:x[:,p,0]=R[:,row,n]
 assert np.array_equal(matmulE(A,x)[:,:,0],b)
 return x

def osculation(S2):
 M=epscale(S2,einv(S2[-1]))
 def rr(a):return epmod(a,M)
 def aa(a,b):return rr(epadd(a,b))
 def ss(a,b):return rr(epsub(a,b))
 def mm(a,b):return rr(epmul(a,b))
 def sc(a,c):return rr(epscale(a,c))
 def pw(a,n):
  o=[1]
  while n:
   if n&1:o=mm(o,a)
   a=mm(a,a);n//=2
  return o
 def iv(a):
  g,s,t=egcd_poly(a,M);assert g==[1]
  return rr(s)
 def pm(a,b):
  o=[[] for _ in range(len(a)+len(b)-1)]
  for i,x in enumerate(a):
   for j,y in enumerate(b):o[i+j]=aa(o[i+j],mm(x,y))
  return o
 jets=[]
 for j in range(11):
  c=[]
  for i in range(j,11):c=aa(c,sc(pw([0,1],i-j),emul(P[i],math.comb(i,j)%5)))
  jets.append(c)
 normalized=[mm(c,iv(jets[0])) for c in jets]
 k1=sc(normalized[1],2);k2=ss(sc(normalized[2],2),pw(k1,2));k3=sc(ss(ss(normalized[3],mm(k1,k2)),pw(k1,3)),2)
 K=[[1],k1,k2,k3];K3=pm(pm(K,K),K)
 W=[ss(jets[i],mm(jets[0],K3[i] if i<len(K3) else [])) for i in range(11)]
 assert not any(W[:4]);D6=W[4:];assert D6[-1]==[1]
 u=sc(D6[5],2);v=ss(sc(D6[4],2),pw(u,2));V=[v,u,[1]];V3=pm(pm(V,V),V)
 residuals=[ss(D6[i],V3[i]) for i in range(7)]
 assert residuals[4:]==[[],[],[]]
 bz=bezout(residuals[0],M);assert bz['gcd']==[1]
 return {'modulus':M,'P_Taylor_coefficients':jets,'P_normalized_Taylor_coefficients':normalized,'K':K,'K_cubed':K3,'W':W,'D6':D6,'quadratic_forced_by_top_coefficients':V,'cube_residuals':residuals,'constant_residual_bezout':bz}

def build_certificates(log=print, direct=True):
 started=time.monotonic();out={}
 def say(s):log('PASS: '+s)
 # Base field tests and exact polynomial identities.
 assert len({fpow(a,24) for a in range(1,25)})==1
 assert pgcd(P,pder(P))==[1] and pgcd(A,pder(A))==[1] and pgcd(P,A)==[1]
 assert pder(Q)==pmul(P,ppow(A,2))
 assert not pmod(psub(Q,ppow(B0,5)),ppow(P,2))
 assert not pmod(psub(Q,ppow(L,5)),ppow(A,3))
 xp=[0,1];steps=[]
 for i in range(1,5):
  xp=pmod(ppow(xp,25),A);steps.append({'power':i,'remainder':xp,'gcd_with_x_difference':pgcd(A,psub(xp,[0,1]))})
 assert steps[1]['gcd_with_x_difference']==[1] and xp==[0,1]
 assert AM==[5,2,6,7,1]
 out['field.json']={'F25_modulus':[2,4,1],'extension_modulus':AM,'A_Frobenius_tests':steps,'P_squarefree':True,'A_squarefree':True,'P_A_coprime':True,'Q_prime_identity':True,'B0_congruence':True,'L_congruence':True}
 say('base polynomial identities; A irreducible of degree four over F_25')
 M4,K4,M,MJ,K,tB=reconstruct()
 R4,p4=rref25(M4);Radd,padd_=rrefE(MJ)
 assert len(p4)==148 and len(padd_)==30 and K.shape==(4,196,18)
 assert not np.any(K[:,195,:17]) and enc(K[:,195,17])==1
 assert not np.any(matmulE(M,K))
 direct_checks=original_equations(K,tB) if direct else None
 say('150 x 195 finite-pole matrix rank 148; full homogeneous kernel dimension 18')
 if direct:say('all original equations (4)-(6) verified on every one of the 18 kernel basis vectors')
 out['linear_system.json']={'variable_order':[list(t) for t in VARS]+[['kappa']],'M4_rows':M4.tolist(),'M4_pivot_columns':p4,'M4_kernel_columns':K4.T.tolist(),'extra_rows':coded(M),'extra_matrix_on_reduced_48_variables':coded(MJ),'extra_pivot_columns':padd_,'full_kernel_columns':np.array(coded(K)).T.tolist(),'affine_origin_column':17,'direct_checks':direct_checks,'tB':tB}
 # Exact classification of H'_5 linear.
 ix=[i for i,(j,r,a) in enumerate(VARS) if j in (1,2)]
 W,wpiv=nullE(K[:,ix,:]);T=matmulE(K,W);assert T.shape[2]==7
 kc=next(i for i in range(7) if np.any(T[:,195,i]));kap=enc(T[:,195,kc]);Ni=getN(T,kc)
 S2=epscale(epquo(Ni[3][1],P),einv(kap));S5=epscale(epquo(Ni[4][1],P),einv(kap))
 R10=epscale(epquo(epsub(Ni[5][1],epmul(Q,Ni[0][1])),P),einv(kap))
 V=linear_formula_basis(S2,S5,R10,tB)
 assert len(rrefE(V)[1])==7 and not np.any(matmulE(M,V))
 assert all(not np.any(matmul25(M4,V[d,:195,:])) for d in range(4))
 assert len(S2)==3 and len(S5)==6 and len(R10)==11
 Dbar=epsub(S5,epscale(epmul(B0,S2),2))
 Kpoly=epadd(epsub(epmul(S2,ppow(B0,2)),epmul(S5,B0)),R10)
 Kquot=epquo(Kpoly,P)
 gcds={name:bezout(a,b) for name,a,b in [('S2_squarefree',S2,epder(S2)),('S2_P',S2,P),('S2_S5',S2,S5),('Dbar_P',Dbar,P)]}
 assert all(z['gcd']==[1] for z in gcds.values())
 out['linear_boundary.json']={'tB':tB,'S2':S2,'S5':S5,'R10':R10,'homogeneous_dimension':7,'normalized_affine_dimension':6,'formula_basis_columns':np.array(coded(V)).T.tolist(),'Dbar':Dbar,'finite_branch_constant_numerator':Kpoly,'finite_branch_constant_quotient_by_P':Kquot,'gcd_certificates':gcds}
 say('linear-derivative locus classified exactly: five parameters in v and one lambda')
 say('Newton-lemma hypotheses certified: deg(S2,S5,R10)=(2,5,10), S2 squarefree, all required coprimalities')
 OC=osculation(S2);out['osculation.json']=OC
 assert OC['modulus']==[349600,188551,1] and OC['cube_residuals'][0]==[72690,324180]
 say('osculating cubic/cube identity excluded: constant residual is a unit modulo S2')
 # Universal first two infinity jets and explicit necessary-system point.
 J=infinity_matrix(tB);JK=matmulE(J,K)
 assert np.array_equal(JK,extract_infinity_jets(K,tB))
 assert len(rrefE(JK[:,1:8,:17])[1])==7
 vi=[i for i,(j,r,a) in enumerate(VARS) if j==0]
 joint=np.concatenate([JK[:,1:8,:17],K[:,vi,:17]],axis=1)
 assert len(rrefE(joint)[1])==12
 target=np.zeros((4,12),dtype=np.int16);target[0,0]=1;target[0,6]=1;target[0,7]=1
 origin=np.concatenate([JK[:,1:8,17],K[:,vi,17]],axis=1)
 coeff=solveE(joint,add[target,neg[origin]])
 witness=add[K[:,:,17:18],matmulE(K[:,:,:17],coeff)]
 witnessjets=matmulE(J,witness)
 assert coded(witnessjets) == [[8],[1],[0],[0],[0],[0],[0],[1]]
 assert coded(witness[:,vi,:])==[[1],[0],[0],[0],[0]]
 assert not np.any(matmulE(M,witness))
 out['infinity_jets.json']={'coefficient_order':['s','alpha2','alpha1','alpha0','delta3','delta2','delta1','delta0'],'jet_matrix_rows':coded(J),'jet_matrix_on_kernel_columns':coded(JK),'affine_jet_rank':7,'affine_joint_jet_and_v_rank':12,'obstructed_necessary_system_witness':{'classification':'necessary-system point only; no irreducibility assertion','parameters':coded(coeff) ,'coefficient_column':[row[0] for row in coded(witness)],'jets':[row[0] for row in coded(witnessjets)],'v_coefficients':[1,0,0,0,0]}}
 say('infinity jet formulas checked independently from M_j; affine jet map rank 7, joint rank with v is 12')
 say('explicit v=1 point with a double cluster and nonzero first transverse coefficient checked')
 # All four supports are handled by exact Frobenius conjugation, not by point search.
 Frob=np.stack([DIG[:,epow(25,25*j)] for j in range(4)],axis=1)
 def sig(T):return matmul25(Frob,T.reshape(4,-1)).reshape(T.shape)
 def sigp(p):return coded(sig(DIG[:,np.array(p,dtype=np.int64)]))
 rho=25;curK=K.copy();curS2=S2[:];curS5=S5[:];curR=R10[:];support=[]
 for j in range(4):
  MM,tt=extra_matrix(rho)
  assert not np.any(matmulE(MM,curK))
  assert all(not np.any(matmul25(M4,curK[d,:195,:])) for d in range(4))
  OO=osculation(curS2)
  support.append({'index':j,'omitted_root_rho_code':rho,'tB':tt,'S2':curS2,'S5':curS5,'R10':curR,'osculation_modulus':OO['modulus'],'constant_residual':OO['cube_residuals'][0],'constant_residual_bezout':OO['constant_residual_bezout']})
  rho=epow(rho,25);curK=sig(curK);curS2=sigp(curS2);curS5=sigp(curS5);curR=sigp(curR)
 assert rho==25 and np.array_equal(curK,K) and len({z['omitted_root_rho_code'] for z in support})==4
 out['four_supports.json']={'Frobenius_matrix_over_F25':Frob.tolist(),'supports':support}
 say('all four supports: conjugate kernel equations and unit osculation obstructions verified')
 log('REBUILD COMPLETE in %.3f seconds' % (time.monotonic()-started))
 return out
