#!/usr/bin/env python3
"""Read and mechanically maintain the local prose research library (stdlib only)."""

import argparse
import hashlib
import json
from pathlib import Path
import re
import sys


STATUSES = {"proved", "conditional", "open", "refuted", "superseded"}
VERIFICATIONS = {"audited_prose", "author_prose", "primary_source", "computation", "not_proved"}
DEFAULT_ROOT = Path(__file__).resolve().parents[1]


def read_json(path):
    return json.loads(path.read_text(encoding="utf-8"))


def write_json(path, value):
    """Explicit maintenance commands are the only callers of this writer."""
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def local_path(root, value):
    if not isinstance(value, str) or not value or Path(value).is_absolute():
        raise ValueError("expected a nonempty repository-relative path")
    path = (root / value).resolve()
    if not path.is_relative_to(root.resolve()):
        raise ValueError("path escapes the repository")
    return path


def load_library(root):
    library = read_json(root / "Research/library.json")
    if not isinstance(library, dict):
        raise ValueError("library.json must contain an object")
    for key in ("definitions", "theorems"):
        if not isinstance(library.get(key), list):
            raise ValueError(f"library.{key} must be an array")
    return library


def has_proof_heading(body):
    """Recognize Markdown headings, not ordinary prose containing 'proof'."""
    lines = body.splitlines()
    fenced = False
    fence_char = None
    for index, line in enumerate(lines):
        stripped = line.strip()
        if stripped.startswith(("```", "~~~")):
            if not fenced:
                fenced, fence_char = True, stripped[0]
            elif stripped[0] == fence_char:
                fenced = False
            continue
        if fenced:
            continue
        heading = re.match(r"^ {0,3}#{1,6}\s+(.+?)\s*#*\s*$", line)
        setext = index + 1 < len(lines) and re.fullmatch(r" {0,3}(?:=+|-+)\s*", lines[index + 1])
        label = heading.group(1) if heading else stripped if setext else None
        if label is not None:
            label = label.strip(" *_`")
            label = re.sub(r"^\d+(?:\.\d+)*[.)]?\s+", "", label)
            if re.match(r"(?i)^proof\b", label):
                return True
    return False


