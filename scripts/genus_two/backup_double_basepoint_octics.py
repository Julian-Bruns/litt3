#!/usr/bin/env sage-python
"""Scalar-certified degree-eight conditions at all eighty actual base points."""
import argparse
import itertools
import json
from pathlib import Path
import time
from sage.all import GF, PolynomialRing, matrix

ap=argparse.ArgumentParser();ap.add_argument('--theta',type=Path,required=True)
ap.add_argument('--quadrics',type=Path,required=True)
ap.add_argument('--output',type=Path,required=True);args=ap.parse_args()
assert not args.output.resolve().is_relative_to(Path(__file__).resolve().parents[2])
start=time.monotonic();td=json.loads(args.theta.read_text());qd=json.loads(args.quadrics.read_text())
k=GF(125,'alpha',modulus=[1,1,0,1]);alpha=k.gen();Ra=PolynomialRing(GF(5),'a');F=Ra.fraction_field()
def spec(s):
    v=F(s.replace('^','**'));return v.numerator()(alpha)/v.denominator()(alpha)
Rt=PolynomialRing(k,'T');psi=Rt([spec(s) for s in td['extension_polynomial']]);A=Rt.quotient(psi,'t');t=A.gen()
z=[A(Rt([spec(s) for s in row])) for row in td['theta_coordinates']]+[A.one()]
mon=[tuple(w.count(i) for i in range(4)) for w in itertools.combinations_with_replacement(range(4),8)]
ops=[matrix(k,4,4,1)]+[matrix(k,4,4,[spec(s) for s in d['translation']]).transpose() for d in qd['covers']]
rows=[]
for op in ops:
    p=[sum(op[i,j]*z[j] for j in range(4)) for i in range(4)]
    powers=[[v**i for i in range(9)] for v in p]
    block=[[k.zero() for _ in mon] for _ in range(20)]
    for col,e in enumerate(mon):
        for j in range(4):
            if not e[j]%5:continue
            v=A(e[j])
            for h in range(4):v*=powers[h][e[h]-(h==j)]
            for h in range(5):block[5*j+h][col]=v[h]
    rows.extend(block)
print('matrix320x165 constructed',time.monotonic()-start,flush=True)
echelon={};selected=[]
for index,v in enumerate(rows):
    row=list(v)
    for pivot,old in sorted(echelon.items()):
        coeff=row[pivot]
        if coeff:
            for j in range(pivot+1,165):row[j]-=coeff*old[j]
            row[pivot]=k.zero()
    support=[i for i,c in enumerate(row) if c]
    if support:
        pivot=support[0];scale=row[pivot];echelon[pivot]=[c/scale for c in row];selected.append(index)
assert len(echelon)==164
print('scalar rank',len(echelon),'seconds',time.monotonic()-start,flush=True)
out={'status':'scalar_elimination_verified','rank':len(echelon),'kernel_dimension':165-len(echelon),
     'selected_rows':selected,'pivot_columns':sorted(echelon),'monomials':[list(e) for e in mon],
     'seconds':time.monotonic()-start}
args.output.write_text(json.dumps(out,indent=2)+'\n')
