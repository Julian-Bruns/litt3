#!/usr/bin/env sage
"""Exact scalar, non-Conway and large-field canonical-string fixtures."""
import json,time
from atlas_coefficient_codec import native_power_basis_decoder
from atlas_field_maps import inverse_frobenius_map,from_power_coordinates

set_random_seed(20260908)
started=time.monotonic();reports=[]
for degree in [2,4,18,26,240,410]:
    P=PolynomialRing(GF(5),'x')
    if degree==2:modulus=P([4,2,1])
    elif degree==410:
        path='/Users/julian/Documents/litt3-computation-data/atlas-native-affine/orbit_0006/chart-31/result.json'
        modulus=P(json.load(open(path))['field_model']['modulus'])
    elif degree==240:
        path='/Users/julian/Documents/litt3-computation-data/orbit11-structure/complete_native_orbit_0004/report.json'
        modulus=P(json.load(open(path))['field_modulus'])
    else:modulus=P.irreducible_element(degree,algorithm='random')
    k=GF(5**degree,name='alpha',modulus=modulus)
    desc=dict(kind='finite_field',degree=degree,generator='alpha')
    decoder=native_power_basis_decoder(k,desc,{'alpha':k.gen()})
    values=[k.zero(),k.one(),k.gen(),k.gen()+1]+[k.random_element() for _ in range(12)]
    texts=[str(c) for c in values]
    before=time.monotonic();answers=[decoder(s) for s in texts];fast=time.monotonic()-before
    before=time.monotonic();old=[k(sage_eval(s,locals={'alpha':k.gen()})) for s in texts];slow=time.monotonic()-before
    assert answers==old==values
    assert all(from_power_coordinates(k,v.polynomial().list())==v for v in values)
    # Kummer coefficients occupy powers0mod3 and systematically have
    # trailing zero coordinates; this was the slow unpadded constructor.
    sparse=[(i*i+1)%5 if i%3==0 else 0 for i in range(degree)]
    while sparse and not sparse[-1]:sparse.pop()
    assert from_power_coordinates(k,sparse)==k(sparse)
    before=time.monotonic();old_roots=[v**(5**(degree-1)) for v in values];old_root_seconds=time.monotonic()-before
    before=time.monotonic();inverse_map=inverse_frobenius_map(k);roots=[inverse_map(v) for v in values];root_seconds=time.monotonic()-before
    assert roots==old_roots and all(r**5==v for r,v in zip(roots,values))
    assert all(decoder(s) is None for s in ['alpha + alpha','alpha^'+str(degree),'5','alpha/alpha','(alpha)','alpha**2'])
    assert native_power_basis_decoder(k,desc,{'alpha':k.gen()+1}) is None
    reports.append(dict(degree=int(degree),coefficients=len(values),fast_seconds=fast,old_seconds=slow,
                        inverse_frobenius_seconds=root_seconds,old_root_seconds=old_root_seconds,
                        exact_scalar_agreement=True,all_fifth_power_identities_verified=True))
print(json.dumps(dict(seed=int(20260908),reports=reports,seconds=time.monotonic()-started),default=int),flush=True)
