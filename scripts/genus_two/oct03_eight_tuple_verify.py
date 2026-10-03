#!/usr/bin/env python3
"""Standalone exact certificate for an admissible abstract SL8(F5) tuple.

Only Python's standard library is used. No search, external CAS, or generated
input is needed. The elementary-root certificate proves the generated group.
"""
import argparse
import hashlib
import json
import platform
import time
from pathlib import Path

P = 5
STAR_WORDS = ['aB', 'BBa', 'AAb', 'AbAA', 'ABBA', 'BAbA', 'aBBAA']
BASIS_WORDS = ['', 'A', 'B', 'a', 'b', 'AA', 'BA', 'bA']


def eye(n):
    return [[int(i == j) for j in range(n)] for i in range(n)]


def transpose(a):
    return list(map(list, zip(*a)))


def mul(a, b):
    return [[sum(x*y for x, y in zip(row, col)) % P for col in zip(*b)] for row in a]


def add(a, b, scale=1):
    return [[(x + scale*y) % P for x, y in zip(r, s)] for r, s in zip(a, b)]


def power(a, n):
    out = eye(len(a))
    while n:
        if n & 1:
            out = mul(out, a)
        a = mul(a, a)
        n >>= 1
    return out


def rref(a):
    a = [[x % P for x in row] for row in a]
    pivots = []
    for col in range(len(a[0])):
        row = len(pivots)
        found = next((i for i in range(row, len(a)) if a[i][col]), None)
        if found is None:
            continue
        a[row], a[found] = a[found], a[row]
        scale = pow(a[row][col], -1, P)
        a[row] = [scale*x % P for x in a[row]]
        for i in range(len(a)):
            if i != row:
                scale = a[i][col]
                a[i] = [(x-scale*y) % P for x, y in zip(a[i], a[row])]
        pivots.append(col)
        if len(pivots) == len(a):
            break
    return a, pivots


def rank(a):
    return len(rref(a)[1])


def inverse(a):
    n = len(a)
    reduced, pivots = rref([row+unit for row, unit in zip(a, eye(n))])
    assert pivots[:n] == list(range(n))
    return [row[n:] for row in reduced]


def determinant(a):
    a = [row[:] for row in a]
    answer = 1
    for col in range(len(a)):
        found = next((i for i in range(col, len(a)) if a[i][col] % P), None)
        if found is None:
            return 0
        if found != col:
            a[col], a[found] = a[found], a[col]
            answer = -answer
        answer = answer*a[col][col] % P
        scale = pow(a[col][col], -1, P)
        a[col] = [scale*x % P for x in a[col]]
        for i in range(col+1, len(a)):
            scale = a[i][col]
            a[i] = [(x-scale*y) % P for x, y in zip(a[i], a[col])]
    return answer % P


def nullspace(a):
    a, pivots = rref(a)
    out = []
    for col in range(len(a[0])):
        if col in pivots:
            continue
        v = [0]*len(a[0])
        v[col] = 1
        for row, pivot in enumerate(pivots):
            v[pivot] = -a[row][col] % P
        out.append(v)
    return out


def vector(a, v):
    return [sum(x*y for x, y in zip(row, v)) % P for row in a]


def row_vector(v, a):
    return vector(transpose(a), v)


def pairing(row, col):
    return sum(x*y for x, y in zip(row, col)) % P


def outer(v, row):
    return [[x*y % P for y in row] for x in v]


def word_matrix(word, generators):
    result = eye(8)
    for letter in word:
        result = mul(result, generators[letter])
    return result


def nilpotent_ranks(a):
    n = add(a, eye(8), -1)
    return [rank(power(n, i)) for i in range(1, 6)]


def jordan_basis(a):
    n = add(a, eye(8), -1)
    n_powers = [power(n, i) for i in range(5)]
    v = next(e for e in eye(8) if any(vector(n_powers[4], e)))
    chain5 = [vector(n_powers[i], v) for i in range(4, -1, -1)]
    for w in nullspace(n_powers[3]):
        columns = chain5 + [vector(n_powers[i], w) for i in range(2, -1, -1)]
        basis = transpose(columns)
        if rank(basis) == 8:
            j = eye(8)
            for i in (0, 1, 2, 3, 5, 6):
                j[i][i+1] = 1
            assert mul(a, basis) == mul(basis, j)
            return basis
    raise AssertionError('No 5+3 Jordan basis')


def coordinates(rows, target):
    augmented = [row+[t] for row, t in zip(transpose(rows), target)]
    reduced, pivots = rref(augmented)
    assert pivots == list(range(7))
    return [reduced[i][7] for i in range(7)]


