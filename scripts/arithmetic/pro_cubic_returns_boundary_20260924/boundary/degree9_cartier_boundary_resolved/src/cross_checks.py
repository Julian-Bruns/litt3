"""Independent standard-library checks and portable certificate readers.

Uses the prior stage's separately implemented Python F25/F(5^8) arithmetic,
not the C++ logarithm tables or GMP Kronecker multiplication.
"""
from __future__ import annotations
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.dont_write_bytecode = True
sys.path.insert(0, str(ROOT / 'prior_stage' / 'src'))
from discriminant import (ev, disc, polys)  # noqa: E402
from extension import (ea, en, es, em, ei, epow, epa, eps, epm, epd, trim,
                       P, Q)  # noqa: E402


def read_poly(stream):
    row = [int(x) for x in stream.readline().split()]
    if not row or row[0] != len(row) - 1:
        raise ValueError('Invalid counted polynomial row')
    return row[1:]


def read_bp(stream):
    count = int(stream.readline())
    return [read_poly(stream) for _ in range(count)]


def read_norm(path):
    with path.open() as stream:
        nx, nt = map(int, stream.readline().split())
        if (nx, nt) != (109, 12):
            raise ValueError('Wrong norm polynomial shape')
        return [[read_poly(stream) for _ in range(nt)] for _ in range(nx)]


def pgcd(a, b):
    while b:
        a, b = b, epd(a, b)[1]
    return eps(a, ei(a[-1])) if a else []


def xgcd(a, b):
    r0, r1 = a[:], b[:]
    u0, u1, v0, v1 = [1], [], [], [1]
    while r1:
        q, r2 = epd(r0, r1)
        u2 = epa(u0, eps(epm(q, u1), 4))
        v2 = epa(v0, eps(epm(q, v1), 4))
        r0, r1, u0, u1, v0, v1 = r1, r2, u1, u2, v1, v2
    scale = ei(r0[-1])
    return eps(r0, scale), eps(u0, scale), eps(v0, scale)


def normalized_input_bytes():
    finite = json.loads((ROOT/'prior_stage/certificates/finite_pole.json').read_text())
    local = json.loads((ROOT/'prior_stage/certificates/four_supports.json').read_text())[0]
    cs, br = finite['columns'], local['normal_basis']
    u, v, w = polys(br[0], cs, 0), polys(br[1], cs, 0), polys(br[2], cs, 1)
    rows = []
    for poly in [P, local['b3'], Q] + u + v + w:
        rows.append(str(len(poly)) + ' ' + ' '.join(map(str, poly)))
    rows.append(str(br[0][-1]) + ' ' + str(br[1][-1]))
    return ('\n'.join(rows) + '\n').encode(), local, u, v, w


