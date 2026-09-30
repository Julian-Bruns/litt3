#!/usr/bin/env python3
"""Independent standard-library check of the Sage trace-secant certificate."""
import argparse
import json
from pathlib import Path
from pro_coreless_20260923.plane.certificates import ff25 as f


def xtrim(a):
    a = [f.trim(c) for c in a]
    while len(a) > 1 and a[-1] == [0]:
        a.pop()
    return a


def xmul(a, b):
    out = [[0] for _ in range(len(a)+len(b)-1)]
    for i, c in enumerate(a):
        for j, d in enumerate(b):
            out[i+j] = f.padd(out[i+j], f.pmul(c, d))
    return xtrim(out)


def xmod(a, d):
    assert d[-1] == [1]
    a = xtrim(a)
    while len(a) >= len(d):
        c, shift = a[-1], len(a)-len(d)
        for j in range(len(d)):
            a[shift+j] = f.psub(a[shift+j], f.pmul(c, d[j]))
        a = xtrim(a)
    return a


def verify(data):
    B = f.interpolate_B()
    assert B == data['B_codes'] and f.P == data['P_codes']
    bp, pp = B[::-1], f.P[::-1]
    m = []
    for i in range(5):
        value = bp[i]
        for j in range(i):
            value = f.sub(value, f.mul(m[j], pp[i-j]))
        m.append(value)
    assert m == data['moments'] == [14,20,16,15,23]
    assert f.determinant([[m[i+j] for j in range(3)] for i in range(3)]) == 23
    D = data['D_coefficients_as_t_polynomials']
    N = data['N_coefficients_as_t_polynomials']
    for i in range(2):
        lhs = [0]
        for j in range(4):
            lhs = f.padd(lhs, f.scale(D[j], m[i+j]))
        assert lhs == [0]
    expected_N = [f.padd([m[2]],f.padd(f.scale(D[2],m[1]),f.scale(D[1],m[0]))),
                  f.padd([m[1]],f.scale(D[2],m[0])),[m[0]]]
    assert N == expected_N
    rem = xmod(xmul([[c] for c in f.P], xmul(N,xmul(N,N))),D)
    assert rem == data['remainder_coefficients_as_t_polynomials']
    u,v = data['bezout_multipliers']
    assert f.padd(f.pmul(u,rem[1]),f.pmul(v,rem[2])) == [1]
    assert f.pgcd(rem[1],rem[2]) == [1]
    print('PASS: independent F25 arithmetic, moment recurrence, full remainder, Bezout identity.')
    print('Geometric scope is proved in admissible_line_trace_obstruction.md.')


if __name__ == '__main__':
    parser=argparse.ArgumentParser()
    parser.add_argument('certificate',type=Path)
    args=parser.parse_args()
    verify(json.loads(args.certificate.read_text()))
