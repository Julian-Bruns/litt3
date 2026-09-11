#!/usr/bin/env python3
"""Replay every tracked partial-basis row with standard-library arithmetic.

This certifies ideal membership, not the Gröbner-basis property, geometric
completeness, or emptiness. The source's substitutions remain prerequisites.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path
from exact_polynomial_field import ExactPolynomialField


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source', type=Path)
    parser.add_argument('basis', type=Path)
    parser.add_argument('receipt', type=Path)
    args = parser.parse_args()
    started = time.monotonic()
    raw = args.source.read_bytes()
    source = json.loads(raw)
    certificate_raw = args.basis.read_bytes()
    certificate = json.loads(certificate_raw)
    assert source['prime'] == 5
    assert certificate['source_sha256'] == hashlib.sha256(raw).hexdigest()
    for name in ('variables', 'field_modulus', 'field_degree'):
        assert source[name] == certificate[name]
    field = ExactPolynomialField(source['field_modulus'])
    n = len(source['variables'])
    d = field.degree

    def decode(encoded):
        result = {}
        for exponent, coefficient in encoded:
            e = tuple(exponent)
            assert len(e) == n and all(isinstance(v, int) and v >= 0 for v in e)
            assert e not in result and len(coefficient) <= d
            assert all(isinstance(v, int) and 0 <= v < 5 for v in coefficient)
            c = field.reduce(coefficient)
            assert any(c)
            result[e] = c
        return result

    equations = [decode(f) for f in source['equations']]
    expected = [decode(f) for f in certificate['equations']]
    witnesses = certificate['polynomial_multipliers']
    assert len(expected) == len(witnesses)
    terms = weights_count = 0
    for row, (target, witness) in enumerate(zip(expected, witnesses)):
        result = {}
        seen = set()
        for index, weight in witness:
            assert isinstance(index, int) and 0 <= index < len(equations)
            assert index not in seen
            seen.add(index)
            for e, c in decode(weight).items():
                weights_count += 1
                for f, a in equations[index].items():
                    ef = tuple(x + y for x, y in zip(e, f))
                    value = result.setdefault(ef, [0] * d)
                    product = field.multiply(c, a)
                    for i, v in enumerate(product):
                        value[i] = (value[i] + v) % 5
                    terms += 1
        actual = {e: tuple(c) for e, c in result.items() if any(c)}
        assert actual == target, ('polynomial identity failure', row)
        if row % 20 == 0:
            print(json.dumps(dict(rows_replayed=row + 1, expanded_products=terms,
                                  seconds=time.monotonic() - started)), flush=True)
    receipt = dict(status='independent_polynomial_basis_identities_PASS',
                   source_sha256=certificate['source_sha256'],
                   certificate_sha256=hashlib.sha256(certificate_raw).hexdigest(),
                   rows_replayed=len(expected), weight_terms=weights_count,
                   expanded_products=terms, seconds=time.monotonic() - started,
                   scope='Exact ideal membership only; no full-basis or exclusion claim')
    with args.receipt.open('x') as handle:
        json.dump(receipt, handle, indent=2)
        handle.write('\n')
    print(json.dumps(receipt), flush=True)


if __name__ == '__main__':
    main()
