"""New exact period-two results, including a stable false positive.

R_star is the extension with u=0 and v=y^2(x^-6+[18]x^-4).
This script certifies its rank-ten cup matrix, a stability Bezout identity,
a nowhere-zero lifted section, and a smooth point of a septic rank-drop
hypersurface. hom_test.py separately proves Hom(F^2 R_star,K)=0.
No claim about other Frobenius periods or the unrestricted existence problem
is made.
"""
from __future__ import annotations
import hashlib
import json
from pathlib import Path
import numpy as np
import period_two as p
import polynomial_certificate as pc

HERE = Path(__file__).resolve().parent
ff = p.ff

def branch_coordinates(e: p.Function) -> list[list[int]]:
    """Reduce sum_{m=1}^8 r^(m-1)*y^2*x^-m modulo (e,x*e)."""
    full = p.cech_monomials(-7)
    xe = p.multiply_functions({(1, 0): 1}, e)
    relations = np.array([[e.get(m, 0), xe.get(m, 0)] for m in full], dtype=np.uint8)
    rank, _, removed = p.rref_nullspace(relations.T)
    assert rank == 2 and [full[i] for i in removed] == [(-8, 2), (-7, 2)]
    a = relations[removed, :]
    inv = np.array([[a[1, 1], ff.negative(int(a[0, 1]))],
                    [ff.negative(int(a[1, 0])), a[0, 0]]], dtype=np.uint8)
    inv = p.MUL[inv, ff.inverse(p.determinant(a))]
    assert np.array_equal(p.matrix_product(a, inv), np.eye(2, dtype=np.uint8))
    result = []
    for exponent in range(-6, 0):
        row = full.index((exponent, 2))
        poly = [0] * 8
        poly[-exponent - 1] = 1
        for index, deleted in enumerate(removed):
            coefficient = 0
            for j in range(2):
                coefficient = ff.add(coefficient,
                                     ff.multiply(int(relations[row, j]), int(inv[j, index])))
            poly[-full[deleted][0] - 1] = ff.add(
                poly[-full[deleted][0] - 1], ff.negative(coefficient))
        result.append(pc.trim(poly))
    return result

def polynomial_of(f: p.Function, y_power: int) -> list[int]:
    assert all(a >= 0 and b == y_power for a, b in f)
    return [f.get((i, y_power), 0) for i in range(max(a for a, b in f) + 1)]

