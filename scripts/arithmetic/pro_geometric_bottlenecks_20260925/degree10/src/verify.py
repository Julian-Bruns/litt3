#!/usr/bin/env python3
"""Rebuild and verify all delivered certificates using only the standard library.

Run from any working directory. All generated files and executables go to a
TemporaryDirectory, never into the delivered archive.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent.parent


def run(command: list[str], *, cwd: Path | None = None) -> str:
    print("$ " + " ".join(command), flush=True)
    result = subprocess.run(
        command, cwd=cwd, text=True, stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT, check=False,
    )
    print(result.stdout, end="" if result.stdout.endswith("\n") else "\n", flush=True)
    if result.returncode:
        raise RuntimeError(f"Command failed with exit code {result.returncode}")
    return result.stdout


def check_manifest() -> None:
    manifest = ROOT / "SHA256SUMS"
    if not manifest.is_file():
        raise RuntimeError("Missing SHA256SUMS; use --skip-manifest only while building the archive")
    count = 0
    for line in manifest.read_text().splitlines():
        if not line.strip():
            continue
        expected, name = line.split("  ", 1)
        path = (ROOT / name).resolve()
        if ROOT not in path.parents:
            raise RuntimeError(f"Unsafe manifest path: {name}")
        actual = hashlib.sha256(path.read_bytes()).hexdigest()
        if actual != expected:
            raise RuntimeError(f"SHA-256 mismatch: {name}")
        count += 1
    print(f"PASS SHA-256 manifest: {count} files", flush=True)


def make_interchanges(data: Path) -> None:
    variables = json.loads((data / "field.json").read_text())["variables"]
    for case in range(11):
        obj = json.loads((data / f"space_{case}.json").read_text())
        rows = [f"{case} {obj['r']} {len(variables)}"]
        rows.extend(" ".join(map(str, row)) for row in variables)
        rows.extend(" ".join(map(str, row)) for row in
                    [obj["particular"], *obj["directions"]])
        (data / f"space_{case}.txt").write_text("\n".join(rows) + "\n")


def compare_data(generated: Path) -> None:
    originals = sorted((ROOT / "data").iterdir())
    generated_names = {p.name for p in generated.iterdir()}
    expected_names = {p.name for p in originals}
    if generated_names != expected_names:
        raise RuntimeError(
            f"Data file sets differ: missing={expected_names-generated_names}, "
            f"unexpected={generated_names-expected_names}"
        )
    for original in originals:
        other = generated / original.name
        if original.suffix == ".json":
            if json.loads(original.read_text()) != json.loads(other.read_text()):
                raise RuntimeError(f"Regenerated JSON differs: {original.name}")
        elif original.read_bytes() != other.read_bytes():
            raise RuntimeError(f"Regenerated interchange differs: {original.name}")
    print(f"PASS all {len(originals)} delivered data files regenerated exactly", flush=True)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--skip-manifest", action="store_true")
    parser.add_argument("--cxx", default=os.environ.get("CXX", "g++"))
    args = parser.parse_args()
    print("Degree-ten discriminant-square partial-result verifier", flush=True)
    print(f"Python {platform.python_version()}; platform {platform.platform()}", flush=True)
    if not args.skip_manifest:
        check_manifest()
    run([args.cxx, "--version"])
    with tempfile.TemporaryDirectory(prefix="degree10-verify-") as temporary:
        work = Path(temporary)
        data = work / "data"
        data.mkdir()
        binaries: dict[str, Path] = {}
        for name in ("linear", "line", "boundary", "audit", "evaluate"):
            binary = work / name
            run([args.cxx, "-std=c++17", "-O3", str(ROOT / "src" / f"{name}.cpp"),
                 "-o", str(binary)])
            binaries[name] = binary
        run([str(binaries["linear"]), str(data)])
        make_interchanges(data)
        for case in range(11):
            run([str(binaries["line"]), str(data / f"space_{case}.txt"),
                 str(data / f"line_{case}.json")])
        run([str(binaries["boundary"]), str(data), str(data / "boundary_checks.json")])
        run([str(binaries["audit"]), str(data)])
        point_path = work / "point.json"
        run([str(binaries["evaluate"]), str(data / "space_0.txt"),
             "0,1,0,0,0,0,1", str(point_path)])
        point = json.loads(point_path.read_text())
        line = json.loads((data / "line_0.json").read_text())
        if point["R0"] != line["boundary_residuals"][0] or point["square"]:
            raise RuntimeError("Standalone evaluator regression failed")
        for case in range(11):
            line = json.loads((data / f"line_{case}.json").read_text())
            boundary = json.loads((data / f"boundary_{case}.json").read_text())
            if not line["geometric_line_excluded"]:
                raise RuntimeError(f"Case {case} line was not excluded")
            if len(boundary["R0"]) != 143 or boundary["square"]:
                raise RuntimeError(f"Case {case} degree-142 point regression failed")
        compare_data(data)
    print("PASS ALL DELIVERED CLAIM CHECKS", flush=True)
    print("STATUS: PARTIAL; the full seven-dimensional geometric square locus remains unresolved.", flush=True)
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (OSError, ValueError, RuntimeError, KeyError) as error:
        print(f"VERIFICATION FAILED: {error}", file=sys.stderr)
        raise SystemExit(1)
