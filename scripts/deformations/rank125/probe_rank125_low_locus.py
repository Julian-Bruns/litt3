#!/usr/bin/env python3
"""Exact necessary E4 equations modulo (f)+J5; no higher-reference claim."""
import argparse
import json
import pickle
import sys
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument("evidence", type=Path)
parser.add_argument("--output", type=Path, required=True)
parser.add_argument("--singular", type=Path)
parser.add_argument("--min-source", type=int, default=5)
parser.add_argument("--max-source", type=int, default=8)
parser.add_argument("--max-target", type=int, default=4)
args = parser.parse_args()
sys.path.insert(0, str(args.evidence.resolve()))
import quadratic as q
with (args.evidence / "quad_setup.pkl").open("rb") as handle:
    setup = pickle.load(handle)
columns = [q.rmul(q.f, [int(i == j) for i in range(125)]) for j in range(125)]
kernel = q.nullspace(list(map(list, zip(*columns))))
kernel, pivots = q.rref(kernel)
kernel = kernel[:len(pivots)]
degrees = [min(d for d, c in zip(q.SD, v) if c) for v in kernel]
active = [(i, v) for i, v in enumerate(kernel)
          if args.min_source <= degrees[i] <= args.max_source]
target = [i for i, d in enumerate(q.SD)
          if d <= args.max_target and i not in setup["QR"][1]]
equations = {i: {} for i in target}
for i, (_, a) in enumerate(active):
    lin = q.reduceq(q.rneg(q.carry(q.f, a)), setup["QR"])
    for k in target:
        if lin[k]:
            equations[k][(i,)] = lin[k]
    for j, (_, b) in enumerate(active[:i + 1]):
        quad = q.rneg(q.Qpair(a, b, setup["BR"]))
        if i != j:
            quad = q.rscale(quad, 2)
        quad = q.reduceq(quad, setup["QR"])
        for k in target:
            if quad[k]:
                equations[k][(j, i)] = quad[k]

def coefficient(c):
    terms = [str(a) + ("*t" if i == 1 else "*t^2" if i == 2 else "")
             for i, a in enumerate(q.DIG[c]) if a]
    return "(" + "+".join(terms) + ")"

def polynomial(p):
    return "+".join(coefficient(c) + "*" + "*".join("x" + str(i) for i in mon)
                    for mon, c in sorted(p.items())) or "0"

nonzero = {i: v for i, v in equations.items() if v}
report = {
    "variables": [{"index": j, "leading_degree": degrees[i],
                   "kernel": [[list(sm), c] for sm, c in zip(q.SM, a) if c]}
                  for j, (i, a) in enumerate(active)],
    "equations": [{"normal_monomial": list(q.SM[i]),
                   "terms": [[list(mon), c] for mon, c in sorted(p.items())]}
                  for i, p in nonzero.items()],
    "term_counts_by_target_degree": {d: [len(p) for i, p in nonzero.items() if q.SD[i] == d]
                                    for d in range(args.max_target + 1)},
    "scope": "Necessary quotient only if target cutoff is below the minimum source degree; omitted source freedoms must separately be proved invisible. No full E4 claim.",
}
args.output.write_text(json.dumps(report, indent=2) + "\n")
print(json.dumps(report["term_counts_by_target_degree"], indent=2))
if args.singular:
    data = ["ring r=(5,t),(" + ",".join("x" + str(i) for i in range(len(active))) + "),dp;",
            "minpoly=t^3+t+1;",
            "ideal I=" + ",\n".join(polynomial(p) for p in nonzero.values()) + ";",
            "print(\"variables/equations\"); print(nvars(basering)); print(size(I));",
            "ideal G=std(I); print(\"dimension\"); print(dim(G));",
            "print(\"basis size\"); print(size(G)); print(G); quit;"]
    args.singular.write_text("\n".join(data) + "\n")
