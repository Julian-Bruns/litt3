#!/usr/bin/env python3
"""Bounded exact checks of the all-level closed-fiber pole formula.

These matrix checks do not prove local effectivity or global descent.
The coefficient ring is the actual unramified lift of F125, not
componentwise arithmetic on Witt digits.
"""
import argparse
import itertools
import json
from pathlib import Path

from verify_bt_obstruction_transport import field


def check():
    fadd, fneg, fmul, fpow = field(3, [1, 1, 0])
    elements = list(itertools.product(range(5), repeat=3))
    matrix_cases = 0
    level_receipts = []
    for n in range(1, 5):
        modulus = 5**(n+1)
        add, neg, mul, power = field(3, [1, 1, 0], modulus)
        zero, one, alpha = (0, 0, 0), (1, 0, 0), (0, 1, 0)

        def scalar(m):
            return (m % modulus, 0, 0)

        def inverse(u):
            # Order of the unit group of this unramified finite ring.
            return power(u, (125-1)*5**(3*n)-1)

        def polynomial(u):
            return add(add(power(u, 3), u), one)

        sigma_alpha = power(alpha, 5)
        for _ in range(n+1):
            derivative = add(mul(scalar(3), power(sigma_alpha, 2)), one)
            sigma_alpha = add(sigma_alpha,
                              neg(mul(polynomial(sigma_alpha), inverse(derivative))))
        assert polynomial(sigma_alpha) == zero

        def sigma(u):
            return add(add(scalar(u[0]), mul(scalar(u[1]), sigma_alpha)),
                       mul(scalar(u[2]), power(sigma_alpha, 2)))

        assert sigma(sigma(sigma(alpha))) == alpha

        def teich(u):
            v = u
            for _ in range(n+1):
                v = power(v, 125)
            assert power(v, 125) == v
            return v

        def mm(A, B):
            return [[add(mul(A[i][0], B[0][j]), mul(A[i][1], B[1][j]))
                     for j in range(2)] for i in range(2)]

        def determinant(A):
            return add(mul(A[0][0], A[1][1]), neg(mul(A[0][1], A[1][0])))

        def invdetone(A):
            assert determinant(A) == one
            return [[A[1][1], neg(A[0][1])], [neg(A[1][0]), A[0][0]]]

        def frob(A):
            return [[sigma(x) for x in row] for row in A]

        S = [[zero, scalar(5)], [one, zero]]
        values = set()
        for z in elements:
            for q in (zero, alpha):
                zhat, qhat = teich(z), teich(q)
                U = [[one, mul(scalar(5**n), qhat)],
                     [mul(scalar(5**(n-1)), zhat),
                      add(one, mul(scalar(5**(2*n-1)), mul(qhat, zhat)))]]
                # It is an actual closed-level matrix comparison modulo5^n.
                for left, right in ((mm(U, S), mm(S, frob(U))),
                                    (mm(frob(U), S), mm(S, U))):
                    assert all((left[i][j][a]-right[i][j][a]) % 5**n == 0
                               for i in range(2) for j in range(2) for a in range(3))
                transported = mm(mm(U, S), invdetone(frob(U)))
                x11 = tuple(c//5**n for c in transported[0][0])
                x22 = tuple(c//5**n for c in transported[1][1])
                assert all(c % 5**n == 0 for c in transported[0][0]+transported[1][1])
                assert x11 == fadd(q, fneg(fpow(z, 5)))
                assert x22 == fadd(z, fneg(fpow(q, 5)))
                polar = fmul((2, 0, 0), fadd(x11, fpow(x22, 25)))
                expected = fmul((2, 0, 0), fadd(fpow(z, 25), fneg(fpow(z, 5))))
                assert polar == expected
                assert (polar == zero) == (fpow(z, 25) == z)
                values.add(polar)
                matrix_cases += 1
        # F125 intersects F25 in F5:25 possible obstruction values here.
        assert len(values) == 25
        level_receipts.append({'level': n, 'modulus': modulus,
                               'field_elements': 125, 'gauge_choices': 2,
                               'image_size_over_F125': len(values)})

    # Group-law check for the additive geometric obstruction.
    def obstruction(z):
        return fmul((2, 0, 0), fadd(fpow(z, 25), fneg(fpow(z, 5))))
    for z in elements:
        for w in elements:
            assert obstruction(fadd(z, w)) == fadd(obstruction(z), obstruction(w))
    return {'matrix_cases': matrix_cases, 'additive_cases': 125**2,
            'levels': level_receipts,
            'formula': '2*(z^(1/5)-z^5)',
            'kernel': 'F25 (intersection F5 in this coefficient field)',
            'scope': 'Exact closed-fiber matrix and finite-field checks only.'}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    result = check()
    if args.output:
        root = Path(__file__).resolve().parents[2]
        if args.output.resolve().is_relative_to(root):
            parser.error('Generated evidence must be outside litt3')
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
