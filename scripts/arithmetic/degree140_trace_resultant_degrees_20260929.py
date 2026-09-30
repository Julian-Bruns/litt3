"""Retain degree and valuation bounds for the new trace resultants.

These are assignment-problem bounds for Sylvester determinants, not a
replay of the incoming Pro calculations. The dual potentials are retained.
"""
import json
import re
import sys
from pathlib import Path

import numpy as np


def assignment(cost):
    n = len(cost)
    u, v, p, way = [0] * (n + 1), [0] * (n + 1), [0] * (n + 1), [0] * (n + 1)
    for i in range(1, n + 1):
        p[0] = i
        j0 = 0
        minv, used = [10**12] * (n + 1), [False] * (n + 1)
        while True:
            used[j0] = True
            i0, delta, j1 = p[j0], 10**12, 0
            for j in range(1, n + 1):
                if not used[j]:
                    cur = cost[i0 - 1][j - 1] - u[i0] - v[j]
                    if cur < minv[j]:
                        minv[j], way[j] = cur, j0
                    if minv[j] < delta:
                        delta, j1 = minv[j], j
            for j in range(n + 1):
                if used[j]:
                    u[p[j]] += delta
                    v[j] -= delta
                else:
                    minv[j] -= delta
            j0 = j1
            if p[j0] == 0:
                break
        while True:
            j1 = way[j0]
            p[j0] = p[j1]
            j0 = j1
            if j0 == 0:
                break
    matching = [0] * n
    for j in range(1, n + 1):
        matching[p[j] - 1] = j - 1
    return {"value": sum(cost[i][matching[i]] for i in range(n)),
            "matching": matching, "row_potential": u[1:], "column_potential": v[1:]}


def sylvester_bound(a, b, maximize=False):
    m, n = len(a) - 1, len(b) - 1
    mat = [[10**9] * (m + n) for _ in range(m + n)]
    for row in range(n):
        for k, value in enumerate(a):
            mat[row][row + k] = -value if maximize else value
    for row in range(m):
        for k, value in enumerate(b):
            mat[n + row][row + k] = -value if maximize else value
    answer = assignment(mat)
    answer["bound"] = -answer["value"] if maximize else answer["value"]
    return answer


root = Path(sys.argv[1])
meta = json.loads((root / "global_positive_summary.json").read_text())
nh, nq = meta["grid"]
data = np.fromfile(root / "global_positive_coefficients.bin", dtype="<i4").reshape(50, nh, nq)
minimal_dp = {}
for line in (root / "global_positive_symbolic.log").read_text().splitlines():
    match = re.match(r"coefficient (\d+) (\d+) terms \d+ den \((\d+), (\d+), (\d+)\)", line)
    if match:
        j, n, dh, dq, dp = map(int, match.groups())
        minimal_dp[j, n] = dp
rows = meta["coefficients"]
M = [max(r["denominator_H_q_Psi"][0] - r["n"] for r in rows if r["j"] == j) for j in range(3)]
DP = [max(r["denominator_H_q_Psi"][2] for r in rows if r["j"] == j) for j in range(3)]
cut = [10**9] * 3
degrees = [[] for _ in range(3)]
valuations = [[] for _ in range(3)]
for i, r in enumerate(rows):
    j, n = r["j"], r["n"]
    dh, dq, dp = r["denominator_H_q_Psi"]
    ii, jj = np.nonzero(data[i])
    cut[j] = min(cut[j], int(ii.min()) + M[j] + n - dh)
    degrees[j].append(int(ii.max()) + M[j] + n - dh + DP[j] - dp)
    valuations[j].append(DP[j] - minimal_dp[j, n])
for j in range(3):
    degrees[j] = [d - cut[j] for d in degrees[j]]
deg_sum = [max(a, b) for a, b in zip(degrees[1], degrees[2])]
val_sum = [min(a, b) for a, b in zip(valuations[1], valuations[2])]
certificates = []
for label, deg, val in [("01", degrees[1], valuations[1]), ("02", degrees[2], valuations[2]), ("0_1plus2", deg_sum, val_sum)]:
    certificates.append({"pair": label,
                         "H_degree": sylvester_bound(degrees[0], deg, True),
                         "Psi_order": sylvester_bound(valuations[0], val)})
answer = {"rescaling": "mu=H*u", "common_H_powers_removed": cut,
          "coefficient_H_degrees": degrees, "coefficient_Psi_orders": valuations,
          "resultants": certificates}
out = root / "positive_resultant_global_degree_certificate.json"
out.write_text(json.dumps(answer, indent=2) + "\n")
print(json.dumps({"output": str(out), "bounds": [{"pair": c["pair"], "H_degree": c["H_degree"]["bound"], "Psi_order": c["Psi_order"]["bound"]} for c in certificates]}))
