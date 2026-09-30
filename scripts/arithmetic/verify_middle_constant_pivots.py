#!/usr/bin/env python3
"""Check every retained constant-pivot identity, including its boundary scope."""
import argparse
import hashlib
import json
from pathlib import Path

from sage.all import GF, PolynomialRing


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("original", type=Path)
    ap.add_argument("reduced", type=Path)
    ap.add_argument("--output", type=Path, required=True)
    args = ap.parse_args()
    a = json.loads(args.original.read_text())
    b = json.loads(args.reduced.read_text())
    assert b["input_sha256"] == hashlib.sha256(args.original.read_bytes()).hexdigest()
    k = GF(25, "a", modulus=PolynomialRing(GF(5), "v")([2, 4, 1]))
    R = PolynomialRing(k, a["variables"], order="degrevlex")
    equations = [R(f) for f in a["equations"]]
    variables = list(a["variables"])
    for step in b["elimination_steps"]:
        name = step["variable"]
        assert name in variables
        v = R(name)
        weights = [k(w) for w in step["row_combination"]]
        replacement = R(step["replacement"])
        assert len(weights) == len(equations)
        combination = sum(w * f for w, f in zip(weights, equations))
        assert combination == v - replacement
        assert combination.derivative(v) == 1
        assert replacement.degree(v) <= 0
        equations = [f.subs({v: replacement}) for f in equations]
        equations = [f for f in equations if f]
        variables.remove(name)
    assert variables == b["variables"]
    assert equations == [R(f) for f in b["equations"]]
    assert all(f.degree(R(v)) <= 0 for v in a["variables"] if v not in variables
               for f in equations)
    receipt = {
        "status": "PASS",
        "scope": "Every recorded elimination is an isomorphism of geometric solution schemes; no parameter inversion or discarded boundary.",
        "original_sha256": hashlib.sha256(args.original.read_bytes()).hexdigest(),
        "reduced_sha256": hashlib.sha256(args.reduced.read_bytes()).hexdigest(),
        "steps": len(b["elimination_steps"]), "retained_variables": len(variables),
    }
    args.output.write_text(json.dumps(receipt, indent=2) + "\n")
    print("PASS", receipt["steps"], "global eliminations", receipt["retained_variables"],
          "retained variables", flush=True)


if __name__ == "__main__":
    main()