def validate(root):
    errors = []
    try:
        library = load_library(root)
    except (OSError, ValueError) as exc:
        return [str(exc)]
    if library.get("schema_version") != 1:
        errors.append("schema_version must be 1")
    definitions, theorems, all_ids = {}, {}, set()
    for kind, target in (("definitions", definitions), ("theorems", theorems)):
        for record in library[kind]:
            if not isinstance(record, dict):
                errors.append(f"{kind}: record must be an object")
                continue
            identifier = record.get("id")
            if not isinstance(identifier, str) or not identifier:
                errors.append(f"{kind}: missing or invalid id")
                continue
            if identifier in all_ids:
                errors.append(f"duplicate id: {identifier}")
            all_ids.add(identifier)
            target[identifier] = record
            if not isinstance(record.get("title"), str) or not record["title"].strip():
                errors.append(f"{identifier}: missing title")

    def check_file(identifier, field, value):
        try:
            path = local_path(root, value)
            if not path.is_file():
                raise ValueError("file does not exist")
            return path
        except (OSError, ValueError) as exc:
            errors.append(f"{identifier}: {field} {value!r}: {exc}")
            return None

    for identifier, record in definitions.items():
        check_file(identifier, "path", record.get("path"))
    graph = {}
    for identifier, record in theorems.items():
        if not isinstance(record.get("status"), str) or record["status"] not in STATUSES:
            errors.append(f"{identifier}: invalid status {record.get('status')!r}")
        if not isinstance(record.get("verification"), str) or record["verification"] not in VERIFICATIONS:
            errors.append(f"{identifier}: invalid verification {record.get('verification')!r}")
        statement = check_file(identifier, "statement", record.get("statement"))
        if statement:
            try:
                if has_proof_heading(statement.read_text(encoding="utf-8")):
                    errors.append(f"{identifier}: canonical statement contains a Proof heading")
                if "statement_sha256" in record and record["statement_sha256"] != digest(statement):
                    errors.append(f"{identifier}: statement_sha256 mismatch (statement drift)")
            except (OSError, UnicodeError) as exc:
                errors.append(f"{identifier}: unreadable statement: {exc}")
        if record.get("solution") is not None:
            check_file(identifier, "solution", record["solution"])
        elif record.get("status") == "proved":
            errors.append(f"{identifier}: proved theorem requires a solution")
        if record.get("source") is not None:
            check_file(identifier, "source", record["source"])
        audits = record.get("audits", [])
        if not isinstance(audits, list):
            errors.append(f"{identifier}: audits must be an array")
        else:
            for audit in audits:
                check_file(identifier, "audit", audit)
        legacy_dependencies = record.get("legacy_dependencies", [])
        if not isinstance(legacy_dependencies, list) or any(not isinstance(item, str) for item in legacy_dependencies):
            errors.append(f"{identifier}: legacy_dependencies must be an array of repository-relative paths")
        else:
            for legacy_dependency in legacy_dependencies:
                check_file(identifier, "legacy dependency", legacy_dependency)
        for field, registry in (("definitions", definitions), ("dependencies", theorems)):
            values = record.get(field)
            if not isinstance(values, list) or any(not isinstance(item, str) for item in values):
                errors.append(f"{identifier}: {field} must be an array of IDs")
                values = []
            for reference in values:
                if reference not in registry:
                    errors.append(f"{identifier}: unresolved {field} id {reference}")
                elif field == "dependencies" and record.get("status") == "proved" and registry[reference].get("status") != "proved":
                    errors.append(f"{identifier}: proved theorem depends on {registry[reference].get('status')} theorem {reference}")
            if field == "dependencies":
                graph[identifier] = [item for item in values if item in theorems]
    # Canonical files must not silently disappear from the continuation library.
    registered = {record.get("path") for record in definitions.values()}
    registered.update(record.get("statement") for record in theorems.values())
    registered.update(record.get("solution") for record in theorems.values())
    for folder in ("Definitions", "Theorems", "Solutions"):
        for path in (root / folder).glob("*.md"):
            relative = path.relative_to(root).as_posix()
            if path.name != "README.md" and relative not in registered:
                errors.append(f"unregistered canonical file: {relative}")
    # Iterative DFS avoids recursion limits on large libraries.
    colors = {}
    for start in graph:
        if colors.get(start):
            continue
        colors[start] = 1
        stack = [(start, iter(graph[start]))]
        while stack:
            current, edges = stack[-1]
            child = next(edges, None)
            if child is None:
                colors[current] = 2
                stack.pop()
            elif colors.get(child) == 1:
                errors.append(f"dependency cycle: {current} -> {child}")
            elif not colors.get(child):
                colors[child] = 1
                stack.append((child, iter(graph[child])))
    try:
        state = read_json(root / "Research/state.json")
        if not isinstance(state, dict) or not isinstance(state.get("active_target_ids"), list):
            errors.append("state.active_target_ids must be an array")
        else:
            for identifier in state["active_target_ids"]:
                if not isinstance(identifier, str) or identifier not in theorems:
                    errors.append(f"state: unresolved active target {identifier!r}")
    except (OSError, ValueError) as exc:
        errors.append(f"state: {exc}")
    return errors


def find_record(library, identifier):
    for record in library["definitions"] + library["theorems"]:
        if record["id"] == identifier:
            return record
    raise ValueError(f"unknown id: {identifier}")


def display(root, identifier, proof=False):
    record = find_record(load_library(root), identifier)
    path = record.get("solution") if proof else record.get("statement", record.get("path"))
    if not path:
        raise ValueError(f"{identifier}: no solution recorded")
    body = local_path(root, path).read_text(encoding="utf-8")
    if proof or "statement" not in record:
        return body
    metadata = [f"Status: {record['status']} | Verification: {record['verification']}"]
    if record.get("evidence_summary"):
        metadata.append(f"Evidence: {record['evidence_summary']}")
    metadata.append("Audits: " + (", ".join(record.get("audits", [])) or "none recorded"))
    return "\n".join(metadata) + "\n\n" + body


def dependencies(root, identifier):
    library = load_library(root)
    find_record(library, identifier)
    seen, lines, stack = set(), [], [(identifier, 0)]
    while stack:
        current, depth = stack.pop()
        record = find_record(library, current)
        repeat = current in seen
        lines.append(f"{'  ' * depth}{current} [{record.get('status', 'definition')}]" + (" (already shown)" if repeat else ""))
        if repeat:
            continue
        seen.add(current)
        for legacy_path in record.get("legacy_dependencies", []):
            lines.append(f"{'  ' * (depth + 1)}{legacy_path} [legacy proof input; unpromoted]")
        edges = record.get("definitions", []) + record.get("dependencies", [])
        stack.extend((child, depth + 1) for child in reversed(edges))
    return "\n".join(lines)


