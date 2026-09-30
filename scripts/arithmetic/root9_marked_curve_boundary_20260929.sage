#!/usr/bin/env sage
"""Resolve every fibre retained by the marked-curve tail norm gcd."""
import argparse,json
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory');args=p.parse_args();out=Path(args.directory)
J0=load(str(out/'J.sobj'));K=J0.parent().base_ring();a=K.gen();b=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(c):return sum((c//25**i%5+(c//25**i//5%5)*b)*a**i for i in range(4))
Q=PolynomialRing(K,'q');q=Q.gen();data=json.loads((out/'marked_curve.json').read_text());tails=json.loads((out/'function_field.tails.json').read_text());src=json.loads((out/'function_field.residual.json').read_text())
fac=load(str(out/'curve_norm_gcd_factors.sobj'));records=[];witnesses=[]
for ff,mult in fac:
 assert ff.is_irreducible();F=K.extension(ff,'qq');qq=F.gen();U=PolynomialRing(F,'H');H=U.gen()
 def evaluate(p):return Q(list(map(dec,p)))(qq)
 def rat(row):return evaluate(row['numerator'])/evaluate(row['denominator'])
 j=U([rat(c) for c in data['J_monic_H']]);original=j
 polys=[]
 for tail in tails['tails']:
  vals=[]
  for r in tail:
   assert not r['b'];den=F.one()
   for f,e in zip(src['poles'],r['den']):den*=evaluate(f)**e
   vals.append(evaluate(r['a'])/den)
  polys.append(U(vals))
 g=j;co=[U.one()]+[U.zero() for _ in polys]
 for i,f in enumerate(polys):
  gg,aa,bb=g.xgcd(f);co=[aa*c for c in co];co[i+1]+=bb;g=gg
 assert sum((c*f for c,f in zip(co,[j]+polys)),U.zero())==g
 print('BOUNDARY',ff.degree(),mult,'COMMON_H_POLYNOMIAL',g,flush=True)
 assert g==H,'An allowed nonzero-H candidate remains; do not claim exclusion.'
 witnesses.append({'q_modulus':ff,'H_modulus':j,'tails':polys,'multipliers':co,'gcd':g})
 records.append({'q_degree':int(ff.degree()),'norm_gcd_multiplicity':int(mult),'only_common_H_root':'H=0','outside_original_open':True,'literal_bezout':'PASS'})
save(witnesses,str(out/'norm_boundary_witnesses.sobj'))
(out/'norm_boundary_receipt.json').write_text(json.dumps(records,indent=2)+'\n')
print('ALL_NORM_BOUNDARIES_OUTSIDE_ORIGINAL_OPEN',flush=True)
