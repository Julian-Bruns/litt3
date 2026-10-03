#!/usr/bin/env python3
"""One tiny NEW exact F25 derivative/gcd gate; no enumeration or replay.

This source is prepared for root inspection and core coordination. Merely
creating it does not authorize running it. The two targets are the necessary
signed monomial endpoint jet conditions q0*P'' - 2*sigma*p9*P', sigma=+/-1,
at a root of the fixed P. Both signs retain the actual first endpoint.
Raw JSON must be written outside litt3; every certificate is checked by
direct polynomial multiplication before it is emitted.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import time


# Encoded b + a*alpha is 5*a+b; alpha^2=alpha+3 over F5.
def fa(x: int, y: int) -> int:
    return ((x % 5 + y % 5) % 5) + 5 * ((x // 5 + y // 5) % 5)


def fn(x: int) -> int:
    return (-x % 5) + 5 * ((-(x // 5)) % 5)


def fs(x: int, y: int) -> int:
    return fa(x, fn(y))


def fm(x: int, y: int) -> int:
    b, a = x % 5, x // 5
    d, c = y % 5, y // 5
    return ((b * d + 3 * a * c) % 5) + 5 * ((b * c + a * d + a * c) % 5)


def fp(x: int, exponent: int) -> int:
    ans = 1
    while exponent:
        if exponent & 1:
            ans = fm(ans, x)
        x = fm(x, x)
        exponent //= 2
    return ans


def fi(x: int) -> int:
    if not x:
        raise ZeroDivisionError("F25 inverse of zero")
    ans = fp(x, 23)
    assert fm(x, ans) == 1
    return ans


def trim(p: list[int]) -> list[int]:
    p = p[:]
    while p and p[-1] == 0:
        p.pop()
    return p


def pa(p: list[int], q: list[int]) -> list[int]:
    return trim([fa(p[i] if i < len(p) else 0, q[i] if i < len(q) else 0)
                 for i in range(max(len(p), len(q)))])


def pn(p: list[int]) -> list[int]:
    return trim([fn(x) for x in p])


def ps(p: list[int], q: list[int]) -> list[int]:
    return pa(p, pn(q))


def scale(p: list[int], scalar: int) -> list[int]:
    return trim([fm(x, scalar) for x in p])


def pm(p: list[int], q: list[int]) -> list[int]:
    if not p or not q:
        return []
    ans = [0] * (len(p) + len(q) - 1)
    for i, x in enumerate(p):
        for j, y in enumerate(q):
            ans[i + j] = fa(ans[i + j], fm(x, y))
    return trim(ans)


def pd(p: list[int]) -> list[int]:
    return trim([fm(i % 5, p[i]) for i in range(1, len(p))])


def divrem(p: list[int], q: list[int]) -> tuple[list[int], list[int]]:
    q = trim(q)
    if not q:
        raise ZeroDivisionError("polynomial divisor zero")
    rest = trim(p)
    quotient = [0] * max(0, len(rest) - len(q) + 1)
    inv = fi(q[-1])
    while rest and len(rest) >= len(q):
        shift = len(rest) - len(q)
        coeff = fm(rest[-1], inv)
        quotient[shift] = fa(quotient[shift], coeff)
        for j, val in enumerate(q):
            rest[j + shift] = fs(rest[j + shift], fm(coeff, val))
        rest = trim(rest)
    quotient = trim(quotient)
    assert pa(pm(quotient, q), rest) == trim(p)
    return quotient, rest


def egcd(p: list[int], q: list[int]) -> tuple[list[int], list[int], list[int]]:
    old_r, r = trim(p), trim(q)
    old_a, a, old_b, b = [1], [], [], [1]
    while r:
        quotient, new_r = divrem(old_r, r)
        old_r, r = r, new_r
        old_a, a = a, ps(old_a, pm(quotient, a))
        old_b, b = b, ps(old_b, pm(quotient, b))
    scalar = fi(old_r[-1])
    g, aa, bb = scale(old_r, scalar), scale(old_a, scalar), scale(old_b, scalar)
    assert pa(pm(aa, p), pm(bb, q)) == g
    return g, aa, bb


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    workspace = Path(__file__).resolve().parents[1]
    output = args.output.resolve()
    if output == workspace or workspace in output.parents:
        raise ValueError("raw output must be outside litt3")
    start = time.monotonic()
    polynomial = [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]
    d = 23
    q0 = [fa(1, d), 2, 1]
    p9 = polynomial[9]  # P(U-1)'s degree9 coefficient, since 10=0.
    first = pd(polynomial)
    second = pd(first)
    gates = []
    for label, sigma in (("plus", 1), ("minus", 4)):
        target = ps(pm(q0, second), scale(first, fm(fm(2, sigma), p9)))
        gcd, bezout_p, bezout_target = egcd(polynomial, target)
        assert divrem(polynomial, gcd)[1] == []
        assert divrem(target, gcd)[1] == []
        gates.append({"sign": label, "sigma_encoded": sigma,
                      "target_ascending": target,
                      "gcd_monic_ascending": gcd,
                      "bezout_P_ascending": bezout_p,
                      "bezout_target_ascending": bezout_target})
    payload = {
        "schema": "litt3.new_exact_monomial_endpoint_derivative_gcd.v1",
        "scope": "Necessary actual monomial conductor endpoint jet gate; not a source construction",
        "field": {"characteristic": 5, "alpha_relation": "alpha^2=alpha+3", "encoding": "5*a+b represents b+a*alpha"},
        "P_ascending": polynomial, "d": d, "q0_ascending": q0,
        "p9_translated_P": p9, "P_prime_ascending": first,
        "P_second_ascending": second,
        "target": "q0*P_second - 2*sigma*p9*P_prime, sigma=+/-1",
        "signed_gates": gates,
        "checks": {"all_divisions_reconstructed": True, "bezout_identity_exact": True, "gcd_divides_both": True},
        "threads": 1, "source_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "elapsed_seconds": time.monotonic() - start,
    }
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(payload, indent=2) + "\n")
    print(json.dumps({"gates": [{"sign": g["sign"],
                      "gcd_degree": len(g["gcd_monic_ascending"])-1,
                      "gcd_monic": g["gcd_monic_ascending"],
                      "target_degree": len(g["target_ascending"])-1} for g in gates],
                      "output": str(output),
                      "elapsed_seconds": payload["elapsed_seconds"]}))


if __name__ == "__main__":
    main()
