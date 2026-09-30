#!/usr/bin/env python3
"""Certify the degree-three secant obstruction for the primitive trace class.

Run with sage -python; write generated data outside the research workspace.
The finite polynomial calculation is separate from the all-divisor argument.
"""
import argparse
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, PowerSeriesRing, matrix, vector


def calculate():
    prime = GF(5)
    rz = PolynomialRing(prime, 'z')
    k = GF(25, name='a', modulus=rz([2, 4, 1]))
    a = k.gen()
    decode = lambda c: k(c % 5) + (c // 5) * a
    encode = lambda c: int(k(c).polynomial()[0]) + 5 * int(k(c).polynomial()[1])
    p_codes = [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]
    b_codes = [22, 16, 11, 3, 15, 11, 2, 6, 12, 14]
    ps = PowerSeriesRing(k, 'v', default_prec=7)
    v = ps.gen()
    expansion = v * ps([decode(c) for c in reversed(b_codes)]) / ps([decode(c) for c in reversed(p_codes)])
    moments = [expansion[i] for i in range(1, 6)]
    hankel = matrix(k, 3, 3, lambda i, j: moments[i+j])
    rp = PolynomialRing(k, 't')
    t = rp.gen()
    linear = matrix(k, [[moments[0], moments[1]], [moments[1], moments[2]]])
    rhs = vector(rp, [-moments[3]-t*moments[2], -moments[4]-t*moments[3]])
    d0, d1 = linear.change_ring(rp).solve_right(rhs)
    rx = PolynomialRing(rp, 'x')
    x = rx.gen()
    D = x**3 + t*x**2 + d1*x + d0
    N = moments[0]*x**2 + (moments[1]+t*moments[0])*x + moments[2]+t*moments[1]+d1*moments[0]
    P = rx([decode(c) for c in p_codes])
    rem = (P*N**3) % D
    common, bezout1, bezout2 = rp(rem[1]).xgcd(rp(rem[2]))
    out = {
        'scope': 'Finite arithmetic for the degree-three primitive trace secant; the canonical proof handles every divisor and etale trace.',
        'P_codes': p_codes, 'B_codes': b_codes,
        'moments': [encode(c) for c in moments],
        'hankel_det': encode(hankel.det()), 'recurrence_minor_det': encode(linear.det()),
        'D_coefficients_as_t_polynomials': [[encode(c) for c in rp(D[i]).list()] for i in range(4)],
        'N_coefficients_as_t_polynomials': [[encode(c) for c in rp(N[i]).list()] for i in range(3)],
        'remainder_coefficients_as_t_polynomials': [[encode(c) for c in rp(rem[i]).list()] for i in range(3)],
        'gcd_of_positive_coefficients': [encode(c) for c in common.list()],
        'bezout_multipliers': [[encode(c) for c in b.list()] for b in [bezout1, bezout2]],
    }
    assert bezout1*rem[1]+bezout2*rem[2] == common
    assert [encode(c) for c in moments] == [14, 20, 16, 15, 23]
    assert encode(hankel.det()) == 23 and common == 1
    return out


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    result = calculate()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps({k:result[k] for k in ['moments','hankel_det','gcd_of_positive_coefficients']}, indent=2))
