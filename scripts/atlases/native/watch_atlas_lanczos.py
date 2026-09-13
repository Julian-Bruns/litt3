#!/usr/bin/env python3
"""Read-only solver progress display; --follow never wakes an agent."""
import argparse
import json
import time
from pathlib import Path


def duration(seconds):
    seconds = max(0, int(seconds))
    return f"{seconds // 3600}h {(seconds // 60) % 60:02d}m {seconds % 60:02d}s"


def show(directory):
    path = directory / "progress.json"
    if not path.exists():
        print("Loading matrix and checking arithmetic; first progress sample pending.", flush=True)
        return False
    data = json.loads(path.read_text())
    age = time.time() - path.stat().st_mtime
    stage = data["stage"]
    finished = stage not in ("lanczos",)
    estimate = data["estimated_remaining_seconds"]
    eta = duration(max(0, estimate - age)) if estimate >= 0 else "first sample pending"
    print(
        f"{stage}: {data['steps']:,}/{data['columns']:,} search steps "
        f"({data['percent_of_dimension']:.1f}%) | ETA ~{eta} | "
        f"elapsed {duration(data['cumulative_seconds'])} | "
        f"CPU average {data['average_cpu_cores']:.1f} cores / "
        f"{data['threads']} configured | sample {age:.0f}s old",
        flush=True,
    )
    if age > 45 and not finished:
        print("Progress sample is stale; check the process/log before trusting the ETA.", flush=True)
    if finished:
        print("Only a verified unit excludes this chart; a dual excludes only this bounded search.", flush=True)
    return finished


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("directory", type=Path)
    parser.add_argument("--follow", action="store_true")
    args = parser.parse_args()
    while True:
        finished = show(args.directory)
        if finished or not args.follow:
            break
        time.sleep(5)