def independent_norm_checks(norm):
    data, local, u, v, w = normalized_input_bytes()
    if data != (ROOT/'inputs/norm_input.txt').read_bytes():
        raise AssertionError('Normal-form input does not match certified kernel')
    kl, km = local['kappa_lambda'], local['kappa_mu']
    b3 = local['b3']
    order = 390624
    assert all(epow(25, order//p) != 1 for p in [2, 3, 13, 313])
    assert epow(25, order) == 1
    zeta = epow(25, order//3)
    xs = []
    for x in range(1000):
        px = ev(P, x)
        if px and ev(b3, x) and epow(px, order//3) == 1:
            xs.append(x)
            if len(xs) == 8:
                break
    if len(xs) != 8:
        raise AssertionError('Not enough independent evaluation points')
    cases = []
    for index, x in enumerate(xs):
        cases.extend([(x, index, 0), (x, index + 5, 1), (x, ei(km), 5)])
        p0, p1 = ev(u[0], x), ev(v[0], x)
        denominator = es(em(kl, p1), em(km, p0))
        if denominator:
            cases.append((x, em(en(p0), ei(denominator)), index + 1))
    dropped = 0
    for x, s, nu in cases:
        lam = em(es(1, em(km, s)), ei(kl))
        px, bx, qx = ev(P, x), ev(b3, x), ev(Q, x)
        # The cube subgroup has order 130208, coprime to 3.
        y = epow(px, pow(3, -1, order//3))
        assert epow(y, 3) == px
        product = 1
        for _ in range(3):
            ns = [ea(ea(em(lam, ev(u[j], x)), em(s, ev(v[j], x))),
                     em(em(nu, y), ev(w[j], x))) for j in range(5)]
            poly = [0]*10
            for j, val in enumerate(ns):
                poly[4-j] = em(qx, val)
                poly[9-j] = val
            poly[0] = ea(poly[0], em(epow(bx, 3), epow(px, 3)))
            dropped += int(ns[0] == 0)
            product = em(product, disc(poly))
            y = em(y, zeta)
        den = epow(em(epow(px, 24), epow(bx, 20)), 3)
        expected = em(product, ei(den))
        rho = epow(nu, 3)
        coeffs = [ev([ev(row, s) for row in coeff], rho) for coeff in norm]
        actual = ev(coeffs, x)
        assert actual == expected, (x, s, nu)
    assert dropped >= 3
    return {'independent_norm_points': len(cases),
            'formal_degree_drop_discriminants_checked': dropped,
            'primitive_generator': 25,
            'multiplicative_group_order': order,
            'prime_divisors_of_order': [2, 3, 13, 313]}


def certificate_summary(root=ROOT):
    cert = root/'certificates'
    norm = read_norm(cert/'norm_poly.txt')
    with (cert/'square_equations.txt').open() as f:
        ell = read_poly(f)
        neq = int(f.readline())
        eqs = [read_bp(f) for _ in range(neq)]
    generic = []
    with (cert/'generic_resultants.txt').open() as f:
        assert read_poly(f) == ell
        count = int(f.readline())
        assert count == 2
        for _ in range(count):
            ia, ib, bound = map(int, f.readline().split())
            raw, red = read_poly(f), read_poly(f)
            generic.append({'constraints': [55+ia, 55+ib],
                            'resultant_degree_bound': bound,
                            'identity_grid_size': bound+1,
                            'extra_check_points': 8,
                            'raw_resultant_degree': len(raw)-1,
                            'raw_leading_coefficient': raw[-1],
                            'removed_monic_ell_power': 756,
                            'saturated_resultant_degree': len(red)-1})
        assert read_poly(f) == [1]
    with (cert/'bezout_generic.txt').open() as f:
        bez_u, bez_v, target = read_poly(f), read_poly(f), read_poly(f)
        assert target == [1]
    with (cert/'exceptional_resultant.txt').open() as f:
        assert read_poly(f) == ell
        b, binverse, odd = read_poly(f), read_poly(f), read_poly(f)
        assert epd(epm(b, binverse), ell)[1] == [1]
        assert pgcd(ell, odd) == [1]
        der = trim([em(j % 5, ell[j]) for j in range(1, len(ell))])
        assert pgcd(ell, der) == [1]
        ne = int(f.readline())
        exeqs = [read_bp(f) for _ in range(ne)]
        ia, ib, bound = map(int, f.readline().split())
        raw, reduced = read_poly(f), read_poly(f)
        assert epd(raw, ell)[1] == reduced
        assert f.readline().strip() == 'FINAL 1'
        assert read_poly(f) == [1]
    gcd, exu, exv = xgcd(ell, reduced)
    assert gcd == [1]
    assert epa(epm(exu, ell), epm(exv, reduced)) == [1]
    exceptional_bezout = {'identity': 'u(s)*ell(s)+v(s)*(R_exc(s) mod ell(s))=1',
                         'u': exu, 'v': exv, 'remainder': reduced, 'target': [1]}
    degrees = [{'constraint': j+55, 'degree_s': max(map(len, p))-1,
                'degree_rho': len(p)-1} for j, p in enumerate(eqs)]
    result = {
        'completion_status': 'complete_negative_decision',
        'support_choices_covered': 4,
        'field_size': 390625,
        'normalization': 'kappa=1; mu=s; lambda=(1-k_mu*s)/k_lambda; rho=nu^3',
        'norm_x_degree_bound': 108,
        'norm_weighted_parameter_degree_bound': 33,
        'norm_identity_grid': {'x_points': 109, 's_points': 34, 'rho_points': 12,
                               'norm_evaluations': 109*34*12,
                               'additional_x_points_checked': 6,
                               'additional_norm_evaluations': 6*34*12,
                               'total_degree_nine_discriminants': 115*34*12*3},
        'ell_coefficients_ascending': ell,
        'ell_degree': len(ell)-1,
        'ell_squarefree': True,
        'generic_square_constraints': degrees,
        'generic_resultants': generic,
        'generic_bezout_degrees': {'u': len(bez_u)-1, 'v': len(bez_v)-1},
        'generic_unit_ideal_target': [1],
        'exceptional_rho_zero_degree': 105,
        'exceptional_rho_nonzero_degree': 106,
        'exceptional_constraints_used': [54+ia,54+ib],
        'exceptional_constraint_degrees_rho': [len(exeqs[ia])-1,len(exeqs[ib])-1],
        'exceptional_resultant_degree_bound': bound,
        'exceptional_resultant_degree': len(raw)-1,
        'exceptional_resultant_grid_size': bound+1,
        'exceptional_extra_check_points': 8,
        'exceptional_unit_ideal_target': [1],
        'undecided_conditions_within_task': []}
    return result, exceptional_bezout, norm


def run_checks():
    result, exbez, norm = certificate_summary()
    result.update(independent_norm_checks(norm))
    assert result == json.loads((ROOT/'certificates/summary.json').read_text())
    assert exbez == json.loads((ROOT/'certificates/exceptional_bezout.json').read_text())
    return result


if __name__ == '__main__':
    result = run_checks()
    print('PASS independent Python norm checks:', result['independent_norm_points'])
    print('PASS exceptional Bezout identity, odd-degree branch, and certificate summaries')
