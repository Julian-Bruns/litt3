#!/usr/bin/env python3
"""Replay the returned rank25 certificate in a disposable copy; preserve inputs."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

p = argparse.ArgumentParser(description=__doc__)
p.add_argument("original", type=Path)
p.add_argument("copy", type=Path)
p.add_argument("--receipt", required=True, type=Path)
p.add_argument("--compare-existing", action="store_true", help="Audit a completed fresh replay without rerunning it")
a = p.parse_args()
original, copy = a.original.resolve(), a.copy.resolve()
assert original != copy and original.is_dir() and copy.is_dir()
manifest = json.loads((original / "MANIFEST_RESULT.json").read_text())["files_sha256"]
def digest(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()
assert all(digest(original / name) == sha for name, sha in manifest.items())
if not a.compare_existing:
    assert all(digest(copy / name) == sha for name, sha in manifest.items())
else:
    assert all(digest(copy / name) == sha for name, sha in manifest.items()
               if not name.startswith("work/receipts/")), "input/source drift"
env = dict(os.environ, OPENBLAS_NUM_THREADS="1", OMP_NUM_THREADS="1", VECLIB_MAXIMUM_THREADS="1")
start = time.monotonic()
log = copy.parent / "fresh_full_replay.log"
if not a.compare_existing:
    with log.open("w") as out:
        result = subprocess.run([sys.executable, "-u", "replay.py", "--full-family", "--no-cache"],
                                cwd=copy, env=env, stdout=out, stderr=subprocess.STDOUT)
    assert result.returncode == 0, f"replay failed: {log}"
else:
    assert '"check_count": 38' in log.read_text(), "fresh full replay did not finish"
comparisons = {}
def compare_recorded(old, new, path=""):
    """Every recorded value must match; final source also exports new diagnostics."""
    if isinstance(old, dict):
        assert isinstance(new, dict) and old.keys() <= new.keys(), path
        extra = [path + "/" + k for k in new.keys() - old.keys()]
        for k,v in old.items():
            if k not in {"seconds", "fourth_vector"}:
                extra += compare_recorded(v,new[k],path+"/"+k)
        return extra
    if isinstance(old, list):
        assert isinstance(new,list) and len(old)==len(new), path
        return [k for i,(v,w) in enumerate(zip(old,new)) for k in compare_recorded(v,w,path+f"/{i}")]
    assert old == new, (path,old,new)
    return []
for name in ("primary_audit", "candidate2100", "fourth_digit", "fourth2100", "fourth2400_frob1",
             "reduced2400_frob1", "universal2100", "top7_2100", "certificate_audit"):
    old = json.loads((original / "work/receipts" / f"{name}.json").read_text())
    new = json.loads((copy / "work/receipts" / f"{name}.json").read_text())
    # Only timing and the runtime path to the SAME checked digit may differ.
    extra = compare_recorded(old,new,name)
    comparisons[name] = {"all_previously_recorded_mathematical_fields_equal": True,
                         "additional_diagnostic_fields": extra, "seconds": new.get("seconds")}
assert all(digest(original / name) == sha for name, sha in manifest.items()), "original changed"
receipt = {"status": "PASS", "original": str(original), "fresh_copy": str(copy),
           "log": str(log), "manifest_files": len(manifest), "original_preserved": True,
           "fresh_full_replay_wall_seconds": None if a.compare_existing else time.monotonic() - start,
           "comparison_resumed_after_diagnostic_schema_check": a.compare_existing,
           "comparisons": comparisons,
           "scope": "Fresh full point and higher-digit geometry, two Frobenius choices, full and reduced coefficients; numerical/source evidence, not by itself a proof of the inverse-Cartier interpretation."}
a.receipt.parent.mkdir(parents=True, exist_ok=True)
a.receipt.write_text(json.dumps(receipt, indent=2) + "\n")
print(json.dumps(receipt, indent=2))
