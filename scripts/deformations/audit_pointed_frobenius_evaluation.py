#!/usr/bin/env sage -python
"""Bounded independent height-three evaluation audit: torsion0 only.

Rebuild at two Laurent precisions, use a different field embedding and
node order, and retain the receipt outside the research workspace.
"""
import hashlib
import itertools
import json
from pathlib import Path
import sys
import time

from sage.all import GF, matrix, vector
from sage.repl.preparse import preparse

workspace = Path(__file__).resolve().parents[2]
source = workspace / "scripts/deformations/verify_pointed_extensions.sage"
evaluator = workspace / "scripts/deformations/probe_pointed_frobenius.py"
data = workspace.parent / "litt3-computation-data/unmarked_extension_spectrum_20260915"
original_receipt = data / "height3_evaluation_resultant.json"
output = data / "height3_torsion0_independent_audit.json"
source_text = source.read_text()
prefix = source_text.split("\ndef verify_block(block):", 1)[0]
assert prefix.count("P = 25") == 1
assert prefix.count("precision = 6*P+30") == 1
baseline = json.loads(original_receipt.read_text())
assert baseline["source_sha256"] == hashlib.sha256(source.read_bytes()).hexdigest()
assert baseline["height"] == 3 and baseline["P"] == 125


def build(extra):
    # Use the old builder in isolation, with its full Sage global context.
    import sage.all
    env = dict(vars(sage.all))
    saved = sys.argv
    sys.argv = [str(source)]
    try:
        text = prefix.replace("P = 25", "P = 125").replace(
            "precision = 6*P+30", "precision = 6*P+30+" + str(extra))
        exec(preparse(text), env)
    finally:
        sys.argv = saved
    return env["k"], env["build_blocks"](0), int(env["precision"])


def source_code(c):
    return sum(int(v) * 5**i for i, v in enumerate(c.polynomial()))


def block_hash(block):
    body = [[[source_code(c) for c in row] for row in A.rows()]
            for A in block["matrices"]]
    return hashlib.sha256(json.dumps(body, separators=(",", ":")).encode()).hexdigest()


started = time.monotonic()
ks0, low, low_precision = build(0)
ks, high, high_precision = build(80)
assert ks == ks0 and len(low) == len(high) == 2
for L, H in zip(low, high):
    assert L["weights"] == H["weights"] and L["exponents"] == H["exponents"]
    assert all(A == B for A, B in zip(L["matrices"], H["matrices"]))

kc = GF(125, "b")
old_root = ks.modulus().change_ring(kc).roots(multiplicities=False)[0]
root = old_root**5
assert root != old_root and root**3 + root + 1 == 0
embedding = ks.hom([root], kc)
inverse = {embedding(c): c for c in ks}
assert len(inverse) == 125 and all(inverse[embedding(c)] == c for c in ks)
for a in ks:
    for b in ks:
        assert embedding(a+b) == embedding(a)+embedding(b)
        assert embedding(a*b) == embedding(a)*embedding(b)
nodes = list(reversed(list(kc)))
node_codes = [source_code(inverse[c]) for c in nodes]
assert len(set(node_codes)) == 125 and node_codes != baseline["node_codes_in_order"]
report = dict(
    kind="independent_height3_two_block_evaluation_audit",
    source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),
    evaluator_current_sha256=hashlib.sha256(evaluator.read_bytes()).hexdigest(),
    original_receipt_sha256=hashlib.sha256(original_receipt.read_bytes()).hexdigest(),
    audit_script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    torsion=0, P=125, baseline_precision=low_precision,
    increased_precision=high_precision,
    all_source_coefficients_equal_at_both_precisions=True,
    embedding="Frobenius conjugate of original first root",
    inverse_field_roundtrips=125, field_sum_product_checks=125*125,
    calculation_modulus=[int(c) for c in kc.modulus().list()],
    calculation_basis_in_original_codes=[source_code(inverse[kc.gen()**i]) for i in range(3)],
    node_codes_in_order=node_codes, blocks=[])


def checkpoint():
    output.write_text(json.dumps(report, indent=2, default=int) + "\n")


checkpoint()
for index, block in enumerate(high):
    B = [matrix(kc, A.nrows(), A.ncols(), [embedding(c) for c in A.list()])
         for A in block["matrices"]]
    n = int(B[0].ncols())
    assert all(A.nrows() == n+2 and A.ncols() == n for A in B)
    q = (n+1)*(n+2)//2
    pairs = list(itertools.combinations(range(n+2), 2))
    assert len(pairs) == q and len(nodes) >= n+1
    rows = []
    for total in range(n+1):
        for i in range(total+1):
            j = total-i
            M = B[0]+nodes[i]*B[1]+nodes[j]*B[2]
            kernel = M.left_kernel().basis()
            assert len(kernel) == 2 and all((v*M).is_zero() for v in kernel)
            u, v = kernel
            row = [u[a]*v[b]-u[b]*v[a] for a, b in pairs]
            assert any(row)
            rows.append(row)
            if total == 0:
                point = [ks(1), inverse[nodes[i]], inverse[nodes[j]]]
                original = sum((c*A for c, A in zip(point, block["matrices"])),
                               matrix(ks, n+2, n))
                sparse = matrix(ks, n+2, n, original.list(), sparse=True)
                generic_kernel = sparse.left_kernel()
                pulled = [vector(ks, [inverse[c] for c in w]) for w in kernel]
                assert generic_kernel.dimension() == 2
                assert all((w*sparse).is_zero() for w in generic_kernel.basis())
                assert all((w*sparse).is_zero() for w in pulled)
                assert matrix(ks, pulled, sparse=True).rank() == 2
        if len(rows) % 256 < total+1:
            report["active"] = dict(block=index, completed_nodes=len(rows), total_nodes=q)
            checkpoint()
    values = matrix(kc, rows)
    assert values.nrows() == values.ncols() == q
    rank = int(values.rank())
    assert rank == q
    old = next(b for b in baseline["blocks"] if b["torsion"] == 0 and b["block"] == index)
    assert old["columns"] == n and old["coefficient_size"] == q and old["rank"] == rank
    record = dict(block=index, columns=n, coefficient_size=q, rank=rank,
                  source_coefficient_sha256=block_hash(block),
                  all_node_kernel_products_zero=True,
                  independent_source_sparse_node_check=True,
                  matches_original_rank=True, seconds=round(time.monotonic()-started, 3))
    report["blocks"].append(record)
    report.pop("active", None)
    checkpoint()
    print(json.dumps(record), flush=True)
report["verdict"] = "PASS: both complete P125 torsion0 blocks retain geometric constant rank."
checkpoint()
print(report["verdict"], flush=True)
