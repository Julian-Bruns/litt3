#!/usr/bin/env sage-python
"""Exact affine ideal of the actual simultaneous rank-two locus.

Exploratory until its output and projective-chart coverage are audited.
The five equations come from the calibrated actual triquadratic.
"""
import argparse
import hashlib
import json
from pathlib import Path
import time
from sage.all import GF, PolynomialRing
from verify import tensor_from_entries, simultaneous_equations


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--data-dir',type=Path,required=True)
    ap.add_argument('--map-data',type=Path,required=True)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    assert not args.output.resolve().is_relative_to(Path(__file__).resolve().parents[3])
    start=time.monotonic()
    data=json.loads((args.data_dir/'certificate.json').read_text())
    mapdata=json.loads(args.map_data.read_text())
    k=GF(125,'alpha',modulus=[1,1,0,1]);alpha=k.gen()
    decode=lambda a:k(a%5)+k((a//5)%5)*alpha+k(a//25)*alpha**2
    R=PolynomialRing(k,names=['b0','b1','b2','c0','c1','c2'],order='degrevlex')
    v=R.gens();b=list(v[:3])+[R(1)];c=list(v[3:])+[R(1)]
    pairs=[(i,j) for i in range(4) for j in range(i,4)]
    bm=[b[i]*b[j] for i,j in pairs];cm=[c[i]*c[j] for i,j in pairs]
    _,F=simultaneous_equations(tensor_from_entries(data['tensor_nonzero_unordered']))
    equations=[sum(decode(int(F[r,i,j]))*bm[i]*cm[j]
                   for i in range(10) for j in range(10)) for r in range(5)]
    G=lambda z: ((z[0]*z[2]-z[1]**2)**2
        +z[1]*z[3]*(z[0]**2+decode(107)*z[0]*z[1]+decode(66)*z[0]*z[2]
                    +decode(66)*z[1]**2+decode(107)*z[1]*z[2]+decode(106)*z[2]**2)
        +z[3]**2*(decode(107)*z[0]*z[1]+decode(68)*z[0]*z[2]
                    +decode(14)*z[1]**2+decode(74)*z[1]*z[2])
        +decode(37)*z[1]*z[3]**3+decode(93)*z[3]**4)
    equations.append(G(c))
    I=R.ideal(equations)
    print('Computing actual six-equation ideal',flush=True)
    gb=I.groebner_basis(algorithm='singular:slimgb')
    print('Groebner basis complete',len(gb),'seconds',time.monotonic()-start,flush=True)
    dim=I.dimension()
    residual=sum(decode(t)*b[0]**e[0]*b[1]**e[1]*b[2]**e[2]
                 for e,t in mapdata['stable_to_boundary_octic'])
    rem=I.reduce(residual)
    print('dimension',dim,'octic remainder zero',not bool(rem),flush=True)
    out=dict(status='exploratory',dimension=int(dim),basis_size=len(gb),
             first_boundary_octic_in_ideal=not bool(rem),
             affine_length=int(I.vector_space_dimension()) if dim==0 else None,
             equations=[str(f) for f in equations],groebner_basis=[str(f) for f in gb],
             octic_remainder=str(rem),seconds=time.monotonic()-start,
             script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest())
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(out,indent=2)+'\n')
    print({k:v for k,v in out.items() if k not in ['equations','groebner_basis','octic_remainder']},flush=True)


if __name__=='__main__':main()
