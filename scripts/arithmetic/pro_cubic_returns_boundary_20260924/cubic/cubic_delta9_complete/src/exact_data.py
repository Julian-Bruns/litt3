"""Regenerate every arithmetic table from the input P,A and a verified root of unity.

Python standard library only. Polynomial arithmetic is independent of the
logarithmic E arithmetic and elimination implemented in scan.cpp.
"""
from __future__ import annotations
import itertools
import math
from finite25 import (
    add, sub, neg, mul, div, inv, power, pad, padd, psub, pscale,
    pmul, pmod, pmon, pgcd, ppow, pdiff, rref,
)


def generate(input_data: dict) -> tuple[dict, dict]:
    P, A = input_data['P'], input_data['A']
    M = input_data['root_of_unity_modulus_over_F25']
    Am = pmon(A)
    x = [0, 1]
    assert mul(5, 5) == 8
    assert pgcd(P, pdiff(P)) == [1]
    assert pgcd(A, pdiff(A)) == [1]
    assert pgcd(A, P) == [1]
    assert ppow(x, 25**4, Am) == x
    assert pgcd(Am, psub(ppow(x, 25**2, Am), x)) == [1]
    assert ppow(x, 25**7, M) == x
    assert pgcd(M, psub(ppow(x, 25, M), x)) == [1]
    assert pmod([1]*29, M) == []
    assert ppow(x, 29, M) == [1] and x != [1]

    def km(a, b): return pmod(pmul(a, b), Am)
    def kp(a, n): return ppow(a, n, Am)
    def ki(a):
        assert pmod(a, Am)
        return kp(a, 25**4-2)
    Ap, App, Pp = pdiff(A), pdiff(pdiff(A)), pdiff(P)
    G = pscale(km(kp(Ap, 3), kp(P, 2)), div(3, power(A[4], 3)))
    exponent = pow(29, -1, 25**4-1)
    b = kp(G, exponent)
    H = km(pscale(ki(Ap), A[4]),
           padd(km(Pp, ki(P)), pscale(km(App, ki(Ap)), 4)))
    c = km(kp(b, 5), H)
    u1 = km(pscale(kp(b, 4), A[4]), ki(Ap))
    u2 = psub(pscale(km(km(u1, c), ki(b)), 4),
              km(km(App, ki(pscale(Ap, 2))), kp(u1, 2)))
    assert kp(b, 29) == G
    # Independent substitutions in the leading and first-correction jet equations.
    lead_residual = psub(km(kp(pscale(b, 2), 3), kp(P, 2)),
                         km(kp(b, 20), kp(u1, 3)))
    first_residual = psub(
        padd(pscale(km(km(kp(pscale(b, 2), 2), pscale(c, 3)), kp(P, 2)), 3),
             km(kp(pscale(b, 2), 3), pscale(km(km(P, Pp), u1), 2))),
        km(km(kp(b, 20), kp(u1, 2)), u2))
    quartic_second_residual = psub(
        padd(km(Ap, u2), km(pscale(App, 3), kp(u1, 2))),
        pscale(km(kp(b, 3), c), mul(4, A[4])))
    assert pmod(lead_residual, Am) == []
    assert pmod(first_residual, Am) == []
    assert pmod(quartic_second_residual, Am) == []
    conjugates = {
        key: [pad(kp(value, 25**i), 4) for i in range(4)]
        for key, value in [('b', b), ('c', c), ('u1', u1), ('u2', u2)]
    }
    assert pad(b, 4) == [21,19,20,22]
    assert pad(c, 4) == [22,7,9,23]
    assert pad(u2, 4) == [1,3,8,15]

    # Derive E=F_(5^7) inside K7=F25[zeta]/M from eta=zeta+zeta^-1.
    def zm(a, b): return pmod(pmul(a, b), M)
    def zp(a, n): return ppow(a, n, M)
    zeta = x
    zeta_inverse = zp(zeta, 28)
    eta = padd(zeta, zeta_inverse)
    eta_conjugates = [zp(eta, 5**i) for i in range(7)]
    eta_minimal = [[1]]
    for root in eta_conjugates:
        result = [[] for _ in range(len(eta_minimal)+1)]
        for i, value in enumerate(eta_minimal):
            result[i] = psub(result[i], zm(value, root))
            result[i+1] = padd(result[i+1], value)
        eta_minimal = result
    assert all(len(row) <= 1 and (not row or row[0] < 5) for row in eta_minimal)
    Em = [row[0] if row else 0 for row in eta_minimal]
    assert Em == [1,2,2,1,3,2,4,1]
    assert ppow(x, 5**7, Em) == x
    assert pgcd(Em, psub(ppow(x, 5, Em), x)) == [1]
    beta_anti = sub(5, power(5, 5))
    eta2 = pscale(psub(zeta, zeta_inverse), inv(beta_anti))
    eta_powers = [pad(zp(eta, i), 7) for i in range(7)]
    system = [[eta_powers[i][j] for i in range(7)]+[pad(eta2, 7)[j]]
              for j in range(7)]
    rank, reduced = rref(system)
    assert rank == 7
    eta2_coordinates = [row[-1] for row in reduced]
    assert all(value < 5 for value in eta2_coordinates)
    za = padd(pscale(eta2_coordinates, mul(3, beta_anti % 5)), [0, 3])
    zb = pscale(eta2_coordinates, mul(3, beta_anti // 5))
    za, zb = pad(za, 7), pad(zb, 7)
    # A separate check in F25[eta]/Em of the derived zeta representation.
    zeta_over_E = [add(a, mul(5, b0)) for a, b0 in zip(za, zb)]
    assert ppow(zeta_over_E, 29, Em) == [1]
    assert ppow(zeta_over_E, 5**7, Em) == ppow(zeta_over_E, 28, Em)
    value = []
    for coefficient in reversed(M):
        value = padd(pmod(pmul(value, zeta_over_E), Em), [coefficient])
    assert value == []

    # Tensor basis constants, all in F5; L=E tensor_F5 K4 is a FIELD.
    basis = [[0]*i+[1] for i in range(4)]+[[0]*i+[5] for i in range(4)]
    def f5_coordinates(value):
        value = pad(pmod(value, Am), 4)
        return [v % 5 for v in value]+[v // 5 for v in value]
    basis_multiplication = [
        [f5_coordinates(km(a, b0)) for b0 in basis] for a in basis
    ]
    frobenius_columns = [f5_coordinates(kp(a, 5**7)) for a in basis]
    constants_f5 = {
        key: [f5_coordinates(row) for row in rows]
        for key, rows in conjugates.items()
    }
    d = P[9]
    rho = div(d, power(d, 5))
    assert d == 22 and rho == 18 and power(5, 5) == 21
    assert mul(rho, power(5, 5)) == 14

    # Complete orbit normalization: first send one chosen endpoint to (0,0).
    # The 6786 pairs left after fixing that endpoint exhaust all triples.
    powers25 = [pow(25, r, 29) for r in range(28)]
    def normal_form(triple):
        candidates = []
        for endpoint in triple:
            i, j = divmod(endpoint, 29)
            for k in range(7):
                factor = powers25[(-i+4*k) % 28]
                candidates.append(tuple(sorted(
                    ((other//29-i) % 4)*29 + ((other % 29-j)*factor) % 29
                    for other in triple)))
        return min(candidates)
    representatives = sorted({normal_form((0, a, b0))
                              for a in range(116) for b0 in range(a, 116)})
    assert len(representatives) == 333
    assert all(row[0] == 0 and normal_form(row) == row for row in representatives)
    assert math.comb(118, 3) == 266916
    assert len(representatives)*math.comb(118, 3) == 88883028
    distribution = {str(size): sum(len(set(row)) == size for row in representatives)
                    for size in [1, 2, 3]}
    assert distribution == {'1': 1, '2': 19, '3': 313}

    # Independent calculation of the sole linear exception, entirely in K4.
    # Zero triple: (i,j)=(0,0) three times. Infinity: (2,0) three times.
    U0 = pscale(conjugates['u2'][0], 3)
    Uinf = pscale(conjugates['u2'][2], 3)
    C0 = pscale(conjugates['c'][0], 3)
    Cinf = pscale(conjugates['c'][2], 3)
    columns = [
        padd(U0, pscale(Uinf, rho)),
        padd(pscale(U0, 5), pscale(Uinf, mul(rho, power(5, 5)))),
        pscale(padd(Cinf, pscale(C0, rho)), 4),
        pscale(padd(pscale(Cinf, 5), pscale(C0, mul(rho, power(5, 5)))), 4),
        [rho],
        psub(km(Cinf, C0), km(U0, Uinf)),
    ]
    coordinate_columns = [f5_coordinates(column) for column in columns]
    matrix = [[coordinate_columns[j][i] for j in range(6)] for i in range(8)]
    rank_augmented, reduced = rref(matrix)
    rank_coefficients, _ = rref([row[:5] for row in matrix])
    assert rank_augmented == rank_coefficients == 5
    solution = [neg(reduced[i][5]) for i in range(5)]
    assert solution == [3,1,3,1,2]
    for row in matrix:
        residual = row[5]
        for a, b0 in zip(row[:5], solution): residual = add(residual, mul(a, b0))
        assert residual == 0
    def norm(a, b0): return add(add(mul(a, a), mul(a, b0)), mul(2, mul(b0, b0)))
    norm_difference = sub(norm(solution[2], solution[3]), norm(solution[0], solution[1]))
    assert norm_difference == 0 and solution[4] != norm_difference
    xval = yval = 8  # 3+beta in the user's F25 encoding.
    direct_residual = psub(
        km(psub(Cinf, [mul(rho, power(yval, 5))]), psub(C0, [yval])),
        km(psub(Uinf, [xval]), psub(U0, [mul(rho, power(xval, 5))])))
    assert direct_residual == [24]
    exception = {
        'zero_endpoint_ids': [0,0,0], 'infinity_endpoint_ids': [58,58,58],
        'matrix_equation': 'M*(x0,x1,y0,y1,z)^T + D = 0; last column is D',
        'matrix_rows_over_F5': matrix, 'rref_augmented_over_F5': reduced,
        'coefficient_rank': rank_coefficients, 'augmented_rank': rank_augmented,
        'linear_solution_over_F5': solution,
        'x_and_y_in_user_F25_code': 8,
        'norm_y_minus_norm_x': norm_difference,
        'required_z': solution[4], 'quadratic_residual_z_minus_norm_difference': 2,
        'original_eliminated_product_residual_in_user_F25_code': 24,
        'original_residual_polynomial_in_K4': direct_residual,
        'scope': 'Independent Python verification of the sole linear exception; its uniqueness comes from the exhaustive scans',
    }
    data = {
        'A_monic': Am, 'G_mod_A': pad(G, 4), 'H_mod_A': pad(H, 4),
        'inverse_29_exponent': exponent,
        'b': pad(b, 4), 'c': pad(c, 4), 'u1': pad(u1, 4), 'u2': pad(u2, 4),
        'jet_substitution_residuals': [[], [], []],
        'conjugates_over_F25': conjugates,
        'E_modulus': Em, 'zeta_a': za, 'zeta_b': zb,
        'eta2_coordinates': eta2_coordinates,
        'constants_over_F5': constants_f5,
        'basis_multiplication': basis_multiplication,
        'frobenius_Q_columns': frobenius_columns,
        'd': d, 'rho': rho,
        'endpoint_count': 116, 'triple_count': 266916,
        'representatives': [list(row) for row in representatives],
        'representative_count': 333, 'representative_distinctness_distribution': distribution,
        'normalized_pair_count': 88883028,
        'scope': 'Complete forced endpoint data, exact field tables, and exhaustive normal forms; not unknown curve coefficients',
    }
    return data, exception


def header_text(data: dict) -> str:
    def array(name, value):
        def fmt(item):
            return '{'+','.join(fmt(v) for v in item)+'}' if isinstance(item, list) else str(item)
        dimensions = []
        item = value
        while isinstance(item, list):
            dimensions.append(len(item)); item = item[0]
        return 'const int '+name+''.join(f'[{d}]' for d in dimensions)+'='+fmt(value)+';\n'
    return ''.join([
        array('EMOD', data['E_modulus']), array('ZA', data['zeta_a']),
        array('ZB', data['zeta_b']), array('KMUL', data['basis_multiplication']),
        array('FROB', data['frobenius_Q_columns']),
        array('BCONST', data['constants_over_F5']['b']),
        array('CCONST', data['constants_over_F5']['c']),
        array('UCONST', data['constants_over_F5']['u2']),
        array('REPS', data['representatives']),
    ])
