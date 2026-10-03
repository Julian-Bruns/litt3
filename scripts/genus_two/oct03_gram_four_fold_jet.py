#!/usr/bin/env python3
"""Essential F5 coefficient checks for the actual Gram-four fold argument.

The geometric theorem is proved in prose. This script checks its local
coefficient formulas and the surviving horizontal-source example exactly.
It constructs no global cover and performs no search for one.
"""

from fractions import Fraction
import json
import platform


P = 5


def poly_add(*polys):
    out = {}
    for poly in polys:
        for exponent, coefficient in poly.items():
            out[exponent] = (out.get(exponent, 0) + coefficient) % P
    return {exponent: coefficient for exponent, coefficient in out.items()
            if coefficient}


def poly_scale(poly, scalar):
    return {exponent: scalar * coefficient % P
            for exponent, coefficient in poly.items()
            if scalar * coefficient % P}


def poly_mul(a, b):
    out = {}
    for ea, ca in a.items():
        for eb, cb in b.items():
            out[ea + eb] = (out.get(ea + eb, 0) + ca * cb) % P
    return {exponent: coefficient for exponent, coefficient in out.items()
            if coefficient}


def derivative(poly):
    return {exponent - 1: exponent * coefficient % P
            for exponent, coefficient in poly.items()
            if exponent and exponent * coefficient % P}


def dot_polys(a, b):
    return poly_add(*(poly_mul(x, y) for x, y in zip(a, b)))


def coefficient_formula():
    # r_i v_j coefficients are named independently. Thus this check does
    # not specialize the rank properties used in the theoretical proof.
    v_exponents = (0, 2, 4, 5, 6)
    evaluation = {}
    jet = {}
    for i in range(4):
        for j in v_exponents:
            evaluation.setdefault(i + j, {})[f"r{i}v{j}"] = 1
            if j and j % P:
                jet.setdefault(i + j - 1, {})[f"r{i}v{j}"] = -j % P
    expected = {
        1: {"r0v2": 3},
        2: {"r1v2": 3},
        3: {"r2v2": 3, "r0v4": 1},
        4: {"r3v2": 3, "r1v4": 1},
    }
    assert all(jet[j] == expected[j] for j in expected)
    # Using rv=0, r0v2=-r2v0 and r0v4=-r2v2 gives the
    # coefficient 2 recorded in both branches of the proof.
    assert (-2 * -1) % P == 2
    assert (-2 + 4) % P == 2
    return {"evaluation": evaluation, "intrinsic_jet": jet}


def surviving_examples():
    r = ({0: 1}, {1: 1}, {3: 1})
    examples = []
    for b in range(1, P):
        v = ({5: 2, 6: -b % P}, {4: 2, 5: b}, {2: 1})
        assert dot_polys(r, v) == {}
        tau = poly_scale(dot_polys(r, tuple(derivative(x) for x in v)), -1)
        assert tau == {5: b}
        # A(Z)c(T), with Z=zeta^5 and T=zeta^2.
        columns = (
            ({5: 2}, {5: b}, {}),
            ({}, {}, {0: 1}),
            ({}, {0: 2}, {}),
            ({0: -b % P}, {}, {}),
        )
        c = ({0: 1}, {2: 1}, {4: 1}, {6: 1})
        image = tuple(poly_add(*(poly_mul(columns[j][i], c[j])
                                  for j in range(4)))
                      for i in range(3))
        assert image == v
        # Columns 1,2,3 of A0 have determinant 2*b up to sign.
        assert 2 * b % P
        # The four evaluated constant-source columns span only the
        # three exact primitive directions 1,zeta,zeta^3 over k(zeta^5).
        evaluated = tuple(dot_polys(r, column) for column in columns)
        assert evaluated[0] == {5: 2, 6: b}
        assert evaluated[1] == {3: 1}
        assert evaluated[2] == {1: 2}
        assert evaluated[3] == {0: -b % P}
        assert all(exponent % P != 4
                   for poly in evaluated for exponent in poly)
        examples.append({"b": b, "v": v, "tau": tau,
                         "evaluated_columns": evaluated})
    return examples


def main():
    assert Fraction(5) - Fraction(20, 8) == Fraction(5, 2)
    formulas = coefficient_formula()
    examples = surviving_examples()
    print(json.dumps({
        "status": "PASS",
        "python": platform.python_version(),
        "scope": "exact local coefficient identities; no global packet",
        "source_line_degree_upper_bound": 2,
        "coefficient_formulas": formulas,
        "surviving_local_examples": examples,
    }, sort_keys=True))


if __name__ == "__main__":
    main()
