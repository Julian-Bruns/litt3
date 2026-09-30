#!/usr/bin/env python3
"""Reproduce the exact point, rank, minor, kernel and tangent certificates."""
from pathlib import Path
import json
from ff25poly import *
from exact_linear_algebra import *
ROOT = Path(__file__).resolve().parents[1]
D = json.loads((ROOT / 'input/data/invariant_blocks.json').read_text())
S = json.loads((ROOT / 'data/shape.json').read_text())
M = [[17,8,18,15,24,10],[17,12,7,22,17,1],[17,12,19,21,19,8],
     [12,5,5,20,9,11],[2,1,1,19,5,0],[7,24,0,15,4,1]]
P = [11,22,18,5,19,20,15,16,9,22,1]
B = [[0,0,0,0,0,1,23],[0,0,0,0,1,0,16,3],[0,0,0,1,0,0,4],
     [0,0,1,0,0,0,3,23],[0,1,0,0,0,0,10,8],[1,0,0,0,0,0,5,10]]

def change_coordinates(u):
    v = [[] for _ in range(6)]
    for i in range(6):
        for c, a in zip(M[i], u):
            v[i] = add(v[i], scale(a, c))
    return v

def build():
    result = []
    for i, f in enumerate(S['factors']):
        assert irreducible(f)
        u = [[1]] + [mod(c, f) for c in S['coords']]
        assert mod(sub(sub(u[2], mul(u[1], u[1])), [0,1]), f) == []
        v = normalize(change_coordinates(u), f)
        result.append({'id': f'R{i+1:02}', 'field_modulus': f,
                       'degree_over_F25': len(f)-1, 'u_coordinates': u,
                       'v_coordinates': v})
    result.append({'id': 'star', 'field_modulus': [0,1],
                   'degree_over_F25': 1,
                   'u_coordinates': [[],[1],[6],[17],[4],[4]],
                   'v_coordinates': [[1],[10],[15],[16],[5],[8]]})
    for point in result:
        f, v = point['field_modulus'], point['v_coordinates']
        point['T_certificate'] = rank_certificate(eval_linear(D['T'], v), f)
        point['Q_certificate'] = rank_certificate(eval_linear(D['Q'], v), f)
        point['tangent_certificate'] = rank_certificate(tangent_matrix(D['T'], v, f), f)
        assert point['T_certificate']['rank'] == 14
        assert point['Q_certificate']['rank'] == 8
        assert point['tangent_certificate']['rank'] == 5
        print('PASS point', point['id'], 'degree', len(f)-1,
              'ranks (14,8), projective tangent dimension 0', flush=True)
    stability = []
    for i, f in enumerate(factor_squarefree(P)):
        assert irreducible(f)
        v = normalize([mod(b, f) for b in B], f)
        t = rank_certificate(eval_linear(D['T'], v), f)
        q = rank_certificate(eval_linear(D['Q'], v), f)
        assert t['rank'] == 15 and q['rank'] == 9
        stability.append({'id': f'B{i+1}', 'root_modulus': f,
                          'degree_over_F25': len(f)-1, 'v_coordinates': v,
                          'T_certificate': t, 'Q_certificate': q})
        print('PASS excluded stability orbit', i+1, 'degree', len(f)-1,
              'ranks (15,9)', flush=True)
    return {'field_convention': 'codes a+5b represent a+b*beta, beta^2=beta+3; ascending polynomials',
            'isolated_points': result, 'strictly_semistable_orbits': stability}

if __name__ == '__main__':
    data = build()
    (ROOT / 'data/points.json').write_text(json.dumps(data, indent=2) + '\n')
