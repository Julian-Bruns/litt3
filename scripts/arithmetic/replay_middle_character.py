#!/usr/bin/env python3
"""Replay the returned middle-character proofs, correcting one temp-file lifetime.

The returned verify.py reads its final reconstructed JSON after leaving the
TemporaryDirectory context. This runner moves that single check inside the
context, without modifying any incoming file or any mathematical check.
All other proof entry points are run unchanged. Raw evidence stays outside
the research repository.
"""
import argparse
import hashlib
import os
from pathlib import Path
import subprocess
import sys


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("archive_root", type=Path)
    parser.add_argument("--checkpoints", action="store_true")
    args = parser.parse_args()
    root = args.archive_root.resolve()
    source = root / "src/verify.py"
    code = source.read_text()
    line = "  check(json.loads((td/'certificates/source_C_gamma_injection.json').read_text())"
    assert code.count(line) == 1
    corrected = code.replace(line, " " + line)
    print("Original verifier SHA256", hashlib.sha256(source.read_bytes()).hexdigest(), flush=True)
    print("Correction: final reconstructed JSON check stays in TemporaryDirectory context.", flush=True)
    os.environ["OPENBLAS_NUM_THREADS"] = "1"
    os.environ["PYTHONDONTWRITEBYTECODE"] = "1"
    sys.path.insert(0, str(root / "src"))
    sys.argv = [str(source), "--rebuild"]
    exec(compile(corrected, str(source), "exec"), {"__name__": "__main__", "__file__": str(source)})
    checker = root / ".build/verify_dag"
    checker.parent.mkdir(exist_ok=True)
    subprocess.run([os.environ.get("CXX", "/opt/homebrew/opt/llvm/bin/clang++"),
                    "-O2", "-std=c++17", str(root / "src/verify_dag.cpp"),
                    "-o", str(checker)], check=True)
    def run(*command):
        print("RUN", *command, flush=True)
        subprocess.run([str(x) for x in command], cwd=root, check=True)
    run(sys.executable, root / "src/verify_inputs.py")
    names = ["N_chart0"] + [f"N_stratum{i}" for i in range(1, 6)]
    names += [f"matched_stratum{i}" for i in range(3, 10)]
    for name in names:
        run(checker, root / f"data/{name}.txt", root / f"certificates/{name}.dag")
    run(sys.executable, root / "src/verify_diagnostics.py")
    if args.checkpoints:
        run(sys.executable, root / "src/verify_inputs.py", "--checkpoints")
        run(sys.executable, root / "src/verify_bridge.py")
        for name in ["matched_chart0", "matched_stratum1", "matched_stratum2", "matched_chart0_minimal"]:
            run(checker, root / f"data/{name}.txt", root / f"certificates/{name}.dag", "allow-incomplete")
    print("PASS all requested identities; unfinished checkpoints prove membership only.", flush=True)


if __name__ == "__main__":
    main()
