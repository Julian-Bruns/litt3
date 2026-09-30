#!/usr/bin/env python3
"""Rebuild and regenerate exact evidence without modifying the archive.

No global square-locus elimination is performed by this verifier. It checks
precisely the finite-locus theorem's computational ingredients and the labeled
single-ratio validation tests. Assertions must remain enabled.
"""
from __future__ import annotations

import argparse
import datetime as dt
import hashlib
import json
import os
from pathlib import Path
import platform
import shlex
import subprocess
import sys
import time

ROOTS = [9,14,2514,7367,20130,104315,139659,154113,281660,364472]
TOOLS = ["reconstruct", "parametrize", "psi", "residual", "infinity_faces",
         "infinity_global", "closure_at_boundary", "check_normalization", "diagnose"]


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for block in iter(lambda: f.read(1024 * 1024), b""):
            h.update(block)
    return h.hexdigest()


def atomic_json(path: Path, value: object) -> None:
    tmp = path.with_suffix(path.suffix + ".tmp")
    tmp.write_text(json.dumps(value, indent=2, sort_keys=True) + "\n")
    tmp.replace(path)


def check_manifest(archive: Path) -> int:
    manifest = archive / "SHA256SUMS"
    if not manifest.exists():
        raise RuntimeError("Missing SHA256SUMS")
    count = 0
    for line in manifest.read_text().splitlines():
        expected, name = line.split("  ", 1)
        path = archive / name
        if path.resolve().is_relative_to(archive.resolve()) is False:
            raise RuntimeError(f"Unsafe manifest path: {name}")
        if not path.is_file() or sha256(path) != expected:
            raise RuntimeError(f"Manifest mismatch: {name}")
        count += 1
    return count


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--workdir", type=Path, required=True)
    parser.add_argument("--resume", action="store_true")
    parser.add_argument("--skip-manifest", action="store_true",
                        help="Maintainer option for an archive not yet sealed.")
    args = parser.parse_args()
    archive = Path(__file__).resolve().parent
    work = args.workdir.resolve()
    if work == archive or work.is_relative_to(archive):
        parser.error("--workdir must be outside the extracted archive")
    build, generated, logs, stamps = [work / n for n in ("build", "generated", "logs", "stamps")]
    for p in (build, generated, logs, stamps):
        p.mkdir(parents=True, exist_ok=True)
    env = os.environ.copy()
    env["PYTHONOPTIMIZE"] = "0"
    compiler = shlex.split(env.get("CXX", "g++"))
    summary: dict = {"status": "running", "started_utc": dt.datetime.now(dt.timezone.utc).isoformat(),
                     "archive": str(archive), "workdir": str(work), "steps": [],
                     "scope": "exact finite-locus ingredients and labeled validation; original square decision unresolved"}
    summary_path = work / "verification_summary.json"
    started = time.perf_counter()
    try:
        if not args.skip_manifest:
            summary["manifest_files_checked"] = check_manifest(archive)
            print(f"PASS manifest: {summary['manifest_files_checked']} files", flush=True)
        else:
            summary["manifest_files_checked"] = None
            print("Manifest check deferred by explicit maintainer option.", flush=True)
        import sympy
        summary["versions"] = {"python": sys.version, "sympy": sympy.__version__,
                               "platform": platform.platform(),
                               "compiler": subprocess.check_output(compiler + ["--version"], text=True).splitlines()[0]}
        sources = sorted((archive / "src").glob("*")) + [archive / "verify.py"]
        codehash = hashlib.sha256("".join(f"{p.name}:{sha256(p)}\n" for p in sources if p.is_file()).encode()).hexdigest()
        summary["source_sha256"] = codehash

        def run(name: str, command: list[str], outputs: list[str]) -> None:
            stamp = stamps / f"{name}.json"
            expected = {n: sha256(archive / "data" / n) for n in outputs}
            ready = all((generated / n).is_file() and sha256(generated / n) == h for n, h in expected.items())
            cached = False
            if args.resume and stamp.exists() and ready:
                saved = json.loads(stamp.read_text())
                cached = saved.get("codehash") == codehash and saved.get("outputs") == expected
            if cached:
                summary["steps"].append({"name": name, "status": "cached-verified", "outputs": expected})
                print(f"PASS {name}: cached evidence rehashed", flush=True)
                return
            t0 = time.perf_counter()
            log = logs / f"{name}.log"
            with log.open("w") as f:
                f.write("$ " + shlex.join(command) + "\n")
                f.flush()
                result = subprocess.run(command, cwd=archive, env=env, stdout=f, stderr=subprocess.STDOUT, check=False)
            record = {"name": name, "command": command, "returncode": result.returncode,
                      "elapsed_seconds": round(time.perf_counter()-t0, 6), "log": str(log)}
            summary["steps"].append(record)
            if result.returncode:
                record["status"] = "failed"
                raise RuntimeError(f"{name} failed; see {log}")
            for n,h in expected.items():
                if not (generated / n).is_file() or sha256(generated / n) != h:
                    record["status"] = "mismatch"
                    raise RuntimeError(f"Regeneration mismatch: {n}")
            record["status"] = "passed"
            record["outputs"] = expected
            atomic_json(stamp, {"codehash": codehash, "outputs": expected})
            atomic_json(summary_path, summary)
            print(f"PASS {name}: {len(outputs)} exact data files matched", flush=True)

        for tool in TOOLS:
            executable = build / tool
            tag = stamps / f"build_{tool}.json"
            cached = args.resume and executable.exists() and tag.exists()
            if cached:
                saved = json.loads(tag.read_text())
                cached = saved.get("codehash") == codehash and saved.get("binary_sha256") == sha256(executable)
            if cached:
                print(f"PASS build {tool}: cached executable rehashed", flush=True)
                continue
            command = compiler + ["-std=c++17", "-O2", str(archive/"src"/f"{tool}.cpp"), "-o", str(executable)]
            log = logs / f"build_{tool}.log"
            t0 = time.perf_counter()
            with log.open("w") as f:
                f.write("$ "+shlex.join(command)+"\n"); f.flush()
                result = subprocess.run(command, env=env, stdout=f, stderr=subprocess.STDOUT, check=False)
            summary["steps"].append({"name": "build_"+tool, "command": command,
                                     "returncode": result.returncode, "status": "passed" if result.returncode == 0 else "failed",
                                     "elapsed_seconds": round(time.perf_counter()-t0, 6), "log": str(log)})
            if result.returncode:
                raise RuntimeError(f"Compilation failed: {tool}; see {log}")
            atomic_json(tag, {"codehash": codehash, "binary_sha256": sha256(executable)})
            print(f"PASS build {tool}", flush=True)

        run("universal", [sys.executable, str(archive/"src"/"derive_universal.py"), str(generated)],
            ["universal_resultant.json"])
        for tool,prefix in [("reconstruct","chart"), ("parametrize","param"), ("psi","psi"),
                            ("residual","check"), ("infinity_faces","infinity"), ("infinity_global","infinity_global")]:
            run(tool, [str(build/tool), str(generated)], [f"{prefix}_{r}.json" for r in ROOTS])
        run("check_normalization", [str(build/"check_normalization")], [])
        for i,r in enumerate(ROOTS):
            run(f"closure_{r}", [str(build/"closure_at_boundary"), str(generated), str(i), str(i+1)],
                [f"closure_{r}.json"])
        run("diagnose", [str(build/"diagnose")], [])
        expected_names = {p.name for p in (archive/"data").glob("*.json")}
        checked_names = {n for rec in summary["steps"] for n in rec.get("outputs", {})}
        if expected_names != checked_names:
            raise RuntimeError(f"Data coverage mismatch: unverified={sorted(expected_names-checked_names)}")
        summary["status"] = "passed"
        summary["data_files_verified"] = len(expected_names)
        summary["elapsed_seconds"] = round(time.perf_counter()-started, 6)
        summary["finished_utc"] = dt.datetime.now(dt.timezone.utc).isoformat()
        atomic_json(summary_path, summary)
        print(f"PASS complete: {len(expected_names)} data files regenerated and matched. Original decision remains unresolved.", flush=True)
        return 0
    except Exception as exc:
        summary["status"] = "failed"
        summary["error"] = str(exc)
        summary["elapsed_seconds"] = round(time.perf_counter()-started, 6)
        atomic_json(summary_path, summary)
        print(f"FAIL: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
