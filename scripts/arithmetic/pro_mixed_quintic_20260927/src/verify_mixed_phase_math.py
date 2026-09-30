"""Independent Python checks for the final proof's small exact lemmas.

This is not the 50,706,761-endpoint enumeration; that complete certificate
is mixed_phase_check.cpp, exercised by two algorithms. No network or CAS.
"""
import argparse
import json
import math
from itertools import combinations, combinations_with_replacement
from pathlib import Path
from exact import F, Extension
from mixed_phase_data import make_data


def independent(vectors, plus, times, negative, inverse):
    basis = {}
    for vector in vectors:
        row = list(vector)
        for pivot in sorted(basis):
            factor = row[pivot]
            if factor:
                rr = basis[pivot]
                for j in range(pivot, len(row)):
                    row[j] = plus[row[j]][negative[times[factor][rr[j]]]]
        pivot = next((j for j, value in enumerate(row) if value), None)
        if pivot is None:
            return False
        factor = inverse[row[pivot]]
        basis[pivot] = [times[factor][x] for x in row]
    return True


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    _, data = make_data()
    phases = data['phase_vectors_F25']
    plus = [[F.add(a, b) for b in range(25)] for a in range(25)]
    times = [[F.mul(a, b) for b in range(25)] for a in range(25)]
    negative = [F.neg(a) for a in range(25)]
    inverse = [0] + [F.inv(a) for a in range(1, 25)]
    tested = 0
    for tail in combinations(range(1, 29), 4):
        assert independent([phases[0]] + [phases[j] for j in tail],
                           plus, times, negative, inverse)
        tested += 1
    assert tested == 20475
    print('PASS: all 20,475 normalized five-phase sets are independent over F25.')
    root = Path(__file__).resolve().parent.parent
    exact_data = json.loads((root/'inputs/data.json').read_text())
    K = Extension(exact_data['zeta_minimal_over_F25'])
    zeta = K.element([0, 1])
    in_f25 = lambda x: all(a == 0 for a in x[1:])
    B_constant, both_constant = [], []
    a = K.embed(17)
    abar = K.embed(F.pow(17, 5))
    for j0 in range(29):
        for ji in range(29):
            B = K.sub(K.pow(zeta, 8*j0), K.pow(zeta, (-8*ji)%29))
            D = K.sub(K.mul(a, K.sub(K.pow(zeta, 5*ji), K.one)),
                      K.mul(abar, K.sub(K.pow(zeta, (-5*j0)%29), K.one)))
            if in_f25(B):
                B_constant.append([j0, ji])
                if in_f25(D):
                    both_constant.append([j0, ji])
    assert B_constant == [[j, (-j)%29] for j in range(29)]
    assert both_constant == [[0, 0]]
    print('PASS: among all 841 phase pairs, B and D are both constant only at (0,0).')
    small = [list(row) for row in combinations_with_replacement(range(4), 5)
             if row[0] == 0 and row[-1] != 0]
    small += [[0, 4*j, 4*j+1, 4*j+2, 4*j+3] for j in range(1, 29)]
    assert len(small) == 62
    orbit = {tuple(sorted(4*(label//4)+(label%4+r)%4 for label in row))
             for row in small for r in range(4)}
    assert len(orbit) == 164
    assert sum(math.comb(119-4*j, 4) for j in range(29)) == 50706761
    permitted = [j for j in range(390624)
                 if j%3 == 0 and j%626 != 0 and j%4069 != 0]
    assert len(permitted) == 129984
    permitted_set = set(permitted)
    assert all((-j)%390624 in permitted_set for j in permitted)
    # The divisibility conditions are invariant under negation and under 25.
    assert all((25*j)%390624%3 == 0
               and (25*j)%390624%626 != 0
               and (25*j)%390624%4069 != 0 for j in permitted)
    output = {
        'five_phase_normalized_subsets': tested,
        'five_phase_all_independent': True,
        'tested_phase_pairs': 841,
        'B_constant_phase_pairs': B_constant,
        'B_and_D_constant_phase_pairs': both_constant,
        'normalized_endpoint_shapes': small,
        'normalized_endpoint_shapes_count': len(small),
        'unnormalized_shapes_count': len(orbit),
        'complete_normalized_endpoint_domain': 50706761,
        'permitted_scalar_count': 129984,
        'root_trace_divided_by_eta0': data['root_trace_divided_by_eta0'],
        'c_trace_bar': data['c_trace_bar'],
        'scope': 'Complete small lemmas; the exhaustive endpoint certificate is separate.',
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(output, indent=2, sort_keys=True)+'\n')
    print('ALL FINAL-PROOF SMALL CHECKS PASS')


if __name__ == '__main__':
    main()
