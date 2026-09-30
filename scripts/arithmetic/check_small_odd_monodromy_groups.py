#!/usr/bin/env sage-python
"""Bounded group/arithmetic check for small_odd_monodromy_exclusion.

This does not construct curves or test unrestricted Galois groups.
The Frobenius polynomial is inherited from the existing exact certificate.
Run with sage -python and redirect JSON outside the research workspace.
"""
import ast
import json
from pathlib import Path

from sage.all import GF, PolynomialRing, ZZ
from sage.libs.gap.libgap import libgap

root = Path(__file__).resolve().parents[2]
tree = ast.parse((root / "scripts/arithmetic/check_degree2_frobenius_orbits.py").read_text())
coefficients = next(ast.literal_eval(node.value) for node in tree.body
                    if isinstance(node, ast.Assign)
                    and any(isinstance(t, ast.Name) and t.id == "coefficients"
                            for t in node.targets))
ring = PolynomialRing(GF(2), "x")
poly = ring(coefficients)
assert poly.is_irreducible()
field = GF(2**18, "a", modulus=poly)
assert field.gen().multiplicative_order() == 171
orders = {p: int(GF(19)(p).multiplicative_order()) for p in (2, 3, 5, 7)}
assert orders == {2: 18, 3: 18, 5: 9, 7: 3}

records = []
for degree in (3, 5, 7, 9):
    for index in range(1, int(libgap.NrTransitiveGroups(degree)) + 1):
        group = libgap.TransitiveGroup(degree, index)
        size = int(group.Size())
        odd = size // (2 ** ZZ(size).valuation(2))
        if odd != degree:
            continue
        fitting = group.FittingSubgroup()
        stabilizer = libgap.Stabilizer(group, 1)
        assert bool(group.IsSolvable())
        assert int(fitting.Size()) == degree
        assert bool(fitting.IsAbelian())
        assert int(stabilizer.Size()) <= (16 if degree == 9 else degree - 1)
        assert int(libgap.AutomorphismGroup(group).Size()) % 19 != 0
        records.append({"degree": degree, "transitive_id": index,
                        "order": size, "fitting_order": int(fitting.Size()),
                        "stabilizer_order": int(stabilizer.Size())})

assert {r["degree"] for r in records} == {3, 5, 7, 9}
print(json.dumps({"status": "PASS", "frobenius_mod2_degree": 18,
                  "frobenius_mod2_order": 171, "orders_mod19": orders,
                  "groups": records,
                  "scope": "Finite verification of the small faithful Sylow quotients; no unrestricted cover verdict"}, indent=2))
