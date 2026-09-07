#!/usr/bin/env sage
"""Bounded ACTUAL oper-field tower scalar and fifth-root regression."""
import argparse,json,time
from pathlib import Path
from atlas_coefficient_codec import canonical_coefficient_decoder
from atlas_native_rref import NativeRref

ap=argparse.ArgumentParser();ap.add_argument('--orbits',type=int,nargs='+',default=[1,4,5,7]);args=ap.parse_args()
root=Path(__file__).resolve().parents[1]
exec(compile((root/'scripts/oper_representatives.sage').read_text(),'oper_representatives.sage','exec'))
reports=[]
for number in args.orbits:
    before=time.monotonic();data=load_oper('orbit_%04d'%number);old=data['k'];desc=data['field_description']
    def layers(k,d):
        return [(k,d)] if d['kind']=='finite_field' else layers(k.base_ring(),d['base'])+[(k,d)]
    all_layers=layers(old,desc);bridge=NativeRref(old,all_layers)
    k=GF(5**bridge.degree,'c',modulus=PolynomialRing(GF(5),'z')(list(bridge.modulus)),check_irreducible=False)
    native=lambda v:k(bridge.to_native(old(v)).polynomial().list())
    images={d['generator']:native(f.gen()) for f,d in all_layers}
    decoder=canonical_coefficient_decoder(k,desc,images)
    theta=old(all_layers[0][0]([(i*i+2*i+1)%5 for i in range(all_layers[0][0].degree())]))+old.gen()
    values=[old.zero(),old.one(),old.gen(),theta,theta**2+theta+1,theta**3+3*theta**2+1]
    texts=[str(v) for v in values]
    t=time.monotonic();decoded=[decoder(s) for s in texts];fast=time.monotonic()-t
    t=time.monotonic();slow_values=[k(sage_eval(s,locals=images)) for s in texts];slow=time.monotonic()-t
    assert decoded==slow_values==[native(v) for v in values]
    roots=[v.pth_power(-1) for v in decoded]
    assert all(r**5==v for r,v in zip(roots,decoded))
    reports.append(dict(rep=data['metadata'].get('id','orbit_%04d'%number),degree_F5=bridge.degree,
        field_model=bridge.field_model,coefficients=len(values),decode_seconds=fast,
        old_decode_seconds=slow,exact_original_field_agreement=True,
        every_fifth_power_identity_verified=True,seconds=time.monotonic()-before))
print(json.dumps(dict(all_passed=True,reports=reports),default=int),flush=True)
