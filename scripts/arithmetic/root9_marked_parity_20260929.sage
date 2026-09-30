#!/usr/bin/env sage
"""Factor the marked-branch parity condition, preserving its exceptions."""
import argparse,json
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory');p.add_argument('data');args=p.parse_args();out=Path(args.directory)
f=load(str(out/'content_0.sobj'));R=f.parent();u,q=R.gens();K=R.base_ring();a=K.gen();beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(c):
 z=K.zero()
 for i in range(4):
  d=c%25;c//=25;z+=(d%5+(d//5)*beta)*a**i
 assert not c
 return z
Q=PolynomialRing(K,'q');qq=Q.gen();d=json.loads((Path(args.data)/'inputs.json').read_text());source=json.loads((Path(args.data)/'scaled_source.json').read_text())
def row(key):return Q(list(map(dec,d[key])))
H=dec(42135);L=load(str(out/'L.sobj'));J=load(str(out/'J.sobj'))
phi=R.hom([H*qq,qq],Q)
N=row('a0')*(H*qq)**3+row('b')*(H*qq)**2+row('c')*H*qq+row('e')
D0=Q(list(map(dec,source['D0_q'])))
line=phi(load(str(out/'coefficient_0_4.sobj')))
unit=qq*D0*N*(qq-dec(10149))*(qq-dec(64426))
extra=Q.one()
for ff,ee in line.factor():
 if ff.gcd(unit).degree()==0:extra*=ff
print('LINE_RAW_DEGREE',line.degree(),'LINE_EXTRA_DEGREE',extra.degree(),'FACTORS',[(g.degree(),e) for g,e in extra.factor()],flush=True)
save({'H':H,'line_coefficient':line,'original_unit_product':unit,'extra':extra},str(out/'line_parity.sobj'))
if extra.degree()>0:
 F5=GF(5)
 def vec(c):return vector(F5,[K(c).polynomial()[i] for i in range(8)])
 cb=matrix(F5,[vec(beta**j*a**i) for i in range(4) for j in range(2)]).transpose().inverse()
 def code(c):
  v=cb*vec(c);return int(sum(ZZ(v[2*i])*25**i+ZZ(v[2*i+1])*5*25**i for i in range(4)))
 blocks=[]
 for ff,ee in extra.factor():blocks.append({'degree':int(ff.degree()),'modulus':[code(c) for c in ff],'coordinates':{'3':[code(c) for c in (H*qq)%ff]}})
 (out/'line_parity_incidence.json').write_text(json.dumps({'scope':'Necessary marked-branch parity exceptions on u=<42135>*q','blocks':blocks},separators=(',',':'))+'\n')
a3=f;b3=load(str(out/'content_1.sobj'));a4=load(str(out/'coefficient_0_4.sobj'));b4=load(str(out/'coefficient_1_4.sobj'))
print('ADJACENT_ROW_DETERMINANT_ZERO',a3*b4-a4*b3==0,flush=True)
aa=a4//a4.gcd(b4);bb=b4//a4.gcd(b4)
save({'a':aa,'b':bb,'common':a4.gcd(b4),'J':J,'L':L},str(out/'marked_scale_equation.sobj'))
print('SCALE_PAIR_DEGREES',[(g.degree(u),g.degree(q),len(g.dict())) for g in [aa,bb]],flush=True)
print('EXCEPTIONAL_COMMON_FACTORS',[(g.degree(u),g.degree(q),int(e)) for g,e in a4.gcd(b4).factor()],flush=True)
