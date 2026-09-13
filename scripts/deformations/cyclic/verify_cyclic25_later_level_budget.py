#!/usr/bin/env python3
"""Finite function-filtration and precision-budget checks for later C25 descent.

These checks do not construct the three-digit Hodge comparison. In particular
they do not establish that its reference-dependent cochains have these supports.
"""
from math import comb


def values(size, degree):
    return [comb(i, degree) % 5 if i >= degree else 0 for i in range(size)]


def coefficients(data):
    out = []
    while data:
        out.append(data[0] % 5)
        data = [(b-a) % 5 for a, b in zip(data, data[1:])]
    return out


def product_coefficients(size, a, b):
    return coefficients([x*y % 5 for x, y in zip(values(size, a), values(size, b))])


def check_support(size, left_augmentation, right_augmentation, output_augmentation):
    count = 0
    for a in range(size-left_augmentation):
        for b in range(size-right_augmentation):
            c = product_coefficients(size, a, b)
            assert not any(c[size-output_augmentation:])
            count += 1
    return count


def main():
    count = 0
    for left, right, output in [(22, 22, 20), (22, 23, 21), (23, 23, 22),
                                (23, 3, 2), (24, 2, 2)]:
        count += check_support(25, left, right, output)
    # A genuinely weaker support: these products need not lie in e^2.
    assert product_coefficients(25, 1, 22)[23] == 3
    assert product_coefficients(25, 2, 21)[23] == 3

    rows = []
    for n in range(2, 21):
        m = n-1
        final = m+2
        quadratic_order, mixed_order = 2*m, 2*m+1
        if n == 2:
            assert quadratic_order == final-1  # Divided quadratic carry.
            assert mixed_order == final
        elif n == 3:
            assert quadratic_order == final    # Ordinary product only.
            assert mixed_order > final
        else:
            assert quadratic_order > final and mixed_order > final
        # First previous scalar correction p^m*r1 receives p^2 in tilde.
        assert m+2 == final and m+3 > final
        if n <= 5:
            rows.append((n, m, quadratic_order, mixed_order, final))

    # Why the next group size is not an automatic initial-level corollary:
    # both B100 and B24 lie in e23*A for a cyclic125 torsor, but their
    # product is B124 and therefore is not even in e*A.
    c = product_coefficients(125, 100, 24)
    assert c[124] == 1 and not any(c[:124])
    print('PASS:', count, 'later-level basis products')
    print('PASS: e23*e2 and e22*e3 can leave e2; explicit e-coordinate witnesses')
    print('n,m,first-square,first-times-second,final-normal-digit =', rows)
    print('PASS: n=3 has an ordinary quadratic; n>=4 quadratics vanish, through n=20')
    print('PASS: at cyclic125, (e23*A)^2 need not lie in e*A (B100*B24=B124)')
    print('Scope: exact algebra and degree budgets, not a geometric descent theorem')


if __name__ == '__main__':
    main()
