#!/usr/bin/env python3
"""Independent finite Macaulay identities for the leading7 E4 equations."""
import argparse
import itertools
import json
import sys
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument("evidence", type=Path)
parser.add_argument("equations", type=Path)
parser.add_argument("--output", type=Path, required=True)
args = parser.parse_args()
sys.path.insert(0, str(args.evidence.resolve()))
import arith as a
data = json.loads(args.equations.read_text())
n = len(data["variables"])
zero = (0,) * n

def power(indices):
    powers = [0] * n
    for i in indices:
        powers[i] += 1
    return tuple(powers)

polys = [{power(indices): c for indices, c in row["terms"]}
         for row in data["equations"]]
units = [power([i]) for i in range(n)]
for bound in range(4):
    monomials = [power(indices) for d in range(bound + 1)
                 for indices in itertools.combinations_with_replacement(range(n), d)]
    columns = []
    labels = []
    for i, p in enumerate(polys):
        for m in monomials:
            columns.append({tuple(x+y for x,y in zip(e,m)): c for e,c in p.items()})
            labels.append((i, m))
    rows = sorted(set(units).union(*(set(p) for p in columns)), key=lambda x:(sum(x),x))
    matrix = [[p.get(e, 0) for p in columns] + [int(e == u) for u in units] for e in rows]
    rr, pivots = a.rref(matrix, aug=n)
    width = len(columns)
    if any(not any(row[:width]) and any(row[width:]) for row in rr):
        continue
    solutions = []
    for target in range(n):
        vector = [0] * width
        for i, p in enumerate(pivots):
            vector[p] = rr[i][width + target]
        value = {}
        for c, poly in zip(vector, columns):
            for e, b in poly.items():
                value[e] = a.ADD[value.get(e, 0)][a.MUL[c][b]]
        value = {e:c for e,c in value.items() if c}
        assert value == {units[target]: 1}
        solutions.append([{ "equation":i, "powers":list(m), "coefficient":c}
                          for (i,m),c in zip(labels,vector) if c])
    report = {"field": "F5[t]/(t^3+t+1)", "variables":n,
              "equation_count":len(polys), "multiplier_degree_bound":bound,
              "identities":solutions,
              "meaning":"x_i = sum recorded monomial multipliers times the eight actual degree5 obstruction equations; exact coefficient verification passed for all i."}
    args.output.write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps({k:v for k,v in report.items() if k != "identities"}, indent=2))
    print("nonzero multipliers", [len(s) for s in solutions])
    break
else:
    raise RuntimeError("No bounded identity found; do not claim exclusion from this program")
