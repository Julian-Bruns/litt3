#!/usr/bin/env sage
"""Check newly generated scale identities independently of native algebra."""
import argparse,json
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory');args=p.parse_args();d=Path(args.directory)
F5=GF(5);R=PolynomialRing(F5,'a');a=R.gen()
K=GF(5**8,name='a',modulus=a**8+a**6+2*a**3+4*a**2+2*a+2);a=K.gen()
beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(c):
 z=K.zero()
 for i in range(4):
  x=c%25;c//=25;z+=(x%5+(x//5)*beta)*a**i
 assert not c
 return z
Q=PolynomialRing(K,'q');q=Q.gen()
data=json.loads((d/'scale_certificates_all.json').read_text());inc=json.loads((d/'finite_incidence.json').read_text())
assert {tuple(b['modulus']) for b in data['blocks']}=={tuple(b['modulus']) for b in inc['blocks']}
ans=[]
for b in data['blocks']:
 f=Q(list(map(dec,b['modulus'])));E=Q.quotient(f,'qq');M=PolynomialRing(E,'mu')
 def row(key):return M([E(Q(list(map(dec,c)))) for c in b[key]])
 witness=row('U')*row('C71')+row('V')*row('C72')
 if 'W' in b:witness+=row('W')*row('C73')
 assert witness==1
 ans.append(int(f.degree()));print('LITERAL_BEZOUT_PASS',f.degree(),flush=True)
(d/'independent_scale_receipt.json').write_text(json.dumps({'modulus_degrees':ans,'literal_bezout':'PASS','coverage_matches_incidence':True},indent=2)+'\n')
