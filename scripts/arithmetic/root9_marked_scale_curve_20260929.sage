#!/usr/bin/env sage
"""Reduce the necessary marked-content scale relation on its genuine curve."""
import argparse,json
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory');args=p.parse_args();out=Path(args.directory)
J=load(str(out/'J.sobj'));R=J.parent();u,q=R.gens();K=R.base_ring();a=K.gen();beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
F5=GF(5)
def vec(c):return vector(F5,[K(c).polynomial()[i] for i in range(8)])
cb=matrix(F5,[vec(beta**j*a**i) for i in range(4) for j in range(2)]).transpose().inverse()
def code(c):
 v=cb*vec(c);return int(sum(ZZ(v[2*i])*25**i+ZZ(v[2*i+1])*5*25**i for i in range(4)))
Q=PolynomialRing(K,'q');qq=Q.gen();F=Q.fraction_field();U=PolynomialRing(F,'u');uu=U.gen();hh=R.hom([uu,U(qq)],U)
j=hh(J);lc=Q(j.leading_coefficient());print('J_LEADING',[(f.degree(),e,code(-f[0]/f[1]) if f.degree()==1 else None) for f,e in lc.factor()],flush=True)
save(j,str(out/'J_over_Kq.sobj'))
vals=[hh(load(str(out/('coefficient_'+str(i)+'_4.sobj'))))%j for i in range(2)]
def integral(f):
 den=lcm([c.denominator() for c in f]);f=f*den
 g=R.zero()
 for i,c in enumerate(f):
  assert c.denominator()==1
  g+=sum((v*u**i*q**k for k,v in enumerate(c.numerator())),R.zero())
 return g,den
den=lcm([c.denominator() for f in vals for c in f]);aa,bb=[integral(f*den)[0] for f in vals]
g=aa.gcd(bb);ar=aa//g;br=bb//g
print('REDUCED_SCALE_DEGREES',[(v.degree(u),v.degree(q),len(v.dict())) for v in [ar,br]],flush=True)
print('REDUCED_COMMON',[(v.degree(u),v.degree(q),int(e)) for v,e in g.factor()],flush=True)
save({'a':ar,'b':br,'common':g,'denominator':den,'J':J},str(out/'scale_curve_reduced.sobj'))
print('BASE_DENOMINATOR_DEGREE',den.degree(),flush=True)
Lpar=load(str(out/'line_parity.sobj'))
for f,e in Lpar['line_coefficient'].factor():print('LINE_FACTOR',f.degree(),e,'ROOT',code(-f[0]/f[1]) if f.degree()==1 else None,flush=True)
