#!/usr/bin/env python3
"""Build every actual solution and audit its transitive Lean axiom dependencies."""
from __future__ import annotations

import argparse
import hashlib
import json
import subprocess
import sys
import re
from datetime import datetime, timezone
from pathlib import Path

FORMALIZATION = Path(__file__).resolve().parents[1]
ARTIFACT_ROOT = FORMALIZATION.parent.parent / "litt3-computation-data/formalization-20261003"


def run(command: list[str], logfile: Path) -> subprocess.CompletedProcess:
    result = subprocess.run(command, cwd=FORMALIZATION, text=True,
                            stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    logfile.write_text(result.stdout)
    return result


def local_dependencies(modules: list[str]) -> list[Path]:
    """Include every locally imported definition and statement in the snapshot."""
    pending = list(modules)
    paths: set[Path] = set()
    while pending:
        module = pending.pop()
        path = FORMALIZATION / (module.replace(".", "/") + ".lean")
        if not path.is_file() or path in paths:
            continue
        paths.add(path)
        for line in path.read_text().splitlines():
            match = re.match(r"^\s*import\s+(.+?)\s*(?:--.*)?$", line)
            if match:
                pending.extend(match.group(1).split())
    paths.add(FORMALIZATION / "scripts/TrustAudit.lean")
    return sorted(paths)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--artifact-root", type=Path, default=ARTIFACT_ROOT)
    parser.add_argument("--module", action="append", default=[],
                        help="Audit a stable solution and its imports; repeat to select several.")
    args = parser.parse_args()
    stamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    out = args.artifact_root / "verification" / stamp
    out.mkdir(parents=True, exist_ok=False)
    solutions = sorted((FORMALIZATION / "Solutions").rglob("*.lean"))
    available = [p.relative_to(FORMALIZATION).with_suffix("").as_posix().replace("/", ".")
                 for p in solutions]
    modules = sorted(set(args.module)) if args.module else available
    unknown = sorted(set(modules) - set(available))
    if unknown:
        parser.error(f"Unknown solution modules: {', '.join(unknown)}")
    sources = local_dependencies(modules)
    hashes = {p.relative_to(FORMALIZATION).as_posix(): hashlib.sha256(p.read_bytes()).hexdigest()
              for p in sources}
    commands = [["lake", "build", *modules], ["lake", "env", "lean", "--version"]]
    build = run(commands[0], out / "build.log")
    if build.returncode:
        print(build.stdout[-12000:])
        print(f"Build failed. Evidence: {out}")
        return build.returncode
    version = run(commands[1], out / "lean-version.log")
    audit_source = "\n".join(f"import {m}" for m in modules) + "\n"
    audit_source += (FORMALIZATION / "scripts/TrustAudit.lean").read_text() + "\n#audit_litt3_axioms\n"
    # All imports must precede the first ordinary command/declaration.
    lines = audit_source.splitlines()
    imports = [line for line in lines if line.startswith("import ")]
    body = [line for line in lines if not line.startswith("import ")]
    audit_source = "\n".join(dict.fromkeys(imports)) + "\n" + "\n".join(body) + "\n"
    audit_file = out / "TrustAudit.lean"
    audit_file.write_text(audit_source)
    command = ["lake", "env", "lean", str(audit_file)]
    commands.append(command)
    audit = run(command, out / "axioms.log")
    rows = []
    for line in audit.stdout.splitlines():
        if line.startswith("{"):
            try:
                row = json.loads(line)
            except json.JSONDecodeError:
                continue
            if isinstance(row, dict) and {"declaration", "axioms", "forbidden"} <= row.keys():
                rows.append(row)
    forbidden = [r for r in rows if r["forbidden"]]
    after = {p.relative_to(FORMALIZATION).as_posix(): hashlib.sha256(p.read_bytes()).hexdigest()
             for p in sources}
    changed = sorted(path for path in hashes if hashes[path] != after.get(path))
    all_axioms = sorted({a for row in rows for a in row["axioms"]})
    report = {
        "started_utc": stamp, "commands": commands,
        "lean_version": version.stdout.strip(),
        "solution_modules": modules, "local_dependency_source_hashes": hashes,
        "build_returncode": build.returncode, "audit_returncode": audit.returncode,
        "checked_declaration_count": len(rows), "axioms": all_axioms,
        "forbidden_dependencies": forbidden, "changed_during_check": changed,
        "declarations": rows,
        "scope": "Build and axiom audit of actual solution modules; no completeness claim for pending source theorems.",
    }
    (out / "report.json").write_text(json.dumps(report, indent=2) + "\n")
    print(f"Built {len(modules)} solution modules; audited {len(rows)} declarations.")
    print(f"Transitive axioms: {', '.join(all_axioms) or '(none)'}")
    print(f"Forbidden dependencies: {len(forbidden)}; source changes during check: {len(changed)}")
    print(f"Evidence: {out}")
    if audit.returncode:
        print(audit.stdout[-8000:])
    if not rows:
        print("ERROR: No declarations were audited.")
    return 1 if audit.returncode or forbidden or changed or not rows else 0


if __name__ == "__main__":
    sys.exit(main())
