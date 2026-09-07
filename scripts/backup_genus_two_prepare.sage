#!/usr/bin/env sage
"""Exact preparation for the backup pair (fixed X, C_alpha).

This never imports or mutates the production atlas controller. All assertions
are curve arithmetic, complete genus-two oper equations, or NECESSARY common
orbifold signatures. No common-cover exclusion is inferred from one atlas.
"""
import argparse
import itertools
import json
import math
import time
from pathlib import Path


def encode(c):
    return [int(x) for x in c.polynomial().list()]


def main(output):
    started = time.monotonic()
    k = GF(125, name='a', modulus=PolynomialRing(GF(5), 'z')([1,1,0,1]))
    a = k.gen()
    R = PolynomialRing(k, 'u'); u = R.gen()
    F = u*(u-1)*(u-2)*(u-3)*(u-a)
    assert F.is_squarefree() and F.degree() == 5
    H = matrix(k, 2, 2, [(F**2)[5*i-j] for i in range(1,3) for j in range(1,3)])
    assert H.det() == 3*(a+1)**4 and H.det()
    cartier_weierstrass=[]
    for branch in [k(0),k(1),k(2),k(3),a]:
        vector_form=vector(k,[-branch,1])
        numerator=H*vector_form
        test=numerator[0]-numerator[1]*(-branch)**5
        assert test
        cartier_weierstrass.append({'branch':encode(branch),'eigen_determinant':encode(test)})
    assert H[1,0]

    counts = []
    for r in [1,2]:
        K = GF(5**(3*r), name='c')
        A = PolynomialRing(K, 'w'); w = A.gen()
        ar = (w**3+w+1).roots(multiplicities=False)[0]
        count = 1
        for x in K:
            value = x*(x-1)*(x-2)*(x-3)*(x-ar)
            count += 1 if value == 0 else (2 if value.is_square() else 0)
        counts.append(int(count))
    assert counts == [118,15926]
    Q = PolynomialRing(QQ, 'T'); T = Q.gen()
    s1,s2 = 126-counts[0],15626-counts[1]
    P = T**4-s1*T**3+(s1**2-s2)/2*T**2-125*s1*T+125**2
    assert P == T**4-8*T**3+182*T**2-1000*T+15625
    assert P.is_irreducible()
    assert P(1)==14800 and P(-1)==16816
    assert ZZ(P(1)).valuation(2)==4 and ZZ(P(-1)).valuation(2)==4
    Z = PolynomialRing(QQ, 'z'); z = Z.gen()
    U = PolynomialRing(Z, 'U'); Ugen = U.gen(); PP = U(P.list())
    ratio = Z(PP.resultant(PP(z*Ugen)))
    ratio_factors = list(ratio.factor())
    assert ratio.valuation(z-1) == 4
    assert all(f == z-1 or not f.is_cyclotomic() for f,e in ratio_factors)
    F3 = PolynomialRing(GF(3), 'T'); T3 = F3.gen(); P3 = F3(P.list())
    assert P3 == (T3**2+2*T3+2)**2
    assert (T3**24-1) % P3 == 0
    torsion_valuations = {}
    for r in [1,2,4,8,24]:
        size = ZZ(P.resultant(T**r-1))
        assert size > 0
        torsion_valuations[str(r)] = int(size.valuation(3))

    # Complete regular projective connections: r_eta + (2u^3+b(u))/F.
    # r_eta=F''/(4F)-3(F')^2/(16F^2), all constants in characteristic5.
    B = PolynomialRing(k, names=['b0','b1','b2'], order='lex')
    b0,b1,b2 = B.gens()
    BR = PolynomialRing(B, 'u'); uu = BR.gen(); FF = BR(F.list())
    numerator = (4*FF*FF.derivative(2)+2*FF.derivative()**2
                 +(2*uu**3+b0+b1*uu+b2*uu**2)*FF)
    curvature = (FF**2*numerator.derivative(2)
                 -4*FF*FF.derivative()*numerator.derivative()
                 +(6*FF.derivative()**2-2*FF*FF.derivative(2))*numerator
                 -3*numerator**2)
    original = [e for e in curvature.list() if e]
    ideal = B.ideal(original)
    gb = list(ideal.groebner_basis())
    assert ideal.vector_space_dimension() == 5 and len(gb) == 3
    Zk = PolynomialRing(k, 'z'); zk = Zk.gen()
    substitute = B.hom([Zk.zero(),Zk.zero(),zk], Zk)
    q = substitute(gb[2]); p0 = -substitute(gb[0]); p1 = -substitute(gb[1])
    assert q.degree() == 5 and q.is_monic() and q.gcd(q.derivative()) == 1
    subst = B.hom([p0,p1,zk], Zk)
    assert all(subst(e) % q == 0 for e in original)
    jac = matrix(B, [[e.derivative(b) for b in B.gens()] for e in original])
    minor_gcd = q
    checked_minors = 0
    for rows in itertools.combinations(range(len(original)),int(3)):
        minor_gcd = minor_gcd.gcd(subst(jac.matrix_from_rows(rows).det()) % q)
        checked_minors += 1
        if minor_gcd == 1:
            break
    assert minor_gcd == 1
    oper_factors = list(q.factor())
    assert all(e == 1 for f,e in oper_factors)

    # Full numerical tame candidates. C has gonality2 and n=N/8.
    tame = []
    def partitions(values, target, prefix=()):
        if target == 0:
            yield prefix
            return
        if not values:
            return
        e,w = values[0]
        for count in range(target//w+1):
            yield from partitions(values[1:],target-count*w,prefix+(e,)*count)
    for n in range(2,85):
        divs = [e for e in range(2,n+1) if n%e == 0 and e%5]
        for signature in partitions([(e,n-n//e) for e in divs],2*n+2):
            assert sum(QQ(1)-QQ(1)/e for e in signature) == 2+QQ(2)/n
            E=lcm(signature);A=ZZ(2*E/n)
            assert A>0
            tame.append({'N_X':8*n,'n_C':n,'inertia':list(signature),'E':int(E),'A':int(A),
                         'torsion_annihilators_C':[int(A*e) for e in signature],
                         'fiber_degrees_X':[8*n//e for e in signature],
                         'fiber_degrees_C':[n//e for e in signature]})
    assert len(tame) == 24

    # Ordinarity and degree/inertia rule out one-wild-only and >=2-tame
    # cases; the retained two-branch theorem gives q=5 for N_X<=2240.
    wild = []
    for n in range(5,281,5):
      for t in range(1,n//5+1):
        e = 5*t
        if t%5 == 0 or n%e:
            continue
        for d in range(2,n+1):
            if n%d or d%5 == 0:
                continue
            c = QQ(e)*(QQ(2)/n+QQ(1)/d)
            if c.denominator()!=1 or not 0<c<e or ZZ(c)%4!=3:
                continue
            j = ZZ(c+1)//4
            if j%5 == 0 or (4*j)%t:
                continue
            assert n*(QQ(c)/e-QQ(1)/d) == 2
            wild.append({'N_X':8*n,'n_C':n,'wild_order':e,'tame_part':t,
                         'wild_group_order':5,'lower_break':int(j),
                         'different':int(e+c),'other_tame_order':d,
                         'fiber_degrees_C':[n//e,n//d]})
    large = [{'N_X':112000,'n_C':14000,'wild_order':1000,'different':1143,
              'other_tame_order':7,'lower_breaks':[1,6],'lower_group_orders':[125,5]},
             {'N_X':336000,'n_C':42000,'wild_order':3000,'different':3143,
              'other_tame_order':21,'lower_breaks':[1,6],'lower_group_orders':[125,5]}]
    for row in large:
        assert row['n_C']*(QQ(row['different']-row['wild_order'])/row['wild_order']
                            -QQ(1)/row['other_tame_order']) == 2

    data = {
        'status':'exact preparation complete; signatures necessary, atlases not solved',
        'active_pair_replaced':False,
        'field':{'characteristic':5,'degree':3,'generator':'a','modulus':[1,1,0,1]},
        'curve':{'equation':'v^2=u(u-1)(u-2)(u-3)(u-a)',
                 'F_coefficients':[encode(c) for c in F.list()],
                 'genus':2,'squarefree':True,'point_at_infinity':'unique O',
                 'pole_semigroup':[2,5],'canonical_divisor':'2O'},
        'arithmetic':{'Hasse_Witt':[[encode(c) for c in row] for row in H.rows()],
            'ordinary':True,'point_count_q':125,'point_counts':counts,
            'Weil_polynomial_coefficients':[int(c) for c in P.list()],
            'ratio_factors':[{'polynomial':str(f),'degree':int(f.degree()),
                'multiplicity':int(e),'cyclotomic':bool(f.is_cyclotomic())} for f,e in ratio_factors],
            'geometrically_absolutely_simple':True,'Hom_with_fixed_X':'zero, by dimensions and simplicity',
            'Cartier_Weierstrass_tests':cartier_weierstrass,
            'Cartier_infinity_eigen_determinant':encode(H[1,0]),
            'all_Cartier_eigenforms_have_simple_zeros':True,
            'all_J2_rational':True,'J_F125_order_2adic_valuation':4,
            'Frobenius_plus_one_determinant':16816,'Frobenius_plus_one_2adic_valuation':4,
            'Frobenius_mod3':str(P3),'J3_field_extension_bound_over_F125':24,
            'J_orders_3adic_valuations':torsion_valuations},
        'opers':{'potential':'r_eta+(2u^3+b0+b1u+b2u^2)/F',
            'scalar_P':'2u^3+b0+b1u+b2u^2','scheme_length':5,'reduced':True,
            'original_curvature_coefficients':[str(e) for e in original],
            'groebner_basis':[str(e) for e in gb],
            'separator_coefficients':[encode(c) for c in q.list()],
            'b0_coefficients':[encode(c) for c in p0.list()],
            'b1_coefficients':[encode(c) for c in p1.list()],
            'closed_points':[{'degree':int(f.degree()),'coefficients':[encode(c) for c in f.list()]} for f,e in oper_factors],
            'original_equations_verified_in_full_length5_algebra':True,
            'original_Jacobian_minors_gcd_one':True,'minors_checked':checked_minors},
        'quotient_signatures':{'coarse_genus':0,'N_X_equals': '8*n_C',
            'all_branch_fibers_X_degree_at_least':8,
            'tame':tame,'small_wild_q5':wild,'large_wild':large,
            'warning':'Numerical/local necessary conditions only. No atlas realization or exclusion is inferred.'},
        'elapsed_seconds':time.monotonic()-started,
    }
    destination=Path(output);destination.parent.mkdir(parents=True,exist_ok=True)
    destination.write_text(json.dumps(data,indent=2,default=int)+'\n')
    print(json.dumps({'output':str(destination),'elapsed_seconds':data['elapsed_seconds'],
        'oper_closed_point_degrees':[int(f.degree()) for f,e in oper_factors],
        'J_orders_3adic_valuations':torsion_valuations,'tame_rows':len(tame),
        'small_wild_rows':len(wild)},indent=2),flush=True)


if __name__ == '__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',default='Research/computations/backup_genus_two_preparation.json')
    main(parser.parse_args().output)
