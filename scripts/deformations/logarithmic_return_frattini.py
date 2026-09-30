#!/usr/bin/env sage-python
"""Exact finite-quotient experiment for the stabilizer of dt/(1+t).

Run with sage -python.  Elements are units u=1+O(t), acting by
phi_u(t)=(1+t)u(t)^p-1.  The stored cutoff is on u, not on phi_u.
The group law u*v=u(t)v(phi_u(t)) is exact modulo t^(N+1).
This is a formal group calculation; no geometric realization is claimed.
"""

from sage.all import GF, PowerSeriesRing
import argparse
import json
import time
from pathlib import Path


def calculate(n, p=5, model="ordinary"):
    started = time.monotonic()
    precision = n + 1 if model == "ordinary" else 2 * n + 1
    ring = PowerSeriesRing(GF(p), "t", default_prec=precision + 4)
    t = ring.gen()
    one = ring(1).add_bigoh(precision)

    def clean(u):
        return ring(u).add_bigoh(precision)

    def substitution(u):
        if model == "ordinary":
            return clean((1 + t) * u**p - 1)
        # q=(1+t^3)/(1-t^3); q(phi)=q*u^p.  Only low digits of u
        # affect phi at the stored precision, so this lift is harmless.
        lift = ring(u.truncate()).add_bigoh(precision + 4)
        q = (1 + t**3) / (1 - t**3)
        qu = q * lift**p
        cube = ((qu - 1) / (qu + 1)) >> 3
        root = ring(1).add_bigoh(precision)
        accuracy = 1
        while accuracy < precision:
            root = clean((2 * root + cube / root**2) / 3)
            accuracy *= 2
        phi = clean(t * root)
        assert clean(phi(-t) + phi) == 0
        return phi

    def multiply(u, v):
        phi = substitution(u)
        return clean(u * v(phi))

    def inverse(u):
        phi = substitution(u)
        return clean((one / u)(phi.reverse(precision=precision)))

    def power(u, exponent):
        if exponent < 0:
            return power(inverse(u), -exponent)
        ans = one
        while exponent:
            if exponent & 1:
                ans = multiply(ans, u)
            u = multiply(u, u)
            exponent >>= 1
        return ans

    indices = (list(range(1, n + 1)) if model == "ordinary"
               else list(range(1, 2 * n, 2)))
    generators = ([clean(1 + t**i) for i in indices]
                  if model == "ordinary" else
                  [clean((1 + 3 * t**i) / (1 - 3 * t**i)) for i in indices])
    generator_inverses = [inverse(u) for u in generators]
    basis = {}
    inverse_powers = {}
    queue = []
    statistics = {"sifts": 0, "nonzero_insertions": 0}

    def insert(u):
        statistics["sifts"] += 1
        while u != one:
            i = int((u - one).valuation())
            assert i in indices
            a = int(u[i])
            if i not in basis:
                u = power(u, pow(a, -1, p))
                assert int(u[i]) == 1
                basis[i] = u
                inverse_powers[i] = [power(u, -j) for j in range(p)]
                queue.append(i)
                statistics["nonzero_insertions"] += 1
                return
            u = multiply(u, inverse_powers[i][a])

    for u in generators:
        insert(power(u, p))
    for i, u in enumerate(generators):
        for j in range(i):
            v = generators[j]
            insert(multiply(multiply(generator_inverses[i], generator_inverses[j]),
                            multiply(u, v)))

    # Normal closure and power closure make the collected basis a subgroup.
    while queue:
        i = queue.pop(0)
        u = basis[i]
        ui = inverse(u)
        insert(power(u, p))
        for v, vi in zip(generators, generator_inverses):
            insert(multiply(multiply(ui, vi), multiply(u, v)))

    # Independent closure pass after the basis has stopped changing.
    before = len(basis)
    for u in list(basis.values()):
        insert(power(u, p))
        ui = inverse(u)
        for v, vi in zip(generators, generator_inverses):
            insert(multiply(multiply(ui, vi), multiply(u, v)))
    assert not queue and len(basis) == before

    # Check the group model and inverses on every standard generator.
    for u, ui in zip(generators, generator_inverses):
        assert multiply(u, ui) == one == multiply(ui, u)
        phi = substitution(u)
        if model == "ordinary":
            assert clean(phi.derivative() * (1 + t) - (1 + phi)) == 0
        else:
            q = (1 + t**3) / (1 - t**3)
            assert clean(q(phi) - q * u**p) == 0

    missing = [i for i in indices if i not in basis]
    return {
        "prime": p,
        "model": model,
        "unit_cutoff": n,
        "group_order_log_p": n,
        "frattini_order_log_p": len(basis),
        "generator_rank": len(missing),
        "frattini_pivots": sorted(basis),
        "quotient_pivots": missing,
        "closure_verified": True,
        "statistics": statistics,
        "elapsed_seconds": round(time.monotonic() - started, 3),
        "scope": "formal stabilizer only; no proper-curve realization",
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("cutoffs", type=int, nargs="+")
    parser.add_argument("--out", type=Path, required=True)
    parser.add_argument("--model", choices=["ordinary", "supersingular"],
                        default="ordinary")
    args = parser.parse_args()
    results = []
    for n in args.cutoffs:
        result = calculate(n, model=args.model)
        results.append(result)
        print(json.dumps(result), flush=True)
        args.out.parent.mkdir(parents=True, exist_ok=True)
        args.out.write_text(json.dumps(results, indent=2) + "\n")
