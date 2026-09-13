#!/usr/bin/env python3
"""Audit the delivered partial data and prepare a genuine trace-zero test point.

Finite checks do not certify the missing universal fifth-trace producer.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse
import hashlib
import json
import sys
from pathlib import Path
from scripts.deformations.rank25.analyze_rank25_w4_germ import ZERO, ONE, elt, add, neg, mul, power, inv


def total(xs):
    out = ZERO
    for x in xs:
        out = add(out, x)
    return out


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('returns', type=Path)
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[3]
    incoming = args.returns.resolve()
    second = incoming/'second/rank25_family_partial_audit'
    sys.path.insert(0, str(second))
    import model
    primary, fourth, repairs = model.load(second)
    cert = json.loads((second/'audit_certificate.json').read_text())
    original_manifest = json.loads((second/'SHA256.json').read_text())
    assert all(hashlib.sha256((second/n).read_bytes()).hexdigest() == h
               for n, h in original_manifest.items())
    assert cert == json.loads((incoming/'second_replay/audit_certificate.json').read_text())
    ell = [model.digits(c) for c in cert['adjoint_row_ell']]
    lam = primary['obstruction_dual_rows'][0]
    assert model.mv(list(zip(*primary['hodge_matrix'])), ell) == [power(c, 5) for c in lam]
    for point in cert['fourth_representatives']:
        x, zeta, normal = [[model.digits(c) for c in point[k]]
                          for k in ['x', 'fourth_curve_digit_zeta', 'normal_R4']]
        assert model.evaluate_fourth(x, fourth, normal=True) == normal
        assert model.mv(primary['hodge_matrix'], [power(c, 5) for c in zeta]) == normal
        assert total(mul(a, b) for a, b in zip(lam, zeta)) == ZERO

    trace = json.loads((incoming/'first/trace_all_charts.json').read_text())
    theta = {tuple(row['powers']): elt(row['coefficient'])
             for row in trace['open']['geometric_zero_equation']}
    polynomial = {tuple(row['powers']): elt(row['coefficient'])
                  for row in trace['open']['trace']}
    assert {tuple(5*i for i in m): power(c, 5) for m, c in theta.items()} == polynomial
    assert theta[(1, 0, 0, 2)] == (2, 1, 1, 0)
    assert all(m[0] == 0 or m == (1, 0, 0, 2) for m in theta)

    def evaluate(p, point):
        return total(mul(c, total_product(power(a, i) for a, i in zip(point, mon)))
                     for mon, c in p.items())

    boundary_points = json.loads((root/'Research/computations/rank25_w5_return_and_global_w4_locus_checks.json').read_text())['boundary_four_roots']
    star = [ZERO]*9
    star[3], star[4] = (3, 0, 0, 3), (0, 3, 1, 4)
    for row, branch in zip(trace['boundaries'], boundary_points):
        a, b = power(elt(branch['a']), 125), power(elt(branch['b']), 125)
        value = evaluate(polynomial, [ZERO, add(a, neg(star[3])), add(b, neg(star[4])), ZERO])
        assert len(row['trace']) == 1 and value == elt(row['trace'][0]['coefficient']) != ZERO

    # A=B=0, q=1 is in the open chart. Set U by the reported trace equation.
    U = neg(mul(evaluate(theta, [ZERO, ZERO, ZERO, ONE]), inv(theta[(1, 0, 0, 2)])))
    x = list(star)
    x[0], x[6] = U, ONE
    r = (0, 2, 2, 4)
    x[5] = power(r, 125)
    y = [power(c, 5) for c in x]
    residual = model.evaluate_fourth(x, fourth)
    dm = [[(2, 0, 1, 4), (0, 1, 3, 0)], [(4, 3, 4, 2), (3, 0, 0, 4)]]
    det = add(mul(dm[0][0], dm[1][1]), neg(mul(dm[0][1], dm[1][0])))
    rhs = [neg(residual[1]), neg(residual[2])]
    y[1] = mul(inv(det), add(mul(dm[1][1], rhs[0]), neg(mul(dm[0][1], rhs[1]))))
    y[2] = mul(inv(det), add(neg(mul(dm[1][0], rhs[0])), mul(dm[0][0], rhs[1])))
    x[1], x[2] = power(y[1], 125), power(y[2], 125)
    assert model.evaluate_fourth(x, fourth) == [ZERO]*9
    assert evaluate(theta, [U, ZERO, ZERO, ONE]) == ZERO
    params = incoming/'geometry/trace_zero_parameters.json'
    params.write_text(json.dumps({'x': x, 'chart': 'A=B=0,q=1; U chosen from reported Theta'}, indent=2)+'\n')

    receipt = {
        'status': 'PASS finite input audit; universal fifth trace not independently reconstructed',
        'original_manifest_files': len(original_manifest),
        'second_certificate_exact_replay': True,
        'independent_adjoint_and_five_full_fourth_digits': True,
        'trace_equals_theta_fifth_as_polynomials': True,
        'reported_boundary_constants_consistent_with_polynomial': True,
        'trace_zero_open_test_x': x, 'trace_zero_open_test_U': U,
        'parameter_file': str(params),
        'actual_fifth_value_at_test': 'pending geometric replay',
        'missing_first_evidence': ['universal fifth-trace producer and polynomial checkpoint',
                                  'symbolic relative receipt and polynomial/fast-cohom dependencies',
                                  'other three line equations and Bezout identity'],
        'scope': 'No fifth lift or global height verdict; second identities are for curve digit and quotient, not rho5.',
    }
    regular = incoming/'geometry/trace_zero4200/fifth_regular_constant_4200_0.json'
    if regular.exists():
        fifth = json.loads(regular.read_text())
        c = [elt(v) for v in fifth['E5']]
        assert c == [elt(v) for v in fifth['riccati_E5']]
        assert c[0] == ZERO == elt(fifth['direct_trace'])
        J = model.jacobian_fourth([power(v, 5) for v in x], fourth)
        sk = [[J[i][j] for j in (7, 8)] for i in (7, 8)]
        determinant = add(mul(sk[0][0], sk[1][1]), neg(mul(sk[0][1], sk[1][0])))
        image_coordinates = [
            mul(inv(determinant), add(mul(sk[1][1], c[7]), neg(mul(sk[0][1], c[8])))),
            mul(inv(determinant), add(mul(sk[0][0], c[8]), neg(mul(sk[1][0], c[7])))),
        ]
        rowA = [add(J[4][j], neg(mul(elt(2), J[3][j]))) for j in (7, 8)]
        blockB = [[J[i][j] for j in (7, 8)] for i in (5, 6)]
        dot = lambda a, b: total(mul(u, v) for u, v in zip(a, b))
        quotient = [c[0], add(add(c[4], neg(mul(elt(2), c[3]))), neg(dot(rowA, image_coordinates))),
                    add(c[5], neg(dot(blockB[0], image_coordinates))),
                    add(c[6], neg(dot(blockB[1], image_coordinates)))]
        assert model.rank(J) == 5
        # Independently check membership against rank, not just the explicit formula.
        assert (model.rank([row+[ci] for row, ci in zip(J, c)]) == 5) == (quotient == [ZERO]*4)
        receipt['actual_fifth_value_at_test'] = {
            'status': fifth['status'], 'C5': c, 'quotient': quotient,
            'source_modulus': fifth['modulus'], 'laurent_workspace': fifth['precision'],
            'certified_rho_precision': fifth['rho5_certified_laurent_precision'],
            'checks': fifth['checks'], 'receipt': str(regular),
            'sha256': hashlib.sha256(regular.read_bytes()).hexdigest(),
            'scope': 'One actual open branch, normalized/original-frame agreement; not the universal trace identity.',
        }
    out = root/'Research/computations/rank25_two_family_returns_checks.json'
    out.write_text(json.dumps(receipt, indent=2)+'\n')
    print(json.dumps(receipt, indent=2))


def total_product(xs):
    out = ONE
    for x in xs:
        out = mul(out, x)
    return out


if __name__ == '__main__':
    main()
