#!/usr/bin/env python3
"""Inventory exact source records and validate honest formal coverage (stdlib).

Reports are generated outside the research workspace. A pending source is
not a Lean theorem, and a component is never promoted by its build status.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
from collections import Counter
from pathlib import Path

FORMALIZATION = Path(__file__).resolve().parents[1]
ROOT = FORMALIZATION.parent
DEFAULT_REPORT = ROOT.parent / "litt3-computation-data/formalization-20261003/coverage.json"
ALLOWED = {"pending", "partial_component", "complete"}
FAMILY_OWNERS = {
    "atlases": "root",
    "shared_tensors": "root",
    "projective_connections": "root",
    "cartier_and_spin": "cartier_spin",
    "deformations": "deformations",
    "jacobians": "jacobians_geometry",
    "quotient_geometry": "jacobians_geometry",
    "curve_arithmetic": "jacobians_geometry",
    "examples": "jacobians_geometry",
}


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def source_inventory() -> list[dict]:
    library = json.loads((ROOT / "Research/library.json").read_text())
    by_path = {r["statement"]: r for r in library["theorems"]}
    records = []
    for path in sorted((ROOT / "Theorems").rglob("*.md")):
        rel = path.relative_to(ROOT).as_posix()
        src = by_path.get(rel)
        records.append({
            "theorem_id": src["id"] if src else path.stem,
            "source_path": rel,
            "assigned_owner": "root" if len(path.relative_to(ROOT / "Theorems").parts) == 1
                else FAMILY_OWNERS.get(path.relative_to(ROOT / "Theorems").parts[0]),
            "source_sha256": digest(path),
            "source_registered": src is not None,
            "source_status": src.get("status") if src else "uncatalogued",
            "source_verification": src.get("verification") if src else None,
            "statement_version": src.get("statement_version") if src else None,
            "proof_path": src.get("proof") if src else None,
            "proof_sha256": digest(ROOT / src["proof"])
                if src and src.get("proof") and (ROOT / src["proof"]).exists() else None,
            "dependencies": src.get("dependencies", []) if src else [],
            "definition_ids": src.get("definitions", []) if src else [],
            "scope": src.get("scope") if src else None,
            "library_statement_sha256": src.get("statement_sha256") if src else None,
            "library_proof_sha256": src.get("proof_sha256") if src else None,
            "library_record_sha256": hashlib.sha256(
                json.dumps(src, sort_keys=True, ensure_ascii=False).encode()).hexdigest()
                if src else None,
            "status": "pending",
            "components": [],
            "gap": "The exact canonical statement has not been formalized.",
        })
    for rel, src in by_path.items():
        if not (ROOT / rel).exists():
            records.append({
                "theorem_id": src["id"], "source_path": rel,
                "assigned_owner": "root" if len(Path(rel).parts) == 2
                    else FAMILY_OWNERS.get(Path(rel).parts[1]),
                "source_registered": True, "source_missing": True,
                "source_status": src.get("status"), "status": "pending",
                "components": [], "gap": "Registered statement file is missing.",
            })
    return records


def make_report() -> dict:
    records = source_inventory()
    by_id = {r["theorem_id"]: r for r in records}
    errors, warnings = [], []
    if len(by_id) != len(records):
        errors.append("Duplicate theorem IDs in source inventory.")
    owners = {}
    for path in sorted((FORMALIZATION / "Coverage").glob("*.json")):
        fragment = json.loads(path.read_text())
        entries = fragment.get("entries", fragment.get("records", []))
        if not isinstance(entries, list):
            errors.append(f"{path.name}: entries is not a list")
            continue
        for entry in entries:
            tid = entry.get("theorem_id")
            if tid not in by_id:
                warnings.append(f"{path.name}: unknown or stale theorem ID {tid}")
                continue
            if tid in owners:
                errors.append(f"Overlapping coverage for {tid}: {owners[tid]}, {path.name}")
                continue
            owners[tid] = path.name
            status = entry.get("status", "pending")
            if status not in ALLOWED:
                errors.append(f"{tid}: unsupported status {status}")
                continue
            current = by_id[tid]
            if entry.get("source_path") != current["source_path"]:
                errors.append(f"{tid}: canonical source path does not match")
            if entry.get("source_sha256") != current.get("source_sha256"):
                warnings.append(f"{tid}: source changed since coverage review")
                status = "pending"
            sync = {"statement": "matched" if entry.get("source_sha256") ==
                    current.get("source_sha256") else "changed"}
            # A human-proof revision does not invalidate a checked Lean proof of
            # an unchanged statement. It does require a fresh source-scope review.
            # Older fragments used proof_sha256; retain that baseline without
            # letting it overwrite the inventory's current proof hash below.
            reviewed_proof = entry.get("reviewed_proof_sha256") or entry.get(
                "source_proof_sha256") or entry.get("proof_sha256")
            reviewed_path = entry.get("reviewed_proof_path") or entry.get(
                "source_proof_path") or entry.get("proof_path")
            if not current.get("proof_path"):
                sync["proof"] = "not_applicable"
            elif reviewed_proof is None:
                sync["proof"] = "missing_baseline"
            elif reviewed_proof != current.get("proof_sha256") or (
                    reviewed_path is not None and reviewed_path != current.get("proof_path")):
                sync["proof"] = "changed"
            else:
                sync["proof"] = "matched"
            for key, reviewed_key in (("dependencies", "reviewed_dependencies"),
                                      ("definition_ids", "reviewed_definition_ids")):
                reviewed = entry.get(reviewed_key)
                sync[key] = "missing_baseline" if reviewed is None else (
                    "matched" if set(reviewed) == set(current.get(key, [])) else "changed")
            if status in {"partial_component", "complete"}:
                if sync["proof"] == "missing_baseline":
                    warnings.append(f"{tid}: human-proof review baseline is not recorded")
                elif sync["proof"] == "changed":
                    warnings.append(f"{tid}: human proof changed since coverage review")
                for key in ("dependencies", "definition_ids"):
                    if sync[key] == "changed":
                        warnings.append(f"{tid}: source {key} changed since coverage review")
            if status in {"partial_component", "complete"} and not entry.get("components"):
                errors.append(f"{tid}: proof coverage has no declarations")
            component_gaps = [c.get("gap") for c in entry.get("components", [])]
            if status == "partial_component" and not (
                    entry.get("gap") or component_gaps and all(component_gaps)):
                errors.append(f"{tid}: partial component omits the geometric/mathematical gap")
            if status == "complete" and not entry.get("full_statement_review"):
                errors.append(f"{tid}: complete status needs an exact statement review")
            for component in entry.get("components", []):
                module = component.get("module", "")
                if not module.startswith("Solutions."):
                    errors.append(f"{tid}: proof component must be a Solutions module")
                module_path = FORMALIZATION / (module.replace(".", "/") + ".lean")
                if not module_path.is_file():
                    errors.append(f"{tid}: missing module {module}")
                if not component.get("declaration") or not component.get("claim"):
                    errors.append(f"{tid}: component needs its exact declaration and claim")
            inventory_keys = {"theorem_id", "assigned_owner", "statement_version", "proof_path",
                              "proof_sha256", "dependencies", "definition_ids", "scope"}
            preserved = {key: current[key] for key in current if key.startswith(
                ("source_", "library_")) or key in inventory_keys}
            current.update(entry)
            if component_gaps and all(component_gaps) and not entry.get("gap"):
                current["gap"] = " ".join(dict.fromkeys(component_gaps))
            current.update(preserved)
            current["status"] = status
            current["coverage_owner"] = path.name
            current["archive_sync"] = sync
    files = sorted(FORMALIZATION.rglob("*.lean"))
    for path in files:
        if ".lake" in path.parts:
            continue
        # This source scan complements kernel dependency auditing, not replaces it.
        text = path.read_text()
        text = re.sub(r"/\-.*?\-/", "", text, flags=re.S)
        text = re.sub(r"--[^\n]*", "", text)
        text = re.sub(r'"(?:\\.|[^"\\])*"', '""', text)
        if re.search(r"\b(sorry|admit|axiom|native_decide)\b", text):
            errors.append(f"Forbidden proof escape in {path.relative_to(FORMALIZATION)}")
    ids = set(by_id)
    for record in records:
        if not record.get("assigned_owner"):
            errors.append(f"{record['theorem_id']}: no assigned family owner")
        for dep in record.get("dependencies", []):
            if dep not in ids:
                warnings.append(f"{record['theorem_id']}: missing source dependency {dep}")
        for field, actual in (("library_statement_sha256", "source_sha256"),
                              ("library_proof_sha256", "proof_sha256")):
            if record.get(field) is not None and record.get(field) != record.get(actual):
                warnings.append(f"{record['theorem_id']}: stale {field} in research library")
    return {
        "schema_version": 2,
        "template_revision": "9a62e6757c3f9f255affa95d01a41d3c8a5d03c6",
        "source_count": len(records),
        "source_status_counts": dict(Counter(r.get("source_status") for r in records)),
        "coverage_counts": dict(Counter(r["status"] for r in records)),
        "covered_ownership_count": len(owners),
        "assigned_owner_counts": dict(Counter(r.get("assigned_owner") for r in records)),
        "claimed_proof_sync_counts": dict(Counter(r.get("archive_sync", {}).get("proof")
            for r in records if r["status"] in {"partial_component", "complete"})),
        "errors": errors,
        "warnings": sorted(set(warnings)),
        "records": records,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--report", type=Path, default=DEFAULT_REPORT)
    args = parser.parse_args()
    report = make_report()
    args.report.parent.mkdir(parents=True, exist_ok=True)
    args.report.write_text(json.dumps(report, indent=2, ensure_ascii=False) + "\n")
    for key in ("source_count", "source_status_counts", "coverage_counts", "covered_ownership_count",
                "assigned_owner_counts"):
        print(f"{key}: {report[key]}")
    print(f"errors: {len(report['errors'])}; warnings: {len(report['warnings'])}")
    for error in report["errors"]:
        print(f"ERROR: {error}")
    print(f"Report: {args.report.resolve()}")
    return 1 if report["errors"] else 0


if __name__ == "__main__":
    raise SystemExit(main())
