import contextlib
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import tempfile
import unittest
from unittest import mock


SPEC = importlib.util.spec_from_file_location("workspace", Path(__file__).resolve().parents[1] / "scripts/research_workspace.py")
workspace = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(workspace)


class WorkspaceTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.write("Definitions/base.md", "# Base\nA definition.\n")
        self.write("Theorems/a.md", "# A\n## Statement\nUnder H, C holds.\n")
        self.write("Solutions/a.md", "# Proof\nSECRET SOLUTION BODY\n")
        self.write("routes/source.md", "# Original note\n")
        self.write("Research/STATE.md", "Active frontier.\n")
        self.library = {"schema_version": 1, "definitions": [{"id": "base", "title": "Base conventions", "path": "Definitions/base.md"}], "theorems": [{"id": "a", "title": "Theorem A", "statement": "Theorems/a.md", "solution": "Solutions/a.md", "status": "proved", "verification": "author_prose", "definitions": ["base"], "dependencies": [], "audits": [], "source": "routes/source.md", "scope": "H only", "statement_version": 1}]}
        self.save()
        self.write("Research/state.json", json.dumps({"active_target_ids": ["a"]}))

    def write(self, path, text):
        destination = self.root / path
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_text(text, encoding="utf-8")

    def save(self):
        self.write("Research/library.json", json.dumps(self.library))

    def add_theorem(self, identifier="b", status="proved"):
        record = dict(self.library["theorems"][0], id=identifier, status=status, dependencies=[])
        self.library["theorems"].append(record)
        return record

    def test_valid_library(self):
        self.assertEqual(workspace.validate(self.root), [])

    def test_cycle(self):
        self.add_theorem()["dependencies"] = ["a"]
        self.library["theorems"][0]["dependencies"] = ["b"]
        self.save()
        self.assertIn("dependency cycle", "\n".join(workspace.validate(self.root)))

    def test_unregistered_canonical_file_is_not_silently_lost(self):
        self.write("Theorems/Thm_forgotten.md", "# Forgotten result\nA statement.\n")
        self.write("Solutions/Sol_forgotten.md", "# Proof\nAn argument.\n")
        self.write("Definitions/Def_forgotten.md", "# Definition\nAn object.\n")
        errors = "\n".join(workspace.validate(self.root))
        for folder, name in (("Theorems", "Thm"), ("Solutions", "Sol"), ("Definitions", "Def")):
            self.assertIn(f"unregistered canonical file: {folder}/{name}_forgotten.md", errors)

    def test_proved_cannot_depend_on_unproved_statuses(self):
        second = self.add_theorem()
        self.library["theorems"][0]["dependencies"] = ["b"]
        for status in ("open", "conditional", "refuted", "superseded"):
            with self.subTest(status=status):
                second["status"] = status
                self.save()
                self.assertIn(f"depends on {status}", "\n".join(workspace.validate(self.root)))

    def test_missing_definition(self):
        self.library["theorems"][0]["definitions"] = ["missing"]
        self.save()
        self.assertIn("unresolved definitions id missing", "\n".join(workspace.validate(self.root)))

    def test_hash_drift_and_stamp_refuses_to_rewrite(self):
        self.assertEqual(workspace.stamp(self.root), 1)
        before = (self.root / "Research/library.json").read_bytes()
        self.write("Theorems/a.md", "# Changed statement\nDifferent conclusion.\n")
        self.assertIn("statement drift", "\n".join(workspace.validate(self.root)))
        with self.assertRaisesRegex(ValueError, "never updated"):
            workspace.stamp(self.root)
        self.assertEqual(before, (self.root / "Research/library.json").read_bytes())

    def test_stamp_is_idempotent(self):
        self.assertEqual(workspace.stamp(self.root), 1)
        before = (self.root / "Research/library.json").read_bytes()
        self.assertEqual(workspace.stamp(self.root), 0)
        self.assertEqual(before, (self.root / "Research/library.json").read_bytes())
        record = workspace.load_library(self.root)["theorems"][0]
        self.assertEqual(record["statement_sha256"], hashlib.sha256((self.root / "Theorems/a.md").read_bytes()).hexdigest())

    def test_show_reads_statement_only(self):
        self.write("routes/audits/check.md", "# Audit\nPRIVATE AUDIT BODY\n")
        self.library["theorems"][0].update(audits=["routes/audits/check.md"], evidence_summary="Author proof with a retained audit record.")
        self.save()
        original = Path.read_text
        def guarded(path, *args, **kwargs):
            self.assertNotIn("Solutions", path.parts)
            self.assertNotIn("audits", path.parts)
            return original(path, *args, **kwargs)
        output = io.StringIO()
        with mock.patch.object(Path, "read_text", guarded), contextlib.redirect_stdout(output):
            self.assertEqual(workspace.main(["show", "a", "--root", str(self.root)]), 0)
        prefix = "Status: proved | Verification: author_prose\nEvidence: Author proof with a retained audit record.\nAudits: routes/audits/check.md\n\n"
        self.assertEqual(output.getvalue(), prefix + (self.root / "Theorems/a.md").read_text())
        self.assertNotIn("PRIVATE AUDIT BODY", output.getvalue())
        self.assertIn("SECRET SOLUTION BODY", workspace.display(self.root, "a", proof=True))

    def test_show_definition_preserves_original_display(self):
        self.assertEqual(workspace.display(self.root, "base"), (self.root / "Definitions/base.md").read_text())

    def test_show_optional_evidence_and_no_audits(self):
        shown = workspace.display(self.root, "a")
        self.assertTrue(shown.startswith("Status: proved | Verification: author_prose\nAudits: none recorded\n\n"))
        self.assertNotIn("Evidence:", shown)

    def test_legacy_dependencies_validate_and_display_without_loading(self):
        self.write("routes/input.md", "# Legacy input\nPRIVATE INPUT BODY\n")
        theorem = self.library["theorems"][0]
        theorem["legacy_dependencies"] = ["routes/input.md"]
        self.save()
        self.assertEqual(workspace.validate(self.root), [])
        original = Path.read_text
        def guarded(path, *args, **kwargs):
            self.assertEqual(path.suffix, ".json")
            return original(path, *args, **kwargs)
        with mock.patch.object(Path, "read_text", guarded):
            tree = workspace.dependencies(self.root, "a")
        self.assertIn("  routes/input.md [legacy proof input; unpromoted]", tree)
        self.assertNotIn("PRIVATE INPUT BODY", tree)
        theorem["legacy_dependencies"] = ["routes/missing.md"]
        self.save()
        self.assertIn("legacy dependency 'routes/missing.md': file does not exist", "\n".join(workspace.validate(self.root)))
        for value in ("routes/input.md", [42]):
            theorem["legacy_dependencies"] = value
            self.save()
            self.assertIn("legacy_dependencies must be an array", "\n".join(workspace.validate(self.root)))
        theorem["legacy_dependencies"] = ["../outside.md"]
        self.save()
        self.assertIn("path escapes the repository", "\n".join(workspace.validate(self.root)))

    def test_inventory_metadata_only_and_search_never_loads_bodies(self):
        self.write("routes/audits/check.md", "# Audit verification\nPRIVATE AUDIT BODY\n")
        self.write("archive/old.md", "# Historical note\nOLD BODY\n")
        self.write("tasks/problem.md", "# Open problem\nTASK BODY\n")
        self.write("TOP_MATH.md", "# Top mathematical note\n")
        self.write("README.md", "# Excluded\n")
        self.write("routes/moved.md", "# Moved theorem\nCanonical statement: [A](../Theorems/Thm_a.md)\n")
        self.assertEqual(workspace.inventory(self.root), 6)
        raw = (self.root / "Research/legacy_inventory.json").read_text()
        self.assertNotIn("PRIVATE AUDIT BODY", raw)
        self.assertNotIn("OLD BODY", raw)
        entries = {entry["path"]: entry for entry in json.loads(raw)["entries"]}
        self.assertEqual(entries["routes/audits/check.md"]["classification"], "audit_reference_only")
        self.assertEqual(entries["archive/old.md"]["classification"], "historical_checkpoint")
        self.assertEqual(entries["routes/moved.md"]["classification"], "redirect")
        self.assertNotIn("README.md", entries)
        original = Path.read_text
        def guarded(path, *args, **kwargs):
            self.assertEqual(path.suffix, ".json")
            return original(path, *args, **kwargs)
        with mock.patch.object(Path, "read_text", guarded):
            self.assertIn("audit_reference_only", workspace.search(self.root, ["audit"]))
            self.assertEqual(workspace.search(self.root, ["PRIVATE AUDIT BODY"]), "")
            self.assertIn("canonical\ta", workspace.search(self.root, ["H only"]))

    def test_proof_headings(self):
        for heading in ("## Proof", "### Proof sketch", "## 2. Proof of the theorem", "Proof\n-----"):
            with self.subTest(heading=heading):
                self.write("Theorems/a.md", "# A\n" + heading + "\nSteps.\n")
                self.assertIn("contains a Proof heading", "\n".join(workspace.validate(self.root)))
        self.write("Theorems/a.md", "# A\nThe proof is recorded separately.\n")
        self.assertEqual(workspace.validate(self.root), [])

    def test_ids_enums_paths_state_and_dependency_resolution(self):
        self.library["definitions"].append(dict(self.library["definitions"][0]))
        theorem = self.library["theorems"][0]
        theorem.update(status="done", verification="machine", definitions=["base"], dependencies=["missing"], statement="Theorems/absent.md")
        self.save()
        self.write("Research/state.json", json.dumps({"active_target_ids": ["absent"]}))
        errors = "\n".join(workspace.validate(self.root))
        for fragment in ("duplicate id", "invalid status", "invalid verification", "file does not exist", "unresolved active target", "unresolved dependencies"):
            self.assertIn(fragment, errors)

    def test_dependencies_and_frontier(self):
        self.assertEqual(workspace.dependencies(self.root, "a"), "a [proved]\n  base [definition]")
        output = io.StringIO()
        with contextlib.redirect_stdout(output):
            self.assertEqual(workspace.main(["--root", str(self.root), "frontier"]), 0)
        self.assertEqual(output.getvalue(), "Active frontier.\n")

    def test_search_limit(self):
        for index in range(25):
            self.add_theorem(f"a{index}")
        self.save()
        self.assertEqual(len(workspace.search(self.root, ["theorem"]).splitlines()), 20)


if __name__ == "__main__":
    unittest.main()
