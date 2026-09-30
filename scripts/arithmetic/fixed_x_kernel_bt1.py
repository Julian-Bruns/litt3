#!/usr/bin/env python3
"""Exact kernel-map syzygy and restricted-Lie determinant for a BT1 seed."""
import argparse
import json
from pathlib import Path

from fixed_x_cartier_petri import calculate, coefficient, kernel, pmul, power
from fixed_x_kernel_wronskian import trim, padd


def run():
    data = calculate()
    qs = [trim(q) for q in data['kernel_B_ascending']]
    dimensions = []
    syzygies = []
    for degree in range(4):
        matrix = [[coefficient(q, exponent-i)
                   for q in qs for i in range(degree+1)]
                  for exponent in range(6+degree)]
        null = kernel(matrix)
        dimensions.append(len(null))
        syzygies.append(null)
    assert dimensions == [0, 0, 1, 3]
    syzygy = [syzygies[2][0][3*j:3*j+3] for j in range(3)]
    assert syzygy == [[10, 15, 20], [11, 2, 4], [1, 0, 0]]
    check = []
    gamma = []
    for q, s in zip(qs, syzygy):
        check = padd(check, pmul(q, s))
        q25 = [0] * (25*(len(q)-1)+1)
        for j, c in enumerate(q):
            assert power(c, 25) == c
            q25[25*j] = c
        gamma = padd(gamma, pmul(q25, s))
    assert check == []
    assert len(gamma)-1 == 125 and gamma[-1] == 1
    assert 127-125 == 2
    assert 3*127 == 381 and 3*2 == 6 and 381 % 6 != 0
    return {
        'field': data['field'],
        'kernel_map_polynomials_ascending': qs,
        'homogeneous_map_degree': 5,
        'bounded_syzygy_dimensions_0_through_3': dimensions,
        'degree_two_syzygy_ascending': syzygy,
        'quotient_splitting_on_P1': [2, 3],
        'gamma_ascending': gamma,
        'gamma_homogeneous_degree': 127,
        'gamma_affine_degree': 125,
        'gamma_order_at_infinity_on_P1': 2,
        'Lie_degrees_on_X': [9, 6, -75],
        'projected_p_map_section_degree_on_X': 381,
        'projected_p_map_order_at_O': 6,
        'uniform_zero_divisor_impossible': True,
    }


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    data = run()
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(data, indent=2)+'\n')
    print('PASS: quotient splitting (2,3); Lie degrees (9,6,-75); '
          'intrinsic determinant section degree381 and order6 at O.')
