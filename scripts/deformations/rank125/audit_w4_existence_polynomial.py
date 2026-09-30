"""Independent finite-algebra audit of the returned W4 existence certificate.

No import from the returned engine; the geometric coefficient table is INPUT.
This verifies its algebraic use, not its geometric reconstruction.
"""
import itertools
import json
import sys
from pathlib import Path


def digits(a):
    return (a % 5, (a // 5) % 5, a // 25)


def add(a, b):
    return sum(((x + y) % 5) * 5**i for i, (x, y) in enumerate(zip(digits(a), digits(b))))


def neg(a):
    return sum((-x % 5) * 5**i for i, x in enumerate(digits(a)))


def product(a, b):
    z = [0] * 5
    for i, x in enumerate(digits(a)):
        for j, y in enumerate(digits(b)):
            z[i + j] += x * y
    # t^3 = -t - 1, with reduction in descending degree.
    for i in (4, 3):
        z[i - 3] -= z[i]
        z[i - 2] -= z[i]
    return sum((z[i] % 5) * 5**i for i in range(3))


MUL = [[product(a, b) for b in range(125)] for a in range(125)]


def mul(a, b):
    return MUL[a][b]


def power(a, n):
    z = 1
    while n:
        if n & 1:
            z = mul(z, a)
        a = mul(a, a)
        n //= 2
    return z


def inv(a):
    assert a
    return power(a, 123)


def acc(p, m, a):
    a = add(p.get(m, 0), a)
    if a:
        p[m] = a
    else:
        p.pop(m, None)


def pa(p, q):
    z = p.copy()
    for m, a in q.items():
        acc(z, m, a)
    return z


def scale(p, c):
    return {m: mul(a, c) for m, a in p.items() if mul(a, c)}


def pm(p, q):
    z = {}
    for e, a in p.items():
        for d, b in q.items():
            acc(z, tuple(x + y for x, y in zip(e, d)), mul(a, b))
    return z


def pc(a):
    return {(0, 0): a} if a else {}


def dot(a, b):
    z = 0
    for x, y in zip(a, b):
        if x and y:
            z = add(z, mul(x, y))
    return z


def main(path):
    d = json.loads(Path(path).read_text())
    exps = [tuple(e) for e in d['exponents']]
    ei = {e: i for i, e in enumerate(exps)}
    assert exps == sorted(itertools.product(range(5), repeat=3), key=lambda e: (sum(e), e))
    f = d['scalar_f_through_degree_7']
    kn = d['kernel_basis']
    red = d['quotient_projection']
    qe = [tuple(e) for e in d['quotient_exponents']]
    assert len(kn) == len(qe) == 43
    cs = (3, 1, 2)

    def ringmul(v, w, divided=False):
        z = [0] * 125
        for i, a in enumerate(v):
            if not a:
                continue
            for j, b in enumerate(w):
                if not b:
                    continue
                e = [x + y for x, y in zip(exps[i], exps[j])]
                over = [h for h, x in enumerate(e) if x >= 5]
                if divided:
                    if len(over) != 1:
                        continue
                    h = over[0]
                    e[h] -= 4
                    c = neg(cs[h])
                else:
                    if over:
                        continue
                    c = 1
                k = ei[tuple(e)]
                z[k] = add(z[k], mul(c, mul(a, b)))
        return z

    def project(v):
        return [dot(v, col) for col in zip(*red)]

    pivots = [ei[tuple(e)] for e in d['kernel_pivots']]
    leads = d['kernel_leading_degrees']
    for i, h in enumerate(kn):
        assert not any(ringmul(f, h))
        assert [h[p] for p in pivots] == [int(j == i) for j in range(43)]
        assert min(sum(exps[e]) for e, a in enumerate(h) if a) == leads[i]
        assert all(not a or (sum(exps[e]) - leads[i]) % 2 == 0 for e, a in enumerate(h))
    # The supplied quotient map has its stated 43 independent coordinates,
    # kills every f-multiple, and annihilates J8.
    for j, e in enumerate(qe):
        assert red[ei[e]] == [int(i == j) for i in range(43)]
    for i, e in enumerate(exps):
        v = [0] * 125
        v[i] = 1
        assert not any(project(ringmul(f, v)))
        if sum(e) >= 8:
            assert not any(red[i])
    carry = [project(ringmul(f, h, divided=True)) for h in kn]
    assert carry == d['carry_images']
    print('PASS: all 43 completed kernels, quotient map, carry images and parities')

    qpair = {tuple(pair): project(row) for pair, row in zip(d['quadratic_pairs'], d['quadratic_scalar_coefficients'])}
    alpha, beta = {(1, 0): 1}, {(0, 1): 1}
    b12 = pa(pa(pc(34), scale(alpha, 64)), scale(beta, 12))
    b15 = pa(pa(pc(6), scale(alpha, 111)), scale(beta, 93))
    b16 = pa(pa(pc(15), scale(alpha, 100)), scale(beta, 42))
    b11 = pa(pc(103), scale(b12, neg(34)))
    p = {(2, 0): 55, (1, 1): 123, (0, 2): 59, (1, 0): 90, (0, 1): 81, (0, 0): 124}
    seed = {1: pc(101), 2: pc(14), 11: b11, 12: b12, 15: b15, 16: b16, 27: p}
    h5 = [add(mul(101, kn[1][i]), mul(14, kn[2][i])) if sum(e) == 5 else 0 for i, e in enumerate(exps)]
    g = [0] * 125
    for e, c in [((1, 0, 2), 45), ((1, 1, 1), 41), ((1, 2, 0), 91), ((3, 0, 0), 58)]:
        g[ei[e]] = c
    q = [a if sum(e) == 2 else 0 for e, a in zip(exps, f)]
    assert ringmul(q, g) == h5
    hminus, hplus = [], []
    for e, a in zip(exps, h5):
        c = 1
        for j in range(3):
            c = mul(c, power(cs[j], e[j]))
        hminus.append(mul(power(a, 25), inv(c)))
        hplus.append(mul(power(a, 5), c))
    vminus, vplus = project(hminus), project(hplus)
    expected_minus = [0, 16, 115, 0, 0, 19, 108, 0]
    expected_plus = [0, 62, 15, 0, 0, 10, 29, 0]
    assert [a for a, e in zip(vminus, qe) if sum(e) == 5] == expected_minus
    assert [a for a, e in zip(vplus, qe) if sum(e) == 5] == expected_plus
    assert add(mul(16, 15), neg(mul(62, 115))) == 99

    out = [{} for _ in qe]
    for i, x in seed.items():
        for k, a in enumerate(carry[i]):
            out[k] = pa(out[k], scale(x, neg(a)))
    for (i, j), row in qpair.items():
        if i in seed and j in seed:
            term = scale(pm(seed[i], seed[j]), 1 if i == j else 2)
            for k, a in enumerate(row):
                out[k] = pa(out[k], scale(term, a))
    for k, e in enumerate(qe):
        if sum(e) == 5:
            out[k] = pa(pa(out[k], scale(alpha, vminus[k])), scale(beta, vplus[k]))
        if sum(e) <= 5:
            assert not out[k], (e, out[k])
    print('PASS: seed identity through degree five in the actual polynomial ring k0[alpha,beta]')

    gammas = [{28: 29, 29: 1}, {27: 11, 30: 1}, {27: 87, 31: 1}, {32: 1}]
    rows = []
    for gamma in gammas:
        assert all(leads[j] == 9 for j in gamma)
        row = [{} for _ in qe]
        for j, c in gamma.items():
            for k, a in enumerate(carry[j]):
                row[k] = pa(row[k], pc(neg(mul(c, a))))
            for i, x in seed.items():
                bilinear = qpair.get(tuple(sorted((i, j))), [0] * 43)
                for k, a in enumerate(bilinear):
                    row[k] = pa(row[k], scale(x, mul(2, mul(c, a))))
        assert all(not z for z, e in zip(row, qe) if sum(e) < 7)
        rows.append([z for z, e in zip(row, qe) if sum(e) == 7])
    A = pa(pa(pc(64), scale(alpha, 67)), scale(beta, 33))
    B = pa(pa(pc(81), scale(alpha, 68)), scale(beta, 50))
    C = pa(pa(pc(2), scale(alpha, 38)), scale(beta, 70))
    D = pa(pa(pc(8), scale(alpha, 67)), scale(beta, 33))
    G = pa(pa(pc(42), scale(alpha, 14)), scale(beta, 66))
    assert rows == [[pc(57), {}, {}, G], [{}, A, B, {}], [{}, C, D, {}], [{}, {}, {}, pc(107)]]
    assert pa(pm(A, D), scale(pm(B, C), 4)) == pc(58)
    determinant = {}
    for perm in itertools.permutations(range(4)):
        sign = 4 if sum(perm[i] > perm[j] for i in range(4) for j in range(i + 1, 4)) % 2 else 1
        term = pc(sign)
        for i in range(4):
            term = pm(term, rows[i][perm[i]])
        determinant = pa(determinant, term)
    assert determinant == pc(44)
    inverse = [
        [pc(inv(57)), {}, {}, {}],
        [{}, scale(D, inv(58)), scale(C, neg(inv(58))), {}],
        [{}, scale(B, neg(inv(58))), scale(A, inv(58)), {}],
        [scale(G, neg(inv(mul(57, 107)))), {}, {}, pc(inv(107))],
    ]
    for i in range(4):
        for j in range(4):
            entry = {}
            for h in range(4):
                entry = pa(entry, pm(rows[h][i], inverse[h][j]))
            assert entry == pc(int(i == j))
    print('PASS: full relative map, AD-BC=[58], det=[44], inverse orientation')
    print('PASS: no finite-field equation imposed on alpha,beta; no geometric coefficient reconstruction claimed')


if __name__ == '__main__':
    main(sys.argv[1])
