#!/usr/bin/env python3
"""Fresh 55 additive assertions on accepted stored branch roots only.

No root extraction, field multiplication, stabilizer replay or search.
"""
import hashlib
import itertools
import json
import time
from pathlib import Path


def main():
    workspace = Path(__file__).resolve().parents[2]
    source = workspace.parent / "litt3-computation-data" / "abelian_rigidity_20260922" / "branch_stabilizer.json"
    raw = source.read_bytes()
    stored = json.loads(raw)
    roots = stored["finite_roots_in_field_basis"]
    assert len(roots) == 10 and all(len(r) == 8 for r in roots)
    assert all(0 <= c < 5 for r in roots for c in r)
    start = time.process_time()
    pairs = list(itertools.combinations_with_replacement(range(10), 2))
    full = {}
    first_four = {}
    for i, j in pairs:
        key = tuple((roots[i][n]+roots[j][n]) % 5 for n in range(5))
        assert key not in full, (full.get(key), (i, j))
        full[key] = [i, j]
        first_four.setdefault(key[:4], []).append([i, j])
    collisions = [v for v in first_four.values() if len(v) > 1]
    assert len(full) == 55
    assert collisions == [[[0, 7], [1, 8]]]
    elapsed = time.process_time()-start
    receipt = {"scope": "Strong Sidon property of ten stored P-roots; no cover exclusion by itself",
               "stored_input": str(source), "stored_input_SHA256": hashlib.sha256(raw).hexdigest(),
               "root_first_five_coordinates": [r[:5] for r in roots],
               "unordered_sums_with_repetition": 55, "distinct_first_five_sums": len(full),
               "first_four_collisions": collisions,
               "CPU_seconds": elapsed, "status": "PASS_STRONG_SIDON"}
    out = workspace.parent / "litt3-computation-data" / "oct03_fixed_x_branch_sidon_gate" / "sidon.json"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(receipt, indent=2)+"\n")
    print(json.dumps({"output": str(out), "CPU_seconds": elapsed, "status": receipt["status"]}))


if __name__ == "__main__":
    main()
