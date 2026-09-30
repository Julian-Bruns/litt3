#!/usr/bin/env python3
"""Exact input-table generator for quadratic_check.cpp. No geometric-field search.

All entries are F5 coordinates in the specified F25 basis of K0.
The large table is regenerable and deliberately not retained in the archive.
"""
import sys,json
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parent))
from exact import *
root=Path(__file__).resolve().parents[1]
d=json.loads((root/'inputs/data.json').read_text());K=Extension(d['zeta_minimal_over_F25']);z=K.element([0,1]);zz=[K.pow(z,j) for j in range(29)];kap=22
from verify_continuation import projections
pr=projections()['unnormalized_F25_Frobenius_projections']
E=Extension(d['A_monic'])
r1,r3=E.element(pr['c_row'][1]),E.element(pr['c_row'][3])
q1,q3=E.element(pr['f0_row'][1]),E.element(pr['f0_row'][3])
w=E.div(r3,r1)
assert E.pow(w,25)==E.mul(E.integer(4),w)
assert E.pow(w,2)==E.embed(21)
assert E.div(E.mul(w,q1),q3)==E.embed(kap)
vec=lambda v: [q for c in v for q in (c%5,c//5)]
def terms(i,j):
    r,a=i%4,i//4;s,b=j%4,j//4
    c1=F.sub(pow(2,r,5)*pow(3,s,5)%5,F.mul(kap,pow(3,r,5)*pow(2,s,5)%5))
    c2=F.sub(pow(2,s,5)*pow(3,r,5)%5,F.mul(kap,pow(3,s,5)*pow(2,r,5)%5))
    return K.add(K.mul(K.embed(c1),zz[(5*a+17*b)%29]),K.mul(K.embed(c2),zz[(5*b+17*a)%29]))
Q=[[vec(terms(i,j)) for j in range(116)] for i in range(116)]
T=[vec(K.mul(K.embed(F.sub(1,kap)),zz[(22*(i//4))%29])) for i in range(116)]
def vals(weight,exponent):return [vec(K.mul(K.integer(pow(weight,i%4,5)),zz[(exponent*(i//4))%29])) for i in range(116)]
tables=[('Q',Q),('T',T),('H15',vals(2,5)),('H35',vals(3,5)),('H117',vals(2,17)),('H317',vals(3,17))]
import argparse
p = argparse.ArgumentParser(description='Regenerate the exact finite quadratic-character table.')
p.add_argument('--output', type=Path, required=True)
args = p.parse_args()
args.output.parent.mkdir(parents=True, exist_ok=True)
with args.output.open('w') as f:
 for name,data in tables:
  shape='[116][116][14]' if name=='Q' else '[116][14]'
  def arr(a):return '{'+','.join(arr(x) if isinstance(x,list) else str(x) for x in a)+'}'
  f.write('static const unsigned char '+name+shape+'='+arr(data)+';\n')

print('PASS exact quadratic-character table; w^2=[21], kappa=[22].')
