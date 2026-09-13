#!/usr/bin/env python3
"""Check literal inline polynomials against the audited returned reconstruction.

Arguments: extracted Pro source directory, optional output JSON path.
This is not a fourth-level geometric replay.
"""
import ast
import contextlib
import hashlib
import io
import json
from pathlib import Path
import re
import sys

source = Path(sys.argv[1]).resolve()
sys.path.insert(0, str(source))
with contextlib.redirect_stdout(io.StringIO()):
    import low_quadratic_projections as g

root = Path(__file__).resolve().parents[3]
path = root / "Research/requests/rank125_critical_fourth_branch_request.md"
body = path.read_text()


class Poly:
    def __init__(self, terms):
        self.terms = terms

    def __add__(self, other):
        return Poly(g.pa(self.terms, other.terms))

    def __mul__(self, other):
        return Poly(g.pm(self.terms, other.terms))

    def __pow__(self, power):
        result = Poly({(0, 0, 0): 1})
        for _ in range(power):
            result = result * self
        return result


def field(code):
    assert 0 <= code < 125
    return Poly({(0, 0, 0): code})


env = {"field": field}
for i in range(3):
    mon = tuple(int(i == j) for j in range(3))
    env[f"s{i+1}"] = Poly({mon: 1})


def literal(name):
    match = re.search(r"(?m)^  " + name + r"=(.*?)(?=,?\n  [A-Za-z0-9]+[ =]|\n\n)", body, re.S)
    assert match, name
    expression = match.group(1).strip().rstrip(",.").replace("\n", " ")
    expression = re.sub(r"\[(\d+)\]", r"field(\1)*", expression)
    expression = expression.replace("^", "**")
    expression = re.sub(r"(\d)\(", r"\1*(", expression)
    assert re.fullmatch(r"[\w\s+*(),]+", expression), expression
    return eval(expression, {"__builtins__": {}}, env).terms


q, f4 = literal("q2"), literal("f4")
h5, h7, g3 = literal("H5"), literal("H7"), literal("g3")
assert q == g.f2 and f4 == g.f4
assert g.pm(q, h5) == {}
assert g.pa(g.pm(q, h7), g.pm(f4, h5)) == {}
root_code = 93  # 3+3t+3t^2
assert h5 == g.ps(g.pm(q, g3), root_code)
assert g.pm(q, g.pm(q, g3)) == {}
assert g.pm(q, g3)

data = json.loads((source / "results/low_quadratic_projections.json").read_text())
receipt = json.loads((source / "results/first_carry_diagnostic.json").read_text())
params = receipt["low_equation_candidate_transported_parameters"]


def decode(poly):
    return {ast.literal_eval(m): c for m, c in poly.items()}


def combination(coeffs, polys):
    result = {}
    for c, p in zip(coeffs, polys):
        result = g.pa(result, g.ps(decode(p), c))
    return result


assert h5 == combination(params[:4], data["source_degree5_basis"])
assert not combination(params[4:10], data["source_degree6_basis"])
expected_h7 = g.pa(
    combination(params[:4], data["source_degree7_corrections"]),
    combination(params[10:], data["source_degree7_basis"]),
)
assert h7 == expected_h7

equations_checked = 0
for degree, equations in data["equations"].items():
    for eq in equations.values():
        value = 0
        for key, coefficient in eq["linear"].items():
            index = ast.literal_eval(key)
            value = g.ADD[value][g.MUL[coefficient][params[index]]]
        for key, coefficient in eq["quadratic"].items():
            i, j = ast.literal_eval(key)
            term = g.MUL[coefficient][g.MUL[params[i]][params[j]]]
            value = g.ADD[value][term]
        assert value == 0, (degree, value)
        equations_checked += 1

assert "http" not in body and "sandbox:" not in body
assert "ONE ZIP only" in body
record = {
    "status": "PASS: literal inline finite data and low equations",
    "prompt_bytes": len(path.read_bytes()),
    "prompt_sha256": hashlib.sha256(path.read_bytes()).hexdigest(),
    "jet_monomials": {"H5": len(h5), "H7": len(h7)},
    "low_equations_checked": equations_checked,
    "attachments_required": False,
    "not_checked": "actual full fourth obstruction or solvability of the completion family",
}
encoded = json.dumps(record, indent=2) + "\n"
if len(sys.argv) > 2:
    Path(sys.argv[2]).write_text(encoded)
print(encoded, end="")
