"""Exact auxiliary algebra for the continuation's ramification certificates.

Only Python's standard library and the archived exact.py are used. Fields use
integer codes, ascending polynomial rows, and no floating-point arithmetic.
"""
from exact import (
    F, Extension, add, sub, neg, scale, mul, power, derivative, trim,
    divmod_poly, mod, gcd, evaluate, determinant,
)

G0 = [13, 12, 10, 3, 2]
G1 = [16, 1, 5, 20]
G3 = [13, 4, 11]
G4 = [9, 17]


class RationalFunction:
    def __init__(self, numerator, denominator=None):
        denominator = [1] if denominator is None else trim(denominator)
        if not denominator:
            raise ZeroDivisionError('zero rational-function denominator')
        common = gcd(numerator, denominator)
        nn = divmod_poly(numerator, common)[0] if numerator else []
        dd = divmod_poly(denominator, common)[0]
        lead_inverse = F.inv(dd[-1])
        self.n = scale(nn, lead_inverse)
        self.d = scale(dd, lead_inverse)

    def __add__(self, other):
        return RationalFunction(add(mul(self.n, other.d), mul(other.n, self.d)),
                                mul(self.d, other.d))

    def __mul__(self, other):
        return RationalFunction(mul(self.n, other.n), mul(self.d, other.d))

    def data(self):
        return {'numerator': self.n, 'denominator': self.d}


def invariants(A):
    return {
        'R': RationalFunction(mul(power(G0, 2), G3), power(G1, 3)),
        'S': RationalFunction(mul(power(G0, 3), G4), power(G1, 4)),
        'T': RationalFunction(mul(A, power(G1, 5)), power(G0, 5)),
    }


def projective_coordinates(A):
    return [power(G0, 5), mul(A, power(G1, 5)),
            mul(power(A, 3), power(G3, 5)),
            mul(power(A, 4), power(G4, 5))]


def inverse_mod(a, h):
    """Polynomial inverse, valid also for a unit in a reducible quotient."""
    old, remainder = h, mod(a, h)
    old_s, ss = [], [1]
    while remainder:
        qq, rr = divmod_poly(old, remainder)
        old, remainder = remainder, rr
        old_s, ss = ss, sub(old_s, mul(qq, ss))
    if len(old) != 1:
        raise ZeroDivisionError('nonunit in polynomial quotient')
    return scale(mod(old_s, h), F.inv(old[0]))


