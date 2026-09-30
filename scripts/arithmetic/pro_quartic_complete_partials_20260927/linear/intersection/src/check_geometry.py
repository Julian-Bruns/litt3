"""Exact algebraic checks accompanying the geometric proofs in REPORT.md.

These checks do not prove the global geometry by numerical sampling. They verify
polynomial identities over Q, all 71 integer component degrees, and the stated
adjunction degree balance. No source-parameter search is performed.
"""
from __future__ import annotations
from fractions import Fraction as Q
from itertools import permutations
from math import comb
from pathlib import Path
import json
import sys

ROOT = Path(__file__).resolve().parents[2]

# Small exact polynomial algebra; variables are x,a,b,t,y,z.
D = 6
Poly = dict[tuple[int, ...], Q]


def constant(c: int | Q) -> Poly:
    return {(0,) * D: Q(c)} if c else {}


def var(i: int) -> Poly:
    e = [0] * D
    e[i] = 1
    return {tuple(e): Q(1)}


def add(*args: Poly) -> Poly:
    out: Poly = {}
    for p in args:
        for e, c in p.items():
            out[e] = out.get(e, Q(0)) + c
            if not out[e]:
                del out[e]
    return out


def scale(p: Poly, c: int | Q) -> Poly:
    return {e: d * c for e, d in p.items() if d * c}


def mul(*args: Poly) -> Poly:
    out = constant(1)
    for p in args:
        new: Poly = {}
        for e, c in out.items():
            for f, d in p.items():
                ef = tuple(a + b for a, b in zip(e, f))
                new[ef] = new.get(ef, Q(0)) + c * d
        out = {e: c for e, c in new.items() if c}
    return out


def power(p: Poly, n: int) -> Poly:
    return mul(*([p] * n))


def determinant(m: list[list[Poly]]) -> Poly:
    n = len(m)
    terms = []
    for p in permutations(range(n)):
        parity = sum(p[i] > p[j] for i in range(n) for j in range(i + 1, n))
        terms.append(scale(mul(*(m[i][p[i]] for i in range(n))), (-1) ** parity))
    return add(*terms)


def local_identities() -> dict:
    x, a, b, t, y, z = [var(i) for i in range(D)]
    # Norm of z_local^2+a*z_local+b in z_local^3=x.
    matrix = [[b, x, mul(a, x)], [a, b, x], [constant(1), a, b]]
    cubic_norm = add(power(x, 2), mul(add(power(a, 3), scale(mul(a, b), -3)), x), power(b, 3))
    assert determinant(matrix) == cubic_norm
    discriminant = add(power(add(power(a, 3), scale(mul(a, b), -3)), 2), scale(power(b, 3), -4))
    factorized = mul(add(power(a, 2), scale(b, -4)), power(add(power(a, 2), scale(b, -1)), 2))
    assert discriminant == factorized
    assert (Q(1) - Q(1, 4)) ** 2 == Q(9, 16)
    # Conjugate collision: y=b+d and z=b-d.
    b1 = scale(add(y, z), Q(1, 2))
    b2 = scale(add(y, scale(z, -1)), Q(1, 2))
    q1 = add(power(add(x, scale(t, -1)), 2), scale(b1, -1))
    q2 = add(power(add(x, t), 2), scale(b2, -1))
    j = add(power(x, 2), scale(power(t, 2), -1), scale(y, Q(-1, 2)))
    difference = add(mul(q1, q2), scale(power(j, 2), -1))
    expected = add(scale(mul(t, z, x), -2), scale(add(power(z, 2), scale(mul(power(t, 2), y), 8)), Q(-1, 4)))
    assert difference == expected
    # Coefficient matrix for the ordinary-component ideal (z,y).
    m = [[t, {}], [z, scale(power(t, 2), 8)]]
    assert determinant(m) == scale(power(t, 3), 8)
    return {
        'coefficient_ring': 'Z[1/2]; identities checked exactly over Q, valid in characteristic 5',
        'branch_norm_determinant': True,
        'branch_discriminant_factorization': True,
        'branch_contact_order': 4,
        'branch_contact_unit': '9/16',
        'collision_complete_square_equations': ['t*z', 'z^2+8*t^2*y'],
        'collision_product_identity': True,
        'collision_contact_order': 3,
        'collision_contact_unit': 8,
    }


def component_degrees(n: int, g: int) -> list[int]:
    d = n - g
    # Coefficients of 2^d*(1+z)^d*(4+z)^g, directly by convolution.
    out = [0] * (n + 1)
    for i in range(d + 1):
        for j in range(g + 1):
            out[i + j] += (2 ** d) * comb(d, i) * comb(g, j) * 4 ** (g - j)
    # Independent intersection-sum formula, including the union at s=0.
    for s, value in enumerate(out):
        e = n - s
        total = sum(comb(d, e - i) * comb(g, i) * 4 ** i
                    for i in range(g + 1) if 0 <= e - i <= d)
        assert value == (2 ** d) * total
    assert sum(2 ** s * v for s, v in enumerate(out)) == 6 ** n
    assert sum(out) == 2 ** (2 * d) * 5 ** g
    assert out[0] == 2 ** (2 * g) * 2 ** d
    assert out[-1] == 2 ** d
    return out


def main() -> None:
    if sys.flags.optimize:
        raise RuntimeError('Assertions must be enabled.')
    n, g = 70, 9
    coeffs = component_degrees(n, g)
    local = local_identities()
    b = g + 2
    canonical_exponent = 5 * n + 2 * g + 1
    contact_degree = canonical_exponent + (n - g + 1)
    assert contact_degree == 6 * n + g + 2 == 4 * b + 3 * (2 * n - b)
    data = {
        'scope': 'Ambient projective norm-square scheme, NOT the three-parameter source intersection',
        'n': n, 'g': g, 'dimension': n - g,
        'component_degree_polynomial': '2^61*(1+z)^61*(4+z)^9',
        'coefficients_ascending_z': coeffs,
        's0_convention': 'Coefficient zero is the sum over all 2^18 torsion components',
        'generic_scheme_multiplicity_on_s': '2^s',
        'scheme_degree': 6 ** n,
        'reduced_degree': 2 ** (2 * (n - g)) * 5 ** g,
        'canonical_exponent_for_M': canonical_exponent,
        'contact_divisor': {'branch_hyperplanes': b, 'branch_weight': 4,
                            'conjugate_pair_degree': 2 * n - b, 'pair_weight': 3,
                            'total_degree': contact_degree},
        'local_identities': local,
    }
    (ROOT / 'intersection/data/ambient_geometry.json').write_text(json.dumps(data, indent=2) + '\n')
    summary = {
        'status': 'PASS', 'integer_component_coefficients_checked': len(coeffs),
        'scheme_degree_matches_weighted_sum': True,
        'reduced_degree_matches_unweighted_sum': True,
        'local_models': 'Exact symbolic identities; no parameter sampling',
        'adjunction_contact_balance': '4*11+3*129=431',
        'geometric_proofs': 'REPORT.md; not inferred from arithmetic identities alone',
        'source_square_decision': 'UNRESOLVED',
    }
    (ROOT / 'intersection/evidence/geometry_checks.json').write_text(json.dumps(summary, indent=2) + '\n')
    print(json.dumps(summary, indent=2))


if __name__ == '__main__':
    main()
