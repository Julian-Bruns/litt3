#!/usr/bin/env python3
"""Bounded checks of the actual-window comparison at several BT heights.

These check the new arbitrary-j and last-digit formulas. Effectivity,
all-order convergence and global patching are mathematical arguments.
Generated evidence belongs outside the research workspace.
"""
import argparse
import json
from pathlib import Path


def check(precision=180, heights=(1, 2, 3)):
    results = []
    parameters = [{0: 1}, {1: 2}, {2: 1}, {7: 3},
                  {0: 2, 1: 3, 2: 4, 6: 1, 12: 2, 25: 4}]
    reference_delta = {}
    for height in heights:
        digit, modulus = 5**height, 5**(height+1)

        def tidy(v):
            return {i: a % modulus for i, a in v.items()
                    if i < precision and a % modulus}

        def add(*values):
            out = {}
            for value in values:
                for i, a in value.items():
                    out[i] = out.get(i, 0) + a
            return tidy(out)

        def scale(v, a):
            return tidy({i: a*b for i, b in v.items()})

        def mul(a, b):
            out = {}
            for i, x in a.items():
                for j, y in b.items():
                    if i+j < precision:
                        out[i+j] = out.get(i+j, 0) + x*y
            return tidy(out)

        def sig(v):
            # Witt Frobenius fixes Z/5^(height+1), substitutes t -> t^5.
            return tidy({5*i: a for i, a in v.items()})

        def der(v):
            return tidy({i-1: i*a for i, a in v.items() if i})

        def red(v):
            return {i: a % 5 for i, a in v.items() if a % 5}

        def mm(a, b):
            return [[add(*(mul(a[i][r], b[r][j]) for r in range(2)))
                     for j in range(2)] for i in range(2)]

        def ma(*ms):
            return [[add(*(m[i][j] for m in ms)) for j in range(2)]
                    for i in range(2)]

        def ms(m, a):
            return [[scale(v, a) for v in row] for row in m]

        def md(m):
            return [[der(v) for v in row] for row in m]

        def connection(j):
            a = add({1: 1}, scale(j, digit))
            x, y, z = {}, {}, {}
            for step in range(precision):
                nz = mul({4: 1}, sig(y))
                nx = mul({4: 1}, add(mul(a, sig(y)), scale(sig(x), -5)))
                ny = add(scale(der(a), -1),
                         scale(mul({4: 1}, mul(mul(a, a), sig(y))), -1),
                         scale(mul({4: 1}, mul(a, sig(x))), 10),
                         scale(mul({4: 1}, sig(z)), 25))
                if (nx, ny, nz) == (x, y, z):
                    break
                x, y, z = nx, ny, nz
            else:
                raise AssertionError('Connection iteration failed to converge')
            gamma = [[x, y], [z, scale(x, -1)]]
            f = [[a, {0: 5}], [{0: 1}, {}]]
            v = [[{}, {0: 5}], [{0: 1}, scale(a, -1)]]
            pulled = [[scale(mul({4: 1}, sig(entry)), 5)
                       for entry in row] for row in gamma]
            zero = [[{}, {}], [{}, {}]]
            assert mm(f, v) == [[{0: 5}, {}], [{}, {0: 5}]]
            assert mm(v, f) == [[{0: 5}, {}], [{}, {0: 5}]]
            # Ignore the very last derivative coefficient of a truncated jet.
            for identity in (ma(md(f), mm(gamma, f), ms(mm(f, pulled), -1)),
                             ma(md(v), mm(pulled, v), ms(mm(v, gamma), -1))):
                assert identity == zero, identity
            return gamma

        base = connection({})
        b = red(base[0][1])
        assert not red(add(b, mul({6: 1}, sig(b)), {0: 1}))
        deltas = []
        for j in parameters:
            gamma = connection(j)
            e = {}
            for degree in base[0][1].keys() | gamma[0][1].keys():
                diff = (gamma[0][1].get(degree, 0)
                        - base[0][1].get(degree, 0)) % modulus
                assert diff % digit == 0
                if diff:
                    e[degree] = diff // digit
            assert not red(add(e, mul({6: 1}, sig(e)), der(j),
                               scale(mul({5: 1}, mul(j, sig(b))), 2)))
            w = {}
            for degree in range(precision):
                coeff = (e.get(degree, 0)
                         - sum(a*w.get(degree-i, 0)
                               for i, a in b.items() if 0 < i <= degree))
                coeff = coeff * pow(b[0], -1, 5) % 5
                if coeff:
                    w[degree] = coeff
            delta = red(add(sig(w), scale(w, -1),
                            {i-1: 2*a for i, a in j.items()}))
            # Omega is a nonzero constant times s^2*b(s^2) ds.
            weighted = red(mul(b, delta))
            assert all(weighted.get(i, 0) == 0
                       for i in range(1, precision-2, 5))
            deltas.append(delta)
        if reference_delta:
            assert deltas == reference_delta
        else:
            reference_delta = deltas
        results.append({'height': height, 'modulus': modulus,
                        'parameters_checked': len(parameters),
                        'same_last_digit_map': True,
                        'cartier_missing_degrees_vanish': True})
    return {'precision': precision, 'checks': results,
            'scope': 'Bounded matrix identities, not an effectivity proof.'}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--precision', type=int, default=180)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    result = check(args.precision)
    if args.output:
        root = Path(__file__).resolve().parents[2]
        if args.output.resolve().is_relative_to(root):
            parser.error('Store generated evidence outside the workspace')
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
