#!/usr/bin/env python3
"""Combine the established degree-ten linear family with pole restrictions.

This is an exact necessary-condition calculation, not an etale realization.
The input is the retained degree10_admissible_primitive result directory.
"""
import argparse
import json
import sys
from pathlib import Path

p = argparse.ArgumentParser()
p.add_argument('archive', type=Path)
p.add_argument('output', type=Path)
a = p.parse_args()
sys.path.insert(0, str(a.archive / 'source'))
from reconstruction import (np, DIG, VARS, P, nullE, matmulE, rrefE,
                            enc, add, neg, evmul)

data = json.loads((a.archive / 'certificates/linear_system.json').read_text())
K = DIG[:, np.array(data['full_kernel_columns'], dtype=np.int64).T]
rows = [j for j, v in enumerate(VARS) if v[0] == 1]
rows += [VARS.index((0, 1, 0))]
N, _ = nullE(K[:, rows, :])
K = matmulE(K, N)

# Projection to (v0,v1,v2,v3,D0,...,D4,Dy,Dxy,kappa), with N2=y^2 D.
labels = ['v0','v1','v2','v3'] + ['D'+str(i) for i in range(5)] + ['Dy','Dxy','kappa']
T = np.zeros((4, 12, 196), dtype=np.int16)
for i in range(4): T[0, i, VARS.index((0, 0, i))] = 1
for i in range(5): T[0, 4+i, VARS.index((2, 2, i))] = 1
# Since P is monic of degree10, read the two coefficients from P(Dy+xDxy).
T[0, 10, VARS.index((2, 0, 11))] = 1
T[0, 9, VARS.index((2, 0, 10))] = 1
T[0, 9, VARS.index((2, 0, 11))] = neg[P[9]]
T[0, 11, 195] = 1
J = matmulE(T, K)

# Verify the projected D reconstructs every N2 coefficient exactly.
for j, (i, r, xdeg) in enumerate(VARS):
    if i != 2: continue
    expected = np.zeros((4, K.shape[2]), dtype=np.int16)
    if r == 2 and xdeg < 5: expected = J[:, 4+xdeg, :]
    if r == 0:
        if xdeg < len(P): expected = add[expected, evmul(DIG[:, P[xdeg], None], J[:,9,:])]
        if 0 <= xdeg-1 < len(P): expected = add[expected, evmul(DIG[:, P[xdeg-1], None], J[:,10,:])]
    assert np.array_equal(expected, K[:,j,:])

records = {}
def inspect(name, zero_labels):
    Z, _ = nullE(J[:, [labels.index(v) for v in zero_labels], :])
    JK = matmulE(J, Z)
    KK = matmulE(K, Z)
    def rank(M): return len(rrefE(M)[1])
    item = dict(homogeneous_dimension=KK.shape[2], projection_rank=rank(JK),
                kappa_rank=rank(JK[:,11:12,:]),
                v_rank=rank(JK[:,:4,:]), D_rank=rank(JK[:,4:11,:]),
                forced_zero=[labels[i] for i in range(12) if not JK[:,i,:].any()],
                projected_columns=[[enc(JK[:,i,j]) for i in range(12)] for j in range(JK.shape[2])],
                full_kernel_columns=[[enc(KK[:,i,j]) for i in range(196)] for j in range(KK.shape[2])])
    records[name] = item
    print(name, {k:v for k,v in item.items() if not k.endswith('columns')}, flush=True)

inspect('polynomial_v', [])
inspect('v_degree_le2_D_pole_le12', ['v3','Dxy'])
inspect('v_degree_le1_D_pole_le13', ['v3','v2'])
inspect('v_degree_le1_D_pole_le10', ['v3','v2','D4','Dxy'])
inspect('v_constant_D_pole_le12', ['v3','v2','v1','Dxy'])
inspect('v_constant_D_pole_le10', ['v3','v2','v1','D4','Dxy'])
inspect('v_constant_D_pole_le6', ['v3','v2','v1','D3','D4','Dy','Dxy'])

# All linear dependencies among the twelve displayed coordinates.
deps, _ = nullE(J.transpose(0,2,1))
out = dict(field='F25[rho]/A; little-endian base25 coding', labels=labels,
           dependency_rows=[[enc(deps[:,i,j]) for i in range(12)] for j in range(deps.shape[2])],
           cases=records)
a.output.parent.mkdir(parents=True, exist_ok=True)
a.output.write_text(json.dumps(out, indent=2)+'\n')
