#!/usr/bin/env python3
"""Small exact input checks for the three focused Pro requests.

This does not execute any of the requested new research calculations.
No generated data are written into the research workspace.
"""

from pathlib import Path
import sys


def rank_mod5(columns, dimension):
    basis = {}
    for column in columns:
        v = [int(a) % 5 for a in column]
        for pivot in sorted(basis):
            if v[pivot]:
                c = v[pivot]
                v = [(a - c * b) % 5 for a, b in zip(v, basis[pivot])]
        pivot = next((i for i, a in enumerate(v) if a), None)
        if pivot is not None:
            inverse = pow(v[pivot], -1, 5)
            basis[pivot] = [(a * inverse) % 5 for a in v]
    assert all(len(v) == dimension for v in basis.values())
    return len(basis)


def mul(a, b, precision):
    c = [0] * precision
    for i, x in enumerate(a):
        for j, y in enumerate(b[: precision - i]):
            c[i + j] = (c[i + j] + x * y) % 5
    return c


def profile(branch_terms):
    """Evaluate A[y]/prod(y-phi_i) inside A^3 modulo a conductor bound."""
    initial_precision = 2 + 2 * max(i for branch in branch_terms for i in branch)
    branches = [
        [branch.get(i, 0) % 5 for i in range(initial_precision)]
        for branch in branch_terms
    ]
    contacts = [
        next(i for i in range(initial_precision) if branches[j][i] != branches[k][i])
        for j, k in [(0, 1), (0, 2), (1, 2)]
    ]
    conductor = [
        contacts[0] + contacts[1],
        contacts[0] + contacts[2],
        contacts[1] + contacts[2],
    ]
    precision = max(conductor)
    branches = [p[:precision] for p in branches]
    columns = []
    powers = [[1] + [0] * (precision - 1) for _ in range(3)]
    for degree in range(3):
        for shift in range(precision):
            columns.append(
                sum(([0] * shift + p[: precision - shift] for p in powers), [])
            )
        powers = [mul(p, b, precision) for p, b in zip(powers, branches)]
    dimension = 3 * precision
    rank = rank_mod5(columns, dimension)
    delta = sum(contacts)
    assert dimension - rank == delta
    kernels = []
    for e in [1, 2, 3]:
        q = 5**e
        image = []
        for branch in range(3):
            for exponent in range(0, precision, q):
                column = [0] * dimension
                column[branch * precision + exponent] = 1
                image.append(column)
        image_rank = rank_mod5(columns + image, dimension) - rank
        kernels.append(delta - image_rank)
    return contacts, conductor, delta, kernels


def check_polynomial_inputs():
    """Run with sage -python and --with-sage for the third prompt's inputs."""
    from sage.all import GF, PolynomialRing

    base = PolynomialRing(GF(5), "z")
    z = base.gen()
    k = GF(125, name="alpha", modulus=z**3 + z + 1)
    alpha = k.gen()
    polynomials = PolynomialRing(k, "u")
    u = polynomials.gen()
    f_base = u * (u - 1) * (u - 2) * (u - 3) * (u - alpha)
    assert list(f_base) == [0, alpha, 4 - alpha, 1 + alpha, 4 - alpha, 1]

    parameters = PolynomialRing(k, "T")
    t = parameters.gen()
    a0, a1, a2, a3, a4 = [f_base[i] for i in range(5)]
    w = t**2 + 3 * a4 * t + 3 * a3
    v = -a2 + (a4 + 2 * t) * w
    psi = 2 * a0 - 2 * a1 * t + a2 * w - v * w
    assert psi.degree() == 5
    assert psi.is_irreducible()
    assert psi.gcd(psi.derivative()) == 1

    field = k.extension(psi, "tau")
    tau = field.gen()
    extended = PolynomialRing(field, "u")
    u = extended.gen()
    f = extended(f_base)
    w = tau**2 + 3 * a4 * tau + 3 * a3
    v = -a2 + (a4 + 2 * tau) * w
    potential = (
        2 * (f.derivative() / f) ** 2 - f.derivative(2) / f
        + (2 * u**3 + tau * u**2 + w * u + v) / f
    )
    assert potential.derivative(2) == 3 * potential**2

    two_variables = PolynomialRing(k, names=("x", "y"))
    x, y = two_variables.gens()
    c = [a**5 for a in list(f_base)]
    polar = (
        2 * c[0] + c[1] * (x + y) + 2 * c[2] * x * y
        + c[3] * x * y * (x + y) + 2 * c[4] * x**2 * y**2
        + c[5] * x**2 * y**2 * (x + y)
    )
    assert polar.subs({y: x}) == 2 * sum(c[i] * x**i for i in range(6))
    print("PASS endpoint coefficients, quintic, dormant identity, Kummer diagonal identity")


def main():
    examples = [
        ("equal contacts", [{1: 1}, {1: 1, 5: 1}, {1: 1, 5: 2}], [12, 13, 13]),
        ("changed sixth jet", [{1: 1}, {1: 1, 5: 1}, {1: 1, 5: 2, 6: 1}], [11, 13, 13]),
        ("unequal contacts", [{1: 1}, {1: 1, 5: 1}, {1: 1, 5: 1, 26: 1}], [27, 33, 34]),
    ]
    for name, branches, expected in examples:
        result = profile(branches)
        if expected is not None:
            assert result[-1] == expected, (name, result)
        print(name, result)

    ending = (
        "continue working on this until you complete the task. dont be lazy, "
        "quality and completeness are more important than speed, take as much time as you need"
    )
    root = Path(__file__).resolve().parents[2]
    for path in sorted((root / "Research/requests/focused_2026_09_16").glob("[0-9]*.md")):
        text = path.read_text()
        assert text.rstrip().endswith(ending), path
        assert not any(ord(c) < 32 and c != "\n" for c in text), path
        assert text.count(r"\(") == text.count(r"\)"), path
        assert text.count(r"\[") == text.count(r"\]"), path
        assert chr(96) * 3 not in text, path
        lines = text.splitlines()
        for i, line in enumerate(lines):
            if line == r"\[":
                j = next(j for j in range(i + 1, len(lines)) if lines[j] == r"\]")
                assert not (i > 0 and j + 1 < len(lines)
                            and lines[i - 1] == "" and lines[j + 1] == ""), path
        print(path.name, len(text.split()), "words;", len(text.encode()), "bytes")
    if "--with-sage" in sys.argv:
        check_polynomial_inputs()


if __name__ == "__main__":
    main()
