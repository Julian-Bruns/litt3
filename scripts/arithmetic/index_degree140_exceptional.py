#!/usr/bin/env python3
"""Index completed exceptional-chart certificates and export portable tables.

This checks coverage and retained terminal certificates; it does not replace
the full resultant/interpolation/Bezout replays recorded by the drivers.
"""
import argparse
import hashlib
import json
from pathlib import Path
import struct


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("checks", type=Path)
    args = ap.parse_args()
    root = args.checks.resolve()
    assert "litt3-computation-data" in root.parts
    roots = [9,14,2514,7367,20130,104315,139659,154113,281660,364472]
    rows, tables = [], []
    for i, r in enumerate(roots, 1):
        quadratic = i in (1,2,4,6,7)
        work = root / ("degree140_quadratic" if quadratic else "degree140_full")
        original = i in (3,10)
        count = 0
        for sign in ((0,) if quadratic else (0,1)):
            name = ("exceptional" if original else "normalized") + f"_closure_{i}_{sign}.json"
            file = work / "certificates" / name
            record = json.loads(file.read_text())
            assert record["root"] == r and record["status"].startswith("complete_")
            finite = record["finite_exceptions"] if original else record["finite"]
            assert len(finite) == 3
            if not original:
                assert all(f["bezout_gcd"] == [1] and f["sylvester_checks"] > 0 for f in finite)
            else:
                for f in finite:
                    cert = json.loads((work / f["certificate"]).read_text())
                    assert cert["excludes_all_nonzero_lambda"] and f["sylvester_checks"] > 0
            n = 6 if quadratic else 3
            count += n
            rows.append({"case": i, "root": r, "sign": sign, "components": n,
                         "terminal_certificate": str(file.relative_to(root)),
                         "sha256": hashlib.sha256(file.read_bytes()).hexdigest()})
        assert count == 6
    assert sum(r["components"] for r in rows) == 60
    for folder, width in [("degree140_full",4),("degree140_quadratic",8)]:
        for file in sorted((root/folder/"data").glob("*values*.bin")):
            data = file.read_bytes()
            assert len(data) == 3*48828*width
            values = list(struct.unpack("<" + ("I" if width == 4 else "Q")*(len(data)//width), data))
            bound = 390625 if width == 4 else 390625**2
            assert all(0 <= x < bound for x in values)
            output = file.with_suffix(".portable.json")
            output.write_text(json.dumps({"N":48828,"pairs":[[71,72],[71,73],[72,73]],
                "layout":"three consecutive arrays of length N, exponent index increasing",
                "coefficient_field_order":bound,"values":values},separators=(",",":"))+"\n")
            tables.append({"file":str(output.relative_to(root)),"sha256":hashlib.sha256(output.read_bytes()).hexdigest(),"count":len(values)})
    result = {"status":"all_60_geometric_exceptional_components_excluded",
              "not_claimed":"generic pivot chart, degrees142/144, or actual common-cover decision",
              "branches":rows,"portable_tables":tables,
              "independent_parameter_evaluations":len(tables)*48828}
    (root/"exceptional_coverage.json").write_text(json.dumps(result,indent=2)+"\n")
    print("PASS: 60 components,",len(rows),"computed H branches,",len(tables),"portable complete evaluation tables.")


if __name__ == "__main__":
    main()
