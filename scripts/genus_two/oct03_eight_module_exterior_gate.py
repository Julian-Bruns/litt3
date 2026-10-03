#!/usr/bin/env python3
"""Small exact characteristic-five Jordan/exterior Scott ledger.

No group enumeration or common-cover existence test is performed.
"""
import argparse
import itertools
import json
from pathlib import Path


def matmul(a, b, p=5):
    return [[sum(x * y for x, y in zip(row, col)) % p
             for col in zip(*b)] for row in a]


def rank(a, p=5):
    a = [row[:] for row in a]
    nr, nc = len(a), len(a[0]) if a else 0
    r = 0
    for c in range(nc):
        pivot = next((i for i in range(r, nr) if a[i][c] % p), None)
        if pivot is None:
            continue
        a[r], a[pivot] = a[pivot], a[r]
        inv = pow(a[r][c], -1, p)
        a[r] = [v * inv % p for v in a[r]]
        for i in range(r + 1, nr):
            coeff = a[i][c]
            if coeff:
                a[i] = [(u - coeff * v) % p
                        for u, v in zip(a[i], a[r])]
        r += 1
        if r == nr:
            break
    return r


def determinant(a, p=5):
    a = [row[:] for row in a]
    d = 1
    for c in range(len(a)):
        pivot = next((i for i in range(c, len(a)) if a[i][c] % p), None)
        if pivot is None:
            return 0
        if pivot != c:
            a[c], a[pivot] = a[pivot], a[c]
            d = -d
        d = d * a[c][c] % p
        inv = pow(a[c][c], -1, p)
        for i in range(c + 1, len(a)):
            coeff = a[i][c] * inv % p
            for j in range(c + 1, len(a)):
                a[i][j] = (a[i][j] - coeff * a[c][j]) % p
    return d % p


def jordan(blocks):
    n = sum(blocks)
    a = [[int(i == j) for j in range(n)] for i in range(n)]
    offset = 0
    for size in blocks:
        for j in range(offset + 1, offset + size):
            a[j - 1][j] = 1
        offset += size
    return a


def exterior(a, degree):
    basis = list(itertools.combinations(range(len(a)), degree))
    return [[determinant([[a[i][j] for j in cols] for i in rows])
             for cols in basis] for rows in basis]


def block_type(a):
    n = len(a)
    nil = [[(a[i][j] - int(i == j)) % 5 for j in range(n)] for i in range(n)]
    power = [[int(i == j) for j in range(n)] for i in range(n)]
    kernels = [0]
    for _ in range(5):
        power = matmul(power, nil)
        kernels.append(n - rank(power))
    assert kernels[-1] == n
    columns = [kernels[i] - kernels[i - 1] for i in range(1, 6)] + [0]
    blocks = {str(i): columns[i - 1] - columns[i] for i in range(1, 6)
              if columns[i - 1] != columns[i]}
    return {"dimension": n, "kernel_dimensions": kernels,
            "jordan_blocks": blocks, "fixed_dimension": kernels[1]}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    rows = {}
    for blocks in ((4, 4), (5, 3)):
        a = jordan(blocks)
        rows["+".join(map(str, blocks))] = {
            str(d): block_type(exterior(a, d)) for d in range(1, 5)
        }
    assert rows["4+4"]["2"]["jordan_blocks"] == {"1": 3, "5": 5}
    assert rows["5+3"]["2"]["jordan_blocks"] == {"3": 1, "5": 5}
    target = Path(args.output)
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(json.dumps({"characteristic": 5, "rows": rows}, indent=2) + "\n")
    print(json.dumps(rows, separators=(",", ":")))


if __name__ == "__main__":
    main()
