#!/usr/bin/env sage -python
"""Check the corrected cubic theta model through its trope branch curve.

Also place the labelled node configuration in an F125 projective frame.
This check is independent of the inverse theta relations themselves.
"""
import argparse
import hashlib
import itertools
import json
from pathlib import Path
from sage.all import *
from probe_pointed_kummer import (theta_from_rosenhain,kummer_from_node,
                                  heisenberg_nodes,trope_planes,ducrohet_quintics)


def normalize(v):
    return tuple(c/next(a for a in v if a) for c in v)


def branch_certificate(node,k,alpha):
    R=PolynomialRing(k,names=['x0','x1','x2','x3'])
    K,coeff=kummer_from_node(node,R);nodes=heisenberg_nodes(node)
    ell=vector(k,trope_planes(nodes,k)[0])
    plane=matrix(k,[ell]).right_kernel().basis_matrix().transpose()
    pts=[plane.solve_right(vector(k,v)) for v in nodes if ell*vector(k,v)==0]
    assert len(pts)==6
    S=PolynomialRing(k,names=['z0','z1','z2']);z=S.gens()
    mons=[z[0]**2,z[1]**2,z[2]**2,z[0]*z[1],z[0]*z[2],z[1]*z[2]]
    ev=matrix(k,[[m(*p) for m in mons] for p in pts]);assert ev.rank()==5
    conic=sum(c*m for c,m in zip(ev.right_kernel().basis()[0],mons))
    assert all(conic(*p)==0 for p in pts)
    assert matrix(k,[[conic.derivative(v).derivative(w) for w in z] for v in z]).det()
    restricted=S(K(*list(plane*vector(S,z))))
    quotient,remainder=restricted.quo_rem(conic**2)
    assert not remainder and quotient.is_constant() and quotient
    p=pts[0];projection=matrix(k,[p]).right_kernel().basis_matrix()
    grad=vector(k,[conic.derivative(v)(*p) for v in z])
    tangent=next(v for v in matrix(k,[grad]).right_kernel().basis()
                 if matrix(k,[p,v]).rank()==2)
    branch=[normalize(projection*tangent)]+[normalize(projection*v) for v in pts[1:]]
    assert len(set(branch))==6
    def det(a,b):return a[0]*b[1]-a[1]*b[0]
    def mobius(a,b,c):
        return matrix(k,[[a[1]*det(b,c),-a[0]*det(b,c)],
                         [c[1]*det(b,a),-c[0]*det(b,a)]])
    target={normalize(v) for v in [(k(a),k(1)) for a in [0,1,2,3,alpha]]+[(k(1),k(0))]}
    matches=[]
    for abc in itertools.permutations(branch,3):
        M=mobius(*abc)
        if {normalize(M*vector(k,v)) for v in branch}==target:matches.append(M)
    assert matches
    frame=None
    for ids in itertools.combinations(range(16),4):
        B=matrix(k,[nodes[i] for i in ids]).transpose()
        if not B.is_invertible():continue
        for j in range(16):
            v=B.solve_right(vector(k,nodes[j]))
            if all(v):
                frame=B*diagonal_matrix(v);break
        if frame is not None:break
    framed=[normalize(frame.inverse()*vector(k,v)) for v in nodes]
    assert all(c**125==c for v in framed for c in v)
    x=vector(R,R.gens());newK=R(K(*list(frame*x)));newK/=newK.leading_coefficient()
    V=ducrohet_quintics(coeff,R)
    twisted_frame=frame.apply_map(lambda c:c**5)
    newV=frame.inverse()*vector(R,[f(*list(twisted_frame*x)) for f in V])
    factor=newV[0].leading_coefficient();newV=[R(f/factor) for f in newV]
    newplanes=[normalize(vector(k,ell)*frame) for ell in trope_planes(nodes,k)]
    assert all(c**125==c for c in newK.coefficients())
    assert all(c**125==c for f in newV for c in f.coefficients())
    assert all(c**125==c for ell in newplanes for c in ell)
    return dict(conic=str(conic),branch_points=[list(map(str,v)) for v in branch],
                target_matches=len(matches),branch_transport=[list(map(str,v)) for v in matches[0].rows()],
                labelled_frame=[list(map(str,v)) for v in frame.rows()],
                all_framed_nodes_over_F125=True,framed_quartic_over_F125=True,
                framed_quintics_over_F125=True,all_framed_tropes_over_F125=True,
                framed_quintic_terms=[len(f.dict()) for f in newV])


def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args();root=Path(__file__).resolve().parents[2]
    assert not args.output.resolve().is_relative_to(root)
    k=GF(5**12,'b');U=PolynomialRing(k,'u');u=U.gen()
    alpha=(u**3+u+1).roots(multiplicities=False)[0]
    node=theta_from_rosenhain(k(2),k(3),alpha)
    receipt=branch_certificate(node,k,alpha)
    receipt.update(source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                   builder_sha256=hashlib.sha256(Path(__file__).with_name('probe_pointed_kummer.py').read_bytes()).hexdigest(),
                   field_modulus=str(k.modulus()),alpha=str(alpha),node=list(map(str,node)))
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(receipt,indent=2,default=int)+'\n')
    print('PASS corrected branch curve and whole F125 frame',flush=True)


if __name__=='__main__':main()
