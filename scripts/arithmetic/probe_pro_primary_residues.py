#!/usr/bin/env sage-python
"""Exact bounded residual tests; no assertion about untested primes or groups."""
import ast
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, ZZ, gcd, lcm

root = Path(__file__).resolve().parents[2]
tree = ast.parse((root / "scripts/arithmetic/check_degree2_frobenius_orbits.py").read_text())
coefficients = next(ast.literal_eval(node.value) for node in tree.body
                    if isinstance(node, ast.Assign)
                    and any(isinstance(t, ast.Name) and t.id == "coefficients"
                            for t in node.targets))
backup = [15625, -1000, 182, -8, 1]

def residue_orders(coeffs, prime):
    ring = PolynomialRing(GF(prime), "t")
    out = []
    for poly, multiplicity in ring(coeffs).factor():
        degree = int(poly.degree())
        if degree == 1:
            value = -poly[0] / poly[1]
        else:
            field = GF(prime**degree, "a", modulus=poly)
            value = field.gen()
        order = int(value.multiplicative_order())
        out.append({"degree": degree, "multiplicity": int(multiplicity),
                    "order": order})
    return out

rows = []
for prime in (2, 3, 7, 11, 13, 17, 19, 23, 29, 31):
    xdata = residue_orders(coefficients, prime)
    ydata = residue_orders(backup, prime)
    # The common base is F_(5^6): X Frobenius is pi_25^3,
    # backup Frobenius is pi_125^2. Unipotent prime-power factors
    # of the actual torsion Frobenius order do not affect this test.
    xorders = [v["order"] // int(gcd(v["order"], 3)) for v in xdata]
    yorder = int(lcm([v["order"] // int(gcd(v["order"], 2)) for v in ydata]))
    roots = 6 // int(prime**ZZ(6).valuation(prime))
    gsp = prime**4 * (prime - 1) * (prime**2 - 1) * (prime**4 - 1)
    xorder = int(lcm(xorders))
    yorders = [v["order"] // int(gcd(v["order"], 2)) for v in ydata]
    rows.append({"prime": prime, "x_factors": xdata, "y_factors": ydata,
                 "backup_y_semisimple_order": yorder,
                 "backup_x_orders": xorders,
                 "backup_x_semisimple_order": xorder,
                 "backup_y_orders": yorders,
                 "reverse_backup_excluded": any((2*xorder) % o for o in yorders),
                 "backup_excluded": any((roots*yorder) % o for o in xorders),
                 "main_universal_excluded": any((roots*gsp) % v["order"] for v in xdata),
                 "universal_for_b3": any((roots*gsp) % o for o in xorders)})

print(json.dumps({"rows": rows,
                  "scope": "Residual necessary conditions for prime-group Galois closures only; no general mixed-prime exclusion"}, indent=2))
