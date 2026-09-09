#!/usr/bin/env python3
"""Bounded F25 chart sweep; no wakeups, no timeout counted as an exclusion."""
import argparse
import fcntl
import hashlib
import json
import math
import os
import shutil
import signal
import struct
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT.parent / "litt3-computation-data"
TERMINAL = {"verified_original_polynomial_unit_certificate", "exact_bounded_dual",
            "time_limit", "memory_limit", "inconclusive", "needs_attention", "already_verified",
            "weak_subsystem_has_point"}
VERIFIED = {"linear_certificate_verified", "verified_polynomial_certificate",
            "verified_original_polynomial_unit_certificate"}


def dimensions(chart, degree):
    q = 31-chart
    return 32*math.comb(q+degree+1, degree+1)+math.comb(q+degree, degree)


def estimate(chart, degree):
    q = 31-chart
    return 480*dimensions(chart, degree)/259259*math.comb(q+degree, degree)/3003


def monitored_run(command, environment, log, timeout, memory_bytes, tick):
    """One child process group; soft-stop native work to preserve checkpoints."""
    child = subprocess.Popen(command, env=environment, stdout=log,
                             stderr=subprocess.STDOUT, start_new_session=True)
    began = time.monotonic()
    reason = None
    stopped = None
    peak = 0
    while child.poll() is None:
        processes = subprocess.check_output(["ps", "-axo", "pgid=,rss="], text=True)
        rss = sum(int(row.split()[1])*1024 for row in processes.splitlines()
                  if row.split() and int(row.split()[0]) == child.pid)
        peak = max(peak, rss)
        now = time.monotonic()
        if stopped is None and (rss > memory_bytes or now-began > timeout):
            reason = "memory_limit" if rss > memory_bytes else "time_limit"
            os.killpg(child.pid, signal.SIGTERM)
            stopped = now
        elif stopped is not None and now-stopped > 30:
            os.killpg(child.pid, signal.SIGKILL)
        tick(child.pid, now-began, rss, peak)
        time.sleep(2)
    return child.returncode, reason, peak


def save(path, data):
    temporary = path.with_suffix(".tmp")
    temporary.write_text(json.dumps(data, indent=2) + "\n")
    temporary.replace(path)


def column_mode(folder, setting):
    """Auto preserves saved congruence coordinates; only fresh jobs use mode1."""
    checkpoint = folder / "checkpoint.bin"
    if setting != "auto":
        return int(setting)
    if not checkpoint.exists():
        return 1
    with checkpoint.open("rb") as stream:
        header = stream.read(8)
    if len(header) != 8:
        raise ValueError("truncated native checkpoint header")
    magic, = struct.unpack("<Q", header)
    modes = {0x4c414e435a4f5331: 0, 0x4c414e435a4f5332: 1}
    if magic not in modes:
        raise ValueError("unknown native checkpoint version")
    return modes[magic]


