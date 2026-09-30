#!/usr/bin/env sage -python
"""Exact first-height pointed incidence on the dormant elliptic curve.

The established family resultant limits the ordinary parameters to the
sixty bad cubic values. This script tests every dormant connection over
each of them (including its nonrational roots), and the t=4 fiber, by
the complete horizontal-section equation in all sixteen theta twists.
"""
import argparse
import hashlib
import json
from pathlib import Path
from sage.all import *
from check_dormant_parameter_curve import dormant_polynomial


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args();root=Path(__file__).resolve().parents[2]
    assert not args.output.resolve().is_relative_to(root)
    k=GF(5**9,'b');U=PolynomialRing(k,'u');u=U.gen();K=U.fraction_field()
    cubic_elements=(u**125-u).roots(multiplicities=False)
    parameters=[]
    for t in cubic_elements:
        if t in [k(0),k(1),k(2),k(3)]:continue
        if t==4:parameters.append(t);continue
        z=1/(t+1);A=(z**5-z)**4
        if A**3+3*A**2+4==0:parameters.append(t)
    assert len(parameters)==61
    E=EllipticCurve(k,[3,0]);records=[];points=set()
    for number,t in enumerate(parameters):
        F=u*(u-1)*(u-2)*(u-3)*(u-t)
        branch=[k(0),k(1),k(2),k(3),t]
        twists=[U(1)]+[u-a for a in branch]+[(u-a)*(u-b) for j,a in enumerate(branch) for b in branch[j+1:]]
        roots=U(dormant_polynomial(t,u)).roots(multiplicities=False)
        assert len(roots)==5
        for T in roots:
            W=T**2-3*(t+1)*T+3*(t+1)
            V=t+1+(-t-1+2*T)*W
            potential=2*(K(F.derivative())/F)**2-K(F.derivative(2))/F+(2*u**3+T*u**2+W*u+V)/F
            kernels=[]
            for label,R in enumerate(twists):
                for multiplier in [R,F//R]:
                    n=(4-multiplier.degree())//2+1
                    if n<=0:continue
                    a=K(multiplier.derivative())/(2*multiplier)-K(F.derivative())/F
                    L2=F**2;L1=U(2*a*F**2);L0=U((a.derivative()+a*a-potential)*F**2)
                    images=[L2*(u**j).derivative(2)+L1*(u**j).derivative()+L0*u**j for j in range(n)]
                    mat=matrix(k,max(f.degree() for f in images)+1,n,
                               lambda i,j:images[j][i],implementation='generic')
                    kernel=mat.right_kernel()
                    if kernel.dimension():
                        assert all(mat*v==0 for v in kernel.basis())
                        kernels.append(dict(torsion=label,multiplier=str(multiplier),
                                            kernel_dimension=int(kernel.dimension()),
                                            horizontal_polynomials=[str(U(list(v))) for v in kernel.basis()]))
            s=T-3*t+1;w=-2*s**3*t+s**4-2*s**3+1
            assert w*w==1+3*s**4
            point=E(0) if not s else E(2*(w+1)/s**2,4*(w+1)/s**3)
            is65=(65*point==E(0))
            assert bool(kernels)==is65
            if kernels:
                assert t**125==t and T**125==T
                if t!=4:
                    assert len(kernels)==1 and kernels[0]['kernel_dimension']==1
                assert all(row['kernel_dimension']==1 for row in kernels)
                points.add(point)
            records.append(dict(parameter=str(t),dormant_parameter=str(T),
                                elliptic_point=str(point),is_65_torsion=is65,
                                horizontal_kernels=kernels))
        if number%10==0:print('parameters',number+1,'of61; pointed dormant points',len(points),flush=True)
    assert len(records)==305 and len(points)==65
    # E[65](kbar) has845 geometric points: ordinary E has a cyclic
    # etale 5-torsion, while13 is prime to5 and has169 points. Thus
    # order65 alone is NOT the global description. The precise finite
    # subgroup here is E(F125) of odd order (its full order is130).
    assert all(P[0]**125==P[0] and P[1]**125==P[1] for P in points if P)
    residue_elliptic=EllipticCurve(GF(125,'a'),[3,0])
    assert residue_elliptic.order()==130
    receipt=dict(kind='pointed_dormant_elliptic_first_height',field_modulus=str(k.modulus()),
                 parameter_count=61,dormant_pair_count=305,pointed_count=65,
                 elliptic_cubic='y^2=x^3+3*x',elliptic_order_over_F125=130,
                 claimed_locus='odd-order subgroup of E(F125), equivalently ker(Frob^3-1) intersect ker[65]',
                 complete_recorded_pairs=records,
                 source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest())
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('PASS all305 dormant pairs; exactly65 pointed points, the odd subgroup of E(F125).')


if __name__=='__main__':main()
