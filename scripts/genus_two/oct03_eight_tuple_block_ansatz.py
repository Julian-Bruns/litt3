#!/usr/bin/env python3
"""Bounded structured 4+4 block ansatz over F5, never a full matrix search."""
import argparse
import itertools
import json
import time
from pathlib import Path

import numpy as np

P = 5


def mul(a, b):
    return a @ b % P


def power(a, n):
    out = np.eye(len(a), dtype=np.int64)
    for _ in range(n):
        out = mul(out, a)
    return out


def rref(a):
    a = np.array(a, dtype=np.int64).copy() % P
    row = 0
    pivots = []
    for col in range(a.shape[1]):
        found = next((i for i in range(row, len(a)) if a[i, col]), None)
        if found is None:
            continue
        a[[row, found]] = a[[found, row]]
        a[row] = a[row] * pow(int(a[row, col]), -1, P) % P
        for i in range(len(a)):
            if i != row and a[i, col]:
                a[i] = (a[i] - a[i, col] * a[row]) % P
        pivots.append(col)
        row += 1
        if row == len(a):
            break
    return a, pivots


def nullspace(a):
    a, pivots = rref(a)
    free = [i for i in range(a.shape[1]) if i not in pivots]
    basis = []
    for col in free:
        v = np.zeros(a.shape[1], dtype=np.int64)
        v[col] = 1
        for row, pivot in enumerate(pivots):
            v[pivot] = -a[row, col] % P
        basis.append(v)
    return basis


def nil_ranks(a):
    nil = (a - np.eye(len(a), dtype=np.int64)) % P
    acc = np.eye(len(a), dtype=np.int64)
    ranks = []
    for _ in range(5):
        acc = mul(acc, nil)
        ranks.append(len(rref(acc)[1]))
    return ranks


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', required=True)
    parser.add_argument('--seconds', type=float, default=25)
    parser.add_argument('--support', type=int, choices=(0, 1, 2, 3), default=2)
    parser.add_argument('--shift-rank2', action='store_true')
    args = parser.parse_args()
    started = time.monotonic()
    identity4 = np.eye(4, dtype=np.int64)
    identity8 = np.eye(8, dtype=np.int64)
    zero4 = np.zeros((4, 4), dtype=np.int64)
    u = identity4.copy()
    u[np.arange(3), np.arange(1, 4)] = 1
    # S=A B, with S^2=3I, hence C^2=2I and lambda^4=-1.
    s = np.block([[zero4, 3 * identity4], [identity4, zero4]])
    assert np.array_equal(power(s, 2), 3 * identity8)
    result = {'field': 5, 'ansatz': 'A=[[J4,X],[0,J4^k]], AB=S, S^2=3I',
              'shift_rank2': args.shift_rank2,
              'support_bound': args.support, 'runs': [], 'tuples': []}
    for k in range(1, 5):
        v = power(u, k)
        # A^5 off-diagonal is a linear function of X.
        basis16 = [np.eye(16, dtype=np.int64)[i].reshape(4, 4) for i in range(16)]
        columns = []
        for x in basis16:
            total = sum((mul(mul(power(u, i), x), power(v, 4-i))
                         for i in range(5)), np.zeros((4, 4), dtype=np.int64)) % P
            columns.append(total.reshape(-1))
        basis = [x.reshape(4, 4) for x in nullspace(np.array(columns).T)]
        if args.shift_rank2:
            families = []
            x0 = (3 * identity4 - mul(u, v)) % P
            assert np.array_equal(power(np.block([[u, x0], [zero4, v]]), 5), identity8)
            for other_row in range(3):
                indices = [4*r+c for r in (other_row, 3) for c in range(4)]
                masked_basis = []
                for coeffs in nullspace(np.array(columns).T[:, indices]):
                    x = np.zeros(16, dtype=np.int64)
                    x[indices] = coeffs
                    masked_basis.append(x.reshape(4, 4))
                if len(masked_basis) > 6:
                    raise RuntimeError('Refuse enumeration of dimension greater than six')
                families.append((other_row, masked_basis))
            run = {'k': k, 'families': []}
            result['runs'].append(run)
            done = False
            for other_row, masked_basis in families:
                fam = {'rows': [other_row, 3], 'dimension': len(masked_basis),
                       'tested': 0, 'rank2': 0, 'A_type_5_3': 0, 'B_order5': 0,
                       'B_type_5_3': 0}
                run['families'].append(fam)
                for coefficients in itertools.product(range(P), repeat=len(masked_basis)):
                    if time.monotonic() - started >= args.seconds:
                        done = True
                        break
                    y = sum((c*z for c, z in zip(coefficients, masked_basis)), zero4.copy()) % P
                    fam['tested'] += 1
                    if len(rref(y)[1]) != 2:
                        continue
                    fam['rank2'] += 1
                    x = (x0 + y) % P
                    a = np.block([[u, x], [zero4, v]])
                    b = mul(power(a, 4), s)
                    if not np.array_equal(power(b, 5), identity8):
                        continue
                    fam['B_order5'] += 1
                    if nil_ranks(a) != [6, 4, 2, 1, 0]:
                        continue
                    fam['A_type_5_3'] += 1
                    if nil_ranks(b) != [6, 4, 2, 1, 0]:
                        continue
                    fam['B_type_5_3'] += 1
                    assert np.array_equal(power(a, 5), identity8)
                    result['tuples'].append({'k': k, 'rows': [other_row, 3],
                                             'coefficients': coefficients,
                                             'A': a.tolist(), 'B': b.tolist()})
                if done:
                    break
            if done:
                result['timeout'] = True
                break
            continue
        run = {'k': k, 'linear_dimension': len(basis), 'tested': 0,
               'A_type_5_3': 0, 'B_order5': 0, 'B_type_5_3': 0}
        result['runs'].append(run)
        done = False
        for support in range(args.support + 1):
            for indices in itertools.combinations(range(len(basis)), support):
                for coefficients in itertools.product(range(1, P), repeat=support):
                    if time.monotonic() - started >= args.seconds:
                        done = True
                        break
                    x = sum((c * basis[i] for i, c in zip(indices, coefficients)),
                            zero4.copy()) % P
                    a = np.block([[u, x], [zero4, v]])
                    assert np.array_equal(power(a, 5), identity8)
                    b = mul(power(a, 4), s)
                    run['tested'] += 1
                    if nil_ranks(a) != [6, 4, 2, 1, 0]:
                        continue
                    run['A_type_5_3'] += 1
                    if not np.array_equal(power(b, 5), identity8):
                        continue
                    run['B_order5'] += 1
                    if nil_ranks(b) != [6, 4, 2, 1, 0]:
                        continue
                    run['B_type_5_3'] += 1
                    result['tuples'].append({'k': k, 'indices': indices,
                                             'coefficients': coefficients,
                                             'A': a.tolist(), 'B': b.tolist()})
                if done:
                    break
            if done:
                break
        if done:
            result['timeout'] = True
            break
    else:
        result['timeout'] = False
    result['elapsed_seconds'] = time.monotonic() - started
    target = Path(args.output)
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps({k: v for k, v in result.items() if k != 'tuples'}))
    print('candidate_count', len(result['tuples']))


if __name__ == '__main__':
    main()
