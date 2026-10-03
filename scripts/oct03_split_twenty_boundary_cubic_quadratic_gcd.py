#!/usr/bin/env python3
"""NEW sole fixed GF25 cubic/quadratic boundary gate, inspection before lease.

No enumeration, GB, imports of old certificates, threads or child processes.
Raw output must be outside litt3. Run only once after root inspection/lease,
with all thread environments1 and a parent subprocess external15s timeout.
P is the ACTUAL fixed polynomial, a^2=a+3, [5*A+B]=B+A*a, d=[23].
The sole target is F(V)=P(V-1)-(V^2+d)^5 being C_3^3-A_2^3 over
the algebraic closure. Exact univariate gcd plus its denominator-zero
branch decide ONLY this polynomial boundary condition, not an actual source.
"""

import argparse
import hashlib
import json
from pathlib import Path
import platform
import time

P_CODES = [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]
D_CODE = 23


def add(a, b):
    return (a % 5 + b % 5) % 5 + 5 * ((a // 5 + b // 5) % 5)


def neg(a):
    return (-a % 5) % 5 + 5 * (-(a // 5) % 5)


def sub(a, b):
    return add(a, neg(b))


def mul(a, b):
    ar, ai, br, bi = a % 5, a // 5, b % 5, b // 5
    return (ar * br + 3 * ai * bi) % 5 + 5 * (
        (ar * bi + ai * br + ai * bi) % 5)


def power(a, n):
    result = 1
    while n:
        if n & 1:
            result = mul(result, a)
        a = mul(a, a)
        n //= 2
    return result


def inv(a):
    if not a:
        raise ZeroDivisionError("GF25 inverse of zero")
    out = power(a, 23)
    assert mul(a, out) == 1
    return out


def trim(p):
    p = list(p)
    while p and p[-1] == 0:
        p.pop()
    return p


def pa(p, q):
    return trim([add(p[i] if i < len(p) else 0,
                     q[i] if i < len(q) else 0)
                 for i in range(max(len(p), len(q)))])


def ps(p, q):
    return pa(p, [neg(c) for c in q])


def scale(p, c):
    return trim([mul(x, c) for x in p])


def pm(p, q):
    if not p or not q:
        return []
    out = [0] * (len(p) + len(q) - 1)
    for i, a in enumerate(p):
        for j, b in enumerate(q):
            out[i + j] = add(out[i + j], mul(a, b))
    return trim(out)


def pp(p, n):
    out = [1]
    for _ in range(n):
        out = pm(out, p)
    return out


def pe(p, x):
    out = 0
    for c in reversed(p):
        out = add(mul(out, x), c)
    return out


def divide(p, q):
    p, q = trim(p), trim(q)
    if not q:
        raise ZeroDivisionError("polynomial division by zero")
    quotient = [0] * max(0, len(p) - len(q) + 1)
    leading = inv(q[-1])
    while p and len(p) >= len(q):
        k = len(p) - len(q)
        c = mul(p[-1], leading)
        quotient[k] = add(quotient[k], c)
        for j, b in enumerate(q):
            p[k + j] = sub(p[k + j], mul(c, b))
        p = trim(p)
    return trim(quotient), p


def xgcd(p, q):
    r0, r1, s0, s1, t0, t1 = trim(p), trim(q), [1], [], [], [1]
    while r1:
        quotient, remainder = divide(r0, r1)
        r0, r1 = r1, remainder
        s0, s1 = s1, ps(s0, pm(quotient, s1))
        t0, t1 = t1, ps(t0, pm(quotient, t1))
    if not r0:
        return [], [], []
    unit = inv(r0[-1])
    return scale(r0, unit), scale(s0, unit), scale(t0, unit)


def vm(p, q):
    """Multiply V polynomials with GF25[r] coefficient polynomials."""
    out = [[] for _ in range(len(p) + len(q) - 1)]
    for i, a in enumerate(p):
        for j, b in enumerate(q):
            out[i + j] = pa(out[i + j], pm(a, b))
    return out


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()
    output = args.output.resolve()
    workspace = Path(__file__).resolve().parent.parent
    if output == workspace or workspace in output.parents:
        raise ValueError("raw certificate must be outside litt3")
    if output.exists():
        raise FileExistsError("refuse replay/overwrite of an existing output")
    started = time.perf_counter()
    assert mul(5, 5) == add(5, 3) and mul(D_CODE, D_CODE) == 2

    # Construct the SOLE target directly from the actual fixed P and d.
    shifted = []
    for c in reversed(P_CODES):
        shifted = pa(pm(shifted, [4, 1]), [c])
    q5 = pp([D_CODE, 0, 1], 5)
    F = ps(shifted, q5)
    assert len(F) == 10 and F[8] == 1 and F[9] == 22
    expected_F = [1, 3, 21, 23, 22, 12, 22, 21, 1, 22]
    assert F == expected_F

    f9 = F[9]
    p = mul(F[8], inv(mul(3, f9)))
    q = sub(mul(F[7], inv(mul(3, f9))), mul(p, p))
    monic_C = [[0, 1], [q], [p], [1]]  # V^3+p V^2+q V+r
    G = [scale(c, f9) for c in vm(vm(monic_C, monic_C), monic_C)]
    for i, c in enumerate(F):
        G[i] = ps(G[i], [c])
    assert all(not c for c in G[7:])
    G = G[:7]
    L, S = G[6], G[5]
    assert len(L) == 2 and L[1] == mul(3, f9)
    T = pa(scale(pm(G[4], L), 2), pp(S, 2))
    equations = [
        ps(ps(pm(G[3], pp(L, 2)), scale(pp(S, 3), 3)),
           scale(pm(S, T), 2)),
        ps(ps(pm(G[2], pp(L, 3)), scale(pp(T, 2), 3)),
           scale(pm(pp(S, 2), T), 2)),
        ps(pm(G[1], pp(L, 4)), pm(S, pp(T, 2))),
        ps(pm(G[0], pp(L, 5)), pp(T, 3)),
    ]
    gcd = equations[0]
    coefficients = [[1], [], [], []]
    for i in range(1, 4):
        gcd, left, right = xgcd(gcd, equations[i])
        coefficients = [pm(left, c) for c in coefficients]
        coefficients[i] = pa(coefficients[i], right)
    rebuilt = []
    for c, eq in zip(coefficients, equations):
        rebuilt = pa(rebuilt, pm(c, eq))
    assert rebuilt == gcd

    # Saturation is exact; never infer a geometric root on L=0 is generic.
    saturated, removed = gcd, 0
    while saturated and len(saturated) >= len(L):
        quotient, remainder = divide(saturated, L)
        if remainder:
            break
        saturated, removed = quotient, removed + 1
    if saturated:
        saturated = scale(saturated, inv(saturated[-1]))
    generic_exists = len(saturated) > 1 or not saturated

    # The ONLY denominator-zero value is checked separately over the field.
    exceptional_r = mul(neg(L[0]), inv(L[1]))
    assert pe(L, exceptional_r) == 0
    exceptional_G = trim([pe(c, exceptional_r) for c in G])
    exceptional_checks = {"degree": len(exceptional_G) - 1}
    if len(exceptional_G) <= 1:
        exceptional_exists = True  # any constant is a cube over algebraic k
    elif len(exceptional_G) == 4:
        lead = exceptional_G[3]
        s = mul(exceptional_G[2], inv(mul(3, lead)))
        expect1, expect0 = mul(3, mul(lead, power(s, 2))), mul(lead, power(s, 3))
        exceptional_exists = exceptional_G[1] == expect1 and exceptional_G[0] == expect0
        exceptional_checks.update({"normalized_linear_constant": s,
                                   "expected_V1": expect1, "expected_V0": expect0})
    else:
        exceptional_exists = False  # positive degree not divisible by three

    result = {
        "scope": "sole fixed F=C_degree3^3-A_degree_at_most2^3 over algebraic closure; no source realization",
        "field": {"characteristic": 5, "a_relation": "a^2=a+3", "code": "[5*A+B]=B+A*a"},
        "P_ascending": P_CODES, "d": D_CODE,
        "shifted_P_ascending": shifted, "F_ascending": F,
        "normalized_cubic_p": p, "normalized_cubic_q": q,
        "G_V_coefficients_r_ascending": G,
        "L_r_ascending": L, "S_r_ascending": S, "T_r_ascending": T,
        "four_equations_r_ascending": equations,
        "gcd_r_ascending": gcd, "bezout_four_coefficients_r_ascending": coefficients,
        "saturated_gcd_r_ascending": saturated, "removed_L_power": removed,
        "generic_exists_over_algebraic_closure": generic_exists,
        "exceptional_r": exceptional_r, "exceptional_G_ascending": exceptional_G,
        "exceptional_checks": exceptional_checks,
        "exceptional_exists_over_algebraic_closure": exceptional_exists,
        "boundary_waring_exists": generic_exists or exceptional_exists,
        "executed_checks": ["a relation and d squared", "actual P shift and sole F target",
                            "fixed coefficient table", "degree7..9 cancellation",
                            "L linear coefficient", "four-polynomial Bezout reconstruction",
                            "exact L saturation", "unique L-zero branch"],
        "source_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "python_version": platform.python_version(), "workers": 1,
        "elapsed_seconds": time.perf_counter() - started,
    }
    output.parent.mkdir(parents=True, exist_ok=True)
    with output.open("x") as stream:
        stream.write(json.dumps(result, indent=2) + "\n")
    print(json.dumps({"output": str(output), "gcd": gcd,
                      "generic_exists": generic_exists,
                      "exceptional_exists": exceptional_exists,
                      "boundary_waring_exists": result["boundary_waring_exists"],
                      "elapsed_seconds": result["elapsed_seconds"]}))


if __name__ == "__main__":
    main()
