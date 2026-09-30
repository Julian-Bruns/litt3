#!/usr/bin/env python3
"""Focused algebra checks for the second quadratic-flag batch.

Run with Sage Python. The supplied verified_results.json contains terminal
metadata, not the intermediate parabolic reconstruction. This program DOES
NOT verify the reported long Frobenius chains or terminal flag incidences.
It preserves that evidence and records exactly the bounded checks made here.
"""
import argparse
import hashlib
import json
from pathlib import Path

from sage.all import GF, PolynomialRing, matrix, vector


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("attachment", type=Path)
    args = parser.parse_args()
    out = (Path(__file__).resolve().parents[3]
           / "litt3-computation-data/contact_replies_20260923")
    out.mkdir(parents=True, exist_ok=True)
    raw = args.attachment.read_bytes()
    supplied = json.loads(raw)
    (out / "supplied_verified_results.json").write_bytes(raw)

    base = GF(5)
    K = GF(25, "a", modulus=PolynomialRing(base, "z")([2, 4, 1]))
    a = K.gen()
    R = PolynomialRing(K, "x")
    x = R.gen()
    decode = lambda n: K(n % 5) + (n // 5)*a
    poly = lambda row: R([decode(n) for n in row])
    P = poly([11,22,18,5,19,20,15,16,9,22,1])
    f4 = poly([8,2,21,11,1])
    g4 = poly([18,15,10,4,1])
    assert P == (x-decode(9))*(x-decode(14))*f4*g4
    assert f4.is_irreducible() and g4.is_irreducible()
    assert f4 != g4 and P.is_squarefree()

    witnesses = supplied["certificates"]
    assert [(v["point"], v["quotient"], v["iterate"]) for v in witnesses] == [
        (None,"A",871), (None,"B",16742), (9,"A",25736),
        (9,"B",3408), (14,"A",11343), (14,"B",2790)]
    for v in witnesses[1:]:
        d1, d2 = v["splitting_degrees"]
        twist = v["twist_t"]
        assert not poly(v["f"]) or poly(v["f"]).degree() <= d1+twist
        assert not poly(v["g"]) or poly(v["g"]).degree() <= d2+twist
        assert -3*twist+sum(v["source_weights"]) == 0

    # Quotient multiplication in primitives f=t, g=t^2+b*t^3+c*t^4.
    Q = PolynomialRing(base, ["b","c","s","u","v","tau"])
    b,c,s,u,v,tau = Q.gens()
    mu = matrix(Q, [[-b,2,s*(c*c-2*b*b*c)],
                    [-c,2*b,1-2*b*c*c*s]])
    kernel = vector(Q, [2-b*c*c*s-b**3*c*s,
                        b-c**3*s, 2*(c-b*b)])
    assert mu*kernel == vector(Q,[0,0])
    assert kernel[1]**2-kernel[0]*kernel[2] == c*(1-2*b**5*s+c**5*s*s)
    T = PolynomialRing(Q,"t")
    t = T.gen()
    f = t
    g = t*t+b*t**3+c*t**4
    wronskian = f.derivative()*g.derivative(2)-f.derivative(2)*g.derivative()
    assert wronskian == 2+b*t+2*c*t*t
    assert (wronskian**5).mod(t**5-s) == 2*(1-2*b**5*s+c**5*s*s)

    # Regular discriminant after the double-zero elementary modification.
    X0,Y0,Z0 = 2*u*u, tau*u*v, tau*v*v
    assert 2*Y0*Y0-tau*X0*Z0 == 0
    # Distinct split/double Smith types of the already established j map.
    j_double = matrix(Q, [[2,0,0],[0,3*tau,0],[0,0,tau]])
    assert j_double.det() == tau*tau

    result = {
        "status": "PASS: focused factorization, metadata and universal algebra only",
        "attachment_sha256": hashlib.sha256(raw).hexdigest(),
        "attachment_bytes": len(raw),
        "factorization": {
            "linear_codes": [9,14], "quartics": [[8,2,21,11,1],[18,15,10,4,1]],
            "irreducible_over_F25": True,
            "remaining_arithmetic_orbits": ["f4/A","f4/B","g4/A","g4/B"],
            "size_each": 4,
        },
        "terminal_metadata": "six rows match; five coarse degree bounds and parabolic source degrees pass",
        "quotient_multiplication_kernel_and_discriminant": True,
        "wronskian_fifth_power_identity": True,
        "double_zero_quadratic_conic": True,
        "NOT_verified": [
            "intermediate Frobenius reconstructions at exponents 871 through 25736",
            "terminal flag incidences or maps from terminal coordinates",
            "nonperiodicity of the remaining sixteen modifications",
            "existence or nonexistence of any actual common cover",
        ],
    }
    (out / "focused_checks.json").write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps(result,indent=2))


if __name__ == "__main__":
    main()
