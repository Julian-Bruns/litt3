#!/usr/bin/env sage -python
"""Extract and verify an actual first-unstable-at-height-two extension.

The exploratory row-module sweep only discovers the candidate. This
certificate checks a nonzero vector against every original cohomology
matrix entry, then reconstructs its regular dormant connection.
"""
import argparse
import hashlib
import json
import sys
from pathlib import Path
from sage.all import *
from pointed_frobenius_polynomial import build_polynomial_blocks
from probe_pointed_family_orbits import insert


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    root=Path(__file__).resolve().parents[2]
    assert not args.output.resolve().is_relative_to(root)
    sys.path.insert(0,str(root/'scripts/genus_two'))
    from check_dormant_parameter_curve import dormant_polynomial
    k=GF(5**5,'b');b=k.gen();U=PolynomialRing(k,'u');u=U.gen()
    t=2*b**3+b**2+b+3
    assert t**5+2*t**2+1==0
    F=u*(u-1)*(u-2)*(u-3)*(u-t);R=u*(u-3)
    block=build_polynomial_blocks(F,R,25)[1]
    M0,M1,M2=block['matrices'];n=M0.ncols()
    chosen=list(M0.transpose().pivots());extras=[j for j in range(n+2) if j not in chosen]
    inv=M0.matrix_from_rows(chosen).inverse()
    A=inv*M1.matrix_from_rows(chosen);B=inv*M2.matrix_from_rows(chosen)
    low=M0.matrix_from_rows(extras)
    C=M1.matrix_from_rows(extras)-low*A;D=M2.matrix_from_rows(extras)-low*B
    KZ=PolynomialRing(k,'z');z=KZ.gen()
    op=A.change_ring(KZ)+z*B.change_ring(KZ)
    obs=C.change_ring(KZ)+z*D.change_ring(KZ)
    basis=[None]*n
    for power in range(n):
        for row in obs.rows():insert(basis,row,KZ)
        obs=obs*op
    determinant=matrix(KZ,basis).det()
    assert determinant.degree()==1
    z0=-determinant[0]/determinant[1]
    rows=[];obs=C+z0*D;op=A+z0*B
    for power in range(n):
        rows.extend(obs.rows());obs=obs*op
    ker=matrix(k,rows,implementation='generic').right_kernel()
    assert ker.dimension()==1
    v=ker.basis()[0];j=next(i for i,c in enumerate(v) if c)
    v=v/v[j]
    lam0=-(op*v)[j]
    assert op*v==-lam0*v
    lam=vector(k,[lam0,1,z0])
    actual=lam0*M0+M1+z0*M2
    assert actual.rank()==n-1 and actual*v==0
    xi=vector(k,[c**125 for c in lam])
    assert vector(k,[c**25 for c in xi])==lam
    # The initial class survives the first height. Check it directly in
    # all sixteen torsion components, independently of family avoidance.
    branches=[k(0),k(1),k(2),k(3),t]
    twists=[U(1)]+[u-a for a in branches]+[(u-a)*(u-c) for i,a in enumerate(branches) for c in branches[i+1:]]
    first_ranks=[]
    for label,twist in enumerate(twists):
        for part,bb in enumerate(build_polynomial_blocks(F,twist,5)):
            mm=bb['matrices']
            vv=sum((xi[j]**5*mm[j] for j in range(3)),matrix(k,mm[0].nrows(),mm[0].ncols(),0))
            assert vv.rank()==vv.ncols()
            first_ranks.append([label,part,int(vv.rank()),int(vv.ncols())])
    h=U(list(v));multiplier=R if block['source_component']=='kappa' else F//R
    # The quotient horizontal scalar is sqrt(multiplier)*h/F^6.
    frac=U.fraction_field()
    log_derivative=frac(multiplier.derivative())/(2*multiplier)+frac(h.derivative())/h-6*frac(F.derivative())/F
    potential=log_derivative.derivative()+log_derivative**2
    base=2*(frac(F.derivative())/F)**2-frac(F.derivative(2))/F
    correction=U(F*(potential-base))
    assert correction.degree()<=3 and correction[3]==2
    T=correction[2]
    W=T**2-3*(t+1)*T+3*(t+1)
    V=t+1+(-t-1+2*T)*W
    assert correction==2*u**3+T*u**2+W*u+V
    assert dormant_polynomial(t,T)==0
    s=T-3*t+1;w=-2*s**3*t+s**4-2*s**3+1
    assert w**2==1+3*s**4 and s
    ecurve=EllipticCurve(k,[3,0])
    point=ecurve(2*(w+1)/s**2,4*(w+1)/s**3)
    assert point
    xx=point[0]
    quotient_U=((xx**5+2*xx**3+xx)/(xx**4+3*xx**2+1))**2
    zz=1/(t+1)
    assert quotient_U**3*(quotient_U+3)**2==(zz**5-zz)**4
    def coeffs(a):return [int(c) for c in k(a).polynomial().list()]
    receipt=dict(kind='explicit_pointed_first_instability_height2',field_modulus=str(k.modulus()),
                 parameter=coeffs(t),parameter_minpoly=str(t.minpoly()),
                 torsion_polynomial=str(R),parity_block=1,source_component=block['source_component'],
                 original_cech_extension=[coeffs(c) for c in xi],
                 frobenius25_projective_parameters=[coeffs(c) for c in lam],
                 kernel_polynomial=[coeffs(c) for c in h.list()],
                 observation_determinant=str(determinant),original_matrix_shape=list(actual.dimensions()),
                 original_matrix_rank=int(actual.rank()),original_matrix_kernel_checked=True,
                 first_height_all32_ranks=first_ranks,
                 log_derivative=str(log_derivative),potential_correction=str(correction),dormant_parameter=coeffs(T),
                 elliptic_point=[coeffs(c) for c in point[:2]],elliptic_point_order=int(point.order()),
                 elliptic_group_order=int(ecurve.order()),
                 dormant_quotient_coordinate=coeffs(quotient_U),
                 dormant_quotient_minpoly=str(quotient_U.minpoly()),
                 source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                 builder_sha256=hashlib.sha256(Path(__file__).with_name('pointed_frobenius_polynomial.py').read_bytes()).hexdigest())
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('PASS original matrix kernel; all32 first-height ranks; regular dormant reconstruction.')
    print('extension',xi,'dormant',T,'elliptic order',point.order(),'group order',ecurve.order())


if __name__=='__main__':main()
