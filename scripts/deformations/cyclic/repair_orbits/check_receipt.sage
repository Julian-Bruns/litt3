#!/usr/bin/env sage
"""Independent characteristic-five check of the new orbit's fourth receipt.

This checks the field, primary/reference equations, actual trace contraction,
and arithmetic transport. It does not replace the integral Laurent engine.
"""
import argparse
import hashlib
import json
from pathlib import Path

ap=argparse.ArgumentParser(description=__doc__)
ap.add_argument('--input',type=Path,required=True)
ap.add_argument('--receipt',type=Path,required=True)
ap.add_argument('--compare',type=Path)
ap.add_argument('--output',type=Path)
args=ap.parse_args()
d=json.loads(args.input.read_text())
r=json.loads(args.receipt.read_text())
k=GF(5**d['field_degree'],'a',modulus=d['field_modulus'])
a=k.gen()
dec=lambda v:sum(k(c)*a**i for i,c in enumerate(v))
enc=lambda x:[int(x[i]) for i in range(k.degree())]
tau=dec(d['tau']); lam=dec(d['shift_coefficients'][1]); chi=dec(d['H'])
assert tau**4+4*tau**3+tau**2+4*tau+3==0
assert tau**625==tau
F00=4*tau*tau+tau+2; F01=3*tau+3
F10=tau**3+3*tau*tau+3; F11=4*tau*tau+1
assert F01*lam**6-F11*lam**5+F00*lam-F10==0
assert chi==F00+F01*lam**5
psi=matrix(k,[[dec(c) for c in row] for row in d['psi']])
rho=vector(k,[dec(c) for c in d['rho']])
pre=vector(k,[dec(c) for c in d['preimage']])
assert psi.rank()==13 and psi*vector(k,[x**5 for x in pre])==rho
adj=vector(k,[dec(c) for c in r['primary_reference_adjustment']])
actual_rho=vector(k,[dec(c) for c in r['actual_base_reference_rho']])
assert psi[:3,:3]*vector(k,[x**5 for x in adj])==actual_rho-rho[:3]
used=vector(k,[dec(c) for c in r['primary_repair_used']])
actual_full=vector(k,list(actual_rho)+[0]*12)
assert psi*vector(k,[x**5 for x in used])==actual_full
weights=vector(k,[3*tau*tau+tau+1,3*tau+4,3])
assert (actual_rho*weights)*(4+4*tau)==1
dual=matrix(k,[[dec(c) for c in row] for row in d['obstruction_dual_rows']])
assert dual.rank()==2 and not dual*psi
assert dual[0]==vector(k,[0]*12+list(-chi*weights))
co=vector(k,[dec(c) for c in r['rho4_coordinates']])
obs=vector(k,[dec(c) for c in r['obstruction_coordinates']])
assert dual*co==obs and obs[0]!=0
assert dec(r['trace_residue'])==obs[0]
assert sum(dec(v) for v in r['trace_decomposition'].values())==obs[0]
assert r['rho4_certified_precision']>=30

if args.compare:
    rr=json.loads(args.compare.read_text())
    assert [dec(c) for c in rr['obstruction_coordinates']]==list(obs)
    assert dec(rr['trace_residue'])==obs[0]
    assert rr['rho4_certified_precision']>r['rho4_certified_precision']

# State the answer over the invariant parameters tau and lambda, without
# relying on Sage's chosen degree-twenty field generator.
basis=[tau**i*lam**j for j in range(5) for i in range(4)]
bmat=matrix(GF(5),[enc(x) for x in basis]).transpose()
if d['cover_orbit']=='nonrational':
    assert bmat.rank()==20 and lam**625!=lam
    coeff=list(bmat.solve_right(vector(GF(5),enc(obs[0]))))
    norm=prod(obs[0]**(625**j) for j in range(5))
    assert norm**625==norm and norm!=0
    base_basis=matrix(GF(5),[enc(tau**i) for i in range(4)]).transpose()
    norm_coeff=list(base_basis.solve_right(vector(GF(5),enc(norm))))
    degree=next(j for j in range(1,6) if obs[0]**(625**j)==obs[0])
else:
    coeff=enc(obs[0]);norm_coeff=coeff;degree=1
result={
 'status':'PASS','scope':'Independent finite-field/reference/trace checks; no second integral engine claimed.',
 'cover_orbit':d['cover_orbit'],
 'trace_in_tau_lambda':[int(c) for c in coeff],
 'order':'lambda^j tau^i, j=0..4, i=0..3',
 'relative_trace_field_degree':int(degree),
 'trace_norm_in_tau':[int(c) for c in norm_coeff],
 'trace_inverse':enc(obs[0]**-1),
 'compared_changed_frobenius':bool(args.compare),
 'inputs_sha256':{str(p):hashlib.sha256(p.read_bytes()).hexdigest()
     for p in [args.input,args.receipt]+([args.compare] if args.compare else [])}}
if args.output:args.output.write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({key:value for key,value in result.items() if key!='inputs_sha256'},indent=2))
