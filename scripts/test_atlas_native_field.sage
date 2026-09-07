#!/usr/bin/env sage
"""Tiny exact native RREF/products in every actual intrinsic census field."""
import json,time
from pathlib import Path
from atlas_native_rref import NativeRref

root=Path(__file__).resolve().parents[1]; folder=root/'Research/computations'
prime=GF(5); Z=PolynomialRing(prime,'z')
base=GF(25,'a',modulus=Z([2,4,1])); descbase=dict(kind='finite_field',degree=2)
fields=[]; cert=json.loads((folder/'normalized_oper_algebra_certificate.json').read_text())
zeta=Z(cert['coordinates']['zeta'])
for row in json.loads((folder/'normalized_oper_closed_points.json').read_text())['factors']:
    modulus=Z(row['polynomial']); k=GF(5**int(row['degree_F5']),'alpha',modulus=modulus,check_irreducible=False)
    fields.append((row['id'],k,k((zeta%modulus).list()),None))
T=PolynomialRing(base,'u')
for row in json.loads((folder/'invariant_oper_solutions.json').read_text())['orbits']:
    h=T(sage_eval(row['factor'],locals={'a':base.gen(),'b7':T.gen()}))
    if h.degree()==1: k=base; layers=None
    else:
        k=T.quotient(h,names='u'); layers=[(base,descbase),(k,dict(kind='polynomial_quotient_field',degree=int(h.degree())))]
    fields.append(('invariant_%s'%row['orbit_id'],k,k(base.gen()),layers))
desc=json.loads((root.parent/'litt3-computation-data/atlas-all18/orbit_0001/tensor/canonical_atlas_system.json').read_text())['field_description']
small=GF(5**int(desc['base']['degree']),'alpha',modulus=Z(desc['base']['modulus']),check_irreducible=False)
TT=PolynomialRing(small,'t'); k=TT.quotient(TT([small(v) for v in desc['modulus']]),names='t')
a=k([small(v) for v in desc['base_F25_generator']])
fields.append(('orbit_0001_actual_tower',k,a,[(small,desc['base']),(k,desc)]))
results=[]
for rep,k,a,layers in fields:
    start=time.monotonic(); native=NativeRref(k,layers)
    if layers is None: theta=k([(i*i+3*i+1)%5 for i in range(native.degree)])
    else: theta=k.gen()+a
    A=matrix(k,[[theta,1,a,theta+a],[a,theta+1,2,theta*a],
                [theta+a,theta+2,a+2,theta+a+theta*a]])
    assert A[2,:]==A[0,:]+A[1,:]
    native.rref(A,audit_sage=True)
    native.multiply(A,A.transpose(),audit_sage=True)
    smallA=matrix(base,2,3,[base.gen(),1,2,3,4+base.gen(),0])
    native.multiply(smallA,A,base_generator=a,audit_sage=True)
    result=dict(rep=rep,degree_F5=native.degree,exact_sage_agreement=True,
        seconds=time.monotonic()-start,operations=native.records)
    print(json.dumps(result),flush=True); results.append(result)
assert len(results)==19
out=root.parent/'litt3-computation-data/orbit11-structure/native_field_fixtures.json'
out.write_text(json.dumps(dict(scope='All18 intrinsic fields plus actual orbit1 tower; small exact arithmetic fixtures, no atlas exclusion',
    fields=results,all_exact_checks_passed=True),indent=2)+'\n')
