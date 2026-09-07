#!/usr/bin/env sage
"""Exact raw Laurent fixtures in every intrinsic census field, no atlas solve."""
import json,time
from pathlib import Path
from atlas_series import coefficient,coefficients,transport,from_terms

root=Path(__file__).resolve().parents[1]
prime=GF(5); Z=PolynomialRing(prime,'z')
data=json.loads((root/'Research/computations/normalized_oper_closed_points.json').read_text())
fields=[]
for factor in data['factors']:
    fields.append((factor['id'],GF(5**int(factor['degree_F5']),name='alpha',
        modulus=Z(factor['polynomial']),check_irreducible=False)))
base=GF(25,'a',modulus=Z([2,4,1])); T=PolynomialRing(base,'u')
invariants=json.loads((root/'Research/computations/invariant_oper_solutions.json').read_text())
for row in invariants['orbits']:
    h=T(sage_eval(row['factor'],locals={'a':base.gen(),'b7':T.gen()}))
    field=base if h.degree()==1 else T.quotient(h,names='u')
    fields.append(('invariant_%s'%row['orbit_id'],field))
# Actual already-exported degree12 tower, unlike the native degree12 field.
desc=json.loads((root.parent/'litt3-computation-data/atlas-all18/orbit_0001/tensor/canonical_atlas_system.json').read_text())['field_description']
small=GF(5**int(desc['base']['degree']),'alpha',modulus=Z(desc['base']['modulus']),check_irreducible=False)
TT=PolynomialRing(small,'t')
fields.append(('orbit_0001_actual_tower',TT.quotient(TT([small(v) for v in desc['modulus']]),names='t')))
results=[]
for rep,k in fields:
    start=time.monotonic(); L=LaurentSeriesRing(k,'q',default_prec=100); q=L.gen()
    c=1+k.gen(); expected={-3:c,2:k(2)}
    fixtures=[(c*q**(-3),{-3:c}),((c*q**(-3)).add_bigoh(10),{-3:c}),
              (c*q**(-3)+2*q**2,expected),(from_terms(L,expected,precision=10),expected)]
    for f,terms in fixtures:
        exponents=range(-5,9)
        assert coefficients(f,exponents)==[terms.get(i,k.zero()) for i in exponents]
        assert [coefficient(f,i) for i in exponents]==[terms.get(i,k.zero()) for i in exponents]
        rebuilt=transport(f,L,lambda x:x)
        assert rebuilt==f and rebuilt.precision_absolute()==f.precision_absolute()
    f=from_terms(L,expected,precision=10)
    product=f*f
    assert coefficients(product,[-6,-1,4])==[c*c,4*c,k(4)]
    assert coefficients(f.derivative(),[-4,1])==[2*c,k(4)]
    try: coefficient(f,10)
    except ValueError: pass
    else: raise AssertionError('Unknown precision must be rejected')
    raw=(q**(-3))[-2]
    result=dict(rep=rep,field=str(k),native_exact_monomial_index_correct=bool(raw==0),
        guarded_fixtures_verified=True,seconds=time.monotonic()-start)
    print(json.dumps(result),flush=True);results.append(result)
assert len(results)==19
out=root.parent/'litt3-computation-data/orbit11-structure/laurent_accessor_fixtures.json'
out.write_text(json.dumps(dict(scope='18 intrinsic census fields plus actual orbit1 tower; raw coefficient identities, not atlas exclusions',
    fields=results,all_guarded_fixtures_verified=True),indent=2)+'\n')
