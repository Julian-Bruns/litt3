#!/usr/bin/env sage-python
"""Bounded independent assembly checks for the backup small-signature audit.

Run with sage -python. This verifies the numerical census independently,
the complete double-cover Cartier list, original certificate/replay linkage,
and the complete tame/wild exclusion partition. It does not replace the
geometric arguments in BACKUP_CORED_COMPLETION_AUDIT_2026_09_11.md.
"""
from fractions import Fraction
from itertools import combinations, combinations_with_replacement
import hashlib
import json
from pathlib import Path
import sys
import time

from sage.all import GF, PolynomialRing


ROOT = Path(__file__).resolve().parents[1]
OUT = Path(sys.argv[1])
started = time.monotonic()


def read(path):
    return json.loads(Path(path).read_text())


def semantic(value):
    if isinstance(value, dict):
        return {key: semantic(item) for key, item in value.items()
                if key not in {"elapsed_seconds", "scope"}}
    if isinstance(value, list):
        return [semantic(item) for item in value]
    return value


links = {}
for fresh, old in [
    ("preparation", "backup_genus_two_preparation"),
    ("torsion", "backup_genus_two_torsion"),
    ("cyclic", "backup_genus_two_cyclic_covers"),
    ("twisted", "backup_genus_two_twisted_tangents"),
    ("tame444", "backup_genus_two_tame444"),
]:
    a = OUT / (fresh + ".json")
    b = ROOT / "Research/computations" / (old + ".json")
    assert semantic(read(a)) == semantic(read(b)), fresh
    links[fresh] = {"replay": str(a), "input": str(b),
                    "replay_sha256": hashlib.sha256(a.read_bytes()).hexdigest(),
                    "input_sha256": hashlib.sha256(b.read_bytes()).hexdigest()}

prep = read(OUT / "preparation.json")
tame = set()
for n in range(2, 85):
    ds = [d for d in range(2, n + 1) if n % d == 0 and d % 5]
    for count in range(3, 7):
        for orders in combinations_with_replacement(ds, count):
            if sum((Fraction(1, d) for d in orders), Fraction()) == count - 2 - Fraction(2, n):
                tame.add((n, orders))
assert tame == {(row["n_C"], tuple(row["inertia"]))
                for row in prep["quotient_signatures"]["tame"]}

partition = {
    "degree_two_prym": [(2, (2, 2, 2, 2, 2, 2))],
    "two_weierstrass": [(3, (3, 3, 3, 3)), (4, (2, 2, 4, 4)),
                        (6, (3, 6, 6)), (8, (2, 8, 8))],
    "klein_four": [(4, (2, 2, 2, 2, 2))],
    "one_weierstrass_elliptic": [(6, (2, 2, 2, 6)), (9, (3, 3, 9)),
                                 (12, (2, 4, 12)), (18, (2, 3, 18))],
    "prym_translation": [(8, (2, 2, 2, 4))],
    "cyclic_ordinary": [(12, (3, 3, 6)), (12, (2, 6, 6)), (24, (2, 3, 12))],
    "four_torsion_secants": [(8, (4, 4, 4))],
    "quadrangular_hecke": [(6, (2, 2, 3, 3)), (12, (2, 2, 2, 3))],
    "triangle344": [(12, (3, 4, 4))],
    "radical_quadratic": [(16, (2, 4, 8)), (36, (2, 3, 9))],
    "hermitian_hessian": [(24, (3, 3, 4))],
    "triangle246": [(24, (2, 4, 6))],
    "triangle238": [(48, (2, 3, 8))],
    "triangle237_new_unit": [(84, (2, 3, 7))],
}
flat = [row for rows in partition.values() for row in rows]
assert len(flat) == len(set(flat)) == len(tame) == 24 and set(flat) == tame

