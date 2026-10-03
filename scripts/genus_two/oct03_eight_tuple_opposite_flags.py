#!/usr/bin/env python3
"""Single-thread, time-bounded exact opposite-flag block-pencil probe over F5."""
import argparse
import itertools
import json
import time
from pathlib import Path

import numpy as np
from oct03_eight_tuple_block_ansatz import mul, power, rref, nil_ranks
from oct03_eight_tuple_rank2_planes import affine_solution, algebra_certificate


def all_planes():
    for pivots in itertools.combinations(range(4), 2):
        positions = [(r, c) for r in range(2) for c in range(pivots[r]+1, 4)
                     if c not in pivots]
        for coeffs in itertools.product(range(5), repeat=len(positions)):
            rows = np.zeros((2, 4), dtype=np.int64)
            for r, c in enumerate(pivots):
                rows[r, c] = 1
            for pos, value in zip(positions, coeffs):
                rows[pos] = value
            yield rows.T


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--seconds', type=float, default=25)
    parser.add_argument('--output', required=True)
    parser.add_argument('--powers', type=int, nargs='+', default=[1, 2, 3, 4])
    args = parser.parse_args()
    started = time.monotonic()
    i4 = np.eye(4, dtype=np.int64)
    i8 = np.eye(8, dtype=np.int64)
    z4 = np.zeros((4, 4), dtype=np.int64)
    u = i4.copy()
    u[np.arange(3), np.arange(1, 4)] = 1
    s = np.block([[z4, 3*i4], [i4, z4]])
    result = {'field': 5, 'ansatz': 'A=[[J4,X],[0,(J4^T)^k]], AB=S, S^2=3I',
              'runs': [], 'tuples': [], 'stopped': None}
    for k in args.powers:
        v = power(u.T, k)
        up = [power(u, i) for i in range(5)]
        vp = [power(v, i) for i in range(5)]
        x0 = (3*i4 - mul(u, v)) % 5
        invuv = mul(power(v, 4), power(u, 4))
        def linear(x):
            return sum((mul(mul(up[i], x), vp[4-i]) for i in range(5)), z4.copy()) % 5
        rhs = np.concatenate((-linear(x0).reshape(-1),
                              [(4 - np.trace(x0)) % 5,
                               (2 - np.trace(mul(invuv, x0))) % 5])) % 5
        run = {'k': k, 'planes': 0, 'consistent_planes': 0, 'tested': 0,
               'rank2': 0, 'B_order5': 0, 'both_type5_3': 0,
               'irreducible': 0, 'max_affine_dimension': 0}
        result['runs'].append(run)
        for p in all_planes():
            if time.monotonic() - started >= args.seconds:
                result['stopped'] = 'time_bound'
                break
            run['planes'] += 1
            generators = [mul(p, np.eye(8, dtype=np.int64)[i].reshape(2, 4)) for i in range(8)]
            columns = [np.concatenate((linear(y).reshape(-1),
                       [np.trace(y) % 5, np.trace(mul(invuv, y)) % 5])) for y in generators]
            solution = affine_solution(np.array(columns).T, rhs)
            if solution is None:
                continue
            particular, basis = solution
            run['consistent_planes'] += 1
            run['max_affine_dimension'] = max(run['max_affine_dimension'], len(basis))
            if len(basis) > 4:
                raise RuntimeError('Refuse family dimension greater than four')
            for coeffs in itertools.product(range(5), repeat=len(basis)):
                if time.monotonic() - started >= args.seconds:
                    result['stopped'] = 'time_bound'
                    break
                r = (particular + sum((c*z for c, z in zip(coeffs, basis)),
                                     np.zeros(8, dtype=np.int64))) % 5
                run['tested'] += 1
                if len(rref(r.reshape(2, 4))[1]) != 2:
                    continue
                run['rank2'] += 1
                x = (x0 + mul(p, r.reshape(2, 4))) % 5
                a = np.block([[u, x], [z4, v]])
                b = mul(power(a, 4), s)
                if not np.array_equal(power(b, 5), i8):
                    continue
                run['B_order5'] += 1
                if nil_ranks(a) != [6, 4, 2, 1, 0] or nil_ranks(b) != [6, 4, 2, 1, 0]:
                    continue
                run['both_type5_3'] += 1
                assert np.array_equal(power(a, 5), i8)
                certificate = algebra_certificate(a, b)
                if certificate is None:
                    continue
                run['irreducible'] += 1
                result['tuples'].append({'k': k, 'P': p.tolist(), 'R': r.reshape(2,4).tolist(),
                                        'A': a.tolist(), 'B': b.tolist(),
                                        'algebra_basis_words': certificate})
                result['stopped'] = 'first_irreducible'
                break
            if result['stopped']:
                break
        if result['stopped']:
            break
    result['elapsed_seconds'] = time.monotonic() - started
    target = Path(args.output)
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps({k:v for k,v in result.items() if k != 'tuples'}))
    print('candidate_count', len(result['tuples']))


if __name__ == '__main__':
    main()
