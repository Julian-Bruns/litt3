#!/usr/bin/env python3
"""Exact certificate for a restricted two-point Bol calculation.

Proved scope: a=4 and two DISTINCT WEIERSTRASS points.  This program does
NOT certify the assertion for other a, or for arbitrary reduced divisors.

Curve on C: y^2 = x^5-x.  Relative Frobenius remains x |-> u^5,
y |-> v^5. All polynomial arithmetic below is exact in characteristic 5.

The program verifies the four actual rational Hom matrices for each
nonzero t in F_5, their lattice conditions, their residues, and the
incompatibility of the four section conditions on P^1 x P^1.

Dependency: SymPy.  Run: python bol_two_point_weierstrass_certificate.py
"""
from __future__ import annotations

import sympy as sp

x, y, z, u = sp.symbols("x y z u")
A, B, R, S = sp.symbols("A B R S")


def mod5_rational(value: sp.Expr) -> int:
    """Reduce a rational NUMBER whose denominator is prime to 5."""
    numerator, denominator = sp.fraction(sp.cancel(value))
    n, d = int(numerator), int(denominator)
    if d % 5 == 0:
        raise ValueError("Denominator is not invertible modulo 5.")
    return n % 5 * pow(d % 5, -1, 5) % 5


def poly5(expr: sp.Expr, *variables: sp.Symbol) -> sp.Expr:
    return sp.Poly(sp.expand(expr), *variables, modulus=5).as_expr()


def local_series(expr: sp.Expr, branch_x: int) -> dict[int, int]:
    """Coefficients needed at W=(branch_x,0), with parameter y=z.

    The exact expansion is x=branch_x-z^2-z^10-... . Replacing it by
    branch_x-z^2 leaves all coefficients used below unchanged: the
    worst pole has order four, and we use only coefficients below four.
    """
    substituted = expr.subs({x: branch_x-z*z, y: z})
    expanded = sp.series(substituted, z, 0, 4).removeO().expand()
    return {j: mod5_rational(expanded.coeff(z, j)) for j in range(-5, 4)}


def rational_hom_basis(t: int) -> list[sp.Matrix]:
    """Maps V_0 -> V_t(W_0+infinity), in their rational Bol frames."""
    it = pow(t, -1, 5)
    den = x*(x+t)**2
    return [
        sp.Matrix([
            [y*(x+3*t)/den, -it],
            [-it*x/(x+t)**2, 0],
        ]),
        sp.Matrix([
            [x/(x+t), 0],
            [t*y*(-x+2*t)/den, 1],
        ]),
        sp.Matrix([
            [(3*t*t*x-it)/(x+t), 3*y/(x+t)**2],
            [2*y/den, 1/(x+t)**2],
        ]),
        sp.Matrix([
            [-y/(x*(x+t)), 2/(x+t)],
            [t*t*(x+3*t)/(x+t), y/(x+t)**2],
        ]),
    ]


def residues_and_lattices(matrix: sp.Matrix, t: int) -> tuple[sp.Matrix, sp.Matrix]:
    """Check all nontrivial finite lattice conditions; compute residues."""
    at_zero = [[local_series(matrix[r,c], 0) for c in range(2)] for r in range(2)]
    at_target = [[local_series(matrix[r,c], -t) for c in range(2)] for r in range(2)]

    # At W_{-t}, the target frame is f=e_2/y,
    # g=e_1/y^3-3e_2/y^4. Thus y^3*m_1 and 3*m_1+y*m_2
    # must be regular, separately for each column.
    for c in range(2):
        assert all(at_target[0][c][j] == 0 for j in (-5, -4))
        assert at_target[1][c][-5] == 0
        for j in (-4, -3, -2, -1):
            assert (3*at_target[0][c][j] + at_target[1][c][j-1]) % 5 == 0

    # At W_0 the source has the analogous (f_0,g_0) frame.
    # Allowing one pole means column 2 is regular, and
    # y*column 1-3*column 2 is divisible by y^3.
    rp = sp.zeros(2)
    for r in range(2):
        assert all(at_zero[r][0][j] == 0 for j in (-5, -4, -3, -2))
        assert all(at_zero[r][1][j] == 0 for j in (-5, -4, -3, -2, -1))
        for j in (0, 1, 2):
            assert (at_zero[r][0][j-1] - 3*at_zero[r][1][j]) % 5 == 0
        rp[r,0] = at_zero[r][1][0]
        rp[r,1] = (at_zero[r][0][2] - 3*at_zero[r][1][3]) % 5

    # At infinity, z_infinity=x^2/y, so x~z_infinity^-2,
    # y~z_infinity^-5. Only the coefficient of z_infinity^-1 is
    # needed, and this substitution computes it exactly.
    rq = sp.zeros(2)
    for r in range(2):
        for c in range(2):
            e = matrix[r,c].subs({x:z**-2, y:z**-5})
            series = sp.series(e, z, 0, 1).removeO().expand()
            for power in (-5, -4, -3, -2):
                assert mod5_rational(series.coeff(z,power)) == 0
            rq[r,c] = mod5_rational(series.coeff(z,-1))
    return rp, rq


