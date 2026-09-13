#!/usr/bin/env python3
"""Ten bounded, chart-preserving equation-layout diagnostics.

Uses pre-exported inputs on ONE solved chart. Solver units are CANDIDATES,
not independently verified polynomial certificates. No mathematical
conclusion from timeouts. Never starts an all-representative queue.
"""
import argparse
from concurrent.futures import ThreadPoolExecutor, as_completed
import hashlib
import json
import os
from pathlib import Path
import subprocess
import time


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    for name in ("plain", "chain", "lift", "factor", "output"):
        ap.add_argument("--" + name, type=Path, required=True)
    ap.add_argument("--seconds", type=int, default=45)
    ap.add_argument("--singular", default="/Applications/SageMath-10-9.app/Contents/Frameworks/Sage.framework/Versions/10.9/local/bin/Singular")
    args = ap.parse_args()
    assert 1 <= args.seconds <= 300
    args.output.mkdir(parents=True, exist_ok=False)
    inputs = {}
    for name in ("plain", "chain", "lift", "factor"):
        folder = getattr(args, name)
        cert = json.loads((folder / "input_certificate.json").read_text())
        assert cert["chart"] == 23 and not cert["slice_only"]
        assert cert["projective_inverse_scale"] == "v.s/2" and cert["chart_guard_equations"] == 1
        program = (folder / "input.sing").read_text()
        inputs[name] = (program.split("option(prot);")[0], cert)
    cases = [
        ("plain", "slimgb", "full"),
        ("plain", "slimgb", "fixed_only"),
        ("plain", "slimgb", "reverse"),
        ("plain", "std", "full"),
        ("chain", "slimgb", "full"),
        ("chain", "slimgb", "fixed_only"),
        ("lift", "slimgb", "full"),
        ("lift", "slimgb", "frobenius_first"),
        ("factor", "slimgb", "full"),
        ("factor", "slimgb", "frobenius_first"),
    ]
    def run(case):
        layout, engine, mode = case
        name = "-".join(case)
        folder = args.output / name
        folder.mkdir()
        prefix, certificate = inputs[layout]
        tweak = ""
        if mode == "fixed_only":
            # On original chart23, last eight equations are precisely the
            # remaining nonlinear Frobenius equations. Keep all 24 roots.
            tweak = "ideal K; for(int i=1;i<=size(I)-9;i++){K[i]=I[i];} K[size(K)+1]=I[size(I)]; I=K;\n"
        elif mode == "reverse":
            tweak = "ideal K; for(int i=1;i<=size(I);i++){K[i]=I[size(I)+1-i];} I=K;\n"
        elif mode == "frobenius_first":
            tweak = "ideal K; int j=1; for(int i=size(I)-32;i<size(I);i++){K[j]=I[i];j++;} for(i=1;i<=size(I)-33;i++){K[j]=I[i];j++;} K[j]=I[size(I)]; I=K;\n"
        program = prefix + tweak + 'option(prot); print("PLAYGROUND_STARTED");\n'
        program += f'ideal G={engine}(I); print("PLAYGROUND_FINISHED"); size(G);\n'
        program += 'if(size(G)==1 && G[1]==1){print("UNIT_CANDIDATE");}\n'
        program += f'write("{folder / "basis.sing"}",G); quit;\n'
        source = folder / "input.sing"
        source.write_text(program)
        start = time.monotonic()
        env = dict(os.environ, OMP_NUM_THREADS="1", OPENBLAS_NUM_THREADS="1", VECLIB_MAXIMUM_THREADS="1")
        # Set limits in the already-running child via a tiny shell, avoiding
        # unsafe preexec_fn callbacks from a multithreaded parent process.
        command = ["/bin/sh", "-c", 'ulimit -t "$1"; exec "$2" -q "$3"', "atlas-test", str(args.seconds + 1), args.singular, str(source)]
        with (folder / "solver.log").open("w") as log:
            process = subprocess.Popen(command, stdout=log, stderr=subprocess.STDOUT, env=env)
            try:
                rc = process.wait(timeout=args.seconds + 15)
                status = "candidate_finished" if rc == 0 else "cpu_limit_or_solver_error"
            except subprocess.TimeoutExpired:
                process.kill(); process.wait(); rc = None
                status = "wall_time_limit"
        text = (folder / "solver.log").read_text(errors="replace")
        if status == "candidate_finished" and ("PLAYGROUND_FINISHED" not in text or "?" in text):
            status = "solver_error"
        result = dict(case=name, status=status, seconds=time.monotonic()-start,
                      unit_candidate="UNIT_CANDIDATE" in text,
                      returncode=rc, input_sha256=hashlib.sha256(program.encode()).hexdigest(),
                      variables=certificate["variables"], log_tail=text[-2000:],
                      scope="Solved-chart runtime diagnostic; units require independent original-equation verification")
        (folder / "result.json").write_text(json.dumps(result, indent=2) + "\n")
        print(json.dumps({k:v for k,v in result.items() if k != "log_tail"}), flush=True)
        return result
    with ThreadPoolExecutor(max_workers=10) as pool:
        results = [future.result() for future in as_completed([pool.submit(run, c) for c in cases])]
    (args.output / "results.json").write_text(json.dumps(results, indent=2) + "\n")


if __name__ == "__main__":
    main()
