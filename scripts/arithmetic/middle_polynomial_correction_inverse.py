#!/usr/bin/env python3
"""Eliminate the seven middle-character corrections without localization.

For H(b)=[P(b),Q(b)] on a normalized source stratum, find a polynomial
left inverse L(b) of Q(b). Then H(b)(p,A)=0 is equivalent to
(P-Q*L*P)p=0 and A=-L*P*p. All geometric parameter values remain.
This script computes an exact bounded-degree inverse, not a point search.
"""
import argparse
import hashlib
import itertools
import json
import time
from pathlib import Path

import numpy as np
from sage.all import GF, PolynomialRing, matrix, identity_matrix


def exponents(n, degree):
    out = []
    for d in range(degree + 1):
        for indices in itertools.combinations_with_replacement(range(n), d):
            e = [0] * n
            for i in indices:
                e[i] += 1
            out.append(tuple(e))
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("tensor", type=Path)
    ap.add_argument("--source-stratum", type=int, choices=range(3), required=True)
    ap.add_argument("--degree", type=int, default=2)
    ap.add_argument("--partial", action="store_true",
                    help="Retain every constant correction combination recoverable at this degree.")
    ap.add_argument("--augmented-solve", action="store_true",
                    help="Use one augmented row reduction instead of multiple generic solver reductions.")
    ap.add_argument("--resume-linear", action="store_true",
                    help="Resume from this output's compact exact coefficient checkpoint.")
    ap.add_argument("--output", type=Path, required=True)
    args = ap.parse_args()
    start = time.time()
    H = np.load(args.tensor, allow_pickle=False)["H"]
    assert H.shape == (30, 15, 10)
    k = GF(25, "a", modulus=PolynomialRing(GF(5), "v")([2, 4, 1]))
    decode = lambda z: k(int(z) % 5) + k(int(z) // 5) * k.gen()
    code = lambda z: int(z.polynomial()[0]) + 5 * int(z.polynomial()[1])
    j = args.source_stratum
    names = [f"b{i}" for i in range(j + 1, 10)]
    R = PolynomialRing(k, names, order="degrevlex")
    n = len(names)
    small = exponents(n, args.degree)
    large = exponents(n, args.degree + 1)
    large_index = {e: i for i, e in enumerate(large)}
    zero = (0,) * n
    affine = [(zero, j)]
    for i in range(n):
        e = tuple(int(a == i) for a in range(n))
        affine.append((e, j + 1 + i))
    # Compress only by constant row identities, valid at every parameter value.
    flat = matrix(k, 30, 7 * len(affine), [
        decode(H[r, 8 + a, b])
        for r in range(30) for a in range(7) for _, b in affine
    ])
    selected_rows = list(flat.transpose().pivots())
    M = matrix(k, 7 * len(large), len(selected_rows) * len(small))
    for rr, r in enumerate(selected_rows):
        for a in range(7):
            for e, b in affine:
                coeff = decode(H[r, 8 + a, b])
                if not coeff:
                    continue
                for u, m in enumerate(small):
                    target = tuple(x + y for x, y in zip(e, m))
                    M[a * len(large) + large_index[target], rr * len(small) + u] += coeff
    target = matrix(k, M.nrows(), 7)
    for a in range(7):
        target[a * len(large) + large_index[zero], a] = 1
    receipt = {
        "status": "RUNNING",
        "scope": "Polynomial correction inverse over every geometric point of the normalized source stratum.",
        "input_sha256": hashlib.sha256(args.tensor.read_bytes()).hexdigest(),
        "source_stratum": j, "inverse_degree_bound": args.degree,
        "variables": names, "matrix_shape": [M.nrows(), M.ncols()],
        "selected_rows": selected_rows,
    }
    args.output.write_text(json.dumps(receipt, indent=2) + "\n")
    print("SOLVE", M.nrows(), M.ncols(), "degree", args.degree, flush=True)
    checkpoint = args.output.with_suffix(".linear.npz")
    if args.resume_linear:
        z = np.load(checkpoint, allow_pickle=False)
        assert str(z["input_sha256"]) == receipt["input_sha256"]
        assert int(z["source_stratum"]) == j and int(z["degree_bound"]) == args.degree
        assert list(map(int, z["selected_rows"])) == selected_rows
        C = matrix(k, [[decode(x) for x in row] for row in z["constant_combinations"]])
        coefficients = matrix(k, [[decode(x) for x in row] for row in z["coefficients"]])
        rank = C.nrows()
        wanted = target * C.transpose()
        print("RESUMED EXACT COEFFICIENTS", flush=True)
    elif args.augmented_solve:
        augmented = M.augment(-target).echelon_form()
        pivots_augmented = augmented.pivots()
        rank_M = sum(p < M.ncols() for p in pivots_augmented)
        obstruction = augmented[rank_M:len(pivots_augmented), M.ncols():]
        C = obstruction.right_kernel().basis_matrix()
        rank = C.nrows()
        print("RECOVERABLE CONSTANT RANK", rank, flush=True)
        if not rank or (rank < 7 and not args.partial):
            receipt.update(status="NO_INVERSE_AT_BOUND" if not args.partial else "NO_CONSTANT_COMBINATION_AT_BOUND",
                           recoverable_constant_rank=rank, seconds=time.time() - start)
            args.output.write_text(json.dumps(receipt, indent=2) + "\n")
            return
        coefficients = matrix(k, M.ncols(), rank)
        rhs = -augmented[:rank_M, M.ncols():] * C.transpose()
        for r, p in enumerate(pivots_augmented[:rank_M]):
            coefficients[p, :] = rhs[r, :]
        wanted = target * C.transpose()
    elif args.partial:
        obstruction = M.left_kernel().basis_matrix() * target
        C = obstruction.right_kernel().basis_matrix()
        rank = C.nrows()
        print("RECOVERABLE CONSTANT RANK", rank, flush=True)
        if not rank:
            receipt.update(status="NO_CONSTANT_COMBINATION_AT_BOUND", seconds=time.time() - start)
            args.output.write_text(json.dumps(receipt, indent=2) + "\n")
            return
        wanted = target * C.transpose()
        coefficients = M.solve_right(wanted)
    else:
        C = identity_matrix(k, 7)
        rank = 7
        wanted = target
        try:
            coefficients = M.solve_right(wanted)
        except ValueError:
            receipt.update(status="NO_INVERSE_AT_BOUND", seconds=time.time() - start)
            args.output.write_text(json.dumps(receipt, indent=2) + "\n")
            print(receipt["status"], flush=True)
            return
    assert M * coefficients == wanted
    np.savez_compressed(checkpoint,
                        coefficients=np.array([[code(x) for x in row] for row in coefficients.rows()], dtype=np.uint8),
                        constant_combinations=np.array([[code(x) for x in row] for row in C.rows()], dtype=np.uint8),
                        selected_rows=np.array(selected_rows, dtype=np.uint8),
                        input_sha256=receipt["input_sha256"], source_stratum=j, degree_bound=args.degree)
    print("COEFFICIENT IDENTITY VERIFIED", flush=True)
    monomials = [R({e: k.one()}) for e in small]
    L = matrix(R, rank, 30)
    for a in range(rank):
        for rr, r in enumerate(selected_rows):
            L[a, r] = sum(coefficients[rr * len(small) + u, a] * monomials[u]
                          for u in range(len(small)))
    bvals = [R.zero() if i < j else R.one() if i == j else R(f"b{i}") for i in range(10)]
    Hpoly = matrix(R, 30, 15, [
        sum(decode(H[r, a, b]) * bvals[b] for b in range(10))
        for r in range(30) for a in range(15)
    ])
    P, Q = Hpoly[:, :8], Hpoly[:, 8:]
    assert L * Q == C.change_ring(R)
    pivots = list(C.pivots())
    free = [i for i in range(7) if i not in pivots]
    assert C[:, pivots] == identity_matrix(k, rank)
    replacement = matrix(R, 7, 8 + len(free))
    LP = -L * P
    for a, pivot in enumerate(pivots):
        for b in range(8):
            replacement[pivot, b] = LP[a, b]
        for b, col in enumerate(free):
            replacement[pivot, 8 + b] = -C[a, col]
    for b, col in enumerate(free):
        replacement[col, 8 + b] = 1
    reduced = P.augment(matrix(R, 30, len(free))) + Q * replacement
    assert L * reduced == 0
    encode_poly = lambda f: [[list(e), code(c)] for e, c in sorted(f.dict().items())]
    receipt.update(
        status="COMPLETE", seconds=time.time() - start,
        eliminated_correction_rank=rank,
        constant_combinations=[[code(c) for c in row] for row in C.rows()],
        eliminated_correction_indices=pivots, retained_correction_indices=free,
        inverse=[[encode_poly(f) for f in row] for row in L.rows()],
        correction_replacement=[[encode_poly(f) for f in row] for row in replacement.rows()],
        reduced_pencil=[[encode_poly(f) for f in row] for row in reduced.rows()],
        checks={"linear_system": True, "left_inverse": True, "equivalent_substitution": True},
        max_reduced_degree=int(max((f.total_degree() for f in reduced.list() if f), default=-1)),
        coefficient_checkpoint_sha256=hashlib.sha256(checkpoint.read_bytes()).hexdigest(),
    )
    args.output.write_text(json.dumps(receipt, separators=(",", ":")) + "\n")
    print("COMPLETE", "seconds", receipt["seconds"], "reduced_degree",
          receipt["max_reduced_degree"], flush=True)


if __name__ == "__main__":
    main()
