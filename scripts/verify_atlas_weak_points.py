#!/usr/bin/env python3
"""Exact small positive certificates: weak points, NOT normalized atlases.

Python standard library only; replay the original tensor, not solver rows.
F25 is F5[a]/(a^2+4a+2), encoded c0+5*c1. Coefficient fifth roots
equal coefficient fifth powers here; this does NOT restrict unknown fields.
"""
import ast
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RECORD = ROOT / "Research/computations/atlas_weak_points.json"


def add(x, y):
    return (x % 5 + y % 5) % 5 + 5 * ((x // 5 + y // 5) % 5)


def neg(x):
    return (-x % 5) + 5 * ((- (x // 5)) % 5)


def mul(x, y):
    a, b, c, d = x % 5, x // 5, y % 5, y // 5
    return (a*c + 3*b*d) % 5 + 5*((a*d + b*c + b*d) % 5)


def power(x, n):
    result = 1
    while n:
        if n & 1:
            result = mul(result, x)
        x = mul(x, x)
        n >>= 1
    return result


def parse(value):
    def visit(node):
        if isinstance(node, ast.Constant) and type(node.value) is int:
            return node.value % 5
        if isinstance(node, ast.Name) and node.id == "a":
            return 5
        if isinstance(node, ast.UnaryOp) and isinstance(node.op, ast.USub):
            return neg(visit(node.operand))
        if isinstance(node, ast.BinOp):
            left = visit(node.left)
            if isinstance(node.op, ast.Pow):
                exponent = ast.literal_eval(node.right)
                assert type(exponent) is int and exponent >= 0
                return power(left, exponent)
            right = visit(node.right)
            if isinstance(node.op, ast.Add):
                return add(left, right)
            if isinstance(node.op, ast.Sub):
                return add(left, neg(right))
            if isinstance(node.op, ast.Mult):
                return mul(left, right)
        raise ValueError(ast.dump(node))
    return visit(ast.parse(str(value).replace("^", "**"), mode="eval").body)


def rank(rows):
    """Exact row rank over F25; only the small original coefficient matrices."""
    rows = [list(row) for row in rows]
    pivot = 0
    for col in range(len(rows[0])):
        selected = next((i for i in range(pivot, len(rows)) if rows[i][col]), None)
        if selected is None:
            continue
        rows[pivot], rows[selected] = rows[selected], rows[pivot]
        inverse = power(rows[pivot][col], 23)
        rows[pivot] = [mul(inverse, value) for value in rows[pivot]]
        for i in range(pivot + 1, len(rows)):
            factor = neg(rows[i][col])
            if factor:
                rows[i] = [add(x, mul(factor, y))
                           for x, y in zip(rows[i], rows[pivot])]
        pivot += 1
        if pivot == len(rows):
            break
    return pivot


def verify(record_path=RECORD):
    record = json.loads(Path(record_path).read_text())
    checked = verify_source(record)
    for source in record.get("additional_sources", []):
        checked.extend(verify_source(source))
    return checked


def verify_source(record):
    source = ROOT / record["source"]
    assert hashlib.sha256(source.read_bytes()).hexdigest() == record["source_sha256"]
    tensor = json.loads(source.read_text())
    cache = {}
    def root_coefficient(c):
        if c not in cache:
            cache[c] = power(parse(c), 5)
        return cache[c]
    checked = []
    for point in record["points"]:
        v = {int(i): c for i, c in point["v_sparse"].items()}
        b = {int(i): c for i, c in point["b_sparse"].items()}
        assert all(0 <= i < 32 and 0 < c < 25 for d in (v, b) for i, c in d.items())
        values = {}
        for name, count in (("N_tensor", 64), ("R_tensor", 32)):
            values[name] = []
            for row in range(count):
                total = 0
                for i, vi in v.items():
                    for j, bj in b.items():
                        total = add(total, mul(root_coefficient(tensor[name][i][row][j]), mul(vi, bj)))
                values[name].append(total)
        chart = point["chart"]
        s = values["R_tensor"]
        assert not any(values["N_tensor"])
        assert all(b.get(i, 0) == 0 and s[i] == 0 for i in range(chart))
        assert b.get(chart, 0) == s[chart] == 1
        full_r = all(power(s[i], 5) == b.get(i, 0) for i in range(32))
        normalization = 0
        for i, vi in v.items():
            normalization = add(normalization, mul(power(vi, 5), b.get(i, 0)))
        assert full_r == point["full_fixed_point"]
        assert normalization == point["normalization"] != 2
        family = {}
        if "fixed_b_affine_dimension" in point:
            # At fixed b, the ENTIRE weak fixed-point system is linear in v:
            # n_b v=0 and s_b v=b^[1/5]. These are original tensor rows.
            matrices = {}
            for name, count in (("N_tensor", 64), ("R_tensor", 32)):
                rows = []
                for row in range(count):
                    values = []
                    for i in range(32):
                        total = 0
                        for j, bj in b.items():
                            total = add(total, mul(root_coefficient(tensor[name][i][row][j]), bj))
                        values.append(total)
                    rows.append(values)
                matrices[name] = rows
            N, R = matrices["N_tensor"], matrices["R_tensor"]
            ell = [power(b.get(i, 0), 5) for i in range(32)]
            rank_n, rank_nr = rank(N), rank(N + R)
            # ell in rowspan(N) forces (v.ell)^5=U.b=0 on the whole N fiber.
            assert rank(N + [ell]) == rank_n
            assert full_r and 32 - rank_nr == point["fixed_b_affine_dimension"]
            family = dict(fixed_b_affine_dimension=32-rank_nr,
                          rank_N=rank_n, rank_NR=rank_nr,
                          normalization_zero_on_entire_N_fiber=True)
        checked.append(dict(representative=record["representative"], chart=chart,
                            source_sha256=record["source_sha256"], full_fixed_point=full_r,
                            normalization=normalization, atlas=False, **family))
    return checked


if __name__ == "__main__":
    print(json.dumps(verify(), indent=2))
    print("PASS: weak-only contradictions impossible on these charts; NO atlas certified.")