wild = set()
for n in range(5, 281, 5):
    for e in range(5, n + 1, 5):
        if n % e or e % 25 == 0:
            continue
        t = e // 5
        for j in range(1, (e + 1) // 4 + 1):
            c = 4 * j - 1
            if j % 5 == 0 or (4 * j) % t or c >= e:
                continue
            for d in range(2, n + 1):
                if n % d == 0 and d % 5 and n * (Fraction(c, e) - Fraction(1, d)) == 2:
                    wild.add((n, e, e + c, d))
assert wild == {(row["n_C"], row["wild_order"], row["different"], row["other_tame_order"])
                for row in prep["quotient_signatures"]["small_wild_q5"]}
wild_partition = {
    "singleton_exact": [(10, 10, 17, 2), (20, 20, 27, 4), (40, 40, 47, 8)],
    "two_point_cyclic_exact": [(40, 20, 31, 2), (60, 30, 41, 3), (120, 60, 71, 6)],
    "reduced_dormant": [(20, 5, 8, 2)],
    "two_torsion_bol": [(40, 10, 13, 4)],
    "four_torsion_bol": [(80, 20, 23, 8)],
    "wild120": [(120, 20, 27, 3)],
    "wild240": [(240, 40, 47, 6)],
    "a7": [(280, 20, 23, 7)],
}
wflat = [row for rows in wild_partition.values() for row in rows]
assert len(wflat) == len(set(wflat)) == len(wild) == 12 and set(wflat) == wild

k = GF(125, name="a", modulus=PolynomialRing(GF(5), "z")([1, 1, 0, 1]))
a = k.gen()
ring = PolynomialRing(k, "u")
u = ring.gen()
F = u * (u - 1) * (u - 2) * (u - 3) * (u - a)
dec = lambda co: sum((k(c) * a**i for i, c in enumerate(co)), k.zero())
poly = lambda coefficients: ring([dec(co) for co in coefficients])
double_path = ROOT / "Research/computations/backup_genus_two_double_covers.json"
double_data = read(double_path)
branches = [k(0), k(1), k(2), k(3), a, None]
seen = set()
for row in double_data["covers"]:
    pair = tuple(row["branch_pair_indices"])
    assert pair not in seen
    seen.add(pair)
    A = ring.one()
    for index in pair:
        if branches[index] is not None:
            A *= u - branches[index]
    B, remainder = F.quo_rem(A)
    assert remainder == 0 and A.degree() in (1, 2) and B.degree() in (3, 4)
    assert A == poly(row["A_coefficients"]) and B == poly(row["elliptic_B_coefficients"])
    assert A.gcd(B) == 1 and A.is_squarefree() and B.is_squarefree()
    assert (B**2)[4] == dec(row["elliptic_Hasse_invariant"]) != 0
assert seen == set(combinations(range(6), 2))

for order in [8, 12, 16, 18, 24, 36]:
    data = read(OUT / f"order{order}.json")
    assert data["status"] == "all_nonbranch_points_of_order_dividing_N_excluded_exact_bezout"
    assert data["order"] == order and data["exact_bezout_sum_one_verified"]
    # Replay the final original-minor identity, not only its boolean flag.
    residual = ring.zero()
    for row, multiplier in zip(data["minors"], data["canonical_jet_bezout_multipliers"]):
        residual += poly(multiplier) * poly(row["removed_branch_factors"]) * poly(row["reduced_minor"])
    assert residual == F**data["canonical_jet_bezout_F_exponent"]

four = read(OUT / "four_torsion_verify.json")
assert four["status"].startswith("PASS") and four["order4_twisted_kernel_cases_verified"] == 1200
assert four["certificate_sha256"] == hashlib.sha256(
    (ROOT / "Research/computations/backup_genus_two_four_torsion.json").read_bytes()).hexdigest()

result = {"status": "PASS scoped backup cored small-packet assembly",
          "tame_count": 24, "wild_count": 12, "large_count": 2,
          "tame_partition": partition, "small_wild_partition": wild_partition,
          "fresh_replay_links": links,
          "double_input_sha256": hashlib.sha256(double_path.read_bytes()).hexdigest(),
          "double_covers_independently_rebuilt": 15,
          "one_point_orders_original_identities": [8, 12, 16, 18, 24, 36],
          "elapsed_seconds": time.monotonic() - started,
          "scope": "Numerical cases and certificate linkage, not the geometric or inherited theorem proofs."}
(OUT / "assembly_receipt.json").write_text(json.dumps(result, indent=2) + "\n")
print(json.dumps({key: result[key] for key in ["status", "tame_count", "wild_count", "large_count", "elapsed_seconds"]}, indent=2))
