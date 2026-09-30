#!/usr/bin/env python3
"""Generate and verify the rational pole-degree-three certificates from source."""
from __future__ import annotations

import argparse
from concurrent.futures import ThreadPoolExecutor, as_completed
import json
import math
import os
from pathlib import Path
import shlex
import subprocess
import sys

SOURCE = Path(__file__).resolve().parent
ALL_DEGREES = list(range(7, 27))


def run_logged(command: list[str], stdout: Path, stderr: Path) -> dict:
    with stdout.open("w") as out, stderr.open("w") as err:
        result = subprocess.run(command, stdout=out, stderr=err, text=True)
    if result.returncode:
        raise RuntimeError(f"{shlex.join(command)} failed; see {stderr}")
    try:
        record = json.loads(stdout.read_text())
    except json.JSONDecodeError as exc:
        raise RuntimeError(f"invalid summary in {stdout}") from exc
    if record.get("status") != "PASS":
        raise RuntimeError(f"native certificate check did not pass: {stdout}")
    return record


def check_record(record: dict, n: int, mode: str, basis: str) -> None:
    if (record["n"], record["d"], record["mode"], record["basis"]) != (
            n, n - 3, mode, basis):
        raise RuntimeError(f"unexpected certificate summary for n={n}")
    if record["covered_subsets"] != math.comb(29, n - 3):
        raise RuntimeError(f"incomplete pole-layout coverage for n={n}")
    if record["phase_cases"] != 64 * record["layouts"]:
        raise RuntimeError(f"incomplete phase coverage for n={n}")
    if sum(record[key] for key in (
            "power_exclusions", "open_exclusions",
            "degree_exclusions")) != record["phase_cases"]:
        raise RuntimeError(f"incomplete case exclusions for n={n}")
    if sum(record["reason_counts"].values()) != record["phase_cases"]:
        raise RuntimeError(f"witness counts do not cover all cases for n={n}")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", required=True, type=Path,
                        help="fresh directory outside the repository")
    parser.add_argument("--n", nargs="+", type=int, default=ALL_DEGREES,
                        help="covering degrees (default: all 7 through 26)")
    parser.add_argument("--jobs", type=int, default=min(4, os.cpu_count() or 1))
    args = parser.parse_args()
    degrees = sorted(set(args.n))
    if args.jobs < 1 or not degrees or any(n not in ALL_DEGREES for n in degrees):
        parser.error("jobs must be positive and covering degrees lie in 7..26")
    output = args.output.resolve()
    repository = SOURCE.parents[3]
    if output == repository or repository in output.parents:
        parser.error("put generated certificates outside the repository")
    if output.exists():
        parser.error("output directory already exists")
    output.mkdir(parents=True)
    (output / "certificates").mkdir()
    (output / "logs").mkdir()

    executable = output / "certificate"
    compiler = shlex.split(os.environ.get("CXX", "c++"))
    if not compiler:
        parser.error("CXX has no compiler command")
    compile_command = compiler + ["-O3", "-std=c++17",
                                  str(SOURCE / "src" / "certificate.cpp"),
                                  "-o", str(executable)]
    with (output / "logs" / "compile.log").open("w") as log:
        result = subprocess.run(compile_command, stdout=log,
                                stderr=subprocess.STDOUT, text=True)
    if result.returncode:
        raise RuntimeError(f"compilation failed; see {output / 'logs' / 'compile.log'}")

    def one(n: int) -> dict:
        certificate = output / "certificates" / f"n{n:02}.rrc"
        records = []
        for mode, basis in (("generate", "polynomial"), ("verify", "fractions")):
            stem = f"{mode}_n{n:02}"
            record = run_logged(
                [str(executable), mode, str(n - 3), str(certificate), basis],
                output / "logs" / f"{stem}.json",
                output / "logs" / f"{stem}.stderr.log")
            check_record(record, n, mode, basis)
            records.append(record)
        producer, verifier = records
        keys = ("layouts", "phase_cases", "covered_subsets", "power_exclusions",
                "open_exclusions", "degree_exclusions", "reason_counts")
        if any(producer[key] != verifier[key] for key in keys):
            raise RuntimeError(f"independent replay differs for n={n}")
        print(f"n={n}: PASS ({producer['layouts']} layouts, "
              f"{producer['phase_cases']} cases)", flush=True)
        return {"n": n, **{key: producer[key] for key in keys}}

    results = []
    with ThreadPoolExecutor(max_workers=args.jobs) as pool:
        futures = [pool.submit(one, n) for n in degrees]
        for future in as_completed(futures):
            results.append(future.result())
    totals = {key: sum(record[key] for record in results)
              for key in ("layouts", "phase_cases", "covered_subsets",
                          "power_exclusions", "open_exclusions",
                          "degree_exclusions")}
    if degrees == ALL_DEGREES and totals != {
            "layouts": 1324308,
            "phase_cases": 84755712,
            "covered_subsets": sum(math.comb(29, n - 3) for n in ALL_DEGREES),
            "power_exclusions": 84755000,
            "open_exclusions": 712,
            "degree_exclusions": 0}:
        raise RuntimeError("full-range totals differ from the theorem")
    summary = {"status": "PASS", "degrees": degrees, **totals}
    (output / "summary.json").write_text(json.dumps(summary, indent=2) + "\n")
    print(json.dumps(summary, indent=2))


if __name__ == "__main__":
    try:
        main()
    except (OSError, RuntimeError, KeyError) as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        sys.exit(1)
