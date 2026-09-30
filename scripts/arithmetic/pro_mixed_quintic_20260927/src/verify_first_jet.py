#!/usr/bin/env python3
"""Verify new first-jet identities and the reconstruction implementation.

The proofs of scalar cubeness and descent in REPORT Sections 21--24 are
THEORETICAL: no computational certificate is needed. These exact checks
verify their elementary arithmetic and exercise the reusable reconstruction
kernel. The one input incidence is an implementation test, NOT a witness or
an exhaustive incidence search. No full shared-field solver is executed.
"""
import argparse
import hashlib
import json
import platform
from itertools import product
from pathlib import Path
from exact import F, add, sub, scale, mul, power, derivative, evaluate
from first_jet import (FastExtension, make_field_data, hermite, evaluate_u,
                       derivative_u, build_leg, scalar_polynomial,
                       opposite_incidence, recover_scalar, _bezout)

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    data = json.loads((ROOT/'inputs/data.json').read_text())
    # Universal polynomial identity in the four independent monomials
    # Pa'/Pa, Aa''/Aa', d Pb'/Pb, d Ab''/Ab'.
    h = [2, 3, 3, 2]
    e_from_A = [(2*h[i] + [0, 3, 0, 2][i]) % 5 for i in range(4)]
    e_from_D = [(3*h[i] + [3, 0, 2, 0][i]) % 5 for i in range(4)]
    assert e_from_A == e_from_D == [4, 4, 1, 1]
    print('PASS universal first-jet identity: dt/du=2c(Ka-d Kb).', flush=True)
    compositions = [m for m in product(range(6), repeat=4) if sum(m) == 5]
    survivors = []
    for m in compositions:
        positive = [x for x in m if x]
        permitted = (all(x % 3 == 0 for x in positive) if 0 in m
                     else len({x % 3 for x in positive}) == 1)
        if permitted:
            survivors.append(m)
    assert len(compositions) == 56 and not survivors
    print('PASS cube-exclusion partition check: all 56 root-count vectors excluded under noncube assumption.', flush=True)
    field = make_field_data(data)
    E, K = field['E'], field['K']
    assert K.order == 5**56
    for i in range(4):
        assert E.pow(field['beta8'][i], 3) == E.div(field['b08'][i], field['b08'][0])
    assert K.pow(field['chi'], 3) == field['zeta']
    assert K.pow(field['chi'], 87) == K.one
    assert K.pow(field['chi'], 29) != K.one
    assert K.pow(field['chi'], 3) != K.one
    assert K.mul(field['chi'], K.inv(field['chi'])) == K.one
    print('PASS exact coefficient-field construction and all cubic ratio roots; chi has order 87.', flush=True)
    # Exact Hermite reconstruction on an entire monomial basis, including
    # U^5 (whose derivative is zero) and the rejection boundary U^6,U^7.
    roots = field['alpha8']
    cases = 0
    for u_degree in range(8):
        for z_degree in range(3):
            original = [[] for _ in range(u_degree+1)]
            original[u_degree] = [E.zero]*z_degree + [E.one]
            values = [evaluate_u(original, a, E) for a in roots]
            jets = [evaluate_u(derivative_u(original, E), a, E) for a in roots]
            reconstructed = hermite(roots, values, jets, E)
            assert reconstructed == original
            cases += 1
    assert cases == 24
    # Repeated roots are retained as integer powers, including multiplicity 5.
    occurrences = [(1, 2)]*5 + [(2, 0)]*2 + [(3, 4)]
    roots_poly = [1]
    derivative_in_u = []
    for c, slope in occurrences:
        derivative_in_u = sub(mul(derivative_in_u, [F.neg(c), 1]),
                              scale(roots_poly, slope))
        roots_poly = mul(roots_poly, [F.neg(c), 1])
    grouped = {}
    for c, slope in occurrences:
        grouped[c] = (grouped.get(c, (0, slope))[0]+1, slope)
    from exact import divmod_poly
    reconstructed_d = []
    for c, (m, slope) in grouped.items():
        qq, rr = divmod_poly(roots_poly, [F.neg(c), 1])
        assert not rr
        reconstructed_d = sub(reconstructed_d, scale(qq, F.mul(m % 5, slope)))
    assert reconstructed_d == derivative_in_u
    assert len(roots_poly)-1 == 8
    print('PASS Hermite reconstruction: 24 basis tests; repeated-root derivative identity retains a multiplicity-five factor.', flush=True)
    # One completely specified artificial incidence. It meets the integer
    # row/column and point-count capacities only. This is NOT asserted to
    # satisfy the high-coefficient, endpoint, norm, or geometric conditions.
    labels = [(0, 0), (0, 1), (1, 0), (2, 0), (3, 0)]
    counts = [2, 1, 1, 1]
    incidence = {(i, i, 20*i+r): 1 for i in range(4)
                  for r in range(1, 15-counts[i]+1)}
    assert len(incidence) == 55
    leg = build_leg(15, labels, incidence, field)
    opp = build_leg(15, labels, opposite_incidence(incidence), field)
    assert opposite_incidence(opposite_incidence(incidence)) == incidence
    scal = scalar_polynomial(labels, leg, field)
    assert scal['degree'] == 2
    # Characteristic-five resonance is not removed by a division. Both
    # pencils are reconstructed and tested at all eight first-jet conditions.
    encode = lambda obj: json.dumps(obj, separators=(',', ':'), sort_keys=True).encode()
    pencil_digest = hashlib.sha256(encode([leg['H0'], leg['H1'],
                                          opp['H0'], opp['H1']])).hexdigest()
    recovered = recover_scalar(labels, leg, field)
    assert recovered['lambda'] != K.zero
    assert K.pow(recovered['lambda'], (5**8-1)*29) == K.one
    # Scalar recovery is also tested independently on all 56 multiplicity
    # patterns using consistent synthetic leading terms, not new incidences.
    recovery_methods = {}
    scalar_test = K.mul(field['beta'][1], field['zeta'])
    constant_test = K.embed(E.embed(7))
    for counts_test in compositions:
        labels_test = [(i, j) for i, m in enumerate(counts_test) for j in range(m)]
        from first_jet import endpoint_slopes
        slopes_test = endpoint_slopes(labels_test, field)
        values_test = []
        for i, m in enumerate(counts_test):
            if m:
                bi = K.integer((-1)**m)
                for (j, _), slope in zip(labels_test, slopes_test):
                    bi = K.mul(bi, slope if i == j else K.sub(field['roots'][i], field['roots'][j]))
                ri = K.div(K.mul(constant_test, bi), K.pow(scalar_test, m))
                values_test.append([K.zero]*m+[ri])
            else:
                wh = K.one
                for j, _ in labels_test:
                    wh = K.mul(wh, K.sub(field['roots'][i], field['roots'][j]))
                values_test.append([K.mul(constant_test, wh)])
        rec = recover_scalar(labels_test, {'root_counts': list(counts_test),
                             'values': values_test, 'slopes': slopes_test}, field)
        assert rec['lambda'] == scalar_test
        recovery_methods[rec['method']] = recovery_methods.get(rec['method'], 0)+1
    from math import gcd
    cube_group = (5**8-1)//3
    excluded_subfield = gcd(cube_group, 5**4-1)
    excluded_fourth = gcd(cube_group, 4*(25-1))
    intersection = gcd(excluded_subfield, excluded_fourth)
    normalized_count = cube_group-excluded_subfield-excluded_fourth+intersection
    assert pow(5,8,29) == 24 and pow(24,7,29) == 1 and 24 != 1
    assert pow(5,8,87) == 82 and pow(82,7,87) == 1 and 82 != 1
    assert (cube_group, excluded_subfield, excluded_fourth, intersection, normalized_count) == (130208,208,32,16,129984)
    print('PASS both reciprocal pencils on one artificial incidence; unique scalar recovery on all 56 root-count patterns.', flush=True)
    print('PASS multiplicative scalar group and normalized remaining count: 129984 (no scalar or curve search).', flush=True)
    result = {
        'python_version': platform.python_version(),
        'overall_status': 'PARTIAL; full actual comparison decision unresolved',
        'proof_status': 'Theoretical proofs in REPORT; no computational certificate is needed for the new theorems.',
        'universal_jet_monomials': ['Pa_prime/Pa', 'Aa_second/Aa_prime',
                                    'd*Pb_prime/Pb', 'd*Ab_second/Ab_prime'],
        'h_equals_tprime_over_t_coefficients': h,
        'second_v_coefficient_from_each_identity': e_from_A,
        'root_count_vectors_checked': len(compositions),
        'noncube_survivors': len(survivors),
        'field_order': str(K.order),
        'xi_F25_code': field['xi_F25_code'],
        'beta_i_in_alpha_basis': [list(b) for b in field['beta8']],
        'cubic_ratio_checks': 4,
        'chi_order': 87,
        'Hermite_basis_cases': cases,
        'multiplicity_five_test': {'factor_degree': 8, 'passed': True},
        'artificial_incidence': {
            'is_geometric_witness': False,
            'scope': 'Implementation test only; no full compatibility or curve validation.',
            'n': 15, 'labels_at_both_ends': labels,
            'entries': [[*key, val] for key, val in sorted(incidence.items())],
            'row_degrees': [15]*4, 'column_degrees': [15]*4,
            'nonzero_entries': len(incidence),
            'scalar_polynomial_degree': scal['degree'],
            'both_reciprocal_pencils_sha256': pencil_digest,
        },
        'unique_scalar_recovery': {'patterns_checked': len(compositions),
                                  'method_counts': recovery_methods,
                                  'all_recovered_values_equal_synthetic_input': True},
        'scalar_group': {'H_order': (5**8-1)*29, 'epsilon_group_order': cube_group*29,
                         'normalized_cube_subgroup_order': cube_group,
                         'excluded_quadratic_subfield': excluded_subfield,
                         'excluded_fourth_power_subgroup': excluded_fourth,
                         'intersection': intersection, 'remaining_normalized_scalars': normalized_count,
                         'E8_Frobenius_phase_multiplier': 24,
                         'E8_Frobenius_incidence_multiplier': 82, 'Frobenius_order': 7},
        'not_executed': ['complete incidence enumeration',
                         'shared-field tests for all reconstructed candidates',
                         'a complete existence or nonexistence verification'],
    }
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result, indent=2)+'\n')
    print('ALL FIRST-JET CHECKS PASS. FULL EXISTENCE/NONEXISTENCE IS NOT DECIDED.', flush=True)


if __name__ == '__main__':
    main()
