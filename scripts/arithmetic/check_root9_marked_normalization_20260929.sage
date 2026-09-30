#!/usr/bin/env sage
"""Check the marked low jets against the actual full critical residual."""
import argparse,json
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory');args=p.parse_args();out=Path(args.directory)
src=load(str(out/'barred_source.sobj'));R=src['denominator'].parent();u,q=R.gens();K=R.base_ring();a=K.gen();beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(c):
 z=K.zero()
 for i in range(4):
  d=c%25;c//=25;z+=(d%5+(d//5)*beta)*a**i
 assert not c
 return z
d=json.loads((out/'normalization_sample.json').read_text());q0=dec(d['q']);u0=dec(d['u']);h=R.hom([u0,q0],K)
X=PolynomialRing(K,'x');x=X.gen();P=X([h(c) for c in src['P']]);tt=X([h(c) for c in src['t']]);den=h(src['denominator'])
S=PowerSeriesRing(K,'z',default_prec=7);z=S.gen();xx=S(dec(9)).add_bigoh(7)
for _ in range(4):xx=(xx-(P(xx)-q0*z**3)/P.derivative()(xx)).add_bigoh(7)
actual=[]
for row in d['co']:
 actual.append(sum((X(list(map(dec,c)))(xx)*z**j for j,c in enumerate(row)),S.zero()))
# Each local low-resultant row and the corresponding actual e row must
# differ by the SAME invertible series, independent of the scale power.
raw=[]
for i in range(3):
 g=S.zero()
 for n in range(3,6):
  name=('content_'+str(i)) if n==3 else ('coefficient_'+str(i)+'_'+str(n))
  f=load(str(out/(name+'.sobj')))
  g+=h(f)*z**n
 raw.append(g.add_bigoh(6))
ratio=(raw[0]/(z**3*actual[0])).add_bigoh(3)
assert ratio.valuation()==0
for i in range(3):assert (raw[i]-z**3*ratio*actual[i]).valuation()>=6
print('ALL_THREE_LOW_JET_ROWS_HAVE_ONE_COMMON_UNIT_FACTOR',flush=True)
print('COMMON_UNIT',ratio,flush=True)
(out/'normalization_receipt.json').write_text(json.dumps({'q':d['q'],'u':d['u'],'precision':int(6),'all_scale_rows_one_common_unit':'PASS','scope':'Regression against full critical source; global local identities still supplied by symbolic construction.'},indent=2)+'\n')
