#!/usr/bin/env python3
"""Regenerate all exact certificates supporting REPORT Sections 11--15.

This is not a bounded search for maps or for coefficient solutions. Resultant
identities are geometric certificates, and the 28-vector check proves a finite
coefficient-field lemma. Neither is an actual curve witness.
"""
import argparse
import json
import platform
from pathlib import Path
from itertools import product
from exact import *
from ramification import (
    G0, G1, G3, G4, F625, RationalFunction, inverse_mod,
    projective_coordinates, resultant_certificate,
    resultant_fixed, sylvester_determinant,
)

ROOT = Path(__file__).resolve().parents[1]
DATA = json.loads((ROOT/'inputs/data.json').read_text())


def projections():
    E = Extension(DATA['A_monic'])
    rows = {}
    for name in ('c_row', 'e_row', 'f0_row', 'f1_row'):
        element = E.element(DATA[name])
        projected = []
        for ll in range(4):
            ss = E.zero
            for ii in range(4):
                weight = pow(2, (-ll*ii) % 4, 5)
                ss = E.add(ss, E.mul(E.integer(weight), E.pow(element, 25**ii)))
            projected.append(list(ss))
        rows[name] = projected
    assert rows['e_row'][3] == [0]*4 == rows['f1_row'][3]
    assert all(v != [0]*4 for name in ('c_row', 'f0_row') for v in rows[name])
    assert rows['c_row'][1] == rows['e_row'][1] != [0]*4
    cc, ee = E.element(rows['c_row'][2]), E.element(rows['e_row'][2])
    assert E.div(ee, cc) == E.embed(12)
    return {'unnormalized_F25_Frobenius_projections': rows,
            'e_to_c_character2_ratio': 12}


def phase_arc_and_counts():
    K = Extension(DATA['zeta_minimal_over_F25'])
    zz = K.element([0, 1])
    assert K.pow(zz, 29) == K.one and zz != K.one
    powers = [K.pow(zz, j) for j in range(29)]
    normalized = []
    for j in range(1, 29):
        tail = powers[j][1:]
        pivot = next((c for c in tail if c != 0), None)
        assert pivot is not None
        normalized.append([F.div(c, pivot) for c in tail])
    assert len({tuple(v) for v in normalized}) == 28
    orbit = {pow(5, j, 29) for j in range(14)}
    assert len(orbit) == 14 and 5 in orbit and 17 not in orbit
    assert orbit | {(2*x) % 29 for x in orbit} == set(range(1, 29))
    single = []
    for counts in product(range(5), repeat=4):
        if sum(counts) != 5:
            continue
        ss = [sum(counts[i]*pow(2, ll*i, 5) for i in range(4)) % 5
              for ll in range(4)]
        if ss[3] == 0:
            assert ss[1] and ss[2]
            single.append({'counts': list(counts), 'characters': ss})
    assert len(single) == 8
    blocks = {}
    for total in (2, 3):
        good = []
        for counts in product(range(total+1), repeat=4):
            if sum(counts) == total and sum(counts[i]*pow(3, i, 5) for i in range(4)) % 5 == 0:
                good.append(list(counts))
        blocks[str(total)] = good
    assert len(blocks['2']) == 2 and len(blocks['3']) == 4
    # Complete local count patterns used in the scalar-character strengthening.
    # Phase positions remain arbitrary; these finite checks are independent
    # checks of the phase-by-phase integer arguments in Theorem 11.2.
    character1_single = []
    character2_single = []
    for counts in product(range(5), repeat=4):
        if sum(counts) != 5:
            continue
        ss = [sum(counts[i]*pow(2, ll*i, 5) for i in range(4)) % 5
              for ll in range(4)]
        if ss[1] == 0:
            assert ss[3] != 0
            character1_single.append({'counts': list(counts), 'characters': ss})
        if ss[2] == 0:
            occupied = {i % 2 for i, count in enumerate(counts) if count}
            assert len(occupied) == 1 and ss[1] and ss[3]
            character2_single.append({'counts': list(counts), 'characters': ss})
    assert len(character1_single) == 8 and len(character2_single) == 8
    character1_blocks = {}
    for total in (2, 3):
        actual = set()
        for counts in product(range(total+1), repeat=4):
            if sum(counts) == total and sum(counts[i]*pow(2, i, 5) for i in range(4)) % 5 == 0:
                actual.add(counts)
        expected = set()
        for i in range(4):
            cc = [0]*4
            cc[i] += 1 if total == 2 else 2
            cc[(i + (2 if total == 2 else 3)) % 4] += 1
            expected.add(tuple(cc))
        assert actual == expected
        character1_blocks[str(total)] = [list(c) for c in sorted(actual)]
    for total in range(1, 5):
        for counts in product(range(total+1), repeat=4):
            if sum(counts) == total and sum(counts[i]*pow(4, i, 5) for i in range(4)) % 5 == 0:
                assert total % 2 == 0
                assert counts[0] + counts[2] == counts[1] + counts[3]
    return {'normalized_nonconstant_zeta_power_vectors': normalized,
            'three_term_independence': True,
            'F5_frobenius_orbit_of_one': sorted(orbit),
            'single_phase_nonpure_count_patterns': single,
            'zero_character_phase_blocks': blocks,
            'character1_single_phase_patterns': character1_single,
            'character2_single_phase_patterns': character2_single,
            'character1_zero_phase_blocks': character1_blocks,
            'character2_small_zero_blocks_have_equal_parities': True}


