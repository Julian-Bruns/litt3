#!/usr/bin/env python3
"""Generate and independently verify the complete degree-six certificate."""
from __future__ import annotations

import argparse
import os
from pathlib import Path
import shlex
import subprocess
import sys

SOURCE = Path(__file__).resolve().parent


def run_logged(command: list[str], log: Path, *, cwd: Path | None = None) -> str:
    with log.open("w") as output:
        result = subprocess.run(command, cwd=cwd, stdout=output,
                                stderr=subprocess.STDOUT, text=True)
    if result.returncode:
        raise RuntimeError(f"{shlex.join(command)} failed; see {log}")
    return log.read_text()


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", required=True, type=Path,
                        help="fresh directory outside the repository")
    args = parser.parse_args()
    output = args.output.resolve()
    repository = SOURCE.parents[3]
    if output == repository or repository in output.parents:
        parser.error("put generated certificates outside the repository")
    if output.exists():
        parser.error("output directory already exists")
    output.mkdir(parents=True)

    executable = output / "pole_obstruction"
    compiler = shlex.split(os.environ.get("CXX", "c++"))
    if not compiler:
        parser.error("CXX has no compiler command")
    run_logged(compiler + ["-O2", "-std=c++17",
                           str(SOURCE / "pole_obstruction.cpp"),
                           "-o", str(executable)], output / "compile.log")
    producer_log = run_logged(
        [str(executable), str(output / "pole_cases.csv")],
        output / "producer.log", cwd=output)
    if "TOTAL 4480" not in producer_log or "pole3_obstruction 4480" not in producer_log:
        raise RuntimeError("producer did not certify all 4,480 cases")
    certificate = output / "exact_certificate.jsonl"
    verifier_log = run_logged(
        [sys.executable, str(SOURCE / "verify_certificate.py"),
         "--certificate", str(certificate)],
        output / "verifier.log")
    if "cases [0,4480) independently verified (4480 cases)" not in verifier_log:
        raise RuntimeError("independent verifier did not certify all 4,480 cases")
    print(f"PASS: 70 layouts and 4,480 cases; certificate in {certificate}")


if __name__ == "__main__":
    try:
        main()
    except (OSError, RuntimeError) as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        sys.exit(1)
