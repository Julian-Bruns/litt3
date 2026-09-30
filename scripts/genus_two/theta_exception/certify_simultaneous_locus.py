#!/usr/bin/env sage-python
"""Produce short ideal-membership certificates for the simultaneous locus.

Six polynomials with pure-power leading monomials certify finiteness.
A seventh identity places the actual first-boundary octic in the ideal.
Replay needs only polynomial multiplication, not a Groebner-basis assertion.
All generated artifacts belong outside the research workspace.
"""
import argparse
import hashlib
import json
from pathlib import Path
import time
from sage.all import GF, PolynomialRing, matrix, identity_matrix
from sage.interfaces.singular import singular


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--probe',type=Path,required=True)
    ap.add_argument('--map-data',type=Path,required=True)
    ap.add_argument('--output',type=Path,required=True)
    ap.add_argument('--replay',action='store_true')
    args=ap.parse_args()
    if args.output.resolve().is_relative_to(Path(__file__).resolve().parents[3]):
        raise ValueError('Certificates must be outside litt3')
    start=time.monotonic()
    k=GF(125,'alpha',modulus=[1,1,0,1])
    R=PolynomialRing(k,names=['b0','b1','b2','c0','c1','c2'],order='degrevlex')
    if args.replay:
        data=json.loads(args.output.read_text())
        equations=[R(f) for f in data['equations']]
        targets=[R(f) for f in data['targets']]
        M=matrix(R,[[R(f) for f in row] for row in data['multipliers']])
    else:
        data=json.loads(args.probe.read_text())
        equations=[R(f) for f in data['equations']]
        targets=[]
        for s in data['groebner_basis']:
            f=R(s)
            if sum(bool(v) for v in f.lm().exponents()[0])==1:
                targets.append(f)
        a=k.gen()
        decode=lambda n:k(n%5)+k(n//5%5)*a+k(n//25)*a*a
        md=json.loads(args.map_data.read_text())
        b=list(R.gens()[:3])+[R(1)]
        H=sum(decode(t)*b[0]**e[0]*b[1]**e[1]*b[2]**e[2]
              for e,t in md['stable_to_boundary_octic'])
        targets.append(H)
        assert len(targets)==7
        si=singular(R.ideal(equations));st=singular(R.ideal(targets))
        print('Lifting seven targets against the six original equations',flush=True)
        singular.eval('matrix certUnits;')
        singular.eval('matrix certLift=lift(%s,%s,certUnits,"slimgb");'%(si.name(),st.name()))
        print('Lift returned; converting and checking exact products',flush=True)
        assert singular('certUnits').sage()==identity_matrix(R,7)
        M=matrix(R,singular('certLift').sage())
    assert matrix(R,1,6,equations)*M==matrix(R,1,7,targets)
    leaders=[list(map(int,f.lm().exponents()[0])) for f in targets[:6]]
    assert all(sum(bool(v) for v in e)==1 for e in leaders)
    assert set(next(i for i,v in enumerate(e) if v) for e in leaders)==set(range(6))
    out={'status':'exact_product_identities_verified','equations':list(map(str,equations)),
         'targets':list(map(str,targets)),
         'multipliers':[[str(x) for x in row] for row in M.rows()],
         'pure_power_leading_exponents':leaders,
         'source_probe_sha256':hashlib.sha256(args.probe.read_bytes()).hexdigest(),
         'map_sha256':hashlib.sha256(args.map_data.read_bytes()).hexdigest(),
         'seconds':time.monotonic()-start}
    if not args.replay:
        args.output.write_text(json.dumps(out,indent=2)+'\n')
    print('PASS: seven polynomial identities; pure leading powers',leaders,flush=True)


if __name__=='__main__':
    main()
