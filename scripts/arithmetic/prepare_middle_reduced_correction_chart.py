#!/usr/bin/env python3
"""Prepare a geometric middle chart after verified polynomial elimination.

The certificate must eliminate all seven correction variables on the
entire normalized source stratum. Only the map scale is then normalized;
no extra determinant, generic-fiber or finite-field condition is imposed.
"""
import argparse
import hashlib
import json
from pathlib import Path

from sage.all import GF, PolynomialRing, matrix


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("certificate", type=Path)
    ap.add_argument("verification", type=Path)
    ap.add_argument("--degree", type=int, choices=range(8), required=True)
    ap.add_argument("--output", type=Path, required=True)
    args = ap.parse_args()
    c = json.loads(args.certificate.read_text())
    v = json.loads(args.verification.read_text())
    assert c["status"] == "COMPLETE" and c["eliminated_correction_rank"] == 7
    assert v["status"] == "PASS"
    digest = hashlib.sha256(args.certificate.read_bytes()).hexdigest()
    assert v["certificate_sha256"] == digest
    k = GF(25, "a", modulus=PolynomialRing(GF(5), "v")([2, 4, 1]))
    dec = lambda z: k(int(z) % 5) + k(int(z) // 5) * k.gen()
    d = args.degree
    names = c["variables"] + [f"p{i}" for i in range(d)]
    R = PolynomialRing(k, names, order="degrevlex")
    n = len(c["variables"])
    p = [R(f"p{i}") if i < d else R.one() if i == d else R.zero() for i in range(8)]
    equations = []
    for row in c["reduced_pencil"]:
        f = R.zero()
        for i, entry in enumerate(row):
            coeff = R({tuple(e) + (0,) * d: dec(a) for e, a in entry})
            f += coeff * p[i]
        equations.append(f)
    monomials = sorted({e for f in equations for e in f.dict()})
    columns = {e: i for i, e in enumerate(monomials)}
    coeffs = matrix(k, len(equations), len(monomials))
    for r, f in enumerate(equations):
        for e, a in f.dict().items():
            coeffs[r, columns[e]] = a
    selected = list(coeffs.transpose().pivots())
    equations = [equations[i] for i in selected]
    receipt = {
        "status": "PREPARED",
        "scope": "Scheme-equivalent necessary middle incidence with all seven correction variables eliminated globally; positive solutions still require full ranks, stability and actual return conditions.",
        "source_stratum": c["source_stratum"], "polynomial_degree": d,
        "certificate_sha256": digest,
        "verification_sha256": hashlib.sha256(args.verification.read_bytes()).hexdigest(),
        "variables": names, "equations": [str(f) for f in equations],
        "constant_selected_rows": selected,
        "max_degree": max((f.total_degree() for f in equations), default=-1),
        "terms": sum(len(f.dict()) for f in equations),
    }
    args.output.write_text(json.dumps(receipt, separators=(",", ":")) + "\n")
    print("PREPARED", len(names), "variables", len(equations), "equations",
          "degree", receipt["max_degree"], "terms", receipt["terms"], flush=True)


if __name__ == "__main__":
    main()
