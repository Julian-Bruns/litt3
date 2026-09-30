#!/usr/bin/env sage-python
"""Identify the transgressed family octic by eighty double base points.

Checks all gradient identities over F5[a][T]/Psi. Bounds a nonzero
rank164 minor by the previously scalar-certified cubic specialization.
"""
import argparse
import itertools
import json
from pathlib import Path
import time
from sage.all import GF, PolynomialRing, lcm

ap=argparse.ArgumentParser()
for name in ['theta','quadrics','octic','calibration','output']:ap.add_argument('--'+name,type=Path,required=True)
args=ap.parse_args();assert not args.output.resolve().is_relative_to(Path(__file__).resolve().parents[2])
start=time.monotonic();td=json.loads(args.theta.read_text());qd=json.loads(args.quadrics.read_text())
od=json.loads(args.octic.read_text());cd=json.loads(args.calibration.read_text())
R=PolynomialRing(GF(5),'a');a=R.gen();F=R.fraction_field();conv=lambda s:F(s.replace('^','**'))
RT=PolynomialRing(R,'T');psi=RT([R(conv(s)) for s in td['extension_polynomial']]);A=RT.quotient(psi,'t')
theta=[[conv(s) for s in row] for row in td['theta_coordinates']]+[[F.one()]]
theta_den=lcm(v.denominator() for row in theta for v in row)
z=[A(RT([R(v*theta_den) for v in row])) for row in theta]
ops=[['1' if i==j else '0' for i in range(4) for j in range(4)]]
ops += [cover['translation'] for cover in qd['covers']]
mon=[tuple(e) for e in cd['monomials']]
coeff={tuple(e):R(s.replace('^','**')) for e,s in od['octic_terms']}
rows={};row_degrees={};point_dens=[]
for label,entries in enumerate(ops):
    m=[conv(s) for s in entries];den=lcm(v.denominator() for v in m);point_dens.append(str(den*theta_den))
    # The supplied translations act on dual coordinates; transpose for moduli.
    p=[sum(A(R(m[4*j+i]*den))*z[j] for j in range(4)) for i in range(4)]
    powers=[[v**i for i in range(9)] for v in p]
    block=[[R.zero() for _ in mon] for _ in range(20)]
    gradients=[A.zero() for _ in range(4)]
    for col,e in enumerate(mon):
        for j in range(4):
            if not e[j]%5:continue
            v=A(e[j])
            for h in range(4):v*=powers[h][e[h]-(h==j)]
            gradients[j]+=A(coeff.get(e,R.zero()))*v
            for h in range(5):block[5*j+h][col]=R(v[h])
    assert all(not v for v in gradients)
    for j,row in enumerate(block):
        index=20*label+j
        if index in cd['selected_rows']:
            rows[index]=row
            row_degrees[index]=max((row[col].degree() for col in cd['pivot_columns']),default=0)
    print('double basepoint orbit',label,'verified',time.monotonic()-start,flush=True)
bound=sum(max(0,d) for d in row_degrees.values())
# Independently evaluate the chosen polynomial minor at alpha and eliminate scalarly.
k=GF(125,'alpha',modulus=[1,1,0,1]);alpha=k.gen()
assert all(R(s.replace('^','**'))(alpha) for s in point_dens)
entries=[[rows[row][col](alpha) for col in cd['pivot_columns']] for row in cd['selected_rows']]
n=len(entries);assert n==164;det=k.one()
for j in range(n):
    h=next(i for i in range(j,n) if entries[i][j])
    if h!=j:entries[j],entries[h]=entries[h],entries[j];det=-det
    v=entries[j][j];det*=v
    for i in range(j+1,n):
        if not entries[i][j]:continue
        r=entries[i][j]/v
        for col in range(j+1,n):entries[i][col]-=r*entries[j][col]
        entries[i][j]=k.zero()
assert det
out={'status':'all_eighty_double_basepoint_identities_verified','rank_minor_size':164,
     'rank_minor_degree_bound':int(bound),'rank_minor_calibration_determinant':str(det),
     'point_clearing_denominators':point_dens,'point_denominator_degree_bound':max(int(R(s.replace('^','**')).degree()) for s in point_dens),
     'row_degree_bounds':{str(row):int(v) for row,v in row_degrees.items()},
     'selected_rows':cd['selected_rows'],'selected_columns':cd['pivot_columns'],
     'octic_coefficient_degree':od['coefficient_degree'],'seconds':time.monotonic()-start}
args.output.write_text(json.dumps(out,indent=2)+'\n')
print('PASS; rank minor bound',bound,'calibration',det,flush=True)
