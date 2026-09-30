#!/usr/bin/env python3
"""Independently verify every branch of the degree-six obstruction certificate.

Python 3 standard library only.  Unlike the producer, this verifier multiplies
field elements by integer Kronecker substitution and checks the D^2 congruence
by evaluations and derivatives, without polynomial division or Laurent series.
Run: python3 verify_certificate.py
Optional --start N --stop M verifies a contiguous certificate block; all keys
and the complete 70-layout census are checked even in block mode.
"""
import argparse
import itertools
import json
from pathlib import Path
import struct
import time

if not __debug__:
    raise RuntimeError("Run without -O: certificate assertions must remain enabled.")

P = 5
N = 14
CARD = P**N
MOD = [1, 2, 4, 0, 4, 4, 3, 1, 3, 4, 4, 0, 4, 2]
SHIFTS = [16*i for i in range(N)]
UNPACK14 = struct.Struct('<14H').unpack
MASK = (1 << (16*N)) - 1
PACK = [[j << k for j in range(5)] for k in SHIFTS]


def pack(cs):
    return sum(PACK[i][c % 5] for i, c in enumerate(cs))


def canonical(raw):
    return sum(PACK[i][c % 5]
               for i, c in enumerate(UNPACK14(raw.to_bytes(2*N, 'little'))))


def decode(code):
    assert 0 <= code < CARD
    cs = []
    for _ in range(N):
        code, r = divmod(code, 5)
        cs.append(r)
    assert not code
    return pack(cs)


def encode(x):
    cs = UNPACK14(x.to_bytes(2*N, 'little'))
    assert all(c < 5 for c in cs)
    return sum(c*5**i for i, c in enumerate(cs))


# Representatives of z^14,...,z^26, independently obtained by reduction.
REDUCTIONS = []
for i in range(N, 2*N-1):
    v = [0]*(2*N-1)
    v[i] = 1
    for j in range(2*N-2, N-1, -1):
        h = v[j] % 5
        for k in range(N):
            v[j-N+k] = (v[j-N+k] - h*MOD[k]) % 5
        v[j] = 0
    REDUCTIONS.append((16*i, pack(v[:N])))


def add(a, b):
    return canonical(a+b)


def neg(a):
    return canonical(4*a)


def sub(a, b):
    return canonical(a+4*b)


def mul(a, b):
    # Initial convolution coefficients are <= 14*4*4 = 224.
    # After reduction, coefficients are <= 224+13*224*4 < 2^16.
    # Thus integer carries cannot cross a 16-bit coefficient slot.
    raw = a*b
    ans = raw & MASK
    for shift, reduction in REDUCTIONS:
        ans += ((raw >> shift) & 65535)*reduction
    return canonical(ans)


def power(a, e):
    r = 1
    while e:
        if e & 1:
            r = mul(r, a)
        a = mul(a, a)
        e >>= 1
    return r


def inv(a):
    assert a
    ans = power(a, CARD-2)
    assert mul(a, ans) == 1
    return ans


def trim(a):
    a = list(a)
    while a and not a[-1]:
        a.pop()
    return a


def padd(a, b):
    n = max(len(a), len(b))
    return trim([add(a[i] if i < len(a) else 0,
                     b[i] if i < len(b) else 0) for i in range(n)])


def psub(a, b):
    return padd(a, [neg(x) for x in b])


