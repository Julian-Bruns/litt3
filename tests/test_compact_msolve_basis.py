"""Term-for-term compact encoding fixture; does not assert a GB certificate."""
import json
from pathlib import Path
import shutil
import struct
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]
HEADER = """#Reduced Groebner basis data
#field characteristic: 5
#variable order: x, zeta
#monomial order: graded reverse lexicographical
#length of basis: 2 elements sorted by increasing leading monomials
"""
BODY = "[1*zeta^2+4*zeta^1+2,\n1*x^2+2*x^1*zeta^1+3*x^1+4*zeta^1+1]:\n"
STANDARDS = "0\t0\n0\t1\n1\t0\n1\t1\n"


class CompactBasisTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        compiler = shutil.which("cc")
        if not compiler:
            raise unittest.SkipTest("C compiler unavailable")
        cls.build = tempfile.TemporaryDirectory()
        cls.exe = Path(cls.build.name) / "compact"
        subprocess.run([compiler, "-O2", "-Wall", "-Wextra", "-Werror",
                        str(ROOT / "scripts/compact_msolve_basis.c"),
                        "-o", str(cls.exe)], check=True)

    @classmethod
    def tearDownClass(cls):
        cls.build.cleanup()

    def encode(self, directory, body=BODY, standards=STANDARDS):
        root = Path(directory)
        (root / "basis").write_text(HEADER + body)
        (root / "standard").write_text(standards)
        return subprocess.run([str(self.exe), str(root / "basis"),
                               str(root / "standard"), str(root / "out")],
                              capture_output=True, text=True)

    def test_every_term_round_trip(self):
        with tempfile.TemporaryDirectory() as d:
            result = self.encode(d)
            self.assertEqual(result.returncode, 0, result.stderr)
            p = Path(d)
            standards = struct.unpack("<4Q", (p / "out.standard.u64").read_bytes())
            leading = struct.unpack("<2Q", (p / "out.lm.u64").read_bytes())
            matrix = (p / "out.u8").read_bytes()
            self.assertEqual(standards, (0, 16, 1, 17))
            self.assertEqual(leading, (32, 2))
            expected_polynomials = [{32: 1, 16: 4, 0: 2},
                                    {2: 1, 17: 2, 1: 3, 16: 4, 0: 1}]
            for i, expected in enumerate(expected_polynomials):
                reconstructed = {leading[i]: 1}
                for j, key in enumerate(standards):
                    coefficient = (-matrix[4*i+j]) % 5
                    if coefficient:
                        reconstructed[key] = coefficient
                self.assertEqual(reconstructed, expected)
            metadata = json.loads((p / "out.json").read_text())
            self.assertEqual(metadata["source_terms"], 8)
            self.assertEqual(metadata["matrix_bytes"], 8)
            self.assertFalse(metadata["groebner_basis_certified"])

    def test_rejects_invalid_terms_without_committing_output(self):
        invalid = [BODY.replace("[1*", "[2*"),
                   BODY.replace("+2,", "+2+3*zeta^1,"),
                   BODY.replace("+2,", "+2+1*x^1*zeta^1,"),
                   BODY.replace("+3*x^1", "+3*x^16"),
                   BODY.replace("+3*x^1", "+3*x^1*x^1"),
                   BODY.replace("+3*x^1", "+3*unknown^1"),
                   BODY.replace("]:", ""),
                   BODY.replace("+3*x^1", "+0*x^1")]
        for body in invalid:
            with self.subTest(body=body), tempfile.TemporaryDirectory() as d:
                result = self.encode(d, body=body)
                self.assertNotEqual(result.returncode, 0)
                self.assertFalse((Path(d) / "out.json").exists())
                self.assertFalse((Path(d) / "out.u8").exists())

    def test_rejects_nonstandard_tail(self):
        with tempfile.TemporaryDirectory() as d:
            result = self.encode(d, standards=STANDARDS.rsplit("1\t1\n", 1)[0])
            self.assertNotEqual(result.returncode, 0)
            self.assertIn("nonstandard tail", result.stderr)

    def test_rejects_unsorted_standard_list(self):
        with tempfile.TemporaryDirectory() as d:
            result = self.encode(d, standards="0 0\n1 0\n0 1\n1 1\n")
            self.assertNotEqual(result.returncode, 0)
            self.assertIn("ascending", result.stderr)


if __name__ == "__main__":
    unittest.main()
