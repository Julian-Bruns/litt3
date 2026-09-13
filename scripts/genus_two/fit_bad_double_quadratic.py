#!/usr/bin/env python3
"""Fit and verify the quadratic Schur term from all31 actual cyclic covers.

This is a finite calculation, not a proof of the complete formal germ.
Run with sage -python. Output coefficient tuples retain the receipt field.
"""
import argparse,json
from pathlib import Path
from sage.all import GF,PolynomialRing,matrix,vector
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('receipt',type=Path);p.add_argument('--output',type=Path)
args=p.parse_args()
data=json.loads(args.receipt.read_text())
P=PolynomialRing(GF(5),'a');k=GF(5**(len(data['field_modulus'])-1),'a',
    modulus=P(data['field_modulus']),impl='pari_ffelt');a=k.gen()
decode=lambda v:sum(k(c)*a**i for i,c in enumerate(v))
encode=lambda c:[int(x) for x in c.polynomial().list()]
points=[v['coordinates'] for v in data['covers']]
assert len(points)==31 and data['status']=='complete'
rows=[[x*x,y*y,z*z,x*y,x*z,y*z] for x,y,z in points]
M=matrix(k,rows,implementation='generic')
values=vector(k,[decode(v['schur_coefficients'][2]) for v in data['covers']])
c=M.solve_right(values);assert M*c==values
H=matrix(k,[[c[0],c[3]/2,c[4]/2],[c[3]/2,c[1],c[5]/2],
    [c[4]/2,c[5]/2,c[2]]],implementation='generic')
rad=list(H.right_kernel().basis());rad=[v/next(x for x in v if x) for v in rad]
result=dict(status='PASS',source=str(args.receipt),field_modulus=data['field_modulus'],
    parameter=data['parameter'],quadratic_coefficients=[encode(x) for x in c],
    monomial_order=['x^2','y^2','z^2','xy','xz','yz'],rank=int(H.rank()),
    invariant_rank=int(H[:2,:2].rank()),anti_square_nonzero=bool(c[2]),
    cross_parity_zero=bool(c[4]==0 and c[5]==0),
    radical=[[encode(x) for x in v] for v in rad],
    radical_coordinate_minpolys=[[[int(x) for x in c.minpoly()] for c in v] for v in rad],
    all31_evaluations_nonzero=all(values),
    scope='Verified quadratic jet only; higher radical term not determined')
print(json.dumps(result,indent=2))
if args.output:args.output.write_text(json.dumps(result,indent=2)+'\n')
