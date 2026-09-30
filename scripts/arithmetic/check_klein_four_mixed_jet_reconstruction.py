#!/usr/bin/env python3
"""Exact integer scope of mixed-denominator character reconstruction.

All conclusions fix the entire parameter curve and endpoint frames.
No actual curve existence or covering-degree exclusion is asserted.
"""
import argparse
import hashlib
import json
from pathlib import Path


def lifting_bounds(d, i):
    if d[i] <= 3:
        return {'automatic': True, 'max_single_zeros': None}
    if d[i] > 10:
        return {'automatic': False, 'max_single_zeros': None}
    others = [d[j] for j in range(3) if j != i]
    one_end = sum(others) <= 3
    both_ends = max(others) <= 1
    bounds = []
    for r in range(d[i]-3):
        bound = 16+2*r
        if one_end:
            bound = 15 if r == 0 else 14+2*r
        if both_ends and r == 0:
            bound = 13
        bounds.append(bound)
    return {'automatic': False, 'one_nonzero_end': one_end,
            'both_nonzero_ends': both_ends,
            'max_single_zeros': max(bounds)}


def check(profile, allocation):
    d, c = allocation['d'], allocation['c']
    u, j2 = 29-profile['e'], profile['j2']
    j = profile['j1']+j2
    known_t = [v <= 3 for v in d]
    known_q = [False]*3
    bounds = [lifting_bounds(d, i) for i in range(3)]
    trace = []
    while True:
        previous = known_t[:], known_q[:]
        delta = [di if fixed else 2*di for di, fixed in zip(d, known_t)]
        first = [ci+u >= 12+v for ci, v in zip(c, delta)]
        axes = [2*ci+u >= 12+v for ci, v in zip(c, delta)]
        known_q = [v or w for v, w in zip(known_q, first)]
        quadratic = 2*j+2*j2 > 22+sum(delta)-2*u
        # With one zero coordinate, q(v)=0 puts a difference on an axis.
        # Each separately excluded axis has zero coordinate in every pair.
        if quadratic and any(known_q):
            known_q = [v or w for v, w in zip(known_q, axes)]
        if sum(known_q) >= 2:
            known_q = [v or w for v, w in zip(known_q, axes)]
        for i in range(3):
            b = bounds[i]['max_single_zeros']
            if known_q[i] and b is not None and c[i]-j2 > b:
                known_t[i] = True
        trace.append({'delta': delta, 'individual': first, 'axes': axes,
                      'quadratic': quadratic, 'known_quotients': known_q[:],
                      'known_denominators': known_t[:]})
        if previous == (known_t, known_q):
            break
        assert len(trace) <= 7
    return {'g': profile['g'], 'e': profile['e'], 'j1': profile['j1'],
            'j2': j2, 'd': d, 'c': c, 'lift_bounds': bounds,
            'steps': trace, 'quotients_unique': all(known_q),
            'complete_characters_unique': all(known_q) and all(known_t)}


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('profiles', type=Path, nargs='+')
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    rows = []
    for path in args.profiles:
        data = json.loads(path.read_text())
        for row in data['rows']:
            if row['n'] not in (85, 86, 87):
                continue
            checks = [check(p, a) for p in row['profiles']
                      for a in p['character_allocations']]
            total = len(checks)
            assert total == {85: 4616, 86: 729, 87: 109}[row['n']]
            q = sum(v['quotients_unique'] for v in checks)
            full = sum(v['complete_characters_unique'] for v in checks)
            if row['n'] in (86, 87):
                assert q == full == total
            else:
                assert (q, full) == (4588, 4536)
            rows.append({'n': row['n'], 'allocations': total,
                         'quotients_unique': q,
                         'complete_characters_unique': full, 'checks': checks})
            print('PASS degree', row['n'], 'quotients', q,
                  'complete characters', full, 'of', total)
    assert len({r['n'] for r in rows}) == len(rows)
    args.output.write_text(json.dumps({'status': 'PASS',
        'scope': 'Necessary integer profiles; fixed entire parameter curve and full endpoint frames. No existence assertion.',
        'inputs': [{'path': str(p), 'sha256': hashlib.sha256(p.read_bytes()).hexdigest()}
                   for p in args.profiles], 'rows': rows}, separators=(',', ':'))+'\n')


if __name__ == '__main__':
    main()
