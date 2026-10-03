#!/usr/bin/env sage
"""New four-omission b=0 leading-pencil determinant; one bounded core."""
import json, time, signal, os
from pathlib import Path
started=time.monotonic()
signal.signal(signal.SIGALRM,lambda s,f: (_ for _ in ()).throw(TimeoutError('bzero fixed determinant hard30s')))
signal.setitimer(signal.ITIMER_REAL,30)
Fp=GF(5); FF=PolynomialRing(Fp,'z'); zz=FF.gen()
E=GF(5**8,'e',modulus=FF([2,4,3,0,1,0,0,0,1])); ee=E.gen()
beta=sum(E(c)*ee**i for i,c in enumerate([3,4,2,2,4,4,4,4]))
assert beta**2==beta+3
R=PolynomialRing(E,'x'); x=R.gen()
def code(c):return E(c%5)+E(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
def enc(a):return [int(v) for v in E(a).polynomial().list()]
def encp(p):return [enc(a) for a in p.list()]
P=poly([11,22,18,5,19,20,15,16,9,22,1])
Z=poly([15,19,24,12,10,19,3,24,18,16]); Sel=poly([1,21,14,22,13])
q=poly([13,18,24]); q3=poly([1,22,9,1])
Qfix=poly([0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24])
L0=poly([18,20,20,15]); kappa=-1/code(24)
Rv=PolynomialRing(E,'V'); V=Rv.gen()
def vector3(p):return vector(E,[p[i] for i in range(3)])
def liftvec(v):return vector(Rv,[Rv(c) for c in v])
def det2(a,b,i,j):return a[i]*b[j]-a[j]*b[i]
def bezout_list(fs):
 g=Rv.zero(); cs=[]
 for f in fs:
  ng,s,t=g.xgcd(f); cs=[c*s for c in cs]+[t]; g=ng
 if g:
  c=g.leading_coefficient(); g=g/c; cs=[u/c for u in cs]
 assert sum((u*f for u,f in zip(cs,fs)),Rv.zero())==g
 return g,cs
records=[]
for omitted in Sel.roots(multiplicities=False):
 t=Sel//(x-omitted); t2=t*t
 assert t.degree()==3 and t.gcd(P).degree()==0
 J,rr=(Qfix-L0**5).quo_rem(t**3); assert not rr and J.gcd(t).degree()==0
 invP=P.inverse_mod(t2); invP2=(P*P).inverse_mod(t2)
 def evjet(H,D,d):
  Rd=(Z*d)%P; Sd=(Z**2*d)%P; R3d=(Z**3*d)%P
  N=(P*Z*H+2*P*Z**2*D+Z*R3d+Z**2*Sd+Z**3*Rd+Z**4*d)%(P*P)
  r2=N*invP2%t2
  return vector(E,[((P*H+R3d)%t)[i] for i in range(3)]+[r2[i] for i in range(6)])
 Mde=matrix(E,[evjet(x**i,R.zero(),R.zero()) for i in range(6)]+[evjet(R.zero(),x**i,R.zero()) for i in range(3)]).transpose()
 mdet=Mde.det(); assert mdet
 force=(kappa+P*J.inverse_mod(t2))%t2
 rhs=-vector(E,[E.zero()]*3+[force[i] for i in range(6)])
 base=Mde.solve_right(rhs); assert Mde*base==rhs
 Dbase=R(list(base[6:]))
 directions=[]
 for d in [q3,q]:
  rhsd=-evjet(R.zero(),R.zero(),d)
  sol=Mde.solve_right(rhsd); assert Mde*sol==rhsd
  directions.append(R(list(sol[6:])))
 D3,Dq=directions
 R3=(Z*q3)%P; Rq=(Z*q)%P; S3=(Z**2*q3)%P; Sq=(Z**2*q)%P
 ip=P.inverse_mod(t)
 J0=(-q3*Dbase)%t
 J3=(-q3*D3+(3*R3**2-4*q3*S3)*ip)%t
 Jq=(-q3*Dq+(3*Rq*R3-3*q3*Sq-q*S3)*ip)%t
 ca=liftvec(vector3(J3))-V*liftvec(vector3(q3%t))
 cb=liftvec(vector3(Jq))-V*liftvec(vector3(q%t))
 cc=liftvec(vector3(J0))
 mat=matrix(Rv,[ca,cb,cc]).transpose(); det=mat.det()
 assert det and det.degree()<=2
 pairs=[(0,1),(0,2),(1,2)]
 minors=[det2(ca,cb,i,j) for i,j in pairs]
 rank_gcd,bs=bezout_list(minors)
 augmin=minors+[det2(ca,cc,i,j) for i,j in pairs]+[det2(cb,cc,i,j) for i,j in pairs]
 aug_gcd,aug_bs=bezout_list(augmin)
 rec={'omitted':enc(omitted),'t':encp(t),'fixed_jet_determinant':enc(mdet),
      'Dbase':encp(Dbase),'Dq3':encp(D3),'Dq':encp(Dq),
      'J_const':encp(J0),'J_q3':encp(J3),'J_q':encp(Jq),
      'determinant':encp(det),'degree':int(det.degree()),
      'leading_coefficient':enc(det.leading_coefficient()),
      'two_column_minors':[encp(f) for f in minors],
      'two_column_rank_gcd':encp(rank_gcd),'two_column_rank_bezout':[encp(f) for f in bs],
      'augmented_rank_gcd':encp(aug_gcd),'augmented_rank_bezout':[encp(f) for f in aug_bs]}
 if rank_gcd==1:
  D=det.monic(); pp=sum((-u*det2(cc,cb,i,j) for u,(i,j) in zip(bs,pairs)),Rv.zero())%D
  rr=sum((-u*det2(ca,cc,i,j) for u,(i,j) in zip(bs,pairs)),Rv.zero())%D
  assert all((ca[i]*pp+cb[i]*rr+cc[i])%D==0 for i in range(3))
  rec.update(p_residue=encp(pp),r_residue=encp(rr),p_gcd_degree=int(pp.gcd(D).degree()),
             determinant_squarefree=bool(D.gcd(D.derivative()).degree()==0))
 records.append(rec)
 print('BZERO omission',len(records),'det degree',det.degree(),'rank gcd',rank_gcd.degree(),'aug gcd',aug_gcd.degree(),flush=True)
out={'scope':'Necessary finite actual leading-coefficient support in homogeneous half B0 b=0; not actual source existence or exclusion.',
     'field_modulus':[2,4,3,0,1,0,0,0,1],'beta':[3,4,2,2,4,4,4,4],
     'records':records,'complete':True,'seconds':time.monotonic()-started,'sage_version':version(),
     'thread_caps':{k:os.environ.get(k) for k in ['OMP_NUM_THREADS','OPENBLAS_NUM_THREADS','MKL_NUM_THREADS','VECLIB_MAXIMUM_THREADS']}}
assert len(records)==4
Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform/half_bzero_leading_pencil.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
signal.setitimer(signal.ITIMER_REAL,0)
print('DONE bzero fixed pencil',round(out['seconds'],3),'seconds',flush=True)
