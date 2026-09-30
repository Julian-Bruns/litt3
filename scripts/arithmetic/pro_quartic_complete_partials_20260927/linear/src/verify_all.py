"""Read-only verification of the supplied exact evidence.

Each stage runs in a fresh temporary copy, with assertions enabled.  Only
nondeterministic timing fields are ignored when comparing regenerated JSON.
This verifies the partial results, not the unresolved global square decision.
"""
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import platform
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
TIMING_FIELDS = {"seconds", "table_seconds"}


def digest(path: Path) -> str:
    result = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1 << 20), b""):
            result.update(block)
    return result.hexdigest()


def verify_manifest() -> int:
    manifest = ROOT / "SHA256SUMS"
    if not manifest.is_file():
        raise RuntimeError("Missing SHA256SUMS; run from an intact extracted archive.")
    recorded: set[str] = set()
    for line in manifest.read_text().splitlines():
        expected, relative = line.split("  ", 1)
        path = ROOT / relative
        if not path.is_file() or digest(path) != expected:
            raise RuntimeError(f"SHA-256 mismatch or missing file: {relative}")
        recorded.add(relative)
    actual = {
        str(path.relative_to(ROOT))
        for path in ROOT.rglob("*")
        if path.is_file()
        and "__pycache__" not in path.parts
        and path.name != "SHA256SUMS"
    }
    if recorded != actual:
        raise RuntimeError(
            f"Manifest coverage mismatch; unlisted={sorted(actual - recorded)}, "
            f"missing={sorted(recorded - actual)}"
        )
    return len(recorded)


def canonical(value: object) -> object:
    """Remove only measured runtimes, retaining every mathematical datum."""
    if isinstance(value, dict):
        return {k: canonical(v) for k, v in value.items() if k not in TIMING_FIELDS}
    if isinstance(value, list):
        return [canonical(v) for v in value]
    return value


def compare_json(reference: Path, regenerated: Path) -> None:
    a = canonical(json.loads(reference.read_text()))
    b = canonical(json.loads(regenerated.read_text()))
    if a != b:
        raise RuntimeError(f"Regenerated evidence differs: {reference.relative_to(ROOT)}")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--skip-manifest", action="store_true",
        help="Maintainer-only mode before rebuilding the archive manifest."
    )
    args = parser.parse_args()
    if sys.flags.optimize:
        raise RuntimeError("Assertions must be enabled; do not use python -O.")
    print(f"Python: {platform.python_implementation()} {platform.python_version()}", flush=True)
    print("Arithmetic dependencies: Python standard library only", flush=True)
    if args.skip_manifest:
        print("Manifest: explicitly skipped (pre-packaging maintainer run)", flush=True)
    else:
        count = verify_manifest()
        print(f"Manifest: PASS ({count} files)", flush=True)

    stages = [
        ("reconstruct.py", "150x156 system, rank 150, six-dimensional affine source"),
        ("symbolic_cramer.py", "global Cramer identities and determinant"),
        ("cube_free.py", "cube-root-free arrays and exact Psi factorization"),
        ("evaluate.py", "exact diagnostic residual and failed square tail"),
        ("polynomial_model.py", "global model source bounds and four exact identities"),
        ("checks.py", "original constraints, degree drops, rank and all-tail diagnostics"),
    ]
    comparisons = [
        "data/source_affine.json", "data/cramer_symbolic.json", "data/cube_free.json",
        "data/example_nonsquare.json", "data/polynomial_model.json",
        "evidence/source_summary.json", "evidence/cramer_summary.json",
        "evidence/cube_free_summary.json", "evidence/numerical_evaluation.json",
        "evidence/polynomial_model_summary.json", "evidence/checks_summary.json",
        "evidence/fixed_resultant_cases.json",
    ]
    with tempfile.TemporaryDirectory(prefix="moving-r9-verify-") as temporary:
        workspace = Path(temporary) / "archive"
        shutil.copytree(ROOT, workspace, ignore=shutil.ignore_patterns("__pycache__"))
        field_run = subprocess.run(
            [sys.executable, "-B", "src/field.py"], cwd=workspace,
            capture_output=True, text=True, check=False,
        )
        if field_run.returncode:
            raise RuntimeError(f"field.py failed:\n{field_run.stdout}\n{field_run.stderr}")
        field_data = canonical(json.loads(field_run.stdout))
        if field_data != canonical(json.loads((ROOT / "evidence/field_init.json").read_text())):
            raise RuntimeError("Field initialization differs from supplied evidence.")
        print("field.py: PASS (all 390624 nonzero powers and 101^3=64426)", flush=True)
        for script, description in stages:
            result = subprocess.run(
                [sys.executable, "-B", "src/" + script], cwd=workspace,
                capture_output=True, text=True, check=False,
            )
            if result.returncode:
                raise RuntimeError(f"{script} failed:\n{result.stdout}\n{result.stderr}")
            print(f"{script}: PASS ({description})", flush=True)
        for relative in comparisons:
            compare_json(ROOT / relative, workspace / relative)
        print(f"Essential JSON reproduction: PASS ({len(comparisons)} files; timings ignored)", flush=True)
    print("Verification scope: exact partial results only; global square locus UNRESOLVED.", flush=True)


if __name__ == "__main__":
    main()
