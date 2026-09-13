#!/usr/bin/env python3
"""One passive sleep until the cleanup deadline; no polling or research work."""
from datetime import datetime, timezone
import json
from pathlib import Path
import time

session = Path(__file__).resolve().parents[1] / "Research/cleanup/SESSION.json"
deadline = datetime.fromisoformat(json.loads(session.read_text())["deadline_utc"].replace("Z", "+00:00"))
time.sleep(max(0.0, (deadline - datetime.now(timezone.utc)).total_seconds()))
session.with_name("DEADLINE_REACHED.txt").write_text(
    "Cleanup deadline reached: " + deadline.isoformat() + "\n", encoding="utf-8"
)
