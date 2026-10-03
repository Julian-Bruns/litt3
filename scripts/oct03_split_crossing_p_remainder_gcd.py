#!/usr/bin/env python3
"""One tiny exact GF(25) P-remainder/gcd certificate; no enumeration.

Inputs: a^2=a+3, encoding [5*A+B]=B+A*a, actual fixed P ascending
[11,22,18,5,19,20,15,16,9,22,1], d=[23].  The sole polynomial target
is (x+1)^2-3*d.  This NEW source has no imported prior certificate and
must be run only after root inspection/lease, under an external 15s cap.
All generated output belongs outside the litt3 workspace.
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
    return (-a % 5) % 5 + 5 * ((-(a // 5)) % 5)


def sub(a, b):
    return add(a, neg(b))


def mul(a, b):
    ar, ai = a % 5, a // 5
    br, bi = b % 5, b // 5
    return (ar * br + 3 * ai * bi) % 5 + 5 * (
        (ar * bi + ai * br + ai * bi) % 5
    )


def power(a, n):
    out = 1
    while n:
        if n & 1:
            out = mul(out, a)
        a = mul(a, a)
        n //= 2
    return out


def inverse(a):
    if a == 0:
        raise ZeroDivisionError("GF(25) inverse of zero")
    result = power(a, 23)
    assert mul(a, result) == 1
    return result


def trim(p):
    p = list(p)
    while p and p[-1] == 0:
        p.pop()
    return p


def padd(p, q):
    return trim([
        add(p[i] if i < len(p) else 0, q[i] if i < len(q) else 0)
        for i in range(max(len(p), len(q)))
    ])


def pneg(p):
    return trim([neg(c) for c in p])


def psub(p, q):
    return padd(p, pneg(q))


def pscale(p, c):
    return trim([mul(x, c) for x in p])


def pmul(p, q):
    if not p or not q:
        return []
    out = [0] * (len(p) + len(q) - 1)
    for i, a in enumerate(p):
        for j, b in enumerate(q):
            out[i + j] = add(out[i + j], mul(a, b))
    return trim(out)


def divide(p, q):
    p, q = trim(p), trim(q)
    if not q:
        raise ZeroDivisionError("polynomial division by zero")
    quotient = [0] * max(0, len(p) - len(q) + 1)
    leading_inverse = inverse(q[-1])
    while p and len(p) >= len(q):
        shift = len(p) - len(q)
        coeff = mul(p[-1], leading_inverse)
        quotient[shift] = add(quotient[shift], coeff)
        for j, b in enumerate(q):
            p[shift + j] = sub(p[shift + j], mul(coeff, b))
        p = trim(p)
    return trim(quotient), p


def extended_gcd(p, q):
    r0, r1 = trim(p), trim(q)
    s0, s1 = [1], []
    t0, t1 = [], [1]
    ledger = []
    while r1:
        quotient, remainder = divide(r0, r1)
        ledger.append({"quotient": quotient, "remainder": remainder})
        r0, r1 = r1, remainder
        s0, s1 = s1, psub(s0, pmul(quotient, s1))
        t0, t1 = t1, psub(t0, pmul(quotient, t1))
    unit = inverse(r0[-1])
    return pscale(r0, unit), pscale(s0, unit), pscale(t0, unit), ledger


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()
    output = args.output.resolve()
    workspace = Path(__file__).resolve().parent.parent
    if output == workspace or workspace in output.parents:
        raise ValueError("raw certificate must be outside litt3")
    started = time.perf_counter()

    # Encoding checks do not enumerate the field.
    assert mul(5, 5) == add(5, 3)  # a^2=a+3
    assert mul(D_CODE, D_CODE) == 2
    target = [sub(1, mul(3, D_CODE)), 2, 1]
    quotient, remainder = divide(P_CODES, target)
    gcd, bezout_p, bezout_target, ledger = extended_gcd(P_CODES, target)
    assert padd(pmul(target, quotient), remainder) == P_CODES
    assert len(remainder) < len(target)
    assert padd(pmul(P_CODES, bezout_p), pmul(target, bezout_target)) == gcd
    assert gcd == [1]

    # Switch from x to U=x+1 in the LINEAR remainder only.
    assert len(remainder) == 2
    rem_u = [sub(remainder[0], remainder[1]), remainder[1]]
    norm = sub(mul(rem_u[0], rem_u[0]),
               mul(mul(rem_u[1], rem_u[1]), mul(3, D_CODE)))
    assert norm != 0

    result = {
        "scope": "fixed P against (x+1)^2-3d only; no source realization",
        "field": {"characteristic": 5, "a_relation": "a^2=a+3",
                  "code": "[5*A+B]=B+A*a"},
        "P_ascending": P_CODES, "d": D_CODE,
        "target_ascending": target,
        "quotient_ascending": quotient,
        "remainder_x_ascending": remainder,
        "remainder_U_ascending": rem_u,
        "norm_over_U_squared_3d": norm,
        "gcd_ascending": gcd,
        "bezout_P_ascending": bezout_p,
        "bezout_target_ascending": bezout_target,
        "euclidean_ledger": ledger,
        "executed_checks": ["a relation", "d squared", "division identity",
                            "remainder degree", "Bezout identity", "gcd one",
                            "linear U remainder norm nonzero"],
        "source_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "python_version": platform.python_version(),
        "workers": 1,
        "elapsed_seconds": time.perf_counter() - started,
    }
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps({"output": str(output), "remainder_x": remainder,
                      "remainder_U": rem_u, "gcd": gcd, "norm": norm,
                      "elapsed_seconds": result["elapsed_seconds"]}))


if __name__ == "__main__":
    main()
