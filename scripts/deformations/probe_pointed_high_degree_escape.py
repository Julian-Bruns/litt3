#!/usr/bin/env sage -python
"""Check actual height-two kernels at factors of the universal determinant.

The large determinant is used only to select a parameter. Every resulting
kernel is verified in the original cohomology matrices. Raw arithmetic
belongs outside the research workspace.
"""
import argparse
import hashlib
import json
import sys
import time
from pathlib import Path
from sage.all import *
from pointed_frobenius_polynomial import build_polynomial_blocks
from probe_pointed_family_orbits import insert


def check_factor(factor, root):
    started=time.monotonic()
    P=PolynomialRing(GF(5),'T');polynomial=P(factor['polynomial'])
    assert polynomial.is_irreducible()
    degree=polynomial.degree();k=GF(5**degree,'t',modulus=polynomial);t=k.gen()
    U=PolynomialRing(k,'u');u=U.gen()
    F=u*(u-1)*(u-2)*(u-3)*(u-t);R=u*(u-3)
    block=build_polynomial_blocks(F,R,25)[1]
    M0,M1,M2=block['matrices'];n=M0.ncols()
    chosen=list(M0.transpose().pivots())
    assert len(chosen)==n
    extras=[j for j in range(n+2) if j not in chosen]
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
    v=ker.basis()[0];j=next(i for i,c in enumerate(v) if c);v=v/v[j]
    lam0=-(op*v)[j]
    assert op*v==-lam0*v
    lam=vector(k,[lam0,1,z0]);actual=lam0*M0+M1+z0*M2
    assert actual.rank()==n-1 and actual*v==0
    xi=vector(k,[c.frobenius(-2) for c in lam])
    assert vector(k,[c**25 for c in xi])==lam
    branches=[k(0),k(1),k(2),k(3),t]
    twists=[U(1)]+[u-a for a in branches]+[(u-a)*(u-b) for i,a in enumerate(branches) for b in branches[i+1:]]
    first_ranks=[]
    for label,twist in enumerate(twists):
        for part,bb in enumerate(build_polynomial_blocks(F,twist,5)):
            mm=bb['matrices']
            vv=sum((xi[j]**5*mm[j] for j in range(3)),matrix(k,mm[0].nrows(),mm[0].ncols(),0))
            assert vv.rank()==vv.ncols()
            first_ranks.append([label,part,int(vv.rank()),int(vv.ncols())])
    h=U(list(v));multiplier=F//R;frac=U.fraction_field()
    logarithm=frac(multiplier.derivative())/(2*multiplier)+frac(h.derivative())/h-6*frac(F.derivative())/F
    potential=logarithm.derivative()+logarithm**2
    correction=U(F*(potential-2*(frac(F.derivative())/F)**2+frac(F.derivative(2))/F))
    assert correction.degree()<=3 and correction[3]==2
    T=correction[2];W=T**2-3*(t+1)*T+3*(t+1)
    V=t+1+(-t-1+2*T)*W
    assert correction==2*u**3+T*u**2+W*u+V
    sys.path.insert(0,str(root/'scripts/genus_two'))
    from check_dormant_parameter_curve import dormant_polynomial
    assert dormant_polynomial(t,T)==0
    def coeffs(c):return [int(a) for a in k(c).polynomial().list()]
    return dict(parameter_polynomial=str(polynomial),parameter_degree=int(degree),
                original_cech_extension=[coeffs(c) for c in xi],
                frobenius25_parameters=[coeffs(c) for c in lam],
                kernel_polynomial=[coeffs(c) for c in h.list()],
                original_matrix_shape=list(actual.dimensions()),original_matrix_rank=int(actual.rank()),
                all32_first_height_ranks=first_ranks,first_instability_height=2,
                dormant_parameter=coeffs(T),dormant_equation_checked=True,
                seconds=float(time.monotonic()-started))


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--input',type=Path,required=True)
    ap.add_argument('--degree',type=int,default=106)
    ap.add_argument('--factor-index',type=int,default=0)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args();root=Path(__file__).resolve().parents[2]
    assert not args.output.resolve().is_relative_to(root)
    original=json.loads(args.input.read_text())
    factors=[f for f in original['factors'] if f['degree']==args.degree]
    result=check_factor(factors[args.factor_index],root)
    result.update(status='exact_original_matrix_check',
                  input_sha256=hashlib.sha256(args.input.read_bytes()).hexdigest(),
                  source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                  builder_sha256=hashlib.sha256(Path(__file__).with_name('pointed_frobenius_polynomial.py').read_bytes()).hexdigest())
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print('PASS degree',args.degree,'first instability exactly2; actual kernel and dormant reconstruction',result['seconds'],flush=True)


if __name__=='__main__':main()
