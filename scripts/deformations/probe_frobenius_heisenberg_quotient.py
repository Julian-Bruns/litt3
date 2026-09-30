#!/usr/bin/env sage -python
"""Exact two-torsion quotient of the actual cubic-backup Frobenius model.

Builds the fixed Igusa quartic, its induced map and the pointed surface.
Optionally reconstructs the first base scheme and its five-point quotient.
This is not a higher-height or all-height semistability test.
"""
import argparse
import hashlib
import itertools
import json
from pathlib import Path
import time

from sage.all import *
from probe_pointed_kummer import (theta_from_rosenhain, kummer_from_node,
                                  ducrohet_quintics, heisenberg_nodes,
                                  trope_planes, frobenius_coefficients)


def invariants(x):
    return [sum(t**4 for t in x),prod(x),
            x[0]**2*x[1]**2+x[2]**2*x[3]**2,
            x[0]**2*x[2]**2+x[1]**2*x[3]**2,
            x[0]**2*x[3]**2+x[1]**2*x[2]**2]


def quartic(q):
    s,p,a,b,c=q
    return p*p*s*s-s*a*b*c+a*a*b*b+a*a*c*c+b*b*c*c-4*p*p*(a*a+b*b+c*c)+16*p**4


def descend_forms(forms,inv,degree,Q):
    """Express forms in degree-'degree' polynomials in five quartics.

    All linear algebra selecting coefficients is over F5. Full identities
    are checked afterward, independently of the selected coefficient rows.
    """
    R=inv[0].parent();k=R.base_ring();fp=GF(5)
    qexp=list(IntegerVectors(degree,5))
    xexp=list(IntegerVectors(4*degree,4))
    row={tuple(e):i for i,e in enumerate(xexp)}
    mat=matrix(fp,len(xexp),len(qexp),sparse=True)
    for j,e in enumerate(qexp):
        f=prod(inv[i]**e[i] for i in range(5))
        for power,c in f.dict().items():mat[row[tuple(power)],j]=fp(c)
    cols=mat.pivots()
    reduced=mat.matrix_from_columns(cols)
    rows=reduced.transpose().pivots()
    square=reduced.matrix_from_rows(rows)
    inverse=square.inverse()
    assert square*inverse==identity_matrix(fp,len(rows))
    monomials=[prod(Q.gen(i)**qexp[j][i] for i in range(5)) for j in cols]
    result=[]
    for f in forms:
        data={tuple(e):c for e,c in f.dict().items()}
        target=[data.get(tuple(xexp[i]),0) for i in rows]
        # Multiply explicitly: the source subfield may use a noncanonical
        # finite-field presentation, for which earlier workspace checks found
        # an unsafe dense backend conversion.
        coefficients=[sum(k(inverse[i,j])*target[j] for j in range(len(rows)))
                      for i in range(len(rows))]
        assert all(sum(k(square[i,j])*coefficients[j] for j in range(len(rows)))==target[i]
                   for i in range(len(rows)))
        g=sum(c*m for c,m in zip(coefficients,monomials))
        assert R(g(*inv))==f
        result.append(g)
    return result,dict(degree=degree,monomials=len(qexp),rank=len(cols))


def encoded(poly):
    return [[list(e),[int(a) for a in c.polynomial().list()]] for e,c in poly.dict().items()]