def residue_transport(q: sp.Matrix, t: int) -> sp.Matrix:
    a,b,c,d = q[0,0], q[0,1], q[1,0], q[1,1]
    it = pow(t, -1, 5)
    return sp.Matrix([
        [it*(d-a), t*b+it*it*c],
        [2*t*t*b-it*c, t*(a+2*d)],
    ]).applyfunc(lambda entry: int(entry) % 5)


def main() -> None:
    f = u**5-u
    for t in range(5):
        H=(u+t)**4+3
        K=(u+t)**2
        potential_numerator=2*(u+t)**3
        # b=H/f solves Bol; b=v*K/f solves it via the odd equation.
        assert poly5(f*sp.diff(H,u,2)+2*sp.diff(H,u)-potential_numerator*H,u)==0
        assert poly5(f*sp.diff(K,u,2)+sp.diff(K,u)-potential_numerator*K,u)==0
        wronskian_polynomial=2*f*(H*sp.diff(K,u)-sp.diff(H,u)*K)-H*K
        assert poly5(wronskian_polynomial-(u+t)**10,u)==0

    # The F_5-defined translations and inversion permute the actual
    # projective connections. Their Mobius Schwarzian derivatives vanish.
    def potential(t: int) -> sp.Expr:
        return 2/f**2+2*(u+t)**3/f
    for t in range(5):
        transformed=potential(t).subs(u,1/u)/u**4
        numerator,_=sp.fraction(sp.cancel(transformed-potential((3*t**3)%5)))
        assert poly5(numerator,u)==0
        for b in range(5):
            numerator,_=sp.fraction(sp.cancel(potential(t).subs(u,u+b)
                                             -potential((t+b)%5)))
            assert poly5(numerator,u)==0

    for t in (1,2,3,4):
        residue_pairs=[residues_and_lattices(m,t) for m in rational_hom_basis(t)]
        for rp,rq in residue_pairs:
            assert rp==residue_transport(rq,t)
        rq_columns=sp.Matrix.hstack(*[sp.Matrix(list(rq)) for _,rq in residue_pairs])
        assert int(rq_columns.det()) % 5 != 0  # independence of the four actual maps

        # The two quotient covectors are (A,B) at W_0 and (R,S) at infinity.
        constraints=sp.Matrix.hstack(*[
            sp.Matrix.vstack(B*rp[:,0]-A*rp[:,1], S*rq[:,0]-R*rq[:,1])
            for rp,rq in residue_pairs
        ])
        actual=poly5(constraints.det(),A,B,R,S)
        expected=poly5(-2*A*A*R*R+2*t*A*B*R*S+t*t*B*B*S*S
                      +t**3*(2*B*B*R*R-A*A*S*S), A,B,R,S)
        assert actual==expected
        print(f"t={t}: actual Hom lattices, residues, and determinant verified")

    # Four distinct nonzero t force every coefficient of the cubic to vanish.
    # The resulting projective system has no point over ANY extension of F_5.
    # Check all four standard affine charts, not just finite-field points.
    equations=[A*A*R*R, A*B*R*S, B*B*S*S, 2*B*B*R*R-A*A*S*S]
    for source_normalization in (A,B):
        for target_normalization in (R,S):
            substitution={source_normalization:1,target_normalization:1}
            variables=tuple(v for v in (A,B,R,S) if v not in substitution)
            ideal=sp.groebner([e.subs(substitution) for e in equations], *variables,
                             modulus=5)
            assert len(ideal.polys)==1 and ideal.polys[0].as_expr()==1
    print("All four projective charts have unit ideal: no common modification.")
    print("SCOPE: a=4, distinct Weierstrass modification points only.")
    print("No claim is made here for the general reduced-divisor problem.")


if __name__ == "__main__":
    main()