def search(root, words):
    terms = " ".join(words).casefold().split()
    library = load_library(root)
    results = []
    for record in library["definitions"] + library["theorems"]:
        metadata = " ".join(str(record.get(key, "")) for key in ("id", "title", "scope", "source"))
        if all(term in metadata.casefold() for term in terms):
            results.append(f"canonical\t{record['id']}\t{record['title']}")
    inventory_path = root / "Research/legacy_inventory.json"
    if len(results) < 20 and inventory_path.exists():
        inventory = read_json(inventory_path)
        for record in inventory["entries"]:
            metadata = f"{record['title']} {record['path']}".casefold()
            if all(term in metadata for term in terms):
                results.append(f"{record['classification']}\t{record['path']}\t{record['title']}")
                if len(results) >= 20:
                    break
    return "\n".join(results[:20])


def inventory(root):
    paths = set()
    for folder in ("routes", "archive", "tasks"):
        paths.update((root / folder).rglob("*.md"))
    excluded = {"readme", "update", "structure", "agents", "changelog", "license", "contributing", "code_of_conduct", "security"}
    paths.update(path for path in root.glob("*.md") if path.stem.casefold() not in excluded)
    entries = []
    for path in sorted(paths):
        relative = path.relative_to(root).as_posix()
        # Resolve through the same boundary check used by the read commands.
        path = local_path(root, relative)
        raw = path.read_bytes()
        body = raw.decode("utf-8", errors="replace")
        title = next((line.lstrip("# ").strip() for line in body.splitlines() if re.match(r"^#{1,6}\s+", line)), path.stem)
        lower = relative.casefold()
        if re.search(r"(?im)^\s*(?:>\s*)?(?:\*\*)?(?:redirect\b|moved to\b|canonical (?:statement|location)\s*:)", body) or (len(raw) < 1800 and re.search(r"\]\([^)]*(?:Theorems/Thm_|Solutions/Sol_)", body)):
            classification = "redirect"
        elif "audit" in lower:
            classification = "audit_reference_only"
        elif lower.startswith("archive/") or any(word in Path(lower).stem for word in ("frontier", "checkpoint", "session", "handoff")):
            classification = "historical_checkpoint"
        else:
            classification = "legacy_unreviewed"
        entries.append({"path": relative, "title": title, "sha256": hashlib.sha256(raw).hexdigest(), "bytes": len(raw), "classification": classification})
    value = {"schema_version": 1, "entries": entries}
    write_json(root / "Research/legacy_inventory.json", value)
    return len(entries)


def stamp(root):
    library = load_library(root)
    pending = []
    for record in library["theorems"]:
        actual = digest(local_path(root, record["statement"]))
        if "statement_sha256" in record:
            if record["statement_sha256"] != actual:
                raise ValueError(f"{record['id']}: statement_sha256 mismatch; existing hashes are never updated")
        else:
            pending.append((record, actual))
    for record, actual in pending:
        record["statement_sha256"] = actual
    if pending:
        write_json(root / "Research/library.json", library)
    return len(pending)


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=DEFAULT_ROOT)
    commands = parser.add_subparsers(dest="command", required=True)
    for name in ("validate", "show", "proof", "dependencies", "frontier", "search", "inventory", "stamp"):
        command = commands.add_parser(name)
        command.add_argument("--root", type=Path, default=argparse.SUPPRESS)
        if name in {"show", "proof", "dependencies"}:
            command.add_argument("id")
        elif name == "search":
            command.add_argument("words", nargs="+")
    args = parser.parse_args(argv)
    root = args.root.resolve()
    try:
        if args.command == "validate":
            errors = validate(root)
            if errors:
                print("\n".join(errors), file=sys.stderr)
                return 1
            print("Workspace valid (structure only; no mathematical verification).")
        elif args.command in {"show", "proof"}:
            print(display(root, args.id, proof=args.command == "proof"), end="")
        elif args.command == "dependencies":
            print(dependencies(root, args.id))
        elif args.command == "frontier":
            print((root / "Research/STATE.md").read_text(encoding="utf-8"), end="")
        elif args.command == "search":
            print(search(root, args.words))
        elif args.command == "inventory":
            print(f"Indexed {inventory(root)} legacy Markdown files.")
        elif args.command == "stamp":
            print(f"Recorded {stamp(root)} missing statement hashes.")
    except (OSError, ValueError, KeyError, TypeError) as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
