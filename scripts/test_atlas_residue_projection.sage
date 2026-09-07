#!/usr/bin/env sage
"""Audit the complete fixed-curve coefficient window, not random atlas samples."""
import json,time
from pathlib import Path
from atlas_series import coefficient,coefficients
from atlas_residue_projection import ResidueProjection

root=Path(__file__).resolve().parents[1]
folder=root.parent/'litt3-computation-data/atlas-all18/invariant_0/tensor'
LS,t,expansions,dt=load(str(folder/'local.sobj'))
field=LS.base_ring(); gaps=[1,2,4,5,7,8,11,14,17]
domain=[-g for g in gaps]+list(range(1,32))
target=[-g for g in gaps]+list(range(1,48))
started=time.monotonic(); projection=ResidueProjection(expansions,domain,target)
setup=time.monotonic()-started
reducers=sorted([(3*i+10*j,s) for (i,j),s in expansions.items()],reverse=True)
def remainder(s):
    for pole,r in reducers:
        c=coefficient(s,-pole)
        if c: s-=c*r
    return s
for j,e in enumerate(projection.exponents):
    f=(t**e).add_bigoh(500); r=remainder(f)
    assert vector(field,coefficients(r,projection.exponents))==projection.remainder.column(j)
    assert vector(field,coefficients(remainder(t**(-85)*r),target))==projection.twice.column(j)
print(json.dumps(dict(fixed_curve_basis_columns_verified=len(projection.exponents),
    setup_seconds=setup,total_seconds=time.monotonic()-started,
    dimensions=list(projection.twice.dimensions()),
    scope='Exact linear operators, all coefficient extensions; all56 original R rows retained')),flush=True)
