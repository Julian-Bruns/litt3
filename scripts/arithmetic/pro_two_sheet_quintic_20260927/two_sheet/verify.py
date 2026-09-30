#!/usr/bin/env python3
"""Exact replay for the two-simple-content-sheet exclusion.

Only the Python standard library and a C++17 compiler are required.
The full mode regenerates every mathematical reference artifact from source.
The certificate mode checks stored identities/coverage and independent
Sylvester regressions; it does not by itself regenerate C71 and C72.
"""
from __future__ import annotations
import argparse
import concurrent.futures
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parent
ENDPOINTS = (145049, 211895, 211959)
COUNTS = {145049: 6, 211895: 4, 211959: 7}
PROGRAMS = ("reconstruct", "endpoints", "eliminate", "split", "drops",
            "universal", "test_fast", "factor", "square", "audit")


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1 << 20), b""):
            h.update(block)
    return h.hexdigest()


def reference_names() -> list[str]:
    names = ["source.txt", "F6.txt", "kernel.txt", "universal_E.txt"]
    for r in ENDPOINTS:
        names += [f"endpoint_{r}.txt", f"elimination_{r}.txt",
                  f"split_{r}.txt", f"ddf_{r}.txt"]
        names += [f"drop_certificate_{r}_{j}.txt" for j in range(2)]
        for i in range(COUNTS[r]):
            names += [f"square_equations_{r}_{i}.txt",
                      f"square_certificate_{r}_{i}_0.txt"]
    return names


def check_manifest() -> int:
    manifest = ROOT / "SHA256SUMS"
    if not manifest.exists():
        print("Manifest not present in development tree; mathematical replay continues.", flush=True)
        return 0
    count = 0
    for line in manifest.read_text().splitlines():
        expected, name = line.split("  ", 1)
        p = (ROOT / name).resolve()
        if not p.is_relative_to(ROOT) or not p.is_file():
            raise RuntimeError(f"Unsafe or missing manifest path: {name}")
        if sha256(p) != expected:
            raise RuntimeError(f"Manifest mismatch: {name}")
        count += 1
    print(f"Manifest verified: {count} files.", flush=True)
    return count


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    modes = parser.add_mutually_exclusive_group()
    modes.add_argument("--full", action="store_true", help="regenerate and compare every reference (default)")
    modes.add_argument("--certificates", action="store_true", help="audit retained certificates only")
    parser.add_argument("--work", type=Path, default=ROOT / "replay_work")
    parser.add_argument("--jobs", type=int, default=2)
    parser.add_argument("--compiler", default=os.environ.get("CXX", "g++"))
    parser.add_argument("--direct", action="store_true", help="audit polynomial identities by direct rather than NTT multiplication")
    args = parser.parse_args()
    if args.jobs < 1:
        parser.error("--jobs must be positive")
    work = args.work.resolve()
    if work == ROOT or work == ROOT / "evidence":
        parser.error("--work must not be the archive root or its evidence directory")
    work.mkdir(parents=True, exist_ok=True)
    build, logs, output = work / "build", work / "logs", work / "evidence"
    for d in (build, logs, output, work / "series"):
        d.mkdir(exist_ok=True)
    manifest_count = check_manifest()
    start = time.monotonic()
    records: list[dict[str, object]] = []

    def command(label: str, cmd: list[str]) -> dict[str, object]:
        log = logs / (label + ".log")
        t0 = time.monotonic()
        with log.open("wb") as stream:
            result = subprocess.run(cmd, cwd=ROOT, stdout=stream, stderr=subprocess.STDOUT, check=False)
        rec = {"label": label, "command": cmd, "returncode": result.returncode,
               "seconds": round(time.monotonic() - t0, 3), "log": str(log)}
        if result.returncode:
            sys.stderr.write(log.read_text(errors="replace")[-12000:])
            raise RuntimeError(f"Failed {label}, exit {result.returncode}; log: {log}")
        print(f"PASS {label}", flush=True)
        return rec

    needed = ("test_fast", "audit") if args.certificates else PROGRAMS
    with concurrent.futures.ThreadPoolExecutor(max_workers=args.jobs) as pool:
        futures = [pool.submit(command, "compile_" + name,
                    [args.compiler, "-O3", "-std=c++17", str(ROOT / "src" / (name + ".cpp")),
                     "-o", str(build / name)]) for name in needed]
        records += [f.result() for f in futures]
    records.append(command("test_fast", [str(build / "test_fast")]))

    compared = 0
    if not args.certificates:
        # Stages use no retained coefficient files as computational inputs.
        for name in ("reconstruct", "endpoints", "eliminate", "split", "drops", "universal"):
            records.append(command(name, [str(build / name), str(output)]))
        with concurrent.futures.ThreadPoolExecutor(max_workers=args.jobs) as pool:
            futures = [pool.submit(command, "factor_" + str(r),
                        [str(build / "factor"), str(output), str(r)]) for r in ENDPOINTS]
            records += [f.result() for f in futures]
        with concurrent.futures.ThreadPoolExecutor(max_workers=args.jobs) as pool:
            futures = []
            for r in ENDPOINTS:
                for i in range(COUNTS[r]):
                    # Erase old series checkpoints to force a genuine full regeneration.
                    for prefix in ("R", "R2", "R3"):
                        (work / "series" / f"{prefix}_{r}_{i}.txt").unlink(missing_ok=True)
                    futures.append(pool.submit(command, f"square_{r}_{i}",
                        [str(build / "square"), str(output), str(r), str(i), "all", str(work / "series")]))
            records += [f.result() for f in futures]
        for name in reference_names():
            if sha256(ROOT / "evidence" / name) != sha256(output / name):
                raise RuntimeError(f"Regenerated reference differs: {name}")
            compared += 1
        print(f"Exact byte comparison passed for all {compared} mathematical reference files.", flush=True)
    audit_dir = ROOT / "evidence" if args.certificates else output
    cmd = [str(build / "audit"), str(audit_dir)]
    if args.direct:
        cmd.append("--direct")
    records.append(command("audit_direct" if args.direct else "audit", cmd))
    result = {
        "status": "passed", "mode": "certificates" if args.certificates else "full",
        "direct_identity_audit": args.direct, "manifest_files": manifest_count,
        "reference_files_compared": compared,
        "mathematical_result": "two-sheet square incidence empty at all three endpoints",
        "ordinary_dimensions": [452, 452, 452], "square_unit_identities": 17,
        "unreduced_degree_drop_unit_identities": 6,
        "seconds": round(time.monotonic() - start, 3), "records": records,
    }
    (work / "verification_summary.json").write_text(json.dumps(result, indent=2) + "\n")
    print("VERIFICATION PASSED", flush=True)
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (RuntimeError, OSError, ValueError) as error:
        print(f"VERIFICATION FAILED: {error}", file=sys.stderr)
        raise SystemExit(1)
