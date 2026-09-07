#!/usr/bin/env sage
"""Complete nonzero J[3] census for the backup genus-two curve.

The normalized norm equation is B(u)^2-lambda*F(u)=U(u)^3, where
B is monic cubic and U monic quadratic. Lambda is required nonzero.
Each of its40 solutions has two square roots a3^2=1/lambda, giving
A=a3*B and the80 nonzero classes with div(v-A)=3D-6O.
"""
import argparse
import json
import time
from pathlib import Path


def enc(c):
    return [int(v) for v in c.polynomial().list()]


def main(output):
    started=time.monotonic()
    k=GF(125,name='a',modulus=PolynomialRing(GF(5),'z')([1,1,0,1])); a=k.gen()
    R=PolynomialRing(k,'u'); u=R.gen()
    F=u*(u-1)*(u-2)*(u-3)*(u-a)
    S=PolynomialRing(k,names=['r','s','lam'],order='degrevlex')
    r,s,lam=S.gens()
    SU=PolynomialRing(S,'u'); x=SU.gen(); FF=SU(F.list())
    UU=x**2+r*x+s
    b2=(3*r+lam*FF[5])/2
    b1=(3*s+3*r**2+lam*FF[4]-b2**2)/2
    b0=(r**3+6*r*s+lam*FF[3]-2*b2*b1)/2
    BB=x**3+b2*x**2+b1*x+b0
    norm=BB**2-lam*FF-UU**3
    assert norm.degree()<=2
    equations=[norm[i] for i in range(3)]
    I=S.ideal(equations)
    print('norm ideal start',flush=True)
    # Saturation removes the irrelevant lambda=0 locus B^2=U^3.
    I=I.saturation(S.ideal(lam))[0]
    print('norm saturation complete',time.monotonic()-started,flush=True)
    gb=I.groebner_basis()
    assert I.dimension()==0 and I.vector_space_dimension()==40
    lex=I.transformed_basis('fglm',other_ring=S.change_ring(order='lex'))
    SL=lex.universe(); rL,sL,lL=SL.gens()
    Kz=PolynomialRing(k,'z'); z=Kz.gen()
    toz=SL.hom([0,0,z],Kz)
    q=toz(lex[-1]).monic()
    if q.degree()!=40:
        raise ArithmeticError('lambda is not a primitive separator; retain full lex algebra')
    assert q.gcd(q.derivative())==1 and q[0]
    assert len(lex)==3
    assert lex[0].degree(rL)==1 and lex[0].monomial_coefficient(rL)==1
    assert lex[1].degree(sL)==1 and lex[1].monomial_coefficient(sL)==1
    pr,ps=-toz(lex[0]),-toz(lex[1])
    subst=S.hom([pr,ps,z],Kz)
    assert all(subst(e)%q==0 for e in equations)
    # The original equations are reduced at every retained norm point.
    jac=matrix(S,[[e.derivative(v) for v in S.gens()] for e in equations])
    assert q.gcd(subst(jac.det()))==1
    bcoeff=[subst(b)%q for b in [b0,b1,b2,S.one()]]
    KU=PolynomialRing(Kz,'u'); xu=KU.gen()
    UF=xu**2+pr*xu+ps
    fK=KU(F.list())
    assert q.gcd(Kz(UF.resultant(fK)))==1
    repeated_degree=int(q.gcd(pr**2-4*ps).degree())
    factors=list(q.factor())
    classes=[]
    for fac,e in factors:
        assert e==1
        d=int(fac.degree())
        residue=Kz.quotient(fac,names='l')
        square=bool((1/residue.gen()).is_square())
        classes.append({'norm_degree':d,'lambda_factor_coefficients':[enc(c) for c in fac.list()],
                        'a3_square_in_norm_residue_field':square,
                        'class_orbit_degree':d if square else 2*d,
                        'class_orbit_count':2 if square else 1})
    orbit_degrees=sorted([row['class_orbit_degree'] for row in classes for j in range(row['class_orbit_count'])])
    assert sum(orbit_degrees)==80
    assert orbit_degrees==[8,24,24,24]
    data={'status':'complete reduced40-point norm algebra and80 nonzero cubic torsion classes',
          'field':{'degree':3,'modulus':[1,1,0,1]},
          'curve':'v^2=u(u-1)(u-2)(u-3)(u-a)',
          'norm_equation':'B^2-lambda*F=U^3; U=u^2+r*u+s; B monic cubic',
          'class_formula':'a3^2=1/lambda; A=a3*B; D=(U,v-A); L=O(D-2O)',
          'length_norm_algebra':40,'nonzero_classes':80,'repeated_support_norm_points':repeated_degree,
          'original_equations':[str(e) for e in equations],
          'separator_coefficients':[enc(c) for c in q.list()],
          'r_coefficients':[enc(c) for c in pr.list()],
          's_coefficients':[enc(c) for c in ps.list()],
          'B_coefficients_as_polynomials_in_lambda':[[enc(c) for c in b.list()] for b in bcoeff],
          'closed_points':classes,'class_Frobenius_orbit_degrees':orbit_degrees,
          'norm_Frobenius_orbit_degrees':[int(f.degree()) for f,e in factors],
          'original_norm_equations_verified_in_full_algebra':True,
          'original_Jacobian_determinant_unit':True,
          'all_U_coprime_F':True,
          'elapsed_seconds':time.monotonic()-started}
    target=Path(output);target.parent.mkdir(parents=True,exist_ok=True)
    target.write_text(json.dumps(data,indent=2,default=int)+'\n')
    print(json.dumps({'output':str(target),'elapsed_seconds':data['elapsed_seconds'],
                     'norm_orbits':data['norm_Frobenius_orbit_degrees'],
                     'class_orbits':orbit_degrees,'repeated_support_norm_points':repeated_degree},indent=2,default=int),flush=True)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',default='Research/computations/backup_genus_two_torsion.json')
    main(parser.parse_args().output)
