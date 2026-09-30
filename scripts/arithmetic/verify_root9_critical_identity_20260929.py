#!/usr/bin/env python3
"""Literal, standard-library verification of the new three-row identity.

The source reconstruction is performed by the accompanying Sage program.
This checker independently multiplies the saved coefficient identity using
the original F25/quartic tower, without Sage or logarithm tables.
"""
import argparse
import hashlib
import json


def ba(a, b):
    return (a % 5 + b % 5) % 5 + 5 * ((a // 5 + b // 5) % 5)


def bn(a):
    return (-a % 5) % 5 + 5 * ((-(a // 5)) % 5)


def bm(a, b):
    a0, a1 = a % 5, a // 5
    b0, b1 = b % 5, b // 5
    return (a0*b0+3*a1*b1) % 5 + 5*((a0*b1+a1*b0+a1*b1) % 5)


def add(a, b):
    z = 0
    for i in range(4):
        z += ba(a % 25, b % 25) * 25**i
        a //= 25
        b //= 25
    return z


def mul(a, b):
    aa = [(a // 25**i) % 25 for i in range(4)]
    bb = [(b // 25**i) % 25 for i in range(4)]
    cc = [0] * 7
    for i in range(4):
        for j in range(4):
            cc[i+j] = ba(cc[i+j], bm(aa[i], bb[j]))
    for i in range(6, 3, -1):
        c = cc[i]
        for j, r in enumerate([5, 2, 6, 7]):
            cc[i-4+j] = ba(cc[i-4+j], bn(bm(c, r)))
    return sum(cc[i] * 25**i for i in range(4))


def polynomial(rows):
    out = {}
    for i, j, c in rows:
        assert i >= 0 and j >= 0 and 0 < c < 390625
        assert (i, j) not in out
        out[i, j] = c
    return out


def main():
    p = argparse.ArgumentParser()
    p.add_argument('certificate')
    args = p.parse_args()
    with open(args.certificate, 'rb') as f:
        raw = f.read()
    cert = json.loads(raw)
    assert cert['generator_x_degrees'] == [12, 13, 14]
    result = {}
    for gs, ms in zip(cert['generators'], cert['multipliers'], strict=True):
        g, m = polynomial(gs), polynomial(ms)
        for (i, j), c in g.items():
            for (k, l), d in m.items():
                key = i+k, j+l
                result[key] = add(result.get(key, 0), mul(c, d))
    result = {k: v for k, v in result.items() if v}
    assert result == polynomial(cert['target']) == {(0, 1): 1}
    print(json.dumps({'identity': 'sum multiplier_i*p_i = q',
                      'status': 'PASS',
                      'generator_terms': [len(r) for r in cert['generators']],
                      'multiplier_terms': [len(r) for r in cert['multipliers']],
                      'sha256': hashlib.sha256(raw).hexdigest()}))


if __name__ == '__main__':
    main()
