#!/usr/bin/env python3
"""Continue the two-endpoint constant test allowing mixed degree14 nodes."""
import argparse
import json
from pathlib import Path
import check_klein_four_constant_pencils as C
from klein_four_constant_marked_pencils import ground_vector, ground_rank

T, Z, O = C.T, C.Z, C.O


def evaluate(poly, a):
    v = Z
    for b in reversed(poly):
        v = T.add(T.mul(v, a), b)
    return v


def subsets(rows, dim):
    out = [((Z,)*dim, 0)]
    for i, row in enumerate(rows):
        out += [(tuple(T.add(a, b) for a, b in zip(v, row)), m | 1 << i) for v, m in out[:]]
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('root', type=Path)
    root = ap.parse_args().root
    targets = json.loads((root/'linear_pencil_targets.json').read_text())['targets']
    log = (root/'degree14_marked_candidates.log').read_text()
    assert 'TOTAL normalized_subsets=40116600 representatives=191280 covered=40116600' in log
    records = [line.split() for line in (root/'degree14_marked_candidates.tsv').read_text().splitlines()]
    zs = [C.power((0, 1, 0, 0, 0, 0, 0), i) for i in range(29)]
    cache = {}
    out = []
    for record in records:
        kind, mask, first, *last = record
        mask, first = int(mask), int(first)
        if mask not in cache:
            nodes = [i for i in range(29) if not mask >> i & 1]
            d = [O]
            for a in nodes:
                d = C.pm(d, [T.neg(zs[a]), O])
            assert len(d) == 15
            q, _ = C.divide([Z]*22+[O], d)
            derivative = [C.scale(v, i % 5) for i, v in enumerate(d)][1:]
            weights = []
            for a in nodes:
                den = T.inv(evaluate(derivative, zs[a]))
                weights.append(tuple(T.mul(zs[k*a % 29], den) for k in (20, 21)))
            cache[mask] = nodes, d, q, weights
        nodes, d, q, weights = cache[mask]
        lam, nu, tr, cn = map(tuple, targets[first])
        p, alpha, gamma = T.inv(d[0]), T.mul(d[1], T.inv(d[0])), d[13]
        k = T.mul(p, T.sub(lam, alpha))
        shift0 = T.sub(T.mul(p, nu), C.scale(q[1], 2))
        if kind == 'ZERO':
            assert k == Z and not last
            wanted = (T.neg(shift0),)
            rows = [(w[0],) for w in weights]
        else:
            assert kind == 'PAIR' and k != Z and len(last) == 1
            second = int(last[0])
            lam2, nu2, tr2, cn2 = map(tuple, targets[second])
            assert T.mul(T.sub(lam2, gamma), T.sub(lam, alpha)) == O
            shift = C.scale(T.sub(tr2, T.mul(k, tr)), 3)
            assert cn2 == T.sub(T.sub(T.mul(T.mul(k, k), cn), T.mul(T.mul(k, tr), shift)), T.mul(shift, shift))
            wanted = (T.sub(shift, shift0), T.add(T.sub(nu2, T.mul(T.sub(gamma, lam2), shift)), C.scale(q[0], 2)))
            rows = weights
        ground = list(map(ground_vector, rows))
        rank = ground_rank(ground)
        aug = ground_rank(ground+[ground_vector(wanted)])
        matches = []
        if rank == aug:
            lookup = {}
            for v, m in subsets(rows[:7], len(wanted)):
                lookup.setdefault(v, []).append(m)
            for v, m in subsets(rows[7:], len(wanted)):
                needed = tuple(T.sub(a, b) for a, b in zip(wanted, v))
                for lo in lookup.get(needed, []):
                    selected = lo | m << 7
                    matches.append(sum(1 << nodes[i] for i in range(14) if selected >> i & 1))
        item = {'kind': kind, 'complement_mask': mask, 'first_target': first,
                'second_target': int(last[0]) if last else None,
                'rank': rank, 'augmented_rank': aug, 'mixed_masks': matches}
        out.append(item)
        if matches:
            print('MATCH', item, flush=True)
    result = {'status': 'necessary_test_complete', 'candidates': len(out), 'different_divisors': len(cache),
              'ground_rank_survivors': sum(r['rank'] == r['augmented_rank'] for r in out),
              'marked_matches': sum(len(r['mixed_masks']) for r in out), 'checks': out}
    (root/'degree14_markings.json').write_text(json.dumps(result, indent=2)+'\n')
    print({k: v for k, v in result.items() if k != 'checks'})


if __name__ == '__main__':
    main()
