#!/usr/bin/env sage
"""Four rational scale sections on the actual endpoint-content curve.

Additional denominator fibres are recorded, not asserted excluded.
"""
import argparse,json,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory');p.add_argument('--branch',type=int,default=1);args=p.parse_args();d=Path(args.directory);out=d/('branch_'+str(args.branch));out.mkdir(exist_ok=True)
co=load(str(d/'coordinates.sobj'));J0=load(str(d/'content_gcd.sobj'));R=J0.parent();H,Z=R.gens();K=R.base_ring();a=K.gen();beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(c):return sum((c//25**i%5+(c//25**i//5%5)*beta)*a**i for i in range(4))
def vec(c):return vector(GF(5),[K(c).polynomial()[i] for i in range(8)])
cb=matrix(GF(5),[vec(beta**j*a**i) for i in range(4) for j in range(2)]).transpose().inverse()
def code(c):
 v=cb*vec(c);return int(sum(ZZ(v[2*i])*25**i+ZZ(v[2*i+1])*5*25**i for i in range(4)))
Q=PolynomialRing(K,'Z');z=Q.gen();F=Q.fraction_field();U=PolynomialRing(F,'H');h=U.gen();hh=R.hom([h,U(z)],U)
j=hh(J0);lc=Q(j.leading_coefficient());j=j.monic();assert j.degree()==12
aa=3*load(str(d/'translated_0_T0.sobj'));bb=2*load(str(d/'translated_1_T0.sobj'));dd=load(str(d/'translated_3_T0.sobj'));vv=(co['root']-dec(9))*co['source_denominator']
def large(phase):
 rot=R.hom([H,phase*Z],R);A=hh(rot(aa));B=hh(rot(bb));D=hh(rot(dd));V=hh(rot(vv));num=(A**3*B**3+A**5*D)%j;den=(V*B**5)%j
 return (num*den.inverse_mod(j))%j
st=time.time()
if (out/'model.sobj').exists():
 saved=load(str(out/'model.sobj'));assert saved['J']==j;mu=U(saved['mu']);print('REUSED_EXACT_MODEL',flush=True)
else:
 if args.branch==0:
  # Small critical root W=omega*T+..., omega=-C1/B. Expanding
  # f through T6 gives a denominator B5, instead of inverting
  # the much larger resultant coefficient c6.
  A=aa;B=bb;D=dd;V=vv;phi=load(str(d/'phi_shift_coefficients.sobj'));ev=load(str(d/'constant_term_coefficients.sobj'))
  C1=load(str(d/'translated_2_T1.sobj'));C2=load(str(d/'translated_2_T2.sobj'));B1=2*load(str(d/'translated_1_T1.sobj'));D1=load(str(d/'translated_3_T1.sobj'))
  assert phi[1]==phi[2]==0
  m=phi[3];m1=phi[4];ell1=ev[6]+sum(phi[k]*load(str(d/('translated_3_T'+str(6-k)+'.sobj'))) for k in range(3,7))
  numerator=-(ell1*B**5-D1*C1**5+(2*m1*B+3*m*B1)*C1**2*B**3-2*m*A*C1**3*B**2-m*C2*C1*B**4)
  den=(hh(V*m**2*B**5))%j;mu=((hh(numerator)%j)*den.inverse_mod(j))%j
 else:mu=large(dec(11)**(args.branch-1))
 print('SCALE_CONSTRUCTED',args.branch,'SECONDS',time.time()-st,flush=True)
 if args.branch in (0,1):
  ar=[hh(load(str(d/('row_'+str(i)+'_T6.sobj')))) for i in range(3)]
  assert (ar[0]+ar[1]*mu+ar[2]*mu**2)%j==0
  print('LOCAL_PARITY_IDENTITY_PASS',flush=True)
 save({'J':j,'mu':mu,'branch':args.branch,'root':co['root'],'q':co['P_root']/z**3},str(out/'model.sobj'))
# Pole catalog: Z, original source denominator, curve leading denominator,
# and the remaining common scale denominator. Whole factors may be grouped;
# no localization claim is made until their complete fibres are treated.
source=Q(hh(co['source_denominator'])[0]);Dsource=source
while not Dsource[0]:Dsource=Dsource//z
Dsource=Dsource.monic()
L=lc
while not L[0]:L=L//z
L=L.monic()
denmu=lcm([c.denominator() for c in mu]).monic();rest=denmu;es=[]
for f in [z,Dsource,L]:
 n=0
 while f.degree()>0 and not rest%f:rest=rest//f;n+=1
 es.append(n)
rest=rest.monic();extra=rest if rest.degree()>0 else z
poles=[z,Dsource,L,extra,z]
def encode_with(f,exps):
 den=prod(p**e for p,e in zip(poles,exps));num=F(f)*den;assert num.denominator()==1
 return {'a':[code(c) for c in num.numerator()],'b':[],'den':list(map(int,exps))}
modden=lcm([c.denominator() for c in j]).monic();mr=modden;me=[]
for f in [z,Dsource,L,extra]:
 n=0
 while f.degree()>0 and not mr%f:mr=mr//f;n+=1
 me.append(n)
assert mr.degree()==0;me.append(0)
mu_exps=es+[int(rest.degree()>0),0]
obj={'scope':'One rational scale branch on the endpoint content curve, with all denominator support explicitly retained for later boundary checks.','rank':12,'branch':args.branch,'root':code(co['root']),'parameter':'Z','poles':[[code(c) for c in f] for f in poles],
 'J_monic_H':[encode_with(c,me) for c in j], 'mu_H':[encode_with(mu[i],mu_exps) for i in range(12)],'actual_q':encode_with(co['P_root']/z**3,[3,0,0,0,0]),'modulus_denominator_exponents':me,'mu_denominator_exponents':mu_exps}
(out/'model.json').write_text(json.dumps(obj,separators=(',',':'),default=int)+'\n')
print('POLE_DEGREES',[p.degree() for p in poles],'MOD_DEN',me,'MU_DEN',mu_exps,flush=True)
print('MU_NUM_DEGREES',[c.numerator().degree() for c in mu],flush=True)
