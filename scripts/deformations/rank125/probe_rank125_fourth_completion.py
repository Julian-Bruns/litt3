#!/usr/bin/env python3
"""Filtered linearization of the ACTUAL quadratic at the returned high jet.

This computes how higher kernel completions change graded fourth targets.
It does not evaluate their additive constants or certify a fourth lift.
The first argument is the extracted, audited Pro source directory.
"""
import json
from pathlib import Path
import sys

sys.path.insert(0, str(Path(sys.argv[1]).resolve()))
import low_quadratic_projections as g


def rank(rows):
    return len(g.rref(rows)[1]) if rows else 0


def quotient(d, h):
    mons = g.MD[d]
    gens = [g.pm(g.f2, {m: 1}) for m in g.MD[d-2]]
    rr, piv = g.rref([[a.get(m, 0) for m in mons] for a in gens])
    out = [h.get(m, 0) for m in mons]
    for row, p in zip(rr, piv):
        c = out[p]
        if c:
            out = [g.ADD[x][g.NEG[g.MUL[c][y]]] for x, y in zip(out, row)]
    return out, len(mons)-len(piv)


h5 = g.pa(g.ps(g.H5[0], 63), g.H5[1])
assert h5 and not g.pm(g.f2, h5)
first = g.tomacaulay(h5)
blocks = []
for d in range(4, 8):
    kernel = g.kerq(d+4) if d+6 <= 12 else [{m: 1} for m in g.MD[d+4]]
    cols = []
    for h in kernel:
        second = g.tomacaulay(h)
        polarized = g.pa(g.bilin(g.C[3], first, second),
                         g.bilin(g.C[3], second, first))
        output = g.frommacaulay(polarized)
        assert all(sum(m) == d for m in output)
        col, target_dim = quotient(d, output)
        cols.append(col)
    rows = list(map(list, zip(*cols)))
    r = rank(rows)
    blocks.append({"target_degree": d, "source_degree": d+4,
                   "source_dimension": len(kernel), "target_dimension": target_dim,
                   "rank": r, "cokernel_dimension": target_dim-r})

print(json.dumps({
    "scope": "graded derivative of actual quadratic at nonzero returned H5; no fourth constants",
    "blocks": blocks,
    "nonzero_rescaling": "ranks unchanged at s*=3+3t+3t^2",
    "not_proved": "solvability of any full fourth comparison"
}, indent=2))