def display(folder):
    state = json.loads((folder / "sweep.json").read_text())
    jobs = state["jobs"]
    done = sum(j["status"] in TERMINAL for j in jobs)
    units = sum(j["status"] == "verified_original_polynomial_unit_certificate" for j in jobs)
    active = next((j for j in jobs if j["status"] not in TERMINAL | {"pending"}), None)
    remaining = sum(min(j["estimated_seconds"], state.get("seconds_per_job", 3600))+12
                    for j in jobs if j["status"] == "pending")
    detail = ""
    if active:
        progress_path = folder / active["name"] / "solve" / "progress.json"
        progress = json.loads(progress_path.read_text()) if progress_path.exists() else {}
        eta = progress.get("estimated_remaining_seconds", -1)
        if eta < 0:
            eta = max(0, active["estimated_seconds"]-active.get("stage_seconds", 0))
        budget = max(0, state.get("seconds_per_job", 3600)-active.get("stage_seconds", 0))
        remaining += min(eta, budget)+12
        detail = (f" | {active['name']}: {active['status']} "
                  f"{progress.get('percent_of_dimension', 0):.1f}%"
                  f" ({progress.get('steps', 0):,}/{progress.get('search_columns', progress.get('columns', 0)):,} steps)"
                  f" | chart ETA ~{eta/60:.1f}min, slot left {budget/60:.1f}min")
    print(f"{done}/{len(jobs)} tests finished; {units} verified exclusions"
          f" | batch ETA ~{remaining/60:.1f}min{detail}", flush=True)
    if state.get("status") in {"overnight_budget_reached", "disk_space_pause"}:
        print(state["status"]+"; pending jobs are preserved for the next launch.", flush=True)
        return True
    return done == len(jobs)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--out", type=Path, required=True)
    parser.add_argument("--watch", action="store_true")
    parser.add_argument("--seconds", type=int, default=120)
    parser.add_argument("--threads", type=int, default=10)
    parser.add_argument("--all-supported", action="store_true",
                        help="Queue every unverified F25 chart; reduce multiplier degree if needed to fit")
    parser.add_argument("--max-columns", type=int, default=1000000)
    parser.add_argument("--memory-gib", type=float, default=6)
    parser.add_argument("--max-hours", type=float, default=10)
    parser.add_argument("--resume-limited", action="store_true",
                        help="Explicitly resume checkpointed time-limited solver jobs")
    parser.add_argument("--plan-only", action="store_true")
    parser.add_argument("--native", type=Path, default=DATA / "atlas_lanczos_native")
    parser.add_argument("--components", action="store_true",
                        help="Exact target-support pruning, with full-operator fallback")
    parser.add_argument("--column-scaling", choices=("0", "1", "auto"), default="0",
                        help="Auto retains checkpoint coordinates; scales only fresh jobs")
    args = parser.parse_args()
    if args.watch:
        while not display(args.out):
            time.sleep(5)
        return
    assert 1 <= args.threads <= 10 and 1 <= args.seconds <= 3600
    args.out.mkdir(parents=True, exist_ok=True)
    lock = (args.out / "controller.lock").open("a")
    fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
    census = json.loads((DATA / "atlas-all18/all18.json").read_text())
    state_path = args.out / "sweep.json"
    if state_path.exists():
        state = json.loads(state_path.read_text())
        if args.resume_limited:
            for job in state["jobs"]:
                if job["status"] == "time_limit" and (args.out/job["name"]/"solve/checkpoint.bin").exists():
                    job["status"] = "pending"
    else:
        # Explicitly selected inexpensive charts. Earlier basis=1 outputs
        # here lack independently checked polynomial certificates.
        jobs = []
        choices = [("orbit_0000", [27, 26, 25, 24]),
                   ("invariant_0", [26, 25, 24]), ("invariant_1", [26, 25, 24])]
        prior = set()
        if args.all_supported:
            choices = [(name, list(range(31, -1, -1))) for name, _ in choices]
            for receipt in DATA.glob("degree5-*-sweep-*/sweep.json"):
                for job in json.loads(receipt.read_text())["jobs"]:
                    if job["status"] == "verified_original_polynomial_unit_certificate":
                        proof = json.loads(Path(job["certificate"]).read_text())
                        if proof["status"] == job["status"] and proof["identity_sum_original_rows_times_multipliers_equals_one_verified"]:
                            source = Path(proof["source"])
                            if hashlib.sha256(source.read_bytes()).hexdigest() == proof["source_sha256"]:
                                prior.add((job["representative"], job["chart"]))
        for representative, charts in choices:
            owner = census["jobs"][representative]
            manifest = json.loads((Path(owner["charts"]) / "manifest.json").read_text())
            ledger = {str(j["chart"]): j for j in manifest["jobs"]}
            ledger.update(json.loads((Path(owner["charts"]) / "run.json").read_text())["jobs"])
            for chart in charts:
                if ledger.get(str(chart), {}).get("status") in VERIFIED or (representative, chart) in prior:
                    continue
                degree = 5
                # The exact dual for this precise ansatz is already checked.
                if args.all_supported and representative == "orbit_0000" and chart == 21:
                    degree = 6
                while dimensions(chart, degree) > args.max_columns and degree > 1:
                    degree -= 1
                prediction = estimate(chart, degree)
                jobs.append(dict(name=f"{representative}-chart-{chart:02d}",
                    representative=representative, chart=chart, tensor=owner["tensor"],
                    charts=owner["charts"], b_degree=degree, columns_bound=dimensions(chart, degree),
                    status="pending", estimated_seconds=prediction+12))
        # First finish as many degree-five tests as practical, then visit
        # every earlier chart at its smaller, memory-bounded degree.
        jobs.sort(key=lambda j: (j["b_degree"] < 5, j["estimated_seconds"]))
        state = dict(status="running", created=time.time(), jobs=jobs,
            scope="Only supported F25 rooted charts; degrees recorded per job. Not all18, not the common-cover problem.")
        save(state_path, state)
    if args.plan_only:
        print(json.dumps({"jobs": len(state["jobs"]), "degree_counts": {
            str(d):sum(j.get("b_degree", 5)==d for j in state["jobs"]) for d in range(1,7)},
            "scope":state["scope"]}, indent=2))
        return
    environment = os.environ.copy()
    environment.update(ATLAS_GRAM_TEAM="1", VECLIB_MAXIMUM_THREADS="1",
                       OMP_WAIT_POLICY="PASSIVE", OMP_NUM_THREADS=str(args.threads))
    environment["ATLAS_GRAM_COMPONENTS"] = "1" if args.components else "0"
    binary = args.native.resolve(strict=True)
    # These positive certificates forbid unit identities in the WEAK ideal
    # at every degree. They say nothing about the full normalized atlas.
    from verify_atlas_weak_points import verify as verify_weak_points
    weak_points = {(p["representative"], p["chart"]): p for p in verify_weak_points()}
    state["controller_pid"] = os.getpid()
    state["binary_sha256"] = hashlib.sha256(binary.read_bytes()).hexdigest()
    state["binary"] = str(binary)
    state["components"] = args.components
    state["column_scaling"] = args.column_scaling
    state["threads"] = args.threads
    state["seconds_per_job"] = args.seconds
    state["status"] = "running"
    launch_time = time.monotonic()
    save(state_path, state)
    for job in state["jobs"]:
        if job["status"] in TERMINAL:
            continue
        point = weak_points.get((job["representative"], job["chart"]))
        if point is not None:
            assert hashlib.sha256(Path(job["tensor"]).read_bytes()).hexdigest() == point["source_sha256"]
            job["status"] = "weak_subsystem_has_point"
            job["weak_point"] = point
            job["note"] = "Exact point forbids weak-only unit search; full atlas is NOT decided."
            save(state_path, state)
            continue
        if time.monotonic()-launch_time >= args.max_hours*3600:
            state["status"] = "overnight_budget_reached"
            break
        if shutil.disk_usage(args.out).free < 12*1024**3:
            state["status"] = "disk_space_pause"
            break
        folder = args.out / job["name"]
        folder.mkdir(exist_ok=True)
        common = ["sage", str(ROOT / "scripts/mixed_atlas_certificate.sage"),
                  "--tensor", job["tensor"], "--atlas-input", job["charts"],
                  "--representative", job["representative"], "--chart", str(job["chart"]),
                  "--v-degree", "0", "--b-degree", str(job.get("b_degree", 5))]
        started = time.monotonic()

        def run(stage, command, timeout):
            job["status"] = stage
            job["stage_seconds"] = 0
            save(state_path, state)
            print(job["name"], stage, flush=True)
            with (folder / f"{stage}.log").open("a") as log:
                def tick(pid, seconds, rss, peak):
                    job.update(child_pid=pid, stage_seconds=seconds, rss_bytes=rss,
                               peak_rss_bytes=max(peak, job.get("peak_rss_bytes", 0)))
                    save(state_path, state)
                code, limit_reason, peak = monitored_run(command, environment, log,
                    timeout, args.memory_gib*1024**3, tick)
                if limit_reason:
                    job["limit_reason"] = limit_reason
                return code

        try:
            if run("export", common + ["--output", str(folder / "input"), "--export-only"], 600):
                raise RuntimeError("input export failed")
            matrix = folder / "input/matrix.bin"
            meta = json.loads((folder / "input/matrix.json").read_text())
            degree = job.get("b_degree", 5)
            multipliers = math.comb(31-job["chart"]+degree, degree)
            assert meta["rows"] % multipliers == 0
            equations = meta["rows"] // multipliers
            result_path = folder / "solve/result.json"
            if not result_path.exists():
                mode = column_mode(folder / "solve", args.column_scaling)
                job["solver_configuration"] = dict(binary=str(binary),
                    binary_sha256=state["binary_sha256"], components=args.components,
                    column_scaling=mode, threads=args.threads)
                run("solve", [str(binary), str(matrix), str(folder / "solve"),
                    str(args.seconds), str(equations), "20260908", "8", str(args.threads), "0", str(mode)], args.seconds+60)
            if not result_path.exists():
                job["status"] = job.get("limit_reason") or ("time_limit" if (folder / "solve/checkpoint.bin").exists() else "inconclusive")
            else:
                result = json.loads(result_path.read_text())
                if result["primal_verified"] or result["dual_verified"]:
                    kind = "primal" if result["primal_verified"] else "dual"
                    certificate = folder / "solve" / ("solution.bin" if kind == "primal" else "dual.bin")
                    assert run("scalar_verify", [sys.executable, str(ROOT / "scripts/verify_sparse_linear_certificate.py"),
                        str(matrix), str(certificate), "--kind", kind], 600) == 0
                    if kind == "primal":
                        assert run("polynomial_verify", common + ["--output", str(folder / "proof"),
                            "--verify-weights", str(certificate)], 600) == 0
                        job["status"] = "verified_original_polynomial_unit_certificate"
                        job["certificate"] = str(folder / "proof/original_polynomial_certificate.json")
                    else:
                        job["status"] = "exact_bounded_dual"
                    job["certificate_sha256"] = hashlib.sha256(certificate.read_bytes()).hexdigest()
                else:
                    job["status"] = "inconclusive"
                job["solver_result"] = result
        except (Exception, subprocess.TimeoutExpired) as exc:
            job["status"] = job.get("limit_reason", "needs_attention")
            job["error"] = str(exc)
        job["elapsed_seconds"] = time.monotonic()-started
        save(state_path, state)
        display(args.out)
    if all(job["status"] in TERMINAL for job in state["jobs"]):
        state["status"] = "complete"
    save(state_path, state)
    display(args.out)


if __name__ == "__main__":
    main()
