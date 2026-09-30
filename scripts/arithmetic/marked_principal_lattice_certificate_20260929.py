#!/usr/bin/env sage -python
"""Certify the complete marked lattice by an actual relation and index.

This verifier contains no Weil polynomial. The actual point-order and
small-primary group receipts provide the lower index; a directly checked
Jacobian relation provides the upper index. The integer checks are exact.
"""
import sys,json,hashlib
from pathlib import Path
from sage.all import ZZ,PolynomialRing,matrix
base=Path(sys.argv[1]);output=Path(sys.argv[2])
paths={'order':base/'marked_jacobian_order/receipt.json',
       'small':base/'marked_jacobian_small_primary/small_primary.json',
       'generator':base/'marked_relation_generator_check/receipt.json',
       'lattice':base/'marked_jacobian_exact_kernel.json'}
rec={k:json.loads(p.read_text())for k,p in paths.items()}
m=ZZ(rec['order']['exact_point_order']);assert all(e==1 for ell,e in m.factor())
assert rec['small']['complete'] and rec['generator']['jacobian_class_zero']
small={ZZ(v['prime']):v for v in rec['small']['primes']}
lower=ZZ(1)
for ell,e in m.factor():
 rank=small[ell]['actual_primary_rank'] if ell in small else 1
 assert rank>=1
 lower*=ell**rank
R=PolynomialRing(ZZ,'T');T=R.gen();Q=T**8+T**4+1
G=R(rec['generator']['relation'])
orbit=matrix(ZZ,[[(T**j*G%Q)[i]for i in range(8)]for j in range(8)])
upper=abs(orbit.det());assert lower==upper
old=matrix(ZZ,rec['lattice']['basis_rows'])
assert old.row_module()==orbit.row_module()
data={'scope':'full marked relation ideal from actual generator plus matching lower and upper indices',
 'assumed_weil_polynomial':False,'generator_coefficients':list(map(int,G)),
 'geometric_orbit_annihilator':list(map(int,Q)),
 'actual_point_order':str(m),'lower_group_order':str(lower),'upper_group_order':str(upper),
 'orbit_basis_rows':[[str(a)for a in row]for row in orbit],
 'previous_enumeration_lattice_identical':True,'exact_kernel':True,
 'inputs':{k:{'path':str(p),'sha256':hashlib.sha256(p.read_bytes()).hexdigest()}for k,p in paths.items()}}
output.write_text(json.dumps(data,indent=2)+'\n')
print('PASS principal ideal and exact index; no Weil-polynomial assumption',upper)
