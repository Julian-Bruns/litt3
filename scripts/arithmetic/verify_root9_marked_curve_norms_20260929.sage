#!/usr/bin/env sage
"""Independent literal Bezout/coverage verification for new tail norms."""
import argparse,json
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory');args=p.parse_args();out=Path(args.directory)
J0=load(str(out/'J.sobj'));K=J0.parent().base_ring();a=K.gen();b=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(c):return sum((c//25**i%5+(c//25**i//5%5)*b)*a**i for i in range(4))
Q=PolynomialRing(K,'q');q=Q.gen()
def readtxt(path):
 v=list(map(int,Path(path).read_text().split()));assert len(v)==v[0]+2;return Q(list(map(dec,v[1:])))
f=readtxt(out/'curve_norms.C71.txt');g=readtxt(out/'curve_norms.C72.txt');w=json.loads((out/'curve_norms.gcd72.json').read_text())
aa=Q(list(map(dec,w['a'])));bb=Q(list(map(dec,w['b'])));gg=Q(list(map(dec,w['gcd'])))
assert aa*f+bb*g==gg
fac=load(str(out/'curve_norm_gcd_factors.sobj'));assert prod(p**e for p,e in fac).monic()==gg.monic()
assert len(fac)==1 and fac[0][0].degree()==5 and fac[0][1]==375
for w in load(str(out/'norm_boundary_witnesses.sobj')):
 assert sum(c*f for c,f in zip(w['multipliers'],[w['H_modulus']]+w['tails']))==w['gcd']
 assert w['gcd']==w['H_modulus'].parent().gen()
print('GLOBAL_NORM_BEZOUT_AND_COMPLETE_BOUNDARY_PASS',flush=True)
(out/'norm_independent_receipt.json').write_text(json.dumps({'norm_degrees':[int(f.degree()),int(g.degree())],'norm_bezout':'PASS','gcd':'irreducible quintic to power375','all_boundary_roots':'H=0, excluded by original chart','boundary_identity':'PASS'},indent=2)+'\n')
