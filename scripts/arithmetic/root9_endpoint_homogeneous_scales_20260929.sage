#!/usr/bin/env sage
"""Compact rational scales as a numerator/denominator pair, without inversion.

Multiplying the degree140 residual by denominator^6 preserves its square
condition on the specified denominator-nonzero chart. Boundary fibres are
retained separately, never declared units by this exporter.
"""
import argparse,json,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory');p.add_argument('--branch',type=int,default=1);p.add_argument('--compact',action='store_true');args=p.parse_args();d=Path(args.directory);out=d/('homogeneous_'+str(args.branch)+('_compact' if args.compact else ''));out.mkdir(exist_ok=True)
co=load(str(d/'coordinates.sobj'));J=load(str(d/'content_gcd.sobj'));R=J.parent();H,Z=R.gens();K=R.base_ring();a=K.gen();beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(c):return sum((c//25**i%5+(c//25**i//5%5)*beta)*a**i for i in range(4))
def vec(c):return vector(GF(5),[K(c).polynomial()[i] for i in range(8)])
cb=matrix(GF(5),[vec(beta**j*a**i) for i in range(4) for j in range(2)]).transpose().inverse()
def code(c):
 v=cb*vec(c);return int(sum(ZZ(v[2*i])*25**i+ZZ(v[2*i+1])*5*25**i for i in range(4)))
Q=PolynomialRing(K,'Z');z=Q.gen();F=Q.fraction_field();U=PolynomialRing(F,'H');h=U.gen();hh=R.hom([h,U(z)],U);j0=hh(J);lc=Q(j0.leading_coefficient());j=j0.monic()
A=3*load(str(d/'translated_0_T0.sobj'));B=2*load(str(d/'translated_1_T0.sobj'));D=load(str(d/'translated_3_T0.sobj'));V=(co['root']-dec(9))*co['source_denominator']
if args.branch:
 rot=R.hom([H,dec(11)**(args.branch-1)*Z],R);num=rot(A**3*B**3+A**5*D);den=rot(V*B**5)
else:
 phi=load(str(d/'phi_shift_coefficients.sobj'));ev=load(str(d/'constant_term_coefficients.sobj'));assert phi[1]==phi[2]==0
 C1=load(str(d/'translated_2_T1.sobj'));C2=load(str(d/'translated_2_T2.sobj'));B1=2*load(str(d/'translated_1_T1.sobj'));D1=load(str(d/'translated_3_T1.sobj'));m=phi[3];m1=phi[4]
 ell1=ev[6]+sum(phi[k]*load(str(d/('translated_3_T'+str(6-k)+'.sobj'))) for k in range(3,7))
 num=-(ell1*B**5-D1*C1**5+(2*m1*B+3*m*B1)*C1**2*B**3-2*m*A*C1**3*B**2-m*C2*C1*B**4);den=V*m**2*B**5
 if args.compact:
  oldnum,oldden=num,den;ell0=ev[5]+sum(phi[k]*load(str(d/('translated_3_T'+str(5-k)+'.sobj'))) for k in range(3,6))
  ratio,rem=D1.quo_rem(D);assert not rem and ratio.is_constant();kappa=ratio.constant_coefficient()
  contact=ell0*B**5-D*C1**5-3*m*C1**2*B**4
  assert hh(contact)%j==0
  num=-((ell1-kappa*ell0)*B**3-(m*C2+m1*C1)*C1*B**2+(3*m*B1+3*m1*B+3*kappa*m*B)*C1**2*B-2*m*A*C1**3)
  den=V*m**2*B**3
  assert hh(num*oldden-oldnum*den)%j==0
  print('CONTENT_FROBENIUS_FOLD_PASS','degrees',num.degree(H),num.degree(Z),den.degree(H),den.degree(Z),flush=True)
assert num.degree(H)<=12 and den.degree(H)<=12
nr=hh(num)%j;dr=hh(den)%j;common=lcm([c.denominator() for c in list(nr)+list(dr)]);nr*=common;dr*=common
assert all(c.denominator()==1 for c in list(nr)+list(dr))
save({'J':j,'numerator':nr,'denominator':dr,'original_num':num,'original_den':den,'common':common},str(out/'model.sobj'))
if args.branch in [0,1]:
 rows=[hh(load(str(d/('row_'+str(i)+'_T6.sobj')))) for i in range(3)]
 assert (rows[0]*dr**2+rows[1]*nr*dr+rows[2]*nr**2)%j==0;print('CLEARED_LOCAL_PARITY_PASS',args.branch,flush=True)
source=Q(hh(co['source_denominator'])[0]);ds=source
while not ds[0]:ds=ds//z
ds=ds.monic();lp=lc
while not lp[0]:lp=lp//z
lp=lp.monic();poles=[z,ds,lp,z,z]
def enc(c,exps):
 v=F(c)*prod(p**e for p,e in zip(poles,exps));assert v.denominator()==1
 return {'a':[code(t) for t in v.numerator()],'b':[],'den':list(map(int,exps))}
md=lcm([c.denominator() for c in j]);zz=md;ee=[]
for p in poles[:3]:
 e=0
 while p.degree()>0 and not zz%p:zz=zz//p;e+=1
 ee.append(e)
assert zz.degree()==0;ee+= [0,0]
obj={'rank':12,'branch':args.branch,'root':code(co['root']),'parameter':'Z','poles':[[code(c) for c in p] for p in poles],'J_monic_H':[enc(c,ee) for c in j],'actual_q':enc(co['P_root']/z**3,[3,0,0,0,0]),'homogeneous_num_H':[enc(nr[i],[0]*5) for i in range(12)],'homogeneous_den_H':[enc(dr[i],[0]*5) for i in range(12)],'mu_H':[enc(0,[0]*5) for i in range(12)],'scope':'Residual multiplied by homogeneous_den^6, valid for square testing where that denominator is nonzero.'}
(out/'model.json').write_text(json.dumps(obj,separators=(',',':'),default=int)+'\n');print('EXPORTED',args.branch,'DEGREES',max(c.numerator().degree() for c in nr),max(c.numerator().degree() for c in dr),flush=True)
