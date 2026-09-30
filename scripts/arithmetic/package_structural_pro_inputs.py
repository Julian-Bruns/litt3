#!/usr/bin/env python3
"""Package the small optional input for the 24 September three-request batch."""
from pathlib import Path
import hashlib
import json
import zipfile

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT.parent / "litt3-computation-data" / "structural_pole_six_returns_tame_20260924" / "outgoing"
OLD = ROOT / "scripts/arithmetic/pro_degree6_actual_return_20260924/return/src"
SUPPORT = ROOT / "scripts/arithmetic/pro_pure_v_request/build_inputs.py"
README = """# Optional input: the pure-v strict-second-return problem

This ZIP is reconstruction source, not a solved return ideal.
The complete mathematical problem is stated in the separate prompt.
No file outside this ZIP is needed to run these commands.

Requirements: Python 3, NumPy and Numba. The unchanged upstream rebuild
was executed with Python 3.14.7, NumPy 2.3.5, Numba 0.65.1.
From this directory run:

    python3 -m pip install -r requirements.txt
    python3 build_inputs.py --smoke
    python3 build_inputs.py

The smoke command checks the manifest, arithmetic, dimensions and 24
bounded comparisons of the prompt's specialized formulas with the
upstream general transition calculation. It is not a return search.
The default command additionally rebuilds the full tensors from P,e,
performs the two reversible constant eliminations, and extracts the
pure-v slice into data/pure_v_return.npz.

The four src/*.py files are unchanged checked source. The original
nineteen-parameter tensor reconstruction, including all 361 mixed
blocks, has been executed and verified. The new wrapper specializes
indices 13,...,18. Its full rebuild command is a reproducible aid;
this package makes no claim that the wrapper has solved an ideal.
The packaging-only checks actually run are recorded separately in
the local batch record, rather than represented as a new theorem.

Pure-v output: c has 35 entries (f then alpha), s has 16.
The regularity matrix is

    [[sum(v_j^25 T_j), 0],
     [sum(v_i v_j^25 C_ij), sum(v_j^25 Q_j)]].

All entries are F25 integer codes a+5b for a+b*beta,
beta^2=beta+3; codes are NOT integers modulo 25.
Unknown v_j may lie in any extension field. Preserve v_j^25.

Recover the matrix at the point ([5],[14]) as follows, with summation
over 0,...,5, and each stored row applied to c or s:

  H[0,0] = top_first_s*s + sum(v_i top_first_c[i]*c)
  H[1,0],H[2,0] = first_at_point*c
  H[2,1],H[1,1],H[2,2],H[1,2]
      = sum(v_j^25 lower_at_point[j]*c)
        (stored order g,q,h,r)
  H[0,k] = sum(v_j^25 top_other_s[j,k-1]*s)
         + sum(v_i v_j^25 top_other_c[i,j,k-1]*c), k=1,2.

Its determinant must be nonzero (or normalized to one).
lower_recovery, t_recovery_c and t_recovery_s recover the other
351 Laurent-matrix coefficients. The ten excluded stability points
are stated explicitly in the prompt.

File map:
- build_inputs.py: wrapper, specialized formulas and bounded smoke checks.
- src/compute.py: field/Laurent arithmetic and the lower quotient tensors.
- src/geometry.py: general actual matrix, used by the formula check.
- src/negative_quotient.py: constant top-block elimination.
- src/reduce_return.py: full exact mixed/recovery/evaluation tensors.
- requirements.txt: dependencies.
- MANIFEST.sha256: hashes of every other file.
"""


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    files = {"README.md": README.encode(),
             "requirements.txt": b"numpy==2.3.5\nnumba==0.65.1\n",
             "build_inputs.py": SUPPORT.read_bytes()}
    for name in ("compute.py", "geometry.py", "negative_quotient.py", "reduce_return.py"):
        files[f"src/{name}"] = (OLD / name).read_bytes()
    files["MANIFEST.sha256"] = "".join(
        f"{hashlib.sha256(content).hexdigest()}  {name}\n"
        for name, content in sorted(files.items())).encode()
    output = OUT / "pure_v_return_inputs.zip"
    with zipfile.ZipFile(output, "w", zipfile.ZIP_DEFLATED, compresslevel=9) as z:
        for name, content in sorted(files.items()):
            z.writestr(name, content)
    with zipfile.ZipFile(output) as z:
        assert z.testzip() is None
        assert all(z.read(name) == content for name, content in files.items())
    metadata = {"path": str(output), "compressed_bytes": output.stat().st_size,
                "uncompressed_bytes": sum(map(len, files.values())),
                "sha256": hashlib.sha256(output.read_bytes()).hexdigest(),
                "files": len(files), "mathematical_decision": "not attempted"}
    assert metadata["compressed_bytes"] <= 20000
    (OUT / "package_metadata.json").write_text(json.dumps(metadata, indent=2) + "\n")
    print(json.dumps(metadata, indent=2))


if __name__ == "__main__":
    main()
