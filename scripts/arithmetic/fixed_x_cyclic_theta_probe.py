#!/usr/bin/env sage -python
"""Test the existing quartic theta cone on every actual AS direction.

The Artin--Schreier fixed scheme is parametrized by a separable
linearized polynomial, so no large splitting field is constructed.
Generated data belong outside the research workspace.
"""
import argparse
import hashlib
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, PowerSeriesRing, matrix, vector


def calculate(theta_path):
    data = json.loads(theta_path.read_text())
    f5 = GF(5)
    r0 = PolynomialRing(f5, 'a0')
    a0 = r0.gen()
    k = GF(25, 'a', modulus=a0*a0+4*a0+2)
    a = k.gen()
    decode = lambda n: k(n % 5)+(n//5)*a
    encode = lambda c: int(c[0])+5*int(c[1])
    serialize = lambda m: [[encode(c) for c in row] for row in m.rows()]
    pol = PolynomialRing(k, 'x')
    x = pol.gen()
    curve = pol([decode(c) for c in data['F_ascending']])
    gaps = data['gap_parameters']
    assert gaps == [1,2,4,5,7,8,11,14,17]
    bound = 5*max(gaps)
    ps = PowerSeriesRing(k, 'q', default_prec=100)
    q = ps.gen()
    rev = pol(list(reversed(curve.list())))
    v = q.add_bigoh(100)
    for _ in range(8):
        v -= (v-q*rev(v))/(1-q*rev.derivative()(v))
    assert (v-q*rev(v)).valuation() >= 100
    u = (v/q)**(-1)
    positions = list(range(-bound,0))
    monomials = [(i,b) for b in range(3) for i in range(bound//3+1)
                 if 0 < 3*i+10*b <= bound]
    monomials.sort(key=lambda ib:3*ib[0]+10*ib[1])
    assert len(monomials) == bound-9
    powers = [ps(1)]
    for _ in range(max(i+3*b for i,b in monomials)):
        powers.append(powers[-1]*u)

    def coefficient(i,b,exponent):
        delta = exponent+3*i+10*b
        return powers[i+3*b][delta//3] if delta >= 0 and delta % 3 == 0 else k(0)

    boundary = matrix(k,bound,len(monomials),
                      lambda row,col:coefficient(*monomials[col],positions[row]))
    complements = matrix(k,bound,9,lambda row,col:int(positions[row] == -gaps[col]))
    full = boundary.augment(complements)
    inverse = full.inverse()
    frobenius0 = matrix(k,9,9,lambda i,j:inverse[-9+i,positions.index(-5*gaps[j])])
    assert frobenius0.rank() == 6
    assert (frobenius0*frobenius0.apply_map(lambda c:c**5)).rank() == 6

    # Independent check by Serre residues and the polynomial Cartier formula.
    holomorphic = [(i,1) for i in range(3)]+[(i,2) for i in range(6)]
    def residue(g,ij):
        i,j = ij
        delta = g-1-(10*j-3*i-4)
        if delta < 0 or delta % 3:
            return k(0)
        coeff = 3*u**(i-3*j)*(q*u.derivative()-u)
        return coeff[delta//3]
    serre = matrix(k,9,9,lambda i,j:residue(gaps[i],holomorphic[j]))
    assert serre.is_invertible()
    cube = curve**3
    nn = matrix(k,3,6,lambda i,j:curve[5*i+4-j] if 5*i+4-j >= 0 else 0)
    mm = matrix(k,6,3,lambda i,j:cube[5*i+4-j] if 5*i+4-j >= 0 else 0)
    cartier = matrix(k,9,9)
    for i in range(3):
        for j in range(6):
            cartier[i,j+3] = nn[i,j]**5
    for i in range(6):
        for j in range(3):
            cartier[i+3,j] = mm[i,j]**5
    assert frobenius0.transpose()*serre == serre.apply_map(lambda c:c**5)*cartier.apply_map(lambda c:c**5)

    # The theta coordinates are t1^(-g) on X^(1), t1=t^5.
    frobenius = frobenius0.apply_map(lambda c:c**5)
    stable = frobenius.column_space().basis_matrix().transpose()
    qq = stable.solve_right(frobenius*stable.apply_map(lambda c:c**5))
    assert qq.is_invertible()
    bb = qq.inverse()
    chosen = None
    for idx in range(6):
        row = vector(k,[int(i == idx) for i in range(6)])
        rows = []
        for j in range(7):
            rows.append(row)
            row = vector(k,[c**5 for c in row])*bb
        krylov = matrix(k,rows[:6])
        if krylov.is_invertible():
            chosen = idx
            break
    assert chosen is not None, 'Try another finite-field linear functional.'
    pp = PolynomialRing(k,'s')
    s = pp.gen()
    nextrow = rows[6]*krylov.inverse()
    lin = s**(5**6)-sum(nextrow[j]*s**(5**j) for j in range(6))
    assert lin.degree() == 15625 and lin.gcd(lin.derivative()) == 1
    coordinate_matrix = stable*krylov.inverse()
    coord = coordinate_matrix*vector(pp,[s**(5**j) for j in range(6)])
    extractor = coordinate_matrix.transpose().solve_right(vector(k,[1,0,0,0,0,0]))
    assert sum(extractor[i]*coord[i] for i in range(9)) == s
    assert all((sum(frobenius[i,j]*coord[j]**5 for j in range(9))-coord[i]) % lin == 0
               for i in range(9))
    quartic = pp(0)
    for exponents,code in data['quartic_terms']:
        term = pp(decode(code))
        for cc,e in zip(coord,exponents):
            if e:
                term *= cc**e
        quartic += term
    singular = lin.gcd(quartic).monic()
    print('AS vectors:',lin.degree(),'quartic-zero vectors:',singular.degree(),flush=True)
    factors = singular.factor()
    factor_degrees = sorted(int(f.degree()) for f,e in factors for _ in range(e))
    bezout = None
    compressed = None
    if singular == s:
        gg,aa,bb = (lin//s).xgcd(quartic)
        assert gg == 1 and aa*(lin//s)+bb*quartic == 1
        sparse = lambda f: [[int(e),encode(c)] for e,c in f.dict().items()]
        bezout = {'linearized_quotient_multiplier':sparse(aa),
                  'quartic_multiplier':sparse(bb)}
        assert all((int(e)-1)%24 == 0 for e in lin.dict())
        assert all((int(e)-12)%24 == 0 for e in quartic.dict())
        lp = pp({(int(e)-1)//24:a for e,a in lin.dict().items()})
        qp = pp({(int(e)-12)//24:a for e,a in quartic.dict().items()})
        gg,uu,vv = lp.xgcd(qp)
        assert gg == 1 and uu*lp+vv*qp == 1
        compressed = {'linearized_quotient_in_s24':sparse(lp),
                      'quartic_quotient_in_s24':sparse(qp),
                      'left_multiplier':sparse(uu),'right_multiplier':sparse(vv)}
    result = {
        'status':'exact_all_Artin_Schreier_theta_direction_probe',
        'theta_sha256':hashlib.sha256(theta_path.read_bytes()).hexdigest(),
        'theta_input':str(theta_path),
        'gap_basis':gaps,
        'frobenius_X':serialize(frobenius0),
        'frobenius_X_first_twist':serialize(frobenius),
        'serre_matrix':serialize(serre),
        'stable_basis_columns':serialize(stable),
        'stable_frobenius':serialize(qq),
        'coordinate_linearized_matrix':serialize(coordinate_matrix),
        'coordinate_extractor':[encode(c) for c in extractor],
        'separating_coordinate':chosen,
        'linearized_ascending_fifth_power_coefficients':[encode(lin[5**j]) for j in range(7)],
        'all_AS_vectors':15625,
        'quartic_zero_vectors':int(singular.degree()),
        'quartic_zero_projective_directions':(int(singular.degree())-1)//4,
        'quartic_zero_F25_orbit_degrees':factor_degrees,
        'singular_polynomial_sparse':[[int(e),encode(c)] for e,c in singular.dict().items()],
        'quartic_substitution_sparse':[[int(e),encode(c)] for e,c in quartic.dict().items()],
        'bezout_certificate':bezout,
        'compressed_bezout':compressed,
        'checks':{
            'Cech_full_rank':True,'Cartier_Serre_independent_check':True,
            'stable_rank_six':True,'relative_twist_retained':True,
            'separable_linearized_polynomial':True,'all_fixed_vectors_parametrized':True
        }
    }
    return result


if __name__ == '__main__':
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--theta',type=Path,default=Path('../litt3-computation-data/theta_jump_20260915/fixed_x_theta_quartic.json'))
    ap.add_argument('--output',type=Path,required=True)
    args = ap.parse_args()
    result = calculate(args.theta)
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:result[k] for k in ['all_AS_vectors','quartic_zero_vectors','quartic_zero_projective_directions','quartic_zero_F25_orbit_degrees']},indent=2))
