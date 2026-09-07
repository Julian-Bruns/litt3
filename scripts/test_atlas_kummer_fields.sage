#!/usr/bin/env sage
"""Tiny dense arithmetic fixtures for the actual optional cubic fields.

No atlas tensors or enumeration: reduce the already certified coordinates,
then test each actual coefficient-field model against generic scalar Sage.
"""
import argparse,json,multiprocessing,time
from pathlib import Path
from atlas_native_rref import NativeRref

ap=argparse.ArgumentParser();ap.add_argument('--orbits',type=int,nargs='+',default=list(range(4,11)))
ap.add_argument('--workers',type=int,default=1);args=ap.parse_args()
root=Path(__file__).resolve().parents[1];folder=root/'Research/computations'
prime=GF(5);Z=PolynomialRing(prime,'z')
rows=json.loads((folder/'normalized_oper_closed_points.json').read_text())['factors']
certificate=json.loads((folder/'normalized_oper_algebra_certificate.json').read_text())
lambda_polynomial=Z(certificate['lambda']);a_polynomial=Z(certificate['coordinates']['zeta'])
out=root.parent/'litt3-computation-data/orbit11-structure/kummer-field-fixtures'
out.mkdir(parents=True,exist_ok=True)

def fixture(number):
    start=time.monotonic();rep='orbit_%04d'%number
    row=next(r for r in rows if r['id']==rep);modulus=Z(row['polynomial'])
    n=int(modulus.degree());base=GF(5**n,'alpha',modulus=modulus,check_irreducible=False)
    lam=base((lambda_polynomial%modulus).list());a=base((a_polynomial%modulus).list())
    character=lam**((5**n-1)//3)
    desc=dict(kind='finite_field',degree=n)
    if character==1:k=base;layers=None
    else:
        T=PolynomialRing(base,'t');k=T.quotient(T.gen()**3-lam,names='t')
        layers=[(base,desc),(k,dict(kind='polynomial_quotient_field',degree=3))]
    bridge=NativeRref(k,layers)
    dense=base([(i*i+3*i+1)%5 for i in range(n)])
    theta=k(dense)+(k.gen() if layers else k(a))
    values=[theta,k(a),theta**2+k(a)*theta,k(dense)*theta+1]
    for u in values:
        assert bridge.from_native(bridge.to_native(u))==u
        for v in values:assert bridge.to_native(u*v)==bridge.to_native(u)*bridge.to_native(v)
    M=matrix(k,[values,[u+v for u,v in zip(values,values[1:]+values[:1])],
                [2*u+v for u,v in zip(values,values[1:]+values[:1])]],implementation='generic')
    assert M[2,:]==M[0,:]+M[1,:]
    bridge.rref(M,audit_sage=True);bridge.multiply(M,M.transpose(),audit_sage=True)
    result=dict(rep=rep,base_degree_F5=n,actual_degree_F5=bridge.degree,
        lambda_is_cube=bool(character==1),field_model=bridge.field_model,
        every_selected_scalar_product_and_generic_matrix_identity_passed=True,
        seconds=time.monotonic()-start,operations=bridge.records,
        scope='Tiny dense arithmetic preflight; no tensor, field-degree reduction or atlas exclusion')
    target=out/(rep+'.json');tmp=Path(str(target)+'.tmp')
    tmp.write_text(json.dumps(result,indent=2,default=int)+'\n');tmp.replace(target)
    print(json.dumps(result,default=int),flush=True);return result

if args.workers==1:
    results=[fixture(n) for n in args.orbits]
else:
    with multiprocessing.get_context('fork').Pool(min(args.workers,len(args.orbits))) as pool:
        results=list(pool.imap_unordered(fixture,args.orbits,chunksize=1))
print(json.dumps(dict(all_passed=True,fields=len(results)),default=int),flush=True)
