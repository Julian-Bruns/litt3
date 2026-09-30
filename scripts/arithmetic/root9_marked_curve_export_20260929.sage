#!/usr/bin/env sage
"""Export the remaining marked-content curve and its forced scale.

This is a coordinate/identity export, not a square-locus decision.
All coefficients use the accepted F25 quartic-tower coding.
"""
import argparse,json
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory');args=p.parse_args();out=Path(args.directory)
d=load(str(out/'compact_scale_fraction.sobj'));R=d['J'].parent();u,q=R.gens();K=R.base_ring();a=K.gen()
beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
F5=GF(5)
def vec(c):return vector(F5,[K(c).polynomial()[i] for i in range(8)])
cb=matrix(F5,[vec(beta**j*a**i) for i in range(4) for j in range(2)]).transpose().inverse()
def code(c):
 v=cb*vec(c);return int(sum(ZZ(v[2*i])*25**i+ZZ(v[2*i+1])*5*25**i for i in range(4)))
Q=PolynomialRing(K,'q');qq=Q.gen();F=Q.fraction_field();U=PolynomialRing(F,'H');H=U.gen();hh=R.hom([H*qq,U(qq)],U)
J=U(hh(d['J'])/qq**3);A=U(hh(d['numerator'])/qq**3);B=U(hh(d['denominator'])/qq**3)
mu=(-A*B.inverse_mod(J))%J
assert (mu*B+A)%J==0
def rat(f):
 f=F(f);return {'numerator':[code(c) for c in f.numerator()], 'denominator':[code(c) for c in f.denominator()]}
def constcode(c):
 c=F(c);assert c.numerator().degree()<=0 and c.denominator().degree()==0
 return code(c.numerator()[0]/c.denominator()[0])
rawj=[]
for i,c in enumerate(J):
 assert c.denominator()==1
 for j,b in enumerate(c.numerator()):
  if b:rawj.append([i,j,code(b)])
den=lcm([c.denominator() for c in mu]);fac=list(den.factor())
obj={'scope':'J(H,q)=0 and forced mu=-A(H)/B(H); base points excluded separately. Not a square-locus decision.',
 'J_Hq':rawj,'J_monic_H':[rat(c) for c in J/J.leading_coefficient()],
 'mu_H':[rat(c) for c in mu], 'A_H':[constcode(c) for c in A], 'B_H':[constcode(c) for c in B],
 'mu_denominator_factors':[[[code(c) for c in f],int(e)] for f,e in fac],
 'J_leading_H':rat(J.leading_coefficient()),'B_norm':rat(J.resultant(B)),
 'identity_mu_B_plus_A':'PASS'}
(out/'marked_curve.json').write_text(json.dumps(obj,separators=(',',':'))+'\n')
print('MU_DEGREES',[(c.numerator().degree(),c.denominator().degree()) for c in mu],flush=True)
print('MU_DEN_FACTORS',obj['mu_denominator_factors'],flush=True)
print('J_LEADING',obj['J_leading_H'],flush=True)
print('B_NORM',obj['B_norm'],flush=True)
