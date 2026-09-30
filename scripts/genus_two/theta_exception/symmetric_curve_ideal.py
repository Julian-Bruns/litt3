#!/usr/bin/env sage-python
"""Explore the five-equation symmetric curve, without imposing a Kummer cut."""
import argparse
import hashlib
import json
from pathlib import Path
import time
from sage.all import GF, PolynomialRing

ap=argparse.ArgumentParser();ap.add_argument('--locus',type=Path,required=True)
ap.add_argument('--map',type=Path,required=True);ap.add_argument('--output',type=Path,required=True)
args=ap.parse_args();assert not args.output.resolve().is_relative_to(Path(__file__).resolve().parents[3])
start=time.monotonic();locus=json.loads(args.locus.read_text());md=json.loads(args.map.read_text())
k=GF(125,'alpha',modulus=[1,1,0,1]);alpha=k.gen()
dec=lambda a:k(a%5)+k((a//5)%5)*alpha+k(a//25)*alpha**2
R=PolynomialRing(k,names=['b0','b1','b2','c0','c1','c2'],order='degrevlex');x=R.gens()
eq=[R(s) for s in locus['equations'][:5]]
h=[sum(dec(t)*xs[0]**e[0]*xs[1]**e[1]*xs[2]**e[2]
       for e,t in md['stable_to_boundary_octic']) for xs in [x[:3],x[3:]]]
I=R.ideal(eq);print('Starting actual five-equation ideal',flush=True)
gb=I.groebner_basis(algorithm='singular:slimgb')
print('Basis complete',len(gb),'seconds',time.monotonic()-start,flush=True)
tests={label:I.reduce(f) for label,f in [('H_b',h[0]),('H_c',h[1]),('H_b_H_c',h[0]*h[1])]}
out={'status':'exploratory_exact_five_equation_ideal','dimension':int(I.dimension()),
     'basis_size':len(gb),'groebner_basis':[str(f) for f in gb],
     'remainders':{label:str(f) for label,f in tests.items()},
     'seconds':time.monotonic()-start,'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
args.output.write_text(json.dumps(out,indent=2)+'\n')
print({key:val for key,val in out.items() if key not in ['groebner_basis','remainders']},flush=True)
print({label:not bool(f) for label,f in tests.items()},flush=True)