def verify():
    i4, i8 = eye(4), eye(8)
    u = eye(4)
    for i in range(3):
        u[i][i+1] = 1
    x = [[4, 3, 1, 4], [2, 4, 3, 1], [1, 1, 1, 4], [1, 3, 1, 0]]
    a = [row+extra for row, extra in zip(u, x)] + [[0]*4+row for row in transpose(u)]
    s = [[0]*4+[3*z % P for z in row] for row in i4] + [row+[0]*4 for row in i4]
    b = mul(power(a, 4), s)
    c = inverse(s)
    assert determinant(a) == determinant(b) == determinant(c) == 1
    assert power(a, 5) == power(b, 5) == i8
    assert nilpotent_ranks(a) == nilpotent_ranks(b) == [6, 4, 2, 1, 0]
    assert mul(mul(a, b), c) == i8
    assert power(s, 2) == [[3*z % P for z in row] for row in i8]
    assert power(c, 2) == [[2*z % P for z in row] for row in i8]
    generators = {'A': a, 'B': b, 'a': power(a, 4), 'b': power(b, 4)}
    w = word_matrix('AAbAbb', generators)
    t = power(w, 3124)
    delta = add(t, i8, -1)
    assert rank(delta) == 1 and mul(delta, delta) == [[0]*8 for _ in range(8)]
    # The short extraction word has exact order 15620=4*5*11*71.
    assert power(w, 15620) == i8
    assert all(power(w, 15620//p) != i8 for p in (2, 5, 11, 71))
    col = next(j for j in range(8) if any(delta[i][j] for i in range(8)))
    v = [delta[i][col] for i in range(8)]
    row = next(i for i in range(8) if v[i])
    phi = [z*pow(v[row], -1, P) % P for z in delta[row]]
    assert outer(v, phi) == delta and pairing(phi, v) == 0
    star = []
    star_rows = []
    for word in STAR_WORDS:
        g = word_matrix(word, generators)
        invg = inverse(g)
        gv = vector(g, v)
        gphi = row_vector(phi, invg)
        alpha = pairing(phi, gv)
        assert pairing(gphi, v) == 0 and alpha != 0
        conjugate = mul(mul(g, t), invg)
        commutator = mul(mul(mul(t, conjugate), inverse(t)), inverse(conjugate))
        functional = [alpha*z % P for z in gphi]
        assert commutator == add(i8, outer(v, functional))
        star_rows.append(functional)
        star.append({'word': word, 'alpha': alpha, 'functional': functional,
                     'commutator': commutator})
    assert rank(star_rows) == 7
    orbit = [vector(word_matrix(word, generators), v) for word in BASIS_WORDS]
    q = transpose(orbit)
    assert rank(q) == 8
    invq = inverse(q)
    roots = []
    for i, word in enumerate(BASIS_WORDS):
        g = word_matrix(word, generators)
        invg = inverse(g)
        for j in range(8):
            if i == j:
                continue
            psi = row_vector(invq[j], g)
            assert pairing(psi, v) == 0
            coeffs = coordinates(star_rows, psi)
            product = i8
            for coefficient, item in zip(coeffs, star):
                product = mul(product, power(item['commutator'], coefficient))
            root = mul(mul(g, product), invg)
            elementary = eye(8)
            elementary[i][j] = 1
            assert root == mul(mul(q, elementary), invq)
            roots.append({'i': i, 'j': j, 'coefficients': coeffs})
    ja = jordan_basis(power(a, 4))
    jb = jordan_basis(b)
    conjugator = mul(jb, inverse(ja))
    correction = pow(determinant(conjugator), -1, P)
    block_scalar = eye(8)
    for i in range(8):
        block_scalar[i][i] = pow(correction, -1, P) if i < 5 else correction**2 % P
    conjugator = mul(mul(jb, block_scalar), inverse(ja))
    assert determinant(conjugator) == 1
    assert mul(mul(conjugator, power(a, 4)), inverse(conjugator)) == b
    return {'field': 5, 'A': a, 'B': b, 'C': c, 'X': x,
            'Jordan_rank_sequences': [nilpotent_ranks(a), nilpotent_ranks(b)],
            'tame_square': 2, 'transvection_word': 'AAbAbb', 'transvection_power': 3124,
            'word_order': 15620, 'transvection': t, 'v': v, 'phi': phi,
            'star': star, 'star_row_rank': 7, 'basis_words': BASIS_WORDS,
            'orbit_basis': q, 'orbit_basis_rank': 8, 'elementary_roots': roots,
            'elementary_root_count': len(roots), 'inverse_conjugator': conjugator,
            'inverse_conjugator_determinant': determinant(conjugator),
            'all_checks_passed': True}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', required=True)
    args = parser.parse_args()
    start = time.monotonic()
    report = verify()
    report['python_version'] = platform.python_version()
    report['source_sha256'] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    report['elapsed_seconds'] = time.monotonic()-start
    target = Path(args.output)
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps({k: report[k] for k in ('all_checks_passed', 'field',
          'Jordan_rank_sequences', 'star_row_rank', 'orbit_basis_rank',
          'elementary_root_count', 'inverse_conjugator_determinant',
          'python_version', 'source_sha256', 'elapsed_seconds')}))


if __name__ == '__main__':
    main()
