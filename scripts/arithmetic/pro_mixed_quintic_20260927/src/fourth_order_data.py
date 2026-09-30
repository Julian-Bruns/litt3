#!/usr/bin/env python3
"""Reconstruct fourth-order invariants and generate the C++ certificate inputs.

Only the Python standard library and retained exact arithmetic are required.
The irreducible-factor and scalar-remainder witnesses are read from the
retained certificate and are rechecked, not trusted, by fourth_order_check.cpp.
"""
import argparse
import json
from pathlib import Path
from types import SimpleNamespace
from exact import (
    F, Extension, add, sub, scale, mul, power, derivative, mod, gcd,
    multiplication_matrix, determinant, irreducible_prime_degree,
)
from ramification import (
    RationalFunction as R, inverse_mod, invariants, interpolate,
    divided_difference_at, sylvester_determinant,
)
ROOT = Path(__file__).resolve().parents[1]


def negative(a):
    return R(scale(a.n, 4), a.d)


def differential(a):
    return R(sub(mul(derivative(a.n), a.d), mul(a.n, derivative(a.d))),
             power(a.d, 2))


def norm_check(h, numerator, denominator):
    """Exact characteristic polynomial by interpolation of small determinants."""
    value = mod(mul(numerator, inverse_mod(denominator, h)), h)
    matrix = multiplication_matrix(value, h)
    n = len(h)-1
    points = list(range(n+1))
    values = [determinant([[F.sub(z if i == j else 0, matrix[i][j])
                           for j in range(n)] for i in range(n)])
              for z in points]
    polynomial = interpolate(points, values, F)
    assert len(polynomial) == n+1 and polynomial[-1] == 1
    squarefree_gcd = gcd(polynomial, derivative(polynomial))
    assert squarefree_gcd == [1]
    return {'residue': value, 'norm_polynomial': polynomial,
            'squarefree_gcd': squarefree_gcd}


def make_data():
    data = json.loads((ROOT/'inputs/data.json').read_text())
    cert = json.loads((ROOT/'evidence/fourth_order_certificate.json').read_text())
    A, P = data['A'], data['P']
    Ap, Pp = derivative(A), derivative(P)
    App, Ppp = derivative(Ap), derivative(Pp)
    Appp = derivative(App)
    Amonic, D = scale(A, F.inv(A[-1])), scale(Ap, F.inv(Ap[-1]))
    I2 = R(mul(A, App), power(Ap, 2)) + R([3]) \
        + R([4])*R(mul(A, Pp), mul(P, Ap))
    I3 = R(A, Ap)*differential(I2) + negative(I2) + R([2])*I2*I2
    assert (len(I2.n)-1, len(I2.d)-1) == (15, 16)
    assert (len(I3.n)-1, len(I3.d)-1) == (27, 29)
    rr = invariants(A)['R']
    finite = {
        'A_roots': norm_check(Amonic, rr.n, rr.d),
        'A_critical_points': norm_check(
            D, scale(mul(A, power(add(mul(Appp, P),
                                       scale(mul(Pp, App), 2)), 2)), 3),
            mul(power(P, 2), power(App, 3))),
        'P_roots': norm_check(
            P, mul(A, sub(mul(Ppp, Ap), scale(mul(Pp, App), 3))),
            scale(mul(Pp, power(Ap, 2)), 2)),
    }
    expected = {
        'A_roots': [11, 11, 22, 21, 1],
        'A_critical_points': [15, 7, 9, 1],
        'P_roots': [0, 4, 11, 2, 17, 13, 13, 6, 13, 3, 1],
    }
    for key, polynomial in expected.items():
        assert finite[key]['norm_polynomial'] == polynomial
    # Independent, direct 43-by-43 Sylvester determinants. This includes
    # specializations at both F25-rational P-roots, hence degree drops.
    sylvester = []
    for x in (0, 1, 4, 5, 9, 14, 24):
        value = sylvester_determinant(
            divided_difference_at(I2, x, F), divided_difference_at(I3, x, F),
            15, 28, F)
        sylvester.append([x, value])
    E = Extension([1, 1, 0, 1])
    assert irreducible_prime_degree([1, 1, 0, 1])
    promote = lambda rr: SimpleNamespace(n=[E.embed(c) for c in rr.n],
                                         d=[E.embed(c) for c in rr.d])
    for code in (25, 26):
        x = E.element([code % 25, (code//25) % 25, code//625])
        value = sylvester_determinant(
            divided_difference_at(promote(I2), x, E),
            divided_difference_at(promote(I3), x, E), 15, 28, E)
        sylvester.append([code, sum(c*25**i for i, c in enumerate(value))])
    generated = {
        'I2': I2.data(), 'I3': I3.data(), 'finite_chart_checks': finite,
        'independent_fixed_Sylvester_checks': sylvester,
        'auxiliary_cubic_irreducible': True,
    }
    polys = {'A': A, 'P': P, 'Amonic': Amonic, 'D': D,
             'I2_numerator': I2.n, 'I2_denominator': I2.d,
             'I3_numerator': I3.n, 'I3_denominator': I3.d}
    return cert, generated, polys


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--output-json', type=Path)
    args = parser.parse_args()
    cert, generated, polys = make_data()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open('w') as out:
        out.write('// Regenerated exact data; see fourth_order_data.py.\n')
        for name, row in polys.items():
            out.write('const Poly '+name+'={'+','.join(map(str, row))+'};\n')
        for i, f in enumerate(cert['factors']):
            row = f['polynomial']
            assert f['degree'] == len(row)-1
            out.write('const Poly factor_'+str(i)+'={'+','.join(map(str, row))+'};\n')
        out.write('const std::vector<Poly> factors={'+','.join(
            'factor_'+str(i) for i in range(len(cert['factors'])))+'};\n')
        for i, f in enumerate(cert['scalar_checks']):
            for key in ('partner', 'epsilon29', 'F25_28_difference'):
                out.write('const Poly '+key+'_'+str(i)+'={'+','.join(
                    map(str, f[key]))+'};\n')
        for key in ('partner', 'epsilon29', 'F25_28_difference'):
            out.write('const std::vector<Poly> expected_'+key+'={'+','.join(
                key+'_'+str(i) for i in range(len(cert['scalar_checks'])))+'};\n')
        out.write('const std::vector<std::pair<E,E>> independent_sylvester={')
        out.write(','.join('{'+str(x)+','+str(v)+'}' for x, v in
                           generated['independent_fixed_Sylvester_checks']))
        out.write('};\n')
    if args.output_json:
        args.output_json.parent.mkdir(parents=True, exist_ok=True)
        args.output_json.write_text(json.dumps(generated, indent=2)+'\n')
    print('PASS fourth-order data: three finite-chart separation norms are squarefree.')
    print('PASS independent direct Sylvester checks: seven F25 and two F25^3 points.')


if __name__ == '__main__':
    main()