def base_quotient(V,K1,inv,D1):
    k=V[0].base_ring();P=V[0].parent()
    # First verify that the x0 chart contains the whole projective base.
    R2=PolynomialRing(k,names=['u','v']);u,v=R2.gens()
    boundary=[]
    for pivot in (1,2,3):
        sub=[R2(0)]*4;sub[pivot]=R2(1)
        for i,z in zip([i for i in (1,2,3) if i!=pivot],(u,v)):sub[i]=z
        gb=R2.ideal([R2(f(*sub)) for f in V]).groebner_basis()
        assert list(gb)==[R2(1)]
        boundary.append(pivot)
    R=PolynomialRing(k,names=['z1','z2','z3']);z=R.gens()
    sub=(R(1),)+z
    ideal=R.ideal([R(f(*sub)) for f in V])
    gb=ideal.groebner_basis()
    assert ideal.dimension()==0
    basis=list(ideal.normal_basis())
    assert len(basis)==80
    exponents=[next(iter(b.dict())) for b in basis]
    def red(f):return ideal.reduce(R(f))
    def vec(f):
        d=red(f).dict()
        return vector(k,[d.get(e,0) for e in exponents])
    den=R(K1(*sub))
    multiplication=matrix(k,[vec(den*b) for b in basis]).transpose()
    coefficients=multiplication.solve_right(vec(1))
    den_inverse=sum(c*b for c,b in zip(coefficients,basis))
    assert red(den*den_inverse)==1
    ratios=[red(R(f(*sub))*den_inverse) for f in inv]
    U=PolynomialRing(k,'t');t=U.gen()
    primitive=None
    for scale in range(5):
        w=ratios[0]+k(scale)*ratios[2]
        powers=[R(1)];cols=[vec(1)]
        for degree in range(1,7):
            nxt=red(powers[-1]*w);v=vec(nxt)
            M=matrix(k,cols).transpose()
            if M.augment(matrix(k,80,1,list(v))).rank()==len(cols):
                coeff=M.solve_right(v)
                pol=t**degree-sum(coeff[i]*t**i for i in range(degree))
                break
            powers.append(nxt);cols.append(v)
        if degree!=5:
            continue
        try:
            coordinates=[M.solve_right(vec(f)) for f in ratios]
        except ValueError:
            continue
        primitive=(scale,pol,[sum(c[i]*t**i for i in range(5)) for c in coordinates])
        break
    assert primitive is not None
    scale,pol,coordinates=primitive
    assert pol.degree()==5
    T=U.quotient(pol,'b');b=T.gen()
    values=[T(f) for f in coordinates]
    assert quartic(values)==0
    pointed=T(D1(*values))
    assert pointed.is_unit()
    return dict(projective_boundary_charts_empty=boundary,base_algebra_dimension=80,
                quotient_algebra_dimension=5,primitive_linear_form='S/K1 + %d Q1/K1'%scale,
                minimal_polynomial=str(pol),polynomial_coefficients=[[int(a) for a in c.polynomial().list()] for c in pol.list()],
                separable=pol.gcd(pol.derivative())==1,
                factor_degrees=[(f.degree(),e) for f,e in pol.factor()],
                normalized_quotient_coordinates=list(map(str,coordinates)),
                pointed_first_step_unit=True,
                warning='The five-dimensional algebra is the quotient of the actual base scheme, not the base ideal of the induced quintic tuple on the quartic.')


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    ap.add_argument('--base-quotient',action='store_true')
    args=ap.parse_args();root=Path(__file__).resolve().parents[2]
    assert not args.output.resolve().is_relative_to(root)
    args.output.parent.mkdir(parents=True,exist_ok=True)
    started=time.monotonic()
    large=GF(5**12,'b');U=PolynomialRing(large,'u');u=U.gen()
    alpha=(u**3+u+1).roots(multiplicities=False)[0]
    node=theta_from_rosenhain(large(2),large(3),alpha)
    Rlarge=PolynomialRing(large,names=['x0','x1','x2','x3'])
    Klarge,coefflarge=kummer_from_node(node,Rlarge)
    # The corrected dual theta node gives Hudson coefficients over F125.
    k,embedding=large.subfields(3)[0];back=embedding.section()
    coeff=tuple(back(c) for c in coefflarge)
    R=PolynomialRing(k,names=['x0','x1','x2','x3']);x=R.gens()
    inv=invariants(x)
    a,b,c,d=coeff;K=inv[0]+2*a*inv[1]+b*inv[2]+c*inv[3]+d*inv[4]
    V=ducrohet_quintics(coeff,R)
    Q=PolynomialRing(k,names=['S','P','Q1','Q2','Q3'])
    relation=quartic(Q.gens())
    assert quartic(inv)==0
    factors=relation.factor()
    assert len(factors)==1 and factors[0][1]==1
    W,linear5=descend_forms(invariants(V),inv,5,Q)
    assert quartic(W).reduce([relation])==0
    print('Induced quintics reconstructed',linear5,flush=True)

    ell=trope_planes(heisenberg_nodes(node),large)[0]
    xx=Rlarge.gens();norm=Rlarge(1)
    for shift,char in itertools.product(range(4),repeat=2):
        norm*=sum(ell[i]*(-1)**((i&char).bit_count()%2)*xx[i^shift] for i in range(4))
    norm/=norm.leading_coefficient()
    norm_small=R({e:back(c) for e,c in norm.dict().items()})
    (D,),linear4=descend_forms([norm_small],inv,4,Q)
    print('Pointed surface reconstructed',linear4,flush=True)
    receipt=dict(kind='actual_frobenius_heisenberg_quotient',status='exact_research_model',
                 source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                 theta_builder_sha256=hashlib.sha256(Path(__file__).with_name('probe_pointed_kummer.py').read_bytes()).hexdigest(),
                 field_modulus=str(k.modulus()),coefficients=list(map(str,coeff)),
                 quotient_quartic=str(relation),quintic_descent=linear5,pointed_descent=linear4,
                 induced_quintics=[encoded(f) for f in W],pointed_surface=encoded(D),
                 induced_quartic_identity=True,whole_pointed_orbit_identity=True)
    if args.base_quotient:
        receipt['base_quotient']=base_quotient(V,frobenius_coefficients(K),inv,frobenius_coefficients(D))
        print('Base quotient reconstructed',receipt['base_quotient']['factor_degrees'],flush=True)
    receipt['seconds']=round(time.monotonic()-started,2)
    args.output.write_text(json.dumps(receipt,indent=2,default=int)+'\n')
    print('Complete',receipt['seconds'],'seconds; no new height verdict.',flush=True)


if __name__=='__main__':main()
