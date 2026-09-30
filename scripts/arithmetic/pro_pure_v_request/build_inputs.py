#!/usr/bin/env python3
"""Reconstruct optional strict-return inputs; this does not decide any return."""
from pathlib import Path
import argparse
import hashlib
import platform
import sys

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / "src"))
import numpy as np
import numba
import compute as c
import geometry
from negative_quotient import build_negative
import reduce_return


def check_manifest():
    path = ROOT / "MANIFEST.sha256"
    if not path.exists():
        return
    for line in path.read_text().splitlines():
        digest, name = line.split("  ", 1)
        assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == digest, name
    print("Input manifest PASS", flush=True)


def pure_v_column(v, f, alpha, g0, q0, s0, t0):
    """The six-coordinate specialization printed in the fresh prompt."""
    V = c.power(v, 25)
    a = c.add(c.pos(c.mul(c.e, f)), alpha)
    p = c.add(a, c.neg(c.mul(c.e, f)))
    chi = c.mul(c.e, g0)
    qp = c.add(q0, c.pos(chi))
    Bs = c.add(c.mul(c.E, g0), c.mul(V, f))
    h = c.neg(c.pos(Bs))
    As = c.add(c.neg(c.mul(c.e, h)),
               c.mul(c.E, c.add(q0, c.neg(c.tail(chi)))), c.mul(V, p))
    r = c.neg(c.pos(As))
    vf = c.mul(v, f)
    n = c.add(s0, c.pos(vf))
    nv = c.add(s0, c.neg(c.tail(vf)))
    vg = c.mul(v, g0)
    na = c.add(t0, c.pos(vg))
    Ns = c.add(c.neg(c.mul(v, h)),
               c.mul(c.E, c.add(t0, c.neg(c.tail(vg)))), c.mul(V, nv))
    nb = c.neg(c.pos(Ns))
    return [[n, na, nb], [a, qp, r], [f, g0, h]], np.concatenate(
        (c.vec(Bs, c.bm144), c.vec(As, c.bm155), c.vec(Ns, c.bas1(-151))))


def smoke():
    for value in range(25):
        assert c.power(c.mono(c=value), 25) == c.mono(c=value)
    assert c.power(c.mono(c=5), 2) == c.mono(c=8)
    assert c.MUL[c.MUL[14, 14], 14] == geometry.evaluate(c.P, 5, 0)
    assert [len(c.bas0(d)) for d in (31, 20, 131, 120, 24, 124)] == [
        23, 12, 123, 112, 16, 116]
    assert [len(c.bas1(d)) for d in (-144, -155, -151)] == [152, 163, 159]
    trials = 0
    # Bounded packaging/formula check, not a geometric return search.
    for vv in ([24, 2, 10, 11, 1, 0], [1, 2, 3, 4, 5, 6]):
        xi = np.array([0] * 13 + list(vv), dtype=np.uint8)
        v = geometry.combine([c.mono(*m) for m in c.v_keys[-6:]], vv)
        spaces = [c.bas0(d) for d in (31, 20, 131, 120, 24, 124)]
        for column in range(6):
            for index in (0, -1):
                free = [{} for _ in range(6)]
                free[column] = c.mono(*spaces[column][index])
                f, alpha, g0, q0, s0, t0 = free
                a = c.add(c.pos(c.mul(c.e, f)), alpha)
                H, residual = pure_v_column(v, *free)
                H0, residual0 = geometry.full_column(xi, a, f, g0, q0, s0, t0)
                assert H == H0 and np.array_equal(residual, residual0)
                trials += 1
    print(f"Field, point, dimensions and {trials} pure-v formula comparisons PASS",
          flush=True)


def build():
    data = ROOT / "data"
    data.mkdir(exist_ok=True)
    c.build()
    A, B, Q, S, L = build_negative(25, -1)
    np.savez_compressed(data / "negative_second.npz", A=A, B=B, Q=Q, S=S, L=L)
    full = reduce_return.build_reduced()
    one_axis = {"T", "Q", "lower_recovery", "t_recovery_s", "lower_at_point",
                "top_first_c", "top_other_s"}
    two_axes = {"C", "t_recovery_c", "top_other_c"}
    sliced = {
        key: (value[13:19, 13:19] if key in two_axes else
              value[13:19] if key in one_axis else value)
        for key, value in full.items()
    }
    assert sliced["T"].shape == (6, 80, 35)
    assert sliced["Q"].shape == (6, 43, 16)
    assert sliced["C"].shape == (6, 6, 43, 35)
    np.savez_compressed(data / "pure_v_return.npz", **sliced)
    print("Wrote exact pure_v_return.npz; no return ideal solved.", flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--smoke", action="store_true",
                        help="bounded formula/package checks only; no tensor rebuild")
    args = parser.parse_args()
    print("Python", platform.python_version(), "NumPy", np.__version__,
          "Numba", numba.__version__, flush=True)
    check_manifest()
    smoke()
    if not args.smoke:
        build()
    print("STATUS: reconstruction aid only; the existence decision is OPEN.",
          flush=True)


if __name__ == "__main__":
    main()
