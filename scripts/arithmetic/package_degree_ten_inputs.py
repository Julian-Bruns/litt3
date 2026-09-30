"""Package the small, optional degree-ten reconstruction input for Pro."""
import hashlib
import json
from pathlib import Path
import sys
import zipfile

ROOT = Path(__file__).resolve().parents[2]
SOURCE = ROOT / "scripts/arithmetic/admissible_higher_collision.sage"
README = """# Degree-ten necessary coefficient reconstruction

This is an optional input to the self-contained degree-ten mathematical
question. It reconstructs necessary equations, not an etale cover and not
a nonexistence proof. It has no dependency on files outside this archive.

Requirements: SageMath 10.9 (tested). Run:

    sage admissible_higher_collision.sage 10 degree10.json

Expected finite matrix: 150 by 195, rank148, nullity47. Of the sixteen
input supports, twelve repeated-fiber supports force kappa=0. The four
distinct-triple supports have combined homogeneous kernel dimension18
and permit kappa nonzero. Fixing kappa=1 gives affine dimension17.

All unknown coefficients are geometric. The finite-field matrix ranks
remain the same after scalar extension. Neither the output kernel nor a
point on it verifies irreducibility, etaleness, or the order-five condition.
The source also accepts degrees9 and11 as regression cases. They are not
required by the current question. It writes bulky exact data only to the
output path supplied by the caller.

The identical source was executed locally in SageMath10.9 for degrees9,
10 and11. Its degree-ten ranks agreed with the values above. The package
does not contain a decision certificate for the remaining degree-ten
family. SHA256SUMS records the source and this README.
"""


def main():
    if len(sys.argv) != 2:
        raise SystemExit("usage: python3 package_degree_ten_inputs.py OUTPUT.zip")
    target = Path(sys.argv[1]).resolve()
    target.parent.mkdir(parents=True, exist_ok=True)
    items = {"README.md": README.encode(), SOURCE.name: SOURCE.read_bytes()}
    manifest = "".join(
        hashlib.sha256(data).hexdigest() + "  " + name + "\n"
        for name, data in sorted(items.items())
    ).encode()
    items["SHA256SUMS"] = manifest
    with zipfile.ZipFile(target, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=9) as archive:
        for name, data in sorted(items.items()):
            info = zipfile.ZipInfo(name, date_time=(2026, 9, 24, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            archive.writestr(info, data, compresslevel=9)
    with zipfile.ZipFile(target) as archive:
        assert archive.testzip() is None
        assert archive.read(SOURCE.name) == SOURCE.read_bytes()
        total = sum(i.file_size for i in archive.infolist())
    assert target.stat().st_size <= 20000
    print(json.dumps({"path": str(target), "compressed_bytes": target.stat().st_size,
                      "uncompressed_bytes": total,
                      "sha256": hashlib.sha256(target.read_bytes()).hexdigest()}, indent=2))


if __name__ == "__main__":
    main()