def construct() -> None:
    z = np.load(HERE / 'period_two_data.npz')
    tensor = z['cup_tensor']
    assert hashlib.sha256(tensor.tobytes(order='C')).hexdigest() == (
        '3b0db6b0a70a32d965569f12c87772dd383f08d821cb4b38d417a45f6f4b463e')
    e = {(-i, 2): c for i, c in enumerate(ff.C_COEFFICIENTS, 1)}
    v = {(-6, 2): 1, (-4, 2): 18}
    coordinates = np.zeros(19, dtype=np.uint8)
    coordinates[13], coordinates[15] = 1, 18
    matrix = p.ADD[tensor[:, :, 13], p.MUL[18, tensor[:, :, 15]]]
    rank, kernel, columns = p.rref_nullspace(matrix)
    assert rank == 10 and kernel.shape == (11, 1)
    expected_kernel = [0, 0, 0, 0, 4, 2, 17, 3, 8, 6, 1]
    assert kernel[:, 0].tolist() == expected_kernel
    assert not np.any(p.matrix_product(matrix, kernel))
    _, _, rows = p.rref_nullspace(matrix[:, columns].T)
    minor = matrix[np.ix_(rows, columns)]
    minor_det = p.determinant(minor)
    assert minor_det == 22

    # Character-pure six-dimensional subspace: a tall 14x4 block and a 7x7 block.
    assert not np.any(tensor[:18, :4, 13:19])
    assert not np.any(tensor[7:, 4:, 13:19])
    assert p.rref_nullspace(matrix[18:, :4])[0] == 4
    assert p.rref_nullspace(matrix[:7, 4:])[0] == 6
    square = tensor[:7, 4:, :]
    current = matrix[:7, 4:]
    pencil = pc.determinant_pencil(square[:, :, 13], square[:, :, 15])
    assert pencil == [22, 0, 17, 14, 14, 22, 9, 19]
    derivative = [ff.multiply(i % 5, pencil[i]) for i in range(1, len(pencil))]
    squarefree_gcd, squarefree_s, squarefree_t = pc.xgcd(pencil, derivative)
    assert squarefree_gcd == [1]
    coordinate_determinants = [p.determinant(square[:, :, t]) for t in range(13, 19)]
    assert coordinate_determinants == [22, 11, 19, 22, 4, 2]
    for t in range(25):
        assert pc.evaluate(pencil, t) == p.determinant(
            p.ADD[square[:, :, 13], p.MUL[t, square[:, :, 15]]])
    assert pc.evaluate(pencil, 18) == 0
    gradient = []
    for parameter in range(13, 19):
        value = 0
        for i in range(7):
            for j in range(7):
                cofactor = p.determinant(np.delete(np.delete(current, i, axis=0), j, axis=1))
                if (i + j) % 2:
                    cofactor = ff.negative(cofactor)
                value = ff.add(value, ff.multiply(cofactor, int(square[i, j, parameter])))
        gradient.append(value)
    assert gradient == [6, 6, 3, 9, 23, 17]
    assert any(gradient)
    assert ff.add(gradient[0], ff.multiply(18, gradient[2])) == 0

    # Stability: the forbidden branch-coordinate value never vanishes at a root of P.
    branch = branch_coordinates(e)
    w3 = branch[3]
    assert w3 == [0, 0, 1, 0, 0, 0, 3, 23]
    gcd, stability_s, stability_t = pc.xgcd(list(ff.P_COEFFICIENTS), w3)
    assert gcd == [1]

    # Reconstruct the unique lifted section of F^2 R_star(O).
    coefficients = p.matrix_product(z['section_kernel'], kernel)[:, 0]
    bottom = {tuple(map(int, mon)): int(c)
              for mon, c in zip(z['section_bottom_basis'], coefficients) if c}
    eb = p.multiply_functions(p.frobenius(e, 25), bottom)
    vb = p.multiply_functions(p.frobenius(v, 25), bottom)
    top = {mon: c for mon, c in eb.items() if mon[0] >= 0}
    first = {mon: c for mon, c in vb.items() if mon[0] >= 0}
    n, a, b = polynomial_of(first, 0), polynomial_of(top, 0), polynomial_of(bottom, 1)
    gcd, bezout_n, bezout_a = pc.xgcd(n, a)
    assert gcd == [1]
    n_v = {mon: ff.negative(c) for mon, c in vb.items() if mon[0] < 0}
    a_v = {mon: ff.negative(c) for mon, c in eb.items() if mon[0] < 0}
    assert all(3*x + 10*y <= -24 for x, y in n_v)
    assert all(3*x + 10*y <= -124 for x, y in a_v)
    weights = [max(3*x + 10*y for x, y in f) for f in (n_v, a_v, bottom)]
    orders = [bound - weight for bound, weight in zip((-24, -124, 151), weights)]
    assert weights == [-24, -126, 151] and orders == [0, 2, 0]
    assert [len(n) - 1, len(a) - 1, len(b) - 1] == [117, 192, 47]

    # Exact finite point scan is recorded only as a finite scan, not as a geometric proof.
    pencil_points = []
    for i in range(13, 19):
        for j in range(i + 1, 19):
            for lam in range(1, 25):
                mat = p.ADD[tensor[:, :, i], p.MUL[lam, tensor[:, :, j]]]
                rk, _, _ = p.rref_nullspace(mat)
                if rk < 11:
                    pencil_points.append({'i_zero_based': i, 'j_zero_based': j,
                                          'lambda_code': lam, 'rank': rk})
    assert len(pencil_points) == 15 and all(point['rank'] == 10 for point in pencil_points)

    certificate = {
        'scope': 'A stable false positive for the second-return kernel test; no unrestricted existence decision.',
        'field': 'F_5[a]/(a^2-a-3), code c0+5*c1',
        'extension_coordinates_zero_based': coordinates.tolist(),
        'u': [], 'v': [[-6, 2, 1], [-4, 2, 18]],
        'cup_matrix_shape': list(matrix.shape), 'cup_rank': rank,
        'cup_kernel': expected_kernel, 'rank_ten_minor_rows': rows,
        'rank_ten_minor_columns': columns, 'rank_ten_minor_det': minor_det,
        'square_block_rows': list(range(7)), 'square_block_columns': list(range(4, 11)),
        'square_block_parameter_indices': list(range(13, 19)),
        'septic_pencil_ascending': pencil, 'septic_gradient_at_point': gradient,
        'septic_coordinate_determinants': coordinate_determinants,
        'septic_pencil_derivative': derivative,
        'septic_squarefree_bezout_pencil_multiplier': squarefree_s,
        'septic_squarefree_bezout_derivative_multiplier': squarefree_t,
        'septic_squarefree_bezout_rhs': [1],
        'septic_is_reduced': True,
        'branch_coordinate_polynomials_ascending': branch,
        'stability_w3': w3, 'stability_bezout_P_multiplier': stability_s,
        'stability_bezout_w3_multiplier': stability_t,
        'stability_bezout_rhs': [1],
        'lift_n_polynomial': n, 'lift_a_polynomial': a, 'lift_b_polynomial': b,
        'lift_n_multiplier': bezout_n, 'lift_a_multiplier': bezout_a,
        'lift_bezout_rhs': [1], 'lift_V_weights': weights, 'lift_V_local_orders': orders,
        'stable_extension': True, 'lifted_section_nowhere_zero': True,
        'geometric_rank_ten_locus_nonempty': True,
        'smooth_reduced_hypersurface_local_dimension': 4,
        'strict_second_return': False,
        'strict_second_return_exclusion_certificate': 'hom_test_certificate.json',
        'other_periods_decided': False,
        'f25_rank_ten_points_in_coordinate_pencils': pencil_points,
    }
    (HERE / 'new_progress_certificate.json').write_text(json.dumps(certificate, indent=2) + '\n')
    np.savez_compressed(HERE / 'new_progress_data.npz', cup_matrix=matrix,
                        cup_kernel=kernel, maximal_minor=minor,
                        square_pencil_0=square[:, :, 13], square_pencil_1=square[:, :, 15],
                        extension_coordinates=coordinates)
    print('R_star: u=0, v=y^2(x^-6+[18]x^-4).')
    print('Cup rank 10; kernel certified; rank-ten minor determinant [22].')
    print('Stable extension: P/w3 Bezout identity equals 1.')
    print('Lift nowhere zero: n/a Bezout identity equals 1; infinity orders (0,2,0).')
    print('Reduced septic: squarefree pencil Bezout identity; smooth rank-ten point; gradient [6,6,3,9,23,17].')
    print('Geometric rank-ten locus is nonempty. No unrestricted existence decision.')

if __name__ == '__main__':
    construct()
