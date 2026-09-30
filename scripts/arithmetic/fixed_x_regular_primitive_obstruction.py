#!/usr/bin/env python3
"""Small exact checks for regular primitives and one-form orbifold quotients.

Run with sage -python. Generated JSON belongs outside the research workspace.
This does not rerun the settled Cartier-eigenform census.
"""
import argparse
import json
from math import gcd as integer_gcd
from pathlib import Path
from sage.all import GF, PolynomialRing, gcd, gap


def calculate():
    k = GF(25, name='a', modulus=PolynomialRing(GF(5), 'z')([2, 4, 1]))
    a = k.gen()
    ring = PolynomialRing(k, 'x')
    decode = lambda n: k(n % 5) + (n // 5) * a
    encode = lambda c: int(c.polynomial()[0]) + 5 * int(c.polynomial()[1])
    coefficients = [11, 22, 18, 5, 19, 20, 15, 16, 9, 22, 1]
    p = ring([decode(n) for n in coefficients])
    cube = p ** 3
    ordinary = [ring([cube[5*i+4-j]**5 for i in range(6)]) for j in range(3)]
    assert gcd([p] + ordinary) == 1
    assert any(b[5] for b in ordinary)

    # Complete finite range: a wild point plus at least one tame point,
    # delta/e >= 2, and 2g(X)-2 = 16. Every tame contribution is >= n/2.
    rows = []
    for n in range(5, 33, 5):
        tame_orders = [d for d in range(2, n+1) if n % d == 0 and d % 5]

        def profiles(budget, start=0, values=()):
            yield values
            for i in range(start, len(tame_orders)):
                cost = n - n // tame_orders[i]
                if cost <= budget:
                    yield from profiles(budget-cost, i, values+(tame_orders[i],))

        for tame in profiles(16):
            if not tame:
                continue
            for e in range(5, n+1, 5):
                if n % e:
                    continue
                residual = 16 - sum(n-n//m for m in tame)
                if residual % (n//e):
                    continue
                b = residual // (n//e)
                if not 0 <= b < e or (e+b) % 4 != 3:
                    continue
                # The only n divisible by 25 has no tame order, so this
                # is an implication of the exhaustive ranges, not a cut.
                assert e % 25
                jump = (e+b+1)//4
                tame_part = e//5
                if jump % 5 == 0 or 4 % (tame_part//integer_gcd(tame_part, jump)):
                    continue
                rows.append([n, e, b, list(tame), jump])
    assert rows == [[10, 10, 1, [2, 2, 2], 3], [15, 5, 2, [3], 2]]

    # A diagnostic using the published primitive-group classification.
    assert gap.eval('LoadPackage("primgrp")') == 'true'
    assert gap.eval('NrPrimitiveGroups(160)') == '2'
    names = gap.eval('List([1,2],i->Name(PrimitiveGroup(160,i)))')
    assert names == '[ "A(160)", "S(160)" ]'
    return {
        'polynomial_P_ascending_F25_codes': coefficients,
        'ordinary_B_columns_ascending_F25_codes': [
            [encode(b[i]) for i in range(6)] for b in ordinary],
        'common_gcd_with_P': 1,
        'degree_five_coefficients': [encode(b[5]) for b in ordinary],
        'wild_and_tame_signature_rows_n_e_b_tame_jump': rows,
        'primitive_degree_160': {
            'GAP_version': gap.eval('GAPInfo.Version'),
            'PrimGrp_version': gap.eval('PackageInfo("primgrp")[1].Version'),
            'count': 2, 'names': ['A(160)', 'S(160)'],
            'scope': 'Uses the published primitive-group library classification.'},
        'checks': 'PASS; no one-branch atlas existence or nonexistence is asserted.'}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    result = calculate()
    body = json.dumps(result, indent=2) + '\n'
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(body)
    print(body)
