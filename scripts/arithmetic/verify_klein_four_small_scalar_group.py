#!/usr/bin/env python3
"""Independent direct F25[zeta]/f7 replay of the small-scalar classification.

Build and invert the complete29-dimensional Fourier matrix over F5.
Solve the two conjugate moment equations in the field, instead of using
the generator's shifted templates or sparse expanded formulas.
"""
import argparse
import json
from pathlib import Path
from verify_klein_four_reciprocal_f25 import F, MOD, product, power


def add(a, b):
    return F.padd(a, b)


def sub(a, b):
    return F.psub(a, b)


def main(path):
    data = json.loads(path.read_text())
    assert not F.pdivmod(data['node_modulus_F5'], MOD)[1]
    assert F.pdivmod(data['beta_embedding'], MOD)[1] == [5]
    zp = [power([0, 1], j) for j in range(29)]

    def bar(a):
        r = []
        for j, c in enumerate(a):
            r = add(r, F.scale(zp[-j % 29], F.power(c, 5)))
        return r

    def coords(a):
        out = []
        for c in a+[0]*(7-len(a)):
            out.extend((c % 5, c//5))
        return out

    columns = [[1]+coords(zp[2*j % 29])+coords(zp[6*j % 29]) for j in range(29)]
    a = [[columns[j][i] for j in range(29)]+[int(i == j) for j in range(29)] for i in range(29)]
    for j in range(29):
        k = next(k for k in range(j, 29) if a[k][j])
        a[k], a[j] = a[j], a[k]
        m = pow(a[j][j], -1, 5)
        a[j] = [x*m % 5 for x in a[j]]
        for i in range(29):
            if i == j:
                continue
            m = a[i][j]
            a[i] = [(x-m*y) % 5 for x, y in zip(a[i], a[j])]
    assert all(a[i][:29] == [int(i == j) for j in range(29)] for i in range(29))
    inverse = [r[29:] for r in a]
    for i in range(29):
        assert [sum(x*y for x, y in zip(inverse[i], col)) % 5 for col in columns] == [int(i == j) for j in range(29)]
    records = {(r[0], r[1], r[2]): r[3:] for r in data['non_norm_one_cases']}
    assert len(records) == len(data['non_norm_one_cases']) == 15138
    boundaries, minimum, attaining = [], 1000, []
    for phase in range(29):
        for ep in range(29):
            for e in range(1, 25):
                epsilon = F.scale(zp[ep], e)
                norm = product(epsilon, bar(epsilon))
                assert len(norm) == 1 and norm[0] in range(1, 5)
                # Substitute x=phi^8-epsilon*kappa+epsilon*y into the
                # first equation and conjugate the resulting linear equation.
                rhs = sub(F.scale(zp[5*phase % 29], 17), F.scale([F.power(17, 5)], norm[0]))
                rhs = sub(rhs, product(epsilon, sub([1], zp[-8*phase % 29])))
                if norm == [1]:
                    if not rhs:
                        boundaries.append([phase, ep, e])
                    continue
                y = bar(F.scale(rhs, pow((1-norm[0]) % 5, -1, 5)))
                x = add(sub(zp[8*phase % 29], F.scale(epsilon, 17)), product(epsilon, y))
                assert product(epsilon, sub([1], bar(x))) == sub(F.scale(zp[5*phase % 29], 17), bar(y))
                assert product(epsilon, sub([17], y)) == sub(zp[8*phase % 29], x)
                vector = [0]+coords(x)+coords(y)
                w0 = [sum(x*y for x, y in zip(row, vector)) % 5 for row in inverse]
                masses = []
                for mr in range(5):
                    weights = [(v+4*mr) % 5 for v in w0]
                    mass = sum(weights)
                    assert mass % 5 == mr
                    masses.append(mass)
                    if mass <= minimum:
                        if mass < minimum:
                            minimum, attaining = mass, []
                        attaining.append({'phase': phase, 'scalar_phase': ep, 'epsilon_base': e,
                                          'mass_mod5': mr, 'weights': weights})
                assert masses == records[phase, ep, e]
    assert boundaries == data['norm_one_boundaries'] == []
    assert minimum == data['minimum_residue_mass_off_norm_one'] == 28
    assert attaining == data['attaining_cases'] and len(attaining) == 14
    assert all(r['phase'] == 0 and set(r['weights']) == {0, 2, 3} for r in attaining)
    first = next(r for r in attaining if r['epsilon_base'] == 23 and r['scalar_phase'] == 2)
    orbit = set()
    for inv in [False, True]:
        for j in range(7):
            exponent = pow(25, j, 29) * (-1 if inv else 1) % 29
            weights = [0]*29
            for i, w in enumerate(first['weights']):
                weights[i*exponent % 29] = w
            e = F.inv(23) if inv else 23
            orbit.add((e, 2*exponent % 29, tuple(weights)))
    assert orbit == {(r['epsilon_base'], r['scalar_phase'], tuple(r['weights'])) for r in attaining}
    assert all(r['weights'].count(2) == 5 and r['weights'].count(3) == 6 for r in attaining)
    print('PASS: all20184 phase/scalar pairs, including5046 norm-one exclusions.')
    print('PASS: independently solved15138 moment pairs and75690 residue vectors; full inverse Fourier matrix.')
    print('PASS: minimum mass28; all14 minimizers have no weight-one nodes and relative phase1.')
    print('PASS: exactly one orbit under coefficient25-Frobenius and endpoint interchange; five weight2 and six weight3 nodes.')
    print('No actual curve is asserted.')


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('certificate', type=Path)
    main(p.parse_args().certificate)
