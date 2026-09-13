#!/usr/bin/env python3
"""Detached, one-shot hourly marker. Never opens a chat or runs a polling loop."""

import argparse
import datetime
import json
import os
from pathlib import Path
import subprocess
import sys
import threading
import time


parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("action", choices=("arm", "check", "worker"))
parser.add_argument("--seconds", type=float, default=3600)
parser.add_argument("--marker", type=Path, required=True)
args = parser.parse_args()
marker = args.marker.resolve()

if args.action == "worker":
    # One kernel-backed wait in a DETACHED process, not the agent/tool process.
    threading.Event().wait(args.seconds)
    record = json.loads(marker.read_text())
    if record["pid"] == os.getpid():
        record.update(status="due", fired_at=time.time())
        marker.write_text(json.dumps(record) + "\n")
elif args.action == "arm":
    if args.seconds <= 0:
        parser.error("--seconds must be positive")
    child = subprocess.Popen(
        [sys.executable, str(Path(__file__).resolve()), "worker",
         "--seconds", str(args.seconds), "--marker", str(marker)],
        stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL, start_new_session=True, close_fds=True,
    )
    due = time.time() + args.seconds
    record = dict(pid=child.pid, status="armed", due_at=due,
                  due_utc=datetime.datetime.fromtimestamp(
                      due, datetime.timezone.utc).isoformat())
    marker.write_text(json.dumps(record) + "\n")
    print(json.dumps(record))
    # Deliberately no child.wait(), communicate(), join(), or polling loop.
else:
    print(marker.read_text().strip() if marker.exists() else "No reminder armed.")
