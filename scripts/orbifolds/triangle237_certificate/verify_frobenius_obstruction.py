#!/usr/bin/env python3
"""Verify a coefficient-field obstruction by exact polynomial identities.

The input equations imply an annihilating polynomial for one coordinate.
A Frobenius remainder and Bezout identity exclude that coordinate from
the specified finite extension. Python standard library only.
"""
import argparse
import hashlib
import json
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
from scripts.atlases.algebra.exact_polynomial_field import ExactPolynomialField


def verify(source_path, certificate_path, extension_degree):
    raw = source_path.read_bytes()
    source = json.loads(raw)
    cert = json.loads(certificate_path.read_bytes())
    assert cert['source_sha256'] == hashlib.sha256(raw).hexdigest()
    assert source.get('prime', 5) == cert['prime'] == 5
    for key in ('field_degree', 'field_modulus', 'variables'):
        assert source[key] == cert[key]
    assert type(extension_degree) is int and extension_degree > 0
    assert cert['frobenius_steps'] == source['field_degree'] * extension_degree
    field = ExactPolynomialField(source['field_modulus'])
    degree = field.degree
    assert degree == source['field_degree']
    n = len(source['variables'])
    zero = (0,) * degree
    one = (1,) + (0,) * (degree - 1)
    unit_exponent = (0,) * n
    coordinate = source['variables'].index(cert['coordinate'])
    products = 0

    def coefficient(c):
        assert len(c) <= degree and all(type(x) is int and 0 <= x < 5 for x in c)
        return field.reduce(c)

    def add(a, b):
        return tuple((x + y) % 5 for x, y in zip(a, b))

    def negate(a):
        return tuple(-x % 5 for x in a)

    def accumulate(out, key, value):
        value = add(out.get(key, zero), value)
        if any(value):
            out[key] = value
        else:
            out.pop(key, None)

    def decode(poly):
        out = {}
        for e, c in poly:
            assert len(e) == n and all(type(x) is int and x >= 0 for x in e)
            e, c = tuple(e), coefficient(c)
            assert e not in out and any(c)
            out[e] = c
        return out

    rows = [decode(f) for f in source['equations']]

    def combination(weights):
        nonlocal products
        out, seen = {}, set()
        for i, weight in weights:
            assert type(i) is int and 0 <= i < len(rows) and i not in seen
            seen.add(i)
            for a, c in decode(weight).items():
                for b, d in rows[i].items():
                    exponent = tuple(x + y for x, y in zip(a, b))
                    accumulate(out, exponent, field.multiply(c, d))
                    products += 1
        return out

    for i, node in enumerate(cert['nodes']):
        expected = decode(node['polynomial'])
        assert combination(node['weights']) == expected, ('identity node', i)
        rows.append(expected)

    monomials = [tuple(m) for m in cert['monomials']]
    assert all(len(m) == n and all(type(e) is int and e >= 0 for e in m)
               for m in monomials)
    assert len(set(monomials)) == len(monomials) and unit_exponent in monomials
    positions = {m: i for i, m in enumerate(monomials)}
    assert len(cert['images']) == len(cert['closure_weights']) == len(monomials)
    images = []
    for j, (m, encoded, weights) in enumerate(zip(
            monomials, cert['images'], cert['closure_weights'])):
        image = decode(encoded)
        assert set(image) <= set(positions)
        target = tuple(e + int(i == coordinate) for i, e in enumerate(m))
        difference = {target: one}
        for e, c in image.items():
            accumulate(difference, e, negate(c))
        assert combination(weights) == difference, ('coordinate closure', j)
        images.append({positions[e]: c for e, c in image.items()})

    def trim(poly):
        poly = list(poly)
        while poly and not any(poly[-1]):
            poly.pop()
        return poly

    def univariate(encoded):
        poly = [coefficient(c) for c in encoded]
        assert poly == trim(poly)
        return poly

    h = univariate(cert['annihilator'])
    assert len(h) > 1 and h[-1] == one
    unit_position = positions[unit_exponent]
    vector = {}
    for c in reversed(h):
        following = {}
        for j, a in vector.items():
            for i, b in images[j].items():
                accumulate(following, i, field.multiply(a, b))
        accumulate(following, unit_position, c)
        vector = following
    assert not vector, 'annihilator does not kill the monomial1'

    def multiply(a, b):
        out = [zero] * max(0, len(a) + len(b) - 1)
        for i, c in enumerate(a):
            if not any(c):
                continue
            for j, d in enumerate(b):
                if any(d):
                    out[i + j] = add(out[i + j], field.multiply(c, d))
        return trim(out)

    def plus(a, b):
        return trim([add(a[i] if i < len(a) else zero,
                         b[i] if i < len(b) else zero)
                     for i in range(max(len(a), len(b)))])

    def remainder(a):
        a = trim(a)
        while len(a) >= len(h):
            shift, leading = len(a) - len(h), a[-1]
            for i, c in enumerate(h):
                a[shift + i] = add(a[shift + i], negate(field.multiply(leading, c)))
            a = trim(a)
        return a

    t = [zero, one]
    frobenius = t
    for _ in range(cert['frobenius_steps']):
        # In characteristic5, both coefficients and exponents are raised
        # to the fifth power. The coefficient's base-field digits stay fixed.
        power = [zero] * (5 * (len(frobenius) - 1) + 1) if frobenius else []
        for i, c in enumerate(frobenius):
            expanded = [0] * (5 * (degree - 1) + 1)
            for j, digit in enumerate(c):
                expanded[5 * j] = digit
            power[5 * i] = field.reduce(expanded)
        frobenius = remainder(power)
    assert frobenius == univariate(cert['frobenius_remainder'])
    a = univariate(cert['bezout_h'])
    b = univariate(cert['bezout_remainder'])
    difference = plus(frobenius, [negate(c) for c in t])
    assert plus(multiply(a, h), multiply(b, difference)) == [one], 'Bezout identity'
    return dict(status='coefficient_field_obstruction_PASS',
                equations=len(source['equations']), identity_nodes=len(cert['nodes']),
                closed_monomials=len(monomials), annihilator_degree=len(h) - 1,
                excluded_field_degree=cert['frobenius_steps'], expanded_products=products)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source', type=Path)
    parser.add_argument('certificate', type=Path)
    parser.add_argument('--extension-degree', type=int, default=2)
    args = parser.parse_args()
    if not __debug__:
        raise RuntimeError('Polynomial identities require assertions to be enabled.')
    started = time.monotonic()
    result = verify(args.source, args.certificate, args.extension_degree)
    result['seconds'] = time.monotonic() - started
    print(json.dumps(result), flush=True)


if __name__ == '__main__':
    main()