def decomposition_and_critical_jets():
    A, P = DATA['A'], DATA['P']
    Ap = derivative(A)
    D = scale(Ap, F.inv(Ap[-1]))
    gg = [G0, G1, [], G3, G4]
    nn = []
    for rr in range(5):
        nn = add(nn, mul(power(gg[rr], 5), power(A, rr)))
    assert scale(nn, Ap[-1]) == mul(P, power(D, 4))
    assert gcd(Ap, derivative(Ap)) == [1]
    assert gcd(Ap, mul(A, P)) == [1]
    assert gcd(G0, G1) == [1] and gcd(A, mul(G0, G1)) == [1]
    App, Appp, Apppp = derivative(Ap), derivative(derivative(Ap)), derivative(derivative(derivative(Ap)))
    Pp, Ppp = derivative(P), derivative(derivative(P))
    b3num = add(mul(Appp, P), scale(mul(Pp, App), 2))
    assert gcd(D, b3num) == [1]
    R = RationalFunction
    JJ = (R(mul(A, Apppp), power(App, 2))
          + R(scale(mul(mul(A, Pp), Appp), 4), mul(P, power(App, 2)))
          + R([2]) + R(mul(A, Ppp), mul(P, App)))
    jremainder = mod(mul(JJ.n, inverse_mod(JJ.d, D)), D)
    assert jremainder == [18, 12]
    assert irreducible_prime_degree(D)
    return {'D': D, 'A_prime_leading_coefficient': Ap[-1],
            'g_rows': gg, 'decomposition_checked': True,
            'A_prime_squarefree_and_coprime_to_AP': True,
            'critical_cubic_coefficient_numerator': b3num,
            'critical_cubic_nonvanishing_gcd': gcd(D, b3num),
            'critical_J_mod_D': jremainder,
            'critical_J_numerator': JJ.n, 'critical_J_denominator': JJ.d}


def boundary_fibers():
    phi = projective_coordinates(DATA['A'])
    h = scale(G0, F.inv(G0[-1]))
    assert gcd(h, derivative(h)) == [1]
    assert powmod([0, 1], 25**4, h) == [0, 1]
    assert gcd(h, sub(powmod([0, 1], 25**2, h), [0, 1])) == [1]
    K = Extension(h)
    uu = K.element([0, 1])
    at = [K.element(mod(w, h)) for w in phi]
    pivot = next(i for i in range(4) if at[i] != K.zero)
    hh = [K.embed(c) for c in h]
    for i in range(4):
        pp = sub(scale([K.embed(c) for c in phi[i]], at[pivot], K),
                 scale([K.embed(c) for c in phi[pivot]], at[i], K), K)
        hh = gcd(hh, pp, K)
    assert hh == [K.neg(uu), K.one]
    roots = [a for a in range(25) if evaluate(G1, a) == 0]
    assert roots == [4, 9, 23]
    values = []
    for a in roots:
        ww = [evaluate(w, a) for w in phi]
        pp = next(c for c in ww if c)
        values.append([F.div(c, pp) for c in ww])
    assert len({tuple(v) for v in values}) == 3
    return {'g0_irreducible': True,
            'g0_projective_fiber_gcd_over_F25_u': [list(c) for c in hh],
            'g1_roots': roots, 'g1_projective_values': values}


def resultant_cross_checks():
    K = F625()
    count = 0
    for m in range(1, 4):
        for n in range(1, 4):
            for da in range(m+1):
                for db in range(n+1):
                    a = [K.integer(j+1) for j in range(m-da)] + [26]
                    b = [K.integer(2*j+1) for j in range(n-db)] + [31]
                    assert resultant_fixed(a, b, m, n, K) == sylvester_determinant(a, b, m, n, K)
                    count += 1
            for a, b in [([], [1]), ([1], []), ([], [])]:
                assert resultant_fixed(a, b, m, n, K) == sylvester_determinant(a, b, m, n, K)
                count += 1
    return {'fixed_degree_sylvester_cross_checks': count,
            'includes_one_and_two_degree_drops_and_zero_polynomials': True}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    report = {'python_version': platform.python_version(), 'status': 'all checks passed',
              'scope': 'Exact certificates for epsilon^4-in-K0 exclusion and uniform tameness; no full existence decision.'}
    report['projections'] = projections()
    report['arc_and_count_patterns'] = phase_arc_and_counts()
    print('PASS scalar-sector ingredients: all required character projections; three-term phase independence; complete local count classifications.')
    report['decomposition_and_critical_jets'] = decomposition_and_critical_jets()
    print('PASS exact four-term Frobenius identity; simple critical points; nonzero cubic jets; J=[18]+[12]x modulo A\'.')
    report['resultant_cross_checks'] = resultant_cross_checks()
    report['resultant_certificate'] = resultant_certificate(DATA['A'])
    results = report['resultant_certificate']['resultants']
    assert len(results['RS'])-1 == 207 and len(results['RT'])-1 == 333
    report['boundary_fibers'] = boundary_fibers()
    print('PASS geometric separation: resultant degrees 207,333; gcd=g0^20*g1^33; both denominator boundaries closed.')
    print('PASS fixed-degree Sylvester cross-checks, including degree drops and zero polynomials.')
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(report, indent=2)+'\n')
    print('ALL CONTINUATION CHECKS PASS. FULL MIXED-PHASE EXISTENCE REMAINS UNRESOLVED.')


if __name__ == '__main__':
    main()
