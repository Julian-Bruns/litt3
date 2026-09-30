#!/usr/bin/env sage -python
"""Second-order Cech reduction and quartic theta term for the fixed X.

Exact calculation. B_X is represented by functions modulo
fifth powers; all generated receipts belong outside litt3.
"""
import argparse
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, PowerSeriesRing, LaurentPolynomialRing, matrix, vector


def run(pole_bound=200, series_precision=160):
    f5 = GF(5)
    p0 = PolynomialRing(f5, 'a0')
    a0 = p0.gen()
    k = GF(25, 'a', modulus=a0*a0 + 4*a0 + 2)
    a = k.gen()
    poly = PolynomialRing(k, 'x')
    x = poly.gen()
    codes = [11,22,18,5,19,20,15,16,9,22,1]
    decode = lambda c: k(c % 5) + (c // 5)*a
    encode = lambda c: int(c[0]) + 5*int(c[1])
    F = poly([decode(c) for c in codes])
    assert F.gcd(F.derivative()) == 1
    gaps = [1,2,4,5,7,8,11,14,17]
    assert pole_bound >= 170 and (series_precision-1)*3 > pole_bound + 170

    # t=x^3/y, q=t^3, v=1/x satisfy v=q*f(v), f(v)=v^10 F(1/v).
    ps = PowerSeriesRing(k, 'q', default_prec=series_precision)
    q = ps.gen()
    fv = poly(list(reversed(F.list())))
    v = q.add_bigoh(series_precision)
    for _ in range(series_precision.bit_length() + 1):
        v -= (v - q*fv(v))/(1-q*fv.derivative()(v))
    assert (v-q*fv(v)).valuation() >= series_precision
    u = (v/q)**(-1)
    laurent = LaurentPolynomialRing(k, 't')
    t = laurent.gen()
    max_positive = 170
    monomials = [(i,b) for b in range(3) for i in range(pole_bound//3+1)
                 if 3*i+10*b <= pole_bound]
    monomials.sort(key=lambda ib: (3*ib[0]+10*ib[1],ib))
    max_power = max(i+3*b for i,b in monomials)
    upowers = [ps(1)]
    for _ in range(max_power):
        upowers.append(upowers[-1]*u)

    def expansion(i,b):
        pole = 3*i+10*b
        coeff = upowers[i+3*b]
        return laurent({3*j-pole:coeff[j]
                        for j in range((pole+max_positive)//3+1)
                        if coeff[j] and (3*j-pole) % 5})

    expansions = [expansion(i,b) for i,b in monomials]
    positions = [-j for j in range(1,pole_bound+1) if j % 5]

    def negative(s):
        assert not s or min(s.exponents()) >= -pole_bound
        return vector(k,[s[j] for j in positions])

    boundary = matrix(k,len(positions),len(monomials),
                      lambda i,j: expansions[j][positions[i]])
    rank = boundary.rank()
    assert len(positions)-rank == 3
    selected = list(boundary.pivots())
    cohom_positions = list(boundary.left_kernel().basis_matrix().pivots())
    assert len(cohom_positions) == 3
    complements = matrix(k,len(positions),3,
                         lambda i,j: 1 if i == cohom_positions[j] else 0)
    splitting = boundary.matrix_from_columns(selected).augment(complements)
    inverse = splitting.inverse()
    assert splitting*inverse == matrix.identity(k,len(positions))

    def split(s):
        coeff = inverse*negative(s)
        affine = sum((coeff[j]*expansions[selected[j]] for j in range(rank)),laurent(0))
        assert negative(s-affine) == complements*vector(k,coeff[rank:])
        return affine, vector(k,coeff[rank:])

    def project(s):
        return vector(k,(inverse*negative(s))[rank:])

    Bs = [poly([decode(c) for c in row]) for row in
          [[24,2,1,0,0,0],[5,16,0,1,0,0],[5,20,0,0,8,1]]]
    # Integral affine primitives y*Q_i, rather than rational primitives
    # with finite poles. d(yQ)=(FQ'+F'Q/3) dx/y^2.
    derivative_columns = [F*(x**j).derivative() + F.derivative()*x**j/3
                          for j in range(26)]
    derivation = matrix(k,36,26,lambda i,j:derivative_columns[j][i])
    Qs = []
    sections = []
    for B in Bs:
        Q = poly(list(derivation.solve_right(vector(k,[B[i] for i in range(36)]))))
        assert F*Q.derivative()+F.derivative()*Q/3 == B
        Qs.append(Q)
        section = sum((Q[j]*expansion(j,1) for j in range(Q.degree()+1)),laurent(0))
        assert not any(negative(section))
        sections.append(section)

    transitions = [t**(-5*g) for g in gaps]
    first = []
    repairs = []
    for shift in transitions:
        terms = [split(shift*s) for s in sections]
        repairs.append([a for a,_ in terms])
        first.append(matrix(k,3,3,lambda i,j:terms[j][1][i]))

    pr = PolynomialRing(k, ['z'+str(g) for g in gaps])
    variables = pr.gens()
    D1 = sum((variables[i]*first[i] for i in range(9)),matrix(pr,3,3))
    assert D1.det() == 0
    D2 = matrix(pr,3,3)
    second = {}
    for j in range(9):
        for ell in range(j,9):
            cols = []
            for c,s in enumerate(sections):
                if j == ell:
                    term = transitions[j]**2*s/2-transitions[j]*repairs[j][c]
                else:
                    term = (transitions[j]*transitions[ell]*s
                            -transitions[j]*repairs[ell][c]
                            -transitions[ell]*repairs[j][c])
                cols.append(project(term))
            block = matrix(k,3,3,lambda i,c:cols[c][i])
            second[j,ell] = block
            D2 += variables[j]*variables[ell]*block
    quartic = (D1.adjugate()*D2).trace()
    assert not quartic or quartic.degree() == 4
    serre = matrix(k,3,3,lambda i,j:
                   -positions[cohom_positions[j]]*sections[i][-positions[cohom_positions[j]]])
    assert serre.is_invertible()
    skew = serre*D1
    assert skew + skew.transpose() == 0
    symmetric_second = (serre*D2 + (serre*D2).transpose())/2
    a_only = [z if g in [1,4,7] else pr(0) for z,g in zip(variables,gaps)]
    compact = symmetric_second.apply_map(lambda f:f(*a_only))
    pfaffian_vector = vector(pr,[skew[1,2],-skew[0,2],skew[0,1]])
    assert pfaffian_vector*compact*pfaffian_vector == serre.det()*quartic
    assert matrix(k,[[f.monomial_coefficient(z) for z in variables]
                     for f in pfaffian_vector]).rank() == 3
    # Rank three over k(z1,z4,z7), plus primitive coefficient content,
    # proves geometric irreducibility of the ternary quadratic in q.
    content = pr(0)
    for entry in compact.list():
        content = content.gcd(entry)
    assert content.degree() == 0
    point = [k(0)]*9
    point[0], point[4] = k(1), k(1)  # z1=z7=1, z4=0.
    determinant_value = compact.det()(*point)
    assert determinant_value == 4*a+4
    common = quartic
    gcd_degrees = []
    for z in variables:
        common = common.gcd(quartic.derivative(z))
        gcd_degrees.append([str(z),int(common.degree())])
        if common.degree() == 0:
            break
    squarefree = bool(quartic) and common.degree() == 0
    binary = PolynomialRing(k,['s','t0'])
    s,t0 = binary.gens()
    plane = [binary(0)]*9
    plane[0],plane[2],plane[3] = s,t0,t0
    binary_quartic = quartic(*plane)
    assert binary_quartic == (2*a+1)*t0*t0*(s-(a+4)*t0)*(s-(a+2)*t0)
    witnesses = []
    for j in range(9):
        for ell in range(j+1,9):
            values = [pr(0)]*9
            values[j], values[ell] = variables[j], variables[ell]
            restriction = quartic(*values)
            if restriction:
                factors = restriction.factor()
                if any(e % 2 for _,e in factors):
                    witnesses.append({'variables':[gaps[j],gaps[ell]],
                                      'polynomial':str(restriction),
                                      'factorization':str(factors)})
    serialize = lambda mat: [[encode(c) for c in row] for row in mat.rows()]
    result = {
        'status':'exact_second_order_Cech_theta',
        'pole_bound':pole_bound,'q_series_precision':series_precision,
        'field_modulus_ascending':[2,4,1],'field_encoding':'c0+5*c1',
        'F_ascending':codes,'gap_parameters':gaps,
        'boundary_dimension':len(positions),'boundary_rank':rank,
        'cohomology_representatives':[positions[i] for i in cohom_positions],
        'affine_primitives_Q':[[encode(c) for c in Q.list()] for Q in Qs],
        'first_matrices':[serialize(b) for b in first],
        'second_matrices':{str(gaps[j])+','+str(gaps[l]):serialize(b)
                           for (j,l),b in second.items()},
        'quartic_terms':[[list(e),encode(c)] for e,c in quartic.dict().items()],
        'quartic_nonzero':bool(quartic),
        'quartic_squarefree':squarefree,'squarefree_gcd_degrees':gcd_degrees,
        'quartic_geometrically_irreducible':True,
        'compact_determinant_at_1_0_1':encode(determinant_value),
        'compact_coefficient_content_unit':True,
        'serre_matrix':serialize(serre),
        'pfaffian_linear_forms':[str(f) for f in pfaffian_vector],
        'compact_quadratic_matrix':[[str(f) for f in row] for row in compact.rows()],
        'binary_plane_z1_s_z4_z5_t':str(binary_quartic.factor()),
        'nonsquare_binary_witnesses':witnesses,
        'checks':{'curve_smooth':True,'local_chart':True,'cohomology_dimension3':True,
                  'primitive_derivatives':True,'whole_first_splittings':True,
                  'first_determinant_zero':True},
    }
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--pole-bound',type=int,default=200)
    parser.add_argument('--series-precision',type=int,default=160)
    parser.add_argument('--output',type=Path,required=True)
    args = parser.parse_args()
    data = run(args.pole_bound,args.series_precision)
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(data,indent=2)+'\n')
    print(json.dumps({k:data[k] for k in ['boundary_dimension','boundary_rank',
          'cohomology_representatives','quartic_nonzero',
          'quartic_geometrically_irreducible']},indent=2),flush=True)
