#!/usr/bin/env sage
"""New exact source-double-jet/pure-half-kernel elimination; one core."""
import json, time, signal
from pathlib import Path
started=time.monotonic()
signal.signal(signal.SIGALRM, lambda s,f: (_ for _ in ()).throw(TimeoutError('new pure half kernel hard30s')))
signal.setitimer(signal.ITIMER_REAL,30)
E=GF(5**24,'e'); R=PolynomialRing(E,'x'); x=R.gen()
beta=(x*x-x-3).roots(multiplicities=False)[0]
def code(c): return E(c%5)+E(c//5)*beta
def poly(cs): return R([code(c) for c in cs])
P=poly([11,22,18,5,19,20,15,16,9,22,1])
Z=poly([15,19,24,12,10,19,3,24,18,16])
Sel=poly([1,21,14,22,13]); q=poly([13,18,24]); q3=poly([1,22,9,1])
Qfix=poly([0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24])
L0=poly([18,20,20,15]); kappa=-1/code(24)
def enc(a): return [int(v) for v in E(a).polynomial().list()]
def encp(p): return [enc(c) for c in p.list()]
def rem(p,t): return R(p)%t
gap=matrix(E,1,5,[((Z*x**i)%P)[9] for i in range(5)])
abasis=[R(v.list()) for v in gap.right_kernel().basis()]
assert len(abasis)==4
repro=q3.derivative()*q-q3*q.derivative()
repeat_roots=repro.roots(multiplicities=False)
assert len(repeat_roots)==4
out=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform/pure_half_source_double_jet_elimination.json')
records=[]
for omitted in Sel.roots(multiplicities=False):
 t=Sel//(x-omitted); t2=t*t
 assert t.degree()==3 and P.gcd(t).degree()==0
 num=Qfix-L0**5
 J,rr=num.quo_rem(t**3); assert not rr and J.gcd(t).degree()==0
 invP=P.inverse_mod(t2); invP2=(P*P).inverse_mod(t2)
 def cv(c,b):
  Rc=(Z*c-Z**2*b)%P
  r1=((3*Z**2*c+Z**3*b)%P)*invP%t2
  return vector(E,[(Rc%t)[i] for i in range(3)]+[r1[i] for i in range(3,6)])
 Mc=matrix(E,[cv(x**i,R.zero()) for i in range(6)]).transpose()
 assert Mc.rank()==6
 Cstar=R(Mc.solve_right(-cv(R.zero(),R.one())).list())
 assert not cv(Cstar,R.one())
 def evjet(e,D,d):
  Rd=(Z*d)%P; Sd=(Z**2*d)%P; R3=(Z**3*d)%P
  N=(P*Z*e+2*P*Z**2*D+Z*R3+Z**2*Sd+Z**3*Rd+Z**4*d)%(P*P)
  r2=N*invP2%t2
  return vector(E,[((P*e+R3)%t)[i] for i in range(3)]+[r2[i] for i in range(6)])
 Mde=matrix(E,[evjet(x**i,R.zero(),R.zero()) for i in range(6)]+[evjet(R.zero(),x**i,R.zero()) for i in range(3)]).transpose()
 assert Mde.rank()==9
 force=(kappa+P*J.inverse_mod(t2))%t2
 base=Mde.solve_right(-vector(E,[E.zero()]*3+[force[i] for i in range(6)]))
 Ebase=R(list(base[:6])); Dbase=R(list(base[6:]))
 assert evjet(Ebase,Dbase,R.zero())+vector(E,[E.zero()]*3+[force[i] for i in range(6)])==0
 for r in repeat_roots:
  lam=-q3(r)/q(r); d=q3+lam*q
  assert d.gcd(P*Sel).degree()==0 and not d(r) and not d.derivative()(r)
  direction=Mde.solve_right(-evjet(R.zero(),R.zero(),d))
  Edir=R(list(direction[:6])); Ddir=R(list(direction[6:]))
  assert evjet(Edir,Ddir,d)==0
  Rd=(Z*d)%P; Sd=(Z**2*d)%P
  Lmat=matrix(E,[[((a*Rd+2*d*((Z*a)%P))%t)[i] for a in abasis] for i in range(3)])
  assert Lmat.rank()==3
  apart=Lmat.solve_right(-vector(E,[(P%t)[i] for i in range(3)]))
  ak=Lmat.right_kernel().basis()[0]
  Apart=sum((apart[i]*abasis[i] for i in range(4)),R.zero())
  Ak=sum((ak[i]*abasis[i] for i in range(4)),R.zero())
  assert Ak%t, 'b=0 needs another stratum'
  V=(Rd-4*d*Cstar)%t
  K=(-4*d*Ddir+(4*Rd**2-2*d*Sd)*P.inverse_mod(t))%t
  T=(4*d*Dbase)%t
  bzero_excluded=matrix(E,[vector(E,[K[i] for i in range(3)]),vector(E,[T[i] for i in range(3)])]).rank()==2
  Rz=PolynomialRing(E,'z'); z=Rz.gen(); RX=PolynomialRing(Rz,'X'); X=RX.gen()
  def lift(p):return RX([Rz(c) for c in p.list()])
  zp=lift(Apart)+z*lift(Ak); wt=(zp*zp)%lift(t)
  vv=[V[i] for i in range(3)]; kk=[K[i] for i in range(3)]; tt=[T[i] for i in range(3)]
  ww=[wt[i] for i in range(3)]; zz=[zp[i] for i in range(3)]
  # Reduce A mod t before reading its three selected coordinates.
  zr=zp%lift(t); zz=[zr[i] for i in range(3)]
  assert any(vv) and any(tt), 'retain a missing-vector boundary'
  j=next(i for i in range(3) if vv[i])
  equations=[Rz(vv[j]*ww[i]-vv[i]*ww[j]) for i in range(3)]
  for i in range(3):
   for h in range(i+1,3):
    equations.append(Rz(tt[i]*(-2*vv[j]*zz[h]+kk[h]*ww[j])-tt[h]*(-2*vv[j]*zz[i]+kk[i]*ww[j])))
  nonzero=[f for f in equations if f]
  assert nonzero
  gcd=nonzero[0]
  for f in nonzero[1:]: gcd=gcd.gcd(f)
  gcd=gcd.monic()
  # The common-divisor identity is recorded through iterated Bezout coefficients.
  bc=[Rz.one()]; gg=nonzero[0]
  for f in nonzero[1:]:
   ng,a,b=gg.xgcd(f); bc=[a*c for c in bc]+[b]; gg=ng
  scale=gg.leading_coefficient()**(-1); bc=[scale*c for c in bc]; gg=gg.monic()
  assert sum((a*f for a,f in zip(bc,nonzero)),Rz.zero())==gcd
  rec={'omitted':enc(omitted),'lambda':enc(lam),'repeat_root':enc(r),'d':encp(d),'t':encp(t),'Cstar':encp(Cstar),'Dbase':encp(Dbase),'Ddir':encp(Ddir),'Mc_determinant':enc(Mc.det()),'Mde_determinant':enc(Mde.det()),'Lmat':[ [enc(c) for c in row] for row in Lmat.rows() ],'Apart':encp(Apart),'Ak':encp(Ak),'V':encp(V),'K':encp(K),'T':encp(T),'bzero_excluded':bool(bzero_excluded),'z_equations':[encp(f) for f in nonzero],'bezout_coefficients':[encp(f) for f in bc],'gcd':encp(gcd),'nonzero_b_excluded':gcd.degree()==0}
  records.append(rec)
  print('NEW PURE HALF',len(records),'b0excluded',bzero_excluded,'zgcddegree',gcd.degree(),flush=True)
  out.write_text(json.dumps({'scope':'NEW exact all full-source double jets and pure-half selected discriminant conditions; 4 repeated leading ratios times4omissions. Necessary actual-source conditions, no generic-rank witness.','field_modulus':[int(c) for c in E.modulus().list()],'beta':enc(beta),'records':records,'complete':len(records)==16,'seconds':time.monotonic()-started},indent=2)+'\n')
signal.setitimer(signal.ITIMER_REAL,0)
print('DONE',len(records),'seconds',time.monotonic()-started,flush=True)
