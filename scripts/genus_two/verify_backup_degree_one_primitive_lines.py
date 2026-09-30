#!/usr/bin/env python3
"""Independent standard-library audit of the backup degree-one plane data.

No Sage or author arithmetic module is imported.  The Taylor section is
rebuilt by the recurrence v^2=f, rather than by the author's cube formula.
Generated receipts are written outside the research workspace.
"""

import argparse
import itertools
import json
import math
from pathlib import Path


def digits(a):
    return [a % 5, (a // 5) % 5, (a // 25) % 5]


def pack(v):
    return sum((a % 5) * 5**i for i, a in enumerate(v))


def add(a, b):
    return pack([x + y for x, y in zip(digits(a), digits(b))])


def neg(a):
    return pack([-x for x in digits(a)])


def sub(a, b):
    return add(a, neg(b))


def mul(a, b):
    v = [0] * 5
    for i, x in enumerate(digits(a)):
        for j, y in enumerate(digits(b)):
            v[i+j] += x*y
    # a^3=-a-1, hence a^4=-a^2-a.
    for i in (4, 3):
        v[i-2] -= v[i]
        v[i-3] -= v[i]
    return pack(v[:3])


def power(a, n):
    out = 1
    while n:
        if n & 1:
            out = mul(out, a)
        a = mul(a, a)
        n //= 2
    return out


def inv(a):
    assert a
    return power(a, 123)


def trim(p):
    while len(p) > 1 and not p[-1]:
        p.pop()
    return p


def padd(p, q):
    return trim([add(p[i] if i < len(p) else 0,
                     q[i] if i < len(q) else 0)
                 for i in range(max(len(p), len(q)))])


def pscale(p, a):
    return trim([mul(x, a) for x in p])


def psub(p, q):
    return padd(p, pscale(q, 4))


def pmul(p, q):
    out = [0] * (len(p) + len(q) - 1)
    for i, a in enumerate(p):
        for j, b in enumerate(q):
            out[i+j] = add(out[i+j], mul(a, b))
    return trim(out)


def ppow(p, n):
    out = [1]
    for _ in range(n):
        out = pmul(out, p)
    return out


def peval(p, x):
    out = 0
    for a in reversed(p):
        out = add(mul(out, x), a)
    return out


def hasse(p, j):
    return trim([mul(p[i], math.comb(i, j) % 5)
                 for i in range(j, len(p))])


def pcoeff(p, j):
    return p[j] if j < len(p) else 0


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    a = 5
    assert add(add(power(a, 3), a), 1) == 0
    for b in range(1, 125):
        assert mul(b, inv(b)) == 1
        assert power(b, 125) == b

    f = [1]
    for b in (0, 1, 2, 3, a):
        f = pmul(f, [neg(b), 1])
    f3 = ppow(f, 3)
    obstruction = hasse(f3, 4)
    H = [power(pcoeff(f3, 5*j+4), 25) for j in range(3)]
    assert ppow(H, 5) == obstruction
    roots = [b for b in range(125) if peval(H, b) == 0]
    assert len(roots) == 1
    t = roots[0]
    assert H == pscale(ppow([neg(t), 1], 2), H[-1])
    # The displayed polynomial factorization proves exhaustion over kbar,
    # not merely over the 125 tested scalars.
    assert all(peval(H, b) for b in (0, 1, 2, 3, a))
    value = peval(f, t)
    points = [b for b in range(125) if power(b, 2) == value]
    assert len(points) == 2 and value
    s = min(points)

    # Independently solve the formal square-root recurrence at (t,s).
    taylor = [s]
    for j in range(1, 6):
        cross = 0
        for i in range(1, j):
            cross = add(cross, mul(taylor[i], taylor[j-i]))
        taylor.append(mul(sub(peval(hasse(f, j), t), cross),
                          inv(mul(2, s))))
    assert taylor[4] == 0 and taylor[5] != 0
    A = [0]
    for j in range(4):
        A = padd(A, pscale(ppow([neg(t), 1], j), taylor[j]))
    assert len(A) == 4 and peval(A, t) == s and peval(A, a) == 0
    residual = psub(ppow(A, 2), f)
    residual_lead = residual[-1]
    assert residual == pscale(
        pmul(ppow([neg(t), 1], 5), [neg(a), 1]), residual_lead)

    norm_source = padd(f3, pmul(ppow(f, 2), ppow(A, 2)))
    norm = [pcoeff(norm_source, 5*j+4) for j in range(3)]
    c = norm[-1]
    assert c and norm == pscale(ppow([neg(power(t, 5)), 1], 2), c)
    lambdas = [b for b in range(125) if mul(power(b, 2), c) == 4]
    assert len(lambdas) == 2

    twisted_f = [power(b, 5) for b in f]
    target_points = [(power(t, 5), power(b, 5)) for b in points]
    for x1, v1 in target_points:
        assert power(v1, 2) == peval(twisted_f, x1) != 0
    assert power(t, 5) == a and t != a

    branch_checks = []
    for b in (None, 0, 1, 2, 3, a):
        source = ppow(f, 2)
        if b is not None:
            source = pmul(source, [neg(b), 1])
        row = [pcoeff(source, 4), pcoeff(source, 9)]
        mismatch = row[1] if b is None else add(row[0], mul(power(b, 5), row[1]))
        assert row != [0, 0] and mismatch
        branch_checks.append({"point": b, "relative_row": row,
                              "required_divisor_mismatch": mismatch})

    # Verify the local six-variable quadratic identity independently.
    # Each variable has degree <=2<5, so exhaustive F5 evaluation proves
    # polynomial equality; this is not a sample test.
    for c0, a0, a1, a2, a3, a4 in itertools.product(range(5), repeat=6):
        p = [a0, 3*a1, a2+3*c0, 3*a2+c0, 3*a3, a4]
        wedge = 2*(p[0]*p[5]-p[1]*p[4]+p[2]*p[3]) % 5
        coeff_u4 = sum([a0, a1, a2, a3, a4][i]
                       * [a0, a1, a2, a3, a4][4-i]
                       for i in range(5)) % 5
        assert wedge == (c0*c0+coeff_u4) % 5

    out = {
        "arithmetic": "independent standard library; F5[a]/(a^3+a+1)",
        "curve": f,
        "critical_H": H,
        "critical_polynomial_factorization_checked_over_algebraic_closure": True,
        "source_points": [[t, b] for b in points],
        "target_points": target_points,
        "square_root_Taylor_coefficients_through_five": taylor,
        "A_rebuilt_by_square_root_recurrence": A,
        "residual_linear_factor_root": a,
        "residual_factor_leading": residual_lead,
        "relative_norm_numerator": norm,
        "relative_norm_constant": c,
        "two_Pluecker_scalars": lambdas,
        "six_Weierstrass_checks": branch_checks,
        "quadratic_identity_exact_finite_check_count": 5**6,
        "passed": True,
    }
    rendered = json.dumps(out, indent=2) + "\n"
    if args.output:
        target = args.output.resolve()
        workspace = Path(__file__).resolve().parents[2]
        assert not target.is_relative_to(workspace)
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text(rendered)
    print(rendered, end="")


if __name__ == "__main__":
    main()