class F625:
    """F25[z]/(z^2-d), d the first nonsquare in the archived encoding.

    An element a+z*b has integer code a+25*b. The extension is used only
    for enough distinct exact interpolation points, never as a search bound.
    """
    zero, one, order = 0, 1, 625

    def __init__(self):
        self.d = next(a for a in range(1, 25) if F.pow(a, 12) != 1)
        self.at = [[F.add(a, b) for b in range(25)] for a in range(25)]
        self.mt = [[F.mul(a, b) for b in range(25)] for a in range(25)]
        self.nt = [F.neg(a) for a in range(25)]
        self.invtab = [0] + [self.pow(a, 623) for a in range(1, 625)]

    def add(self, a, b):
        return self.at[a % 25][b % 25] + 25*self.at[a // 25][b // 25]

    def neg(self, a):
        return self.nt[a % 25] + 25*self.nt[a // 25]

    def sub(self, a, b):
        return self.add(a, self.neg(b))

    def mul(self, a, b):
        a0, a1, b0, b1 = a % 25, a // 25, b % 25, b // 25
        c0 = self.at[self.mt[a0][b0]][self.mt[self.d][self.mt[a1][b1]]]
        c1 = self.at[self.mt[a0][b1]][self.mt[a1][b0]]
        return c0 + 25*c1

    def pow(self, a, n):
        if n < 0:
            return self.pow(self.inv(a), -n)
        out = 1
        while n:
            if n & 1:
                out = self.mul(out, a)
            a = self.mul(a, a)
            n >>= 1
        return out

    def inv(self, a):
        if not a:
            raise ZeroDivisionError('inverse of zero')
        return self.invtab[a]

    def integer(self, n):
        return n % 5


def resultant_actual(a, b, K):
    """Exact Euclidean resultant at the actual polynomial degrees."""
    a, b = trim(a, K), trim(b, K)
    out = K.one
    if not a or not b:
        return K.zero
    while len(b) > 1:
        m, n = len(a)-1, len(b)-1
        rr = mod(a, b, K)
        if not rr:
            return K.zero
        s = len(rr)-1
        out = K.mul(out, K.pow(b[-1], m-s))
        if m*n % 2:
            out = K.neg(out)
        a, b = b, rr
    return K.mul(out, K.pow(b[0], len(a)-1))


def resultant_fixed(a, b, m, n, K):
    """Specialization of the fixed-(m,n) Sylvester determinant.

    Degree drops are not discarded. If both degrees drop the determinant
    vanishes; if only one drops, the exact leading-coefficient factor is kept.
    """
    a, b = trim(a, K), trim(b, K)
    if not a or not b:
        return K.zero
    da, db = m-(len(a)-1), n-(len(b)-1)
    if da < 0 or db < 0:
        raise ValueError('actual degree exceeds the fixed Sylvester degree')
    if da and db:
        return K.zero
    out = resultant_actual(a, b, K)
    if da:
        out = K.mul(out, K.pow(b[-1], da))
        if n*da % 2:
            out = K.neg(out)
    if db:
        out = K.mul(out, K.pow(a[-1], db))
    return out


def sylvester_determinant(a, b, m, n, K):
    """Independent small-matrix cross-check for the resultant routine."""
    aa = list(a) + [K.zero]*(m+1-len(a))
    bb = list(b) + [K.zero]*(n+1-len(b))
    aa, bb = list(reversed(aa)), list(reversed(bb))
    rows = []
    for j in range(n):
        rows.append([K.zero]*j + aa + [K.zero]*(n-1-j))
    for j in range(m):
        rows.append([K.zero]*j + bb + [K.zero]*(m-1-j))
    return determinant(rows, K)


def divided_difference_at(function, x, K):
    nn, dd = evaluate(function.n, x, K), evaluate(function.d, x, K)
    pp = sub(scale(function.d, nn, K), scale(function.n, dd, K), K)
    out, remainder = divmod_poly(pp, [K.neg(x), K.one], K)
    if remainder:
        raise ArithmeticError('divided difference is not polynomial')
    return out


def interpolate(xs, ys, K):
    out, basis = [], [K.one]
    for x, y in zip(xs, ys):
        cc = K.mul(K.sub(y, evaluate(out, x, K)), K.inv(evaluate(basis, x, K)))
        out = add(out, scale(basis, cc, K), K)
        basis = mul(basis, [K.neg(x), K.one], K)
    return out


def resultant_certificate(A):
    K = F625()
    functions = invariants(A)
    results = {}
    bounds = {'S': (12, 216), 'T': (19, 342)}
    for other, (n, bound) in bounds.items():
        xs = list(range(bound+1))
        ys = [resultant_fixed(divided_difference_at(functions['R'], x, K),
                              divided_difference_at(functions[other], x, K),
                              9, n, K) for x in xs]
        pp = interpolate(xs, ys, K)
        if any(c >= 25 for c in pp):
            raise ArithmeticError('resultant coefficients did not descend to F25')
        for x in range(bound+1, bound+12):
            rr = resultant_fixed(divided_difference_at(functions['R'], x, K),
                                 divided_difference_at(functions[other], x, K),
                                 9, n, K)
            assert evaluate(pp, x, K) == rr
        results['R'+other] = pp
    common = gcd(results['RS'], results['RT'])
    g0 = scale(G0, F.inv(G0[-1]))
    g1 = scale(G1, F.inv(G1[-1]))
    assert common == mul(power(g0, 20), power(g1, 33))
    return {'F625_nonsquare_d': K.d,
            'interpolation_degree_bounds': {'RS': 216, 'RT': 342},
            'interpolation_point_counts': {'RS': 217, 'RT': 343},
            'extra_check_points_per_resultant': 11,
            'resultants': results, 'gcd': common,
            'gcd_factorization': {'g0_monic_exponent': 20, 'g1_monic_exponent': 33},
            'invariants': {name: func.data() for name, func in functions.items()}}
