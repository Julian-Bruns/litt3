#!/usr/bin/env python3
"""Independent direct-division checks for forced endpoint coefficient planes.

The exhaustive C++ program uses relative norms. This checker instead solves
two four-by-four multiplication systems over M to obtain the actual jets.
Only the emitted deterministic samples are checked here; completeness is
the separate exhaustive enumeration.
"""
import argparse
import json
from pathlib import Path
import klein_four_constant_pencil_targets as T
import klein_four_constant_character_jet as J
F = J.F
Z, O = T.ZERO, T.ONE


def m4(a, b):
    out = [Z]*7
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            out[i+j] = T.add(out[i+j], T.mul(x, y))
    for i in range(6, 3, -1):
        for j, c in enumerate(F.AMONIC[:4]):
            out[i-4+j] = T.sub(out[i-4+j], scale(out[i], c))
    return out[:4]


def scale(a, c):
    return tuple(F.f.mul(v, c) for v in a)


def divide4(rhs, b):
    columns = []
    for j in range(4):
        unit = [Z]*4
        unit[j] = O
        columns.append(m4(b, unit))
    rows = [[columns[j][i] for j in range(4)] + [rhs[i]] for i in range(4)]
    for j in range(4):
        p = next(i for i in range(j, 4) if rows[i][j] != Z)
        rows[j], rows[p] = rows[p], rows[j]
        inv = T.inv(rows[j][j])
        rows[j] = [T.mul(v, inv) for v in rows[j]]
        for i in range(4):
            if i == j:
                continue
            c = rows[i][j]
            rows[i] = [T.sub(x, T.mul(c, y)) for x, y in zip(rows[i], rows[j])]
    answer = [r[-1] for r in rows]
    assert m4(b, answer) == rhs
    return answer


def cross(a, b):
    return [T.sub(T.mul(a[(i+1)%3], b[(i+2)%3]),
                  T.mul(a[(i+2)%3], b[(i+1)%3])) for i in range(3)]


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('root', type=Path)
    args = ap.parse_args()
    old = F.construct_data()
    roots = list(map(tuple, old['alpha_roots']))
    bases = list(map(tuple, old['B_base']))
    z = (0, 1, 0, 0, 0, 0, 0)
    zp = [O]
    for i in range(1, 29):
        zp.append(T.mul(zp[-1], z))
    constants = []
    for a, b in zip(roots, bases):
        ca = F.es(F.ei(F.ev(F.f.der(F.f.A), a)), 13)
        la = F.em(ca, F.ea(
            F.em(F.ev(F.f.der(F.f.P), a), F.ei(F.ev(F.f.P, a))),
            F.en(F.em(F.ev(F.f.der(F.f.der(F.f.A)), a), F.ei(F.ev(F.f.der(F.f.A), a))))))
        constants.append([a, b, F.em(ca, F.ep(b, 4)), F.em(la, F.ep(b, 5))])
    checked = []
    for line in (args.root/'two_endpoint_plane_samples.tsv').read_text().splitlines():
        tags, phases, character, normal, direction = line.split('\t')
        parse = lambda s: [int(v) for v in s.strip(',').split(',')]
        tags, phases, character = parse(tags), parse(phases), int(character)
        expected = parse(normal)
        labels = []
        for tag, phase in zip(tags, phases):
            labels.append([[scale(zp[(weight*phase)%29], v) for v in coeff]
                           for coeff, weight in zip(constants[tag], (0, 1, 4, 5))])
        sums = [[Z]*4 for _ in range(4)]
        for sign, label in zip(J.SIGNS[character], labels):
            for j in range(4):
                sums[j] = [T.add(x, scale(y, sign)) for x, y in zip(sums[j], label[j])]
        a, b, da, db = sums
        r = divide4(a, b)
        s = divide4([T.sub(x, y) for x, y in zip(da, m4(r, db))], b)
        n = cross(r[1:], s[1:])
        pivot = next(x for x in n if x != Z)
        n = [T.mul(x, T.inv(pivot)) for x in n]
        assert [v for x in n for v in x] == expected, (tags, phases, character)
        raw = parse(direction)
        dr = [tuple(raw[7*i:7*i+7]) for i in range(3)]
        assert all(v == Z for v in cross(r[1:], dr))
        checked.append({'tags': tags, 'phases': phases, 'character': character})
    assert len(checked) >= 150
    result = {'status': 'PASS', 'method': 'Independent direct division by Gaussian elimination over M, without the relative-norm shortcut.',
              'scope': 'Deterministic samples only; full enumeration is separately retained.',
              'count': len(checked), 'checks': checked}
    (args.root/'two_endpoint_planes_independent.json').write_text(json.dumps(result, indent=2)+'\n')
    print('PASS direct plane and direction checks:', len(checked))


if __name__ == '__main__':
    main()