def pmul(a, b):
    if not a or not b:
        return []
    c = [0]*(len(a)+len(b)-1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            c[i+j] = add(c[i+j], mul(x, y))
    return trim(c)


def pdiff(a):
    return trim([mul(i % 5, a[i]) for i in range(1, len(a))])


def peval(a, x):
    r = 0
    for c in reversed(a):
        r = add(mul(r, x), c)
    return r


def det(a):
    u = mul(a[0][0], sub(mul(a[1][1], a[2][2]), mul(a[1][2], a[2][1])))
    v = mul(a[0][1], sub(mul(a[1][0], a[2][2]), mul(a[1][2], a[2][0])))
    w = mul(a[0][2], sub(mul(a[1][0], a[2][1]), mul(a[1][1], a[2][0])))
    return add(sub(u, v), w)


def nullspace(a):
    a = [list(row) for row in a]
    ncols = len(a[0])
    pivots = []
    for col in range(ncols):
        row = len(pivots)
        pivot = next((i for i in range(row, len(a)) if a[i][col]), None)
        if pivot is None:
            continue
        a[row], a[pivot] = a[pivot], a[row]
        u = inv(a[row][col])
        a[row] = [mul(x, u) for x in a[row]]
        for i in range(len(a)):
            if i != row:
                t = a[i][col]
                a[i] = [sub(x, mul(t, y)) for x, y in zip(a[i], a[row])]
        pivots.append(col)
    result = []
    for free in range(ncols):
        if free not in pivots:
            v = [0]*ncols
            v[free] = 1
            for i, pivot in enumerate(pivots):
                v[pivot] = neg(a[i][free])
            result.append(v)
    return result


def representative(t):
    # A minimum representative contains zero; translate each of its three
    # points to zero, for each orientation. This is independent of the
    # producer's exhaustive 29-translation loop.
    return min(tuple(sorted((sign*(x-origin)) % 29 for x in t))
               for sign in (-1, 1) for origin in t)


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--start', type=int, default=0)
    ap.add_argument('--stop', type=int, default=4480)
    ap.add_argument('--certificate', type=Path,
                    default=Path(__file__).with_name('exact_certificate.jsonl'))
    args = ap.parse_args()
    assert 0 <= args.start <= args.stop <= 4480
    started = time.monotonic()
    z = decode(5)
    assert power(z, 29) == 1 and z != 1
    roots29 = [power(z, i) for i in range(29)]
    total = 0
    for x in roots29:
        total = add(total, x)
    assert total == 0
    assert next(i for i in range(1, 29) if pow(5, i, 29) == 1) == 14
    g = decode(4481951269)
    assert power(g, 4) == 4 and power(g, 8) == 1
    roots8 = [power(g, i) for i in range(8)]
    layouts = sorted({representative(t)
                      for t in itertools.combinations(range(29), 3)})
    assert len(layouts) == 70
    records = [json.loads(line) for line in args.certificate.read_text().splitlines()]
    expected = {(t, (0, j, k)) for t in layouts for j in range(8) for k in range(8)}
    actual = [(tuple(r['layout']), tuple(r['xi_exponents'])) for r in records]
    assert len(actual) == 4480 and len(set(actual)) == 4480
    assert set(actual) == expected
    cache = {}
    for record in records[args.start:args.stop]:
        layout = tuple(record['layout'])
        if layout not in cache:
            qs = [roots29[e] for e in layout]
            D = [1]
            for q in qs:
                D = pmul(D, [neg(q), 1])
            Dp = pdiff(D)
            Dpp = pdiff(Dp)
            dps = [peval(Dp, q) for q in qs]
            invdps = [inv(d) for d in dps]
            qpows = [[power(q, j) for j in range(5)] for q in qs]
            M1, M2 = [], []
            for q, dp, qp in zip(qs, dps, qpows):
                dpp = peval(Dpp, q)
                row1, row2 = [], []
                for j in range(5):
                    dj = mul(j % 5, qp[j-1]) if j else 0
                    row1.append(sub(mul(mul(2, dp), dj), mul(dpp, qp[j])))
                    row2.append(sub(mul(mul(mul(2, q), dp), dj),
                                    mul(add(mul(4, dp), mul(q, dpp)), qp[j])))
                M1.append(row1)
                M2.append(row2)
            U, V = nullspace(M1), nullspace(M2)
            assert len(U) == len(V) == 2
            Ue = [[peval(u, q) for u in U] for q in qs]
            Ve = [[peval(v, q) for v in V] for q in qs]
            cache[layout] = (qs, D, Dp, invdps, qpows, Ue, Ve)
        qs, D, Dp, invdps, qpows, Ue, Ve = cache[layout]
        B1, B2, N1, N2, E0, E1, E2 = [list(map(decode, record[name]))
                                     for name in ('B1','B2','N1','N2','E0','E1','E2')]
        assert len(B1) == len(B2) == 5 and B1[4] and B2[4]
        assert B1[0] and B2[0] and D[0]
        N1p, N2p = pdiff(N1), pdiff(N2)
        # Global polynomial derivative identities with both m_i = 1.
        assert psub(psub(pmul(N1p, D), pmul(N1, Dp)), pmul(B1, B1)) == []
        threeD = [mul(3, x) for x in D]
        assert psub(psub(pmul([0]+D, N2p),
                         pmul(padd(threeD, [0]+Dp), N2)), pmul(B2, B2)) == []
        H = []
        for i, q in enumerate(qs):
            xi = roots8[record['xi_exponents'][i]]
            weight = mul(qpows[i][4], xi)
            e1, e2 = peval(B1, q), peval(B2, q)
            assert e1 and e2 and e2 == mul(weight, e1)
            H.append([neg(mul(weight, x)) for x in Ue[i]] + Ve[i])
            n1, n2 = peval(N1, q), peval(N2, q)
            n1p, n2p = peval(N1p, q), peval(N2p, q)
            n13, n23 = power(n1, 3), power(n2, 3)
            n14, n24 = mul(n13, n1), mul(n23, n2)
            assert mul(q, n24) == n14
            # E0(q) = (s*N2^4-N1^4)'(q)/D'(q).
            numerator = sub(add(n24, mul(mul(mul(4, q), n23), n2p)),
                            mul(mul(4, n13), n1p))
            assert peval(E0, q) == mul(numerator, invdps[i])
            assert peval(E1, q) == mul(1, n13)  # -4 = 1 in F_5.
            assert peval(E2, q) == mul(mul(4, qpows[i][4]), n23)
        # Rank 3: there is exactly one common scale, no missing parameter.
        assert any(det([[row[j] for j in columns] for row in H])
                   for columns in itertools.combinations(range(4), 3))
        assert len(E0) == len(E1) == len(E2) == 3
        delta = det([[E1[i], E2[i], E0[i]] for i in range(3)])
        assert delta and encode(delta) == record['determinant']
        witness = list(map(decode, record['unit_witness']))
        assert len(witness) == 3
        for E, expected_dot in ((E0, 1), (E1, 0), (E2, 0)):
            dot = 0
            for a, b in zip(witness, E):
                dot = add(dot, mul(a, b))
            assert dot == expected_dot
    checked = args.stop - args.start
    print(f'PASS: complete 70-layout / 4480-case census; '
          f'cases [{args.start},{args.stop}) independently verified ({checked} cases).')
    print(f'Elapsed seconds: {time.monotonic()-started:.3f}')


if __name__ == '__main__':
    main()
