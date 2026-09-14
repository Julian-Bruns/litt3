"""Recheck native predecessor prefixes against exact Sage row spaces.

Run: sage scripts/atlases/native/verify_predecessor_prefixes.sage
Optional --data DIRECTORY selects the atlas-predecessor-tests input directory.
The current native engine is compiled and all checkpoints stay in a temporary
directory. Retained matrices, predecessor tables and old certificates are read-only.
"""
import argparse
import json
from pathlib import Path
import runpy
import struct
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[3]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("--data", type=Path,
                    default=ROOT.parent/"litt3-computation-data/atlas-predecessor-tests")
args = parser.parse_args()
k = GF(25, name="a", modulus=PolynomialRing(GF(5), "z")([2, 4, 1]))
a = k.gen()


def decode(code):
    return k(code % 5) + a * (code // 5)


def read_matrix(path):
    raw = []
    with path.open("rb") as stream:
        nrows, ncols = struct.unpack("<II", stream.read(8))
        for row in range(nrows):
            count = struct.unpack("<I", stream.read(4))[0]
            columns = struct.unpack("<" + "I" * count, stream.read(4 * count))
            values = stream.read(count)
            raw.append({c: decode(v) for c, v in zip(columns, values)})
    return nrows, ncols, raw


def check(checkpoint, prefix, nrows, ncols, raw):
    data = checkpoint.read_bytes()
    magic, nr, nc, boundary, processed = struct.unpack_from("<QIIII", data, 0)
    assert magic == 0x4d414341554c3032
    assert (nr, nc, processed) == (nrows, ncols, prefix)
    rank = struct.unpack_from("<I", data, 64)[0]
    pos, entries, heads = 68, {}, []
    for row in range(rank):
        offset, count = struct.unpack_from("<QI", data, pos)
        pos += 12
        columns = struct.unpack_from("<" + "I" * count, data, pos)
        pos += 4 * count
        values = data[pos:pos + count]
        pos += count
        heads.append(columns[0])
        for col, value in zip(columns, values):
            entries[row, col] = decode(value)
    pivots = matrix(k, rank, ncols, entries)
    original = matrix(k, prefix, ncols,
                      {(r, c): v for r in range(prefix) for c, v in raw[r].items()})
    assert pivots.row_space() == original.row_space()
    assert sorted(heads) == list(original.pivots())
    return rank


with tempfile.TemporaryDirectory(prefix="litt3-prefix-") as temporary:
    work = Path(temporary)
    code = runpy.run_path(str(ROOT/"scripts/atlases/mixed_atlas_certificate.sage"))["CPP_GENERAL"]
    source, binary = work/"eliminate.cpp", work/"eliminate"
    source.write_text(code)
    subprocess.run(["c++", "-O3", "-std=c++17", "-pthread", str(source),
                    "-o", str(binary)], check=True, timeout=60)
    cases = [("chart-28", 320, [1, 5, 93, 100, 150, 250, 299]),
             ("zero-descendant", 2, [1, 2, 3, 4])]
    for case, boundary, prefixes in cases:
        inputs, output = args.data/case, work/case
        output.mkdir()
        nrows, ncols, raw = read_matrix(inputs/"matrix.bin")
        previous = 0
        for prefix in prefixes:
            command = [str(binary), str(inputs/"matrix.bin"), str(output/"dag.bin"),
                       str(output/"weights.bin"), "60", str(2 * 1024**3),
                       str(output/"state.cp"), str(boundary), "30",
                       str(prefix - previous), "-1", "", case, "{}",
                       str(inputs/"predecessor.bin"), "1", "0"]
            result = subprocess.run(command, capture_output=True, text=True,
                                    check=True, timeout=65)
            assert json.loads(result.stdout)["rows_processed"] == prefix
            rank = check(output/"state.cp", prefix, nrows, ncols, raw)
            print(case, "prefix", prefix, "rank", rank, "PASS", flush=True)
            previous = prefix
print("PASS: 11 exact prefix row spaces and pivot sets, including zero descendants.")
