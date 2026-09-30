#!/usr/bin/env python3
"""Check the explicit local BT pole model modulo 25.

The all-order connection and group effectivity are proved in the linked
human-readable proof. These bounded identities check its matrix algebra;
they do not replace crystalline effectivity by a numerical assertion.
"""
import argparse
import json
from pathlib import Path


def check(bound):
    modulus = 25

    def poly(items=()):
        return {i: a % modulus for i, a in items if a % modulus}

    def add(*values):
        out = {}
        for value in values:
            for i, a in value.items():
                out[i] = (out.get(i, 0) + a) % modulus
        return poly(out.items())

    def scale(value, a):
        return poly((i, a*b) for i, b in value.items())

    def mul(left, right):
        out = {}
        for i, a in left.items():
            for j, b in right.items():
                if i+j < bound:
                    out[i+j] = (out.get(i+j, 0) + a*b) % modulus
        return poly(out.items())

    def sigma(value):
        # Coefficients lie in Z/25, where the Witt Frobenius is identity.
        return poly((5*i, a) for i, a in value.items() if 5*i < bound)

    def deriv(value):
        return poly((i-1, i*a) for i, a in value.items() if i)

    def matadd(*matrices):
        return [[add(*(m[i][j] for m in matrices)) for j in range(2)]
                for i in range(2)]

    def matscale(matrix, a):
        return [[scale(v, a) for v in row] for row in matrix]

    def matmul(left, right):
        return [[add(*(mul(left[i][k], right[k][j]) for k in range(2)))
                 for j in range(2)] for i in range(2)]

    def matsigma(matrix):
        return [[sigma(v) for v in row] for row in matrix]

    def matderiv(matrix):
        return [[deriv(v) for v in row] for row in matrix]

    one, five, t, t4 = ({0: 1}, {0: 5}, {1: 1}, {4: 1})
    zero = [[{}, {}], [{}, {}]]
    p_identity = [[five, {}], [{}, five]]
    connections = []
    models = []
    for j in (0, 1):
        f = add(t, {0: 5*j})
        a, b, c = {}, {}, {}
        for iteration in range(2*bound):
            new_c = mul(t4, sigma(b))
            new_a = add(mul(f, new_c), scale(mul(t4, sigma(a)), -5))
            new_b = add(scale(one, -1), scale(mul(f, a), -1),
                        scale(mul(mul(t4, f), sigma(a)), 5))
            if (new_a, new_b, new_c) == (a, b, c):
                break
            a, b, c = new_a, new_b, new_c
        else:
            raise AssertionError('Connection iteration did not stabilize')
        connection = [[a, b], [c, scale(a, -1)]]
        F = [[f, five], [one, {}]]
        V = [[{}, five], [one, scale(f, -1)]]
        if matmul(F, V) != p_identity or matmul(V, F) != p_identity:
            raise AssertionError('F,V product identity failed')
        pulled_connection = [[scale(mul(t4, v), 5) for v in row]
                             for row in matsigma(connection)]
        f_horizontal = matadd(matderiv(F), matmul(connection, F),
                             matscale(matmul(F, pulled_connection), -1))
        v_horizontal = matadd(matderiv(V), matmul(pulled_connection, V),
                             matscale(matmul(V, connection), -1))
        if f_horizontal != zero or v_horizontal != zero:
            raise AssertionError('F,V horizontality failed')
        connections.append(connection)
        models.append({'parameter': j, 'iterations': iteration+1,
                       'connection': connection})
    reduced = [[[poly((i, a % 5) for i, a in v.items()) for v in row]
                for row in C] for C in connections]
    if reduced[0] != reduced[1]:
        raise AssertionError('The marked BT1 connections differ')
    if reduced[0][0][1].get(0) != 4:
        raise AssertionError('Kodaira--Spencer coefficient is not -1')

    # The returned exact pole formula uses the actual divided connection.
    h = reduced[0][0][1]
    b0, b1 = connections[0][0][1], connections[1][0][1]
    m = {}
    for exponent in b0.keys() | b1.keys():
        difference = (b1.get(exponent, 0)-b0.get(exponent, 0)) % 25
        if difference % 5:
            raise AssertionError('Connection difference is not divisible by 5')
        if difference:
            m[exponent] = difference//5

    def mod5(value):
        return {i: a % 5 for i, a in value.items() if a % 5}

    if mod5(add(h, mul({6: 1}, sigma(h)), one)):
        raise AssertionError('h+t^6*h^5=-1 failed')
    if mod5(add(m, mul({6: 1}, sigma(m)),
                scale(mul({5: 1}, sigma(h)), 2))):
        raise AssertionError('Divided connection recurrence failed')
    quotient = {}
    inverse_constant = pow(h[0], -1, 5)
    for n in range(bound):
        coefficient = (m.get(n, 0)-sum(a*quotient.get(n-i, 0)
                       for i, a in h.items() if 0 < i <= n))
        coefficient = coefficient*inverse_constant % 5
        if coefficient:
            quotient[n] = coefficient
    if not quotient or min(quotient) != 5 or quotient[5] != 3:
        raise AssertionError('w=m/h does not start with 3*t^5')
    delta = mod5(add({-1: 2}, sigma(quotient), scale(quotient, -1)))
    if min(delta) != -1 or delta[-1] != 2:
        raise AssertionError('Exact representative does not have simple pole 2/t')

    # The ordinary unit-root line has vector (f+5/t^5,1) and
    # Frobenius multiplier sigma(f)+5/t^25, all modulo 25.
    for j in (0, 1):
        f = add(t, {0: 5*j})
        v = add(f, {-5: 5})
        lam = sigma(v)
        if add(mul(f, lam), five) != mul(lam, v):
            raise AssertionError('Unit-root eigenvector identity failed')
    lam0 = {5: 1, -25: 5}
    lam1 = {5: 1, 0: 5, -25: 5}
    if mul(lam0, {0: 1, -5: 5}) != lam1:
        raise AssertionError('Unit-root multiplier ratio failed')

    # x^5-x=-t^-5 is equivalent, by z=x+t^-1, to z^5-z=-t^-1.
    rhs = {i: a % 5 for i, a in add({-5: 4}, {-5: 1}, {-1: 4}).items()
           if a % 5}
    if rhs != {-1: 4}:
        raise AssertionError('Artin--Schreier reduction failed')
    return {'precision_T': bound, 'coefficient_modulus': modulus,
            'checks': ['FV=VF=5', 'F horizontal', 'V horizontal',
                       'identical marked BT1', 'unit Kodaira--Spencer',
                       'unit-root line', 'ratio 1+5/t^5',
                       'Artin--Schreier conductor-one representative',
                       'actual divided connection recurrence',
                       'w=m/h starts 3*t^5', 'Delta=2/t+w^5-w has pole order 1'],
            'exact_delta_jet': delta,
            'models': models}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--precision', type=int, default=200)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    if args.precision < 10:
        parser.error('Use precision at least 10')
    result = check(args.precision)
    if args.output:
        root = Path(__file__).resolve().parents[2]
        if args.output.resolve().is_relative_to(root):
            parser.error('Generated evidence must be outside the workspace')
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result, indent=2)+'\n')
    print('PASS: '+', '.join(result['checks']))
    print('Bounded matrix check only; group effectivity and pole implication'
          ' use the mathematical proof.')


if __name__ == '__main__':
    main()
