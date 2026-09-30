#!/usr/bin/env python3
"""Exact finite evidence for the involution-secant theorem.

This enumerates forced local leading labels, not geometric curves.
Uses only the standard library and the included, preserved F25 arithmetic.
"""
from pathlib import Path
import argparse
import itertools
import json
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.dont_write_bytecode = True
sys.path.insert(0, str(ROOT / 'previous' / 'src'))
import local_checks as m


def determinant(columns):
    """Determinant of a 4x4 matrix over the encoded F25, given columns."""
    rows = [list(row) for row in zip(*columns)]
    answer = 0
    for perm in itertools.permutations(range(4)):
        term = 1
        for row, col in enumerate(perm):
            term = m.MUL[term][rows[row][col]]
        if sum(perm[i] > perm[j] for i in range(4) for j in range(i+1, 4)) % 2:
            term = m.NEG[term]
        answer = m.ADD[answer][term]
    return answer


def construct_certificates():
    old = m.construct_data()  # Rechecks the exact field presentations.
    alpha = [tuple(a) for a in old['alpha_roots']]
    base = [tuple(b) for b in old['B_base']]
    powers, p = [], [1]
    for _ in range(29):
        powers.append(tuple(p + [0] * (7-len(p))))
        p = m.f.rem([0] + p, m.D7)
    assert p == [1]

    def tensor_value(terms):
        out = [0] * 28
        for coefficient, exponent in terms:
            term = [m.MUL[x][y] for x in coefficient
                    for y in powers[exponent % 29]]
            out = [m.ADD[x][y] for x, y in zip(out, term)]
        return out

    # Cubic divided differences on all unordered pairs, WITH repetitions.
    pair_values, seen = [], {}
    for a, b in itertools.combinations_with_replacement(range(29), 2):
        cyclic = [0] * 29
        for e in (3*a, 2*a+b, a+2*b, 3*b):
            cyclic[e % 29] = (cyclic[e % 29]+1) % 5
        value = tuple(m.cr(cyclic))
        assert any(value), ('zero cubic divided difference', a, b)
        assert value not in seen, ('collision', seen.get(value), (a, b))
        seen[value] = (a, b)
        pair_values.append({'exponents': [a, b], 'remainder_F5_degree14': list(value)})
    assert len(pair_values) == 435

    # The 120 heterogeneous-pair root patterns with >=3 distinct roots.
    rank_certificates = []
    for tags in itertools.product(range(4), repeat=4):
        if tags[0] == tags[1] or tags[2] == tags[3] or len(set(tags)) < 3:
            continue
        a = [alpha[i] for i in tags]
        b = [base[i] for i in tags]
        d01 = m.ea(a[0], m.en(a[1]))
        d23 = m.ea(a[2], m.en(a[3]))
        columns = [m.en(m.em(d23, b[0])), m.em(d23, b[1]),
                   m.em(d01, b[2]), m.en(m.em(d01, b[3]))]
        det = determinant(columns)
        assert det, ('dependent coefficient columns', tags)
        rank_certificates.append({'root_indices': list(tags),
                                  'columns_over_F25': [list(c) for c in columns],
                                  'determinant_F25': det})
    assert len(rank_certificates) == 120

    Cs, Ds, Ls, constants = [], [], [], []
    Ap = m.f.der(m.f.A)
    App = m.f.der(Ap)
    Pp = m.f.der(m.f.P)
    for i, a in enumerate(alpha):
        p = m.ev(Ap, a)
        C = m.es(m.ei(p), m.f.A[-1])
        D = m.en(m.em(m.es(m.ev(App, a), 3), m.em(m.ep(C, 2), m.ei(p))))
        M = m.em(m.ev(Pp, a), m.ei(m.ev(m.f.P, a)))
        L = m.ea(m.em(C, M), m.es(m.em(D, m.ei(C)), 2))
        assert C != m.ZERO and D != m.ZERO and L != m.ZERO
        ratio = m.em(D, m.ei(m.em(C, L)))
        assert any(ratio[1:]), ('D/(C L) unexpectedly in F25', i)
        Cs.append(C); Ds.append(D); Ls.append(L)
        constants.append({'root_index': i, 'C': list(C), 'D': list(D),
                          'M': list(M), 'L': list(L), 'D_over_C_L': list(ratio)})

    # Nonzero transverse coefficient for each pair of different roots.
    transverse = []
    for i, j in itertools.combinations(range(4), 2):
        difference = m.ea(alpha[i], m.en(alpha[j]))
        b, c = base[i], base[j]
        coefficients = [
            m.em(m.ea(m.em(difference, Ls[i]), m.en(m.es(Cs[i], 4))), m.ep(b, 4)),
            m.es(m.em(Cs[i], m.em(m.ep(b, 3), c)), 4),
            m.es(m.em(Cs[j], m.em(b, m.ep(c, 3))), 4),
            m.em(m.en(m.ea(m.em(difference, Ls[j]), m.es(Cs[j], 4))), m.ep(c, 4)),
        ]
        evaluations = []
        for r in range(29):
            value = tensor_value(zip(coefficients, (0, r, 3*r, 4*r)))
            assert any(value), ('zero transverse coefficient', i, j, r)
            evaluations.append({'relative_exponent': r,
                                'tensor_coordinates_alpha_then_omega': value})
        transverse.append({'root_indices': [i, j], 'omega_exponent_multipliers': [0, 1, 3, 4],
                           'coefficients_in_E': [list(c) for c in coefficients],
                           'evaluations': evaluations})
    assert sum(len(row['evaluations']) for row in transverse) == 174

    return {
        'scope': 'Exhaustive forced-local-label checks, NOT a geometric curve search.',
        'F25_encoding': '[a+5b]=a+b*beta, beta^2=beta+3; ascending coefficients',
        'E': {'definition': 'F25[alpha]/A_monic(alpha)', 'A_monic': old['A_monic'],
              'roots_A': old['alpha_roots'], 'base_labels': old['B_base']},
        'F': {'definition': 'F25[omega]/D7(omega)', 'D7': m.D7,
              'tensor_order': 'alpha^i*omega^j: i=0..3 outer, j=0..6 inner'},
        'pair_value_field': {'definition': 'F5[omega]/M14(omega)', 'M14': m.M14},
        'cubic_divided_difference_pairs': pair_values,
        'heterogeneous_pair_rank_certificates': rank_certificates,
        'root_constants': constants,
        'different_root_transverse_certificates': transverse,
        'counts': {'unordered_pairs_including_repetitions': 435,
                   'pair_value_collisions': 0, 'full_rank_root_patterns': 120,
                   'nonzero_transverse_evaluations': 174, 'root_ratio_nonmembership_checks': 4},
    }


def encoded(data):
    return json.dumps(data, indent=2, sort_keys=True) + '\n'


def run():
    data = construct_certificates()
    expected = (ROOT / 'data' / 'secant_certificates.json').read_text()
    assert encoded(data) == expected, 'exact secant-certificate regeneration differs'
    print('PASS 435 unordered mu29 pairs, including repetitions: cubic divided differences all distinct and nonzero.')
    print('PASS all 120 heterogeneous-pair patterns with at least three roots: exact coefficient rank four.')
    print('PASS all 174 normalized different-root transverse coefficients: nonzero.')
    print('PASS all four exact ratios D/(C L) are outside F25.')
    print('PASS exact secant-certificate regeneration, byte for byte.')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--write-data', type=Path)
    args = parser.parse_args()
    if args.write_data:
        args.write_data.write_text(encoded(construct_certificates()))
        print('Wrote exact secant certificates:', args.write_data)
    else:
        run()
