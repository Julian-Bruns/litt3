#!/usr/bin/env python3
"""Verify all new polynomial certificates and exceptional-pencil identities.

There is no point sampling and no endpoint enumeration. Every coefficient
of each retained polynomial identity is checked exactly in F25.
"""
from __future__ import annotations
import json,sys
from pathlib import Path
from polynomial_core import *
from exact_fields import T as T_alpha,alpha_T,evaluate as original_evaluate,CODES
ROOT=Path(__file__).resolve().parents[2]

# Independently connect the convenient theta rows to the supplied alpha model.
th=sum((T_alpha.from_base(code(n))*alpha_T**j for j,n in enumerate([5,17,12,5])),T_alpha.zero)
assert th**4==T_alpha.from_base(code(20))
for nm,key in [('C','c'),('E','e'),('U','f'),('V','g')]:
 for i in range(4):
  original=original_evaluate(CODES[key],alpha_T**(25**i))
  model=sum((T_alpha.from_base(code(n)*pow(2,i*j,5))*th**j
             for j,n in enumerate(ROWS[nm])),T_alpha.zero)
  assert original==model,(nm,i)

# Symbolic quartic norm agrees with the multiplication determinant.
cols=[epsilon_times(T.row([F25.zero]*j+[F25.one])) for j in range(4)]
mult_matrix=[[cols[j][i] for j in range(4)] for i in range(4)]
N=norm_polynomial()
assert determinant(mult_matrix)==N

record=json.loads((ROOT/'structural/evidence/pencil_certificates.json').read_text())
assert record['schema']=='pencil-identities-v1'
expected={(d,'norm'):N for d in [0,1,3]}
expected.update({(2,'norm_times_'+nm):mul(N,p) for nm,p in residuals_d2().items()})
seen=set();summaries=[]
for cert in record['certificates']:
 key=(cert['relative_type'],cert['name'])
 assert key in expected and key not in seen;seen.add(key)
 target=unserial(cert['target']);assert target==expected[key]
 hs=[unserial(p) for p in cert['multipliers']]
 assert len(hs)==4
 qs=quadrics(key[0])
 actual=sum_poly(mul(h,q) for h,q in zip(hs,qs))
 assert actual==target,key
 summaries.append({'relative_type':key[0],'identity':key[1],
                   'multiplier_degree':max(map(degree,hs)),
                   'nonzero_multiplier_terms':sum(map(len,hs)),
                   'all_coefficients_verified':True})
assert seen==set(expected)

# Reverse inclusion: the entire norm-invertible d=2 pencil locus is
# precisely the stated separable cubic, not just a list of necessary roots.
z=X[2];z2=power(z,2)
x0=sum_poly([scale(z2,7),scale(z,NEG[5]),const(6)])
x1=sum_poly([scale(z2,12),neg(z),const(NEG[6])])
f=residuals_d2()['cubic']

def modf(p):
 assert all(a==0 and b==0 for a,b,c in p)
 p=dict(p)
 while p and max(m[2] for m in p)>=3:
  n=max(m[2] for m in p);c=p.get((0,0,n),0)
  if not c:raise AssertionError('Noncanonical polynomial')
  p=sub(p,scale(shift(f,(0,0,n-3)),c))
 return p

def substitute(p):
 out={}
 for (a,b,c),coef in p.items():
  term=scale(mul(mul(power(x0,a),power(x1,b)),power(z,c)),coef)
  out=add(out,term)
 return modf(out)
for q in quadrics(2):assert not substitute(q)
for h in residuals_d2().values():assert not substitute(h)
n_inv=sum_poly([const(13),scale(z,7),scale(z2,2)])
assert modf(mul(substitute(N),n_inv))==const(1)

quadratic=sum_poly([z2,scale(z,16),const(20)])
assert mul(sub(z,const(10)),quadratic)==f
D=code(16)**2-4*code(20)
assert to_code(D)==23 and D**12==code(4)
assert evaluate(quadratic,[0,0,10])!=0
# Therefore the quadratic is separable and irreducible over F25, and
# the cubic is reduced. No quadratic root lies in the degree-seven K/F25.

vals=[evaluate(x0,[0,0,10]),evaluate(x1,[0,0,10]),10]
assert vals==[16,12,10]
e=T.row(list(map(code,[16,12,10,1])))
assert evaluate(N,vals)==6
assert row('C',2)==T.from_base(code(11))*e+T.from_base(code(16))
w=e*row('E',0)
assert [to_code(v) for v in w.c]==[19,4,10,1]
obstruction=w.c[1]-e.c[1]*w.c[3]
assert to_code(obstruction)==17 and obstruction

out={'status':'PASS','scope':'exact pencil-locus classification and both-single-type exclusion',
     'full_original_decision':'UNRESOLVED','endpoint_search_performed':False,
     'polynomial_identity_check':'all coefficients, not samples',
     'original_alpha_rows_checked':16,'norm_determinant_checked':True,
     'certificates':summaries,
     'd_0_1_3_norm_invertible_locus':'empty',
     'd_2_norm_invertible_locus':{
       'isomorphism':'F25[z]/(z^3+[6]z^2+[7]z+[11])',
       'degree':3,'reduced':True,'factorization':[[NEG[10],1],[20,16,1]],
       'quadratic_discriminant':23,'discriminant_power_12':4,
       'norm_inverse_ascending':[13,7,2],
       'only_K_rational_direction_theta':[16,12,10,1],
       'direction_norm':6,
       'c_alpha2_equals_11_times_direction_plus':16,
       'direction_times_e_alpha_theta':[19,4,10,1],
       'nonzero_pencil_rank_drop_obstruction':17}}
print(json.dumps(out,indent=2))
