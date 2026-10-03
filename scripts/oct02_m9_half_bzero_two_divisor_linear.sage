#!/usr/bin/env sage
"""New fixed 6x5/CRT/scalar check on extracted quadratic bzero algebras."""
import json,time,signal,os
from pathlib import Path
started=time.monotonic()
signal.signal(signal.SIGALRM,lambda s,f: (_ for _ in ()).throw(TimeoutError('bzero candidate check hard30s')))
signal.setitimer(signal.ITIMER_REAL,30)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
seed=json.loads((folder/'half_bzero_leading_pencil.json').read_text())
F5=GF(5); RF=PolynomialRing(F5,'z')
E=GF(5**8,'e',modulus=RF(seed['field_modulus'])); ee=E.gen()
def dec(v):return sum(E(c)*ee**i for i,c in enumerate(v))
beta=dec(seed['beta']); assert beta**2==beta+3
R=PolynomialRing(E,'x'); x=R.gen(); RV=PolynomialRing(E,'V')
def code(c):return E(c%5)+E(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
def decp(cs,ring=R):return ring([dec(c) for c in cs])
def enc(a):return [int(c) for c in E(a).polynomial().list()]
def encp(p):return [enc(c) for c in p.list()]
P=poly([11,22,18,5,19,20,15,16,9,22,1]); Z=poly([15,19,24,12,10,19,3,24,18,16])
q=poly([13,18,24]); q3=poly([1,22,9,1])
Qfix=poly([0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]); L0=poly([18,20,20,15])
gap=matrix(E,1,5,[((Z*x**i)%P)[9] for i in range(5)])
abasis=[R(v.list()) for v in gap.right_kernel().basis()]; assert len(abasis)==4
results=[]
from itertools import combinations
for oi,s in enumerate(seed['records']):
 t=decp(s['t']); t2=t*t
 Dbase=decp(s['Dbase']); D3=decp(s['Dq3']); Dq=decp(s['Dq'])
 J,r=(Qfix-L0**5).quo_rem(t**3); assert not r
 force=(-1/code(24)+P*J.inverse_mod(t2))%t2; invP2=(P*P).inverse_mod(t2)
 def evjet(H,D,d):
  Rd=(Z*d)%P; Sd=(Z**2*d)%P; R3d=(Z**3*d)%P
  N=(P*Z*H+2*P*Z**2*D+Z*R3d+Z**2*Sd+Z**3*Rd+Z**4*d)%(P*P)
  r2=N*invP2%t2
  return vector(E,[((P*H+R3d)%t)[i] for i in range(3)]+[r2[i] for i in range(6)])
 ME=matrix(E,[evjet(x**i,R.zero(),R.zero()) for i in range(6)]).transpose()
 sourceE=[]
 for D0,d0,ff in [(Dbase,R.zero(),vector(E,[E.zero()]*3+[force[i] for i in range(6)])),(D3,q3,vector(E,9)),(Dq,q,vector(E,9))]:
  rhs=-evjet(R.zero(),D0,d0)-ff
  sol=ME.solve_right(rhs); assert ME*sol==rhs
  sourceE.append(R(sol.list()))
 Ebase,E3,Eq=sourceE
 Delta=decp(s['determinant'],RV).monic(); assert Delta.degree()==2 and Delta.gcd(Delta.derivative())==1
 pp=decp(s['p_residue'],RV); rr=decp(s['r_residue'],RV)
 for factor,multiplicity in Delta.factor():
  assert multiplicity==1 and factor.is_irreducible()
  B=RV.quotient(factor,'vv'); vv=B.gen(); assert B.is_field()
  RB=PolynomialRing(B,'X'); X=RB.gen()
  def lift(p):return RB([B(c) for c in p.list()])
  def encb(a):return encp(B(a).lift())
  def encbp(p):return [encb(c) for c in p.list()]
  pb=B(pp); rb=B(rr); d=pb*lift(q3)+rb*lift(q); n=lift(q3)
  PB=lift(P); ZB=lift(Z); tb=lift(t)
  D=lift(Dbase)+pb*lift(D3)+rb*lift(Dq)
  ES=lift(Ebase)+pb*lift(E3)+rb*lift(Eq)
  C=D[2]
  rec={'omission':oi+1,'factor':encp(factor),'multiplicity':int(multiplicity),'p':encb(pb),'r':encb(rb),'C':encb(C)}
  if not C:
   rec.update(excluded=True,reason='C=0 contradicts actual B0 leading row');results.append(rec);continue
  boundary={'d_discriminant_gcd':int(d.gcd(d.derivative()).degree()),'P_gcd':int(d.gcd(PB).degree()),'t_gcd':int(d.gcd(tb).degree())}
  rec.update(boundary=boundary)
  if any(boundary.values()):
   rec.update(excluded=False,reason='two-divisor open hypotheses fail');results.append(rec);continue
  def K(j,f):return (ZB**j*f).quo_rem(PB)[0]
  def Rm(j,f):return (ZB**j*f)%PB
  kd=K(1,d); k2d=K(2,d); k3d=K(3,d); kn=K(1,n); k2n=K(2,n)
  assert kd.gcd(d).degree()==0
  Rd=Rm(1,d); Rn=Rm(1,n)
  F1=D+ZB*kd-3*k2d
  h0=ES-ZB*D-k3d+3*ZB*k2d-3*ZB**2*kd
  def lm(A,a):
   JS=(-PB.inverse_mod(tb)*Rm(2,A))%tb
   L=a*lift(q)-JS[2]*n/C
   return JS,L
  YR=PolynomialRing(RB.fraction_field(),'Y'); Y=YR.gen()
  def direct_trace(A,L,H):
   JS=(-PB.inverse_mod(tb)*Rm(2,A))%tb; ka=K(1,A)
   ef=A-3*Y**2*kd
   ff=Y*F1-2*Y**2*ka
   hf=h0+Y*(JS+2*ZB*ka-K(2,A))
   nf1=L+Y**2*kn
   nf2=H+Y*(vv-k2n+2*ZB*kn)+2*Y**2*K(1,L)
   return (ef*nf2+ff*nf1+hf*n)%(Y**3-PB)
  def linearrows(A,a):
   JS,L=lm(A,a); ka=K(1,A)
   old=(2*d*Rm(1,L)-3*L*Rd+A*Rn-2*n*Rm(1,A))%tb
   new=(A*(vv-k2n+2*ZB*kn)-PB*kd*K(1,L)+F1*L-2*PB*ka*kn+(JS+2*ZB*ka-K(2,A))*n)%d
   direct=direct_trace(A,L,RB.zero())
   assert RB(direct[1])%d==new
   assert RB(direct[2])==2*(A*K(1,L)-ka*L)
   mus1=L-Y**2*Rn/PB
   mus2=Y*(vv+Rm(2,n)/PB)-2*Y**2*Rm(1,L)/PB
   es=A+3*Y**2*Rd/PB
   fs=Y*D+2*Y**2*Rm(1,A)/PB+3*Y*Rm(2,d)/PB
   selected=(d*mus2+es*mus1+fs*n)%(Y**3-PB)
   assert RB(-PB*selected[2])%tb==old
   return vector(B,[old[i] for i in range(3)]+[new[i] for i in range(3)])
  cols=[linearrows(lift(A),B.zero()) for A in abasis]+[linearrows(RB.zero(),B.one())]
  M=matrix(B,cols).transpose(); rank=M.rank()
  rec.update(rank=int(rank),matrix=[ [encb(c) for c in row] for row in M.rows() ],
             E_source=encbp(ES),D_source=encbp(D))
  G0=(PB*(-3*kd*(vv-k2n+2*ZB*kn)+F1*kn)+h0*n)%d
  assert RB(direct_trace(RB.zero(),RB.zero(),RB.zero())[0])%d==G0
  rec['scalar_constant']=encbp(G0)
  if rank==5:
   selected=next(I for I in combinations(range(6),5) if M.matrix_from_rows(I).det())
   rec.update(injective_minor_rows=list(selected),injective_minor=encb(M.matrix_from_rows(selected).det()),excluded=bool(G0),reason='rank5 and nonzero scalar constant' if G0 else 'rank5 but zero scalar constant')
  elif rank==4:
   kern=M.right_kernel().basis()[0]; assert not M*kern
   A=sum((kern[i]*lift(abasis[i]) for i in range(4)),RB.zero()); a=kern[4]; JS,L=lm(A,a)
   Ht=(-A*L*d.inverse_mod(tb))%tb
   Hd=(2*(A*K(1,L)-K(1,A)*L)*(3*kd).inverse_mod(d))%d
   kk=((Hd-Ht)*tb.inverse_mod(d))%d; crt=kk[2]
   rec.update(kernel=[encb(c) for c in kern],A_kernel=encbp(A),L_kernel=encbp(L),CRT_coefficient=encb(crt))
   if crt:
    rec.update(excluded=bool(G0),reason='rank4 and nonzero CRT coefficient force zero, scalar constant nonzero' if G0 else 'rank4 CRT forces zero but scalar constant zero')
   else:
    H=Ht+tb*kk; assert H.degree()<=4
    T=(A*H)%d; span=matrix(B,[[G0[i] for i in range(3)],[T[i] for i in range(3)]]).rank()
    rec.update(cubic_vector=encbp(T),scalar_span_rank=int(span),excluded=bool(span==2 or (not T and G0)),reason='rank4 CRT zero; cubic scalar vector incompatibility' if span==2 or (not T and G0) else 'rank4 cubic scalar boundary retained')
  else:
   rec.update(excluded=False,reason='rank below4; no nonlinear search')
  results.append(rec)
  print('BZERO two-divisor',oi+1,'factor degree',factor.degree(),'rank',rank,'excluded',rec['excluded'],rec['reason'],flush=True)
out={'scope':'Fixed quadratic candidate algebra check of old selected and new leading trace rows; source parameters not searched.',
     'seed':'half_bzero_leading_pencil.json','field_modulus':seed['field_modulus'],'beta':seed['beta'],
     'A_gap_basis':[encp(A) for A in abasis],'records':results,'complete':True,
     'all_excluded':all(r['excluded'] for r in results),'direct_cubic_character_assertions':True,'seconds':time.monotonic()-started,'sage_version':version(),
     'thread_caps':{k:os.environ.get(k) for k in ['OMP_NUM_THREADS','OPENBLAS_NUM_THREADS','MKL_NUM_THREADS','VECLIB_MAXIMUM_THREADS']}}
(folder/'half_bzero_two_divisor_linear.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
signal.setitimer(signal.ITIMER_REAL,0)
print('DONE bzero two divisor',round(out['seconds'],3),'seconds','all excluded',out['all_excluded'],flush=True)
