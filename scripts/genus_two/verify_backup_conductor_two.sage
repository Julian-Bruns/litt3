"""Verify both conductor-two atlas exclusions on the fixed genus-two backup.

The 16 twists are indexed by 0 (trivial), then the five individual finite
branch factors, then their ten pairs. Each has generic and infinity charts.
Default: all 32 charts. No files are written.
"""
import argparse
import itertools
import time

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("--twist", type=int, choices=range(16))
parser.add_argument("--chart", choices=("all", "generic", "infinity"), default="all")
parser.add_argument("--verbose", action="store_true")
args = parser.parse_args()

Z = PolynomialRing(GF(5), "z")
z = Z.gen()
k = GF(125, "alpha", modulus=z**3 + z + 1)
alpha = k.gen()
U0 = PolynomialRing(k, "u")
u0 = U0.gen()
roots = [k(0), k(1), k(2), k(3), alpha]
F0 = prod(u0 - a for a in roots)
twists = [()] + [(i,) for i in range(5)] + list(itertools.combinations(range(5), 2))

matrix_Q = matrix(k, 9, 6, lambda i,j:
    (F0*(u0**j).derivative() + F0.derivative()*u0**j/2)[i],
    implementation="generic")
assert matrix_Q.rank() == 6
rows = list(matrix_Q.transpose().pivots())
pivot = matrix_Q.matrix_from_rows(rows)
inverse = pivot.inverse()
assert pivot*inverse == identity_matrix(k, 6)

def run_chart(twist, chart):
    started = time.monotonic()
    factors = twists[twist]
    E0 = prod((u0-roots[i] for i in factors), U0(1))
    J0 = F0 // E0
    assert E0*J0 == F0
    m = len(factors)
    names = (("a0", "a1", "a2", "a3", "b0") if m == 0
             else ("a0", "a1", "a2", "b0", "b1"))
    R = PolynomialRing(k, names=names+("r0", "r1", "lam"), order="degrevlex")
    coefficients = R.gens()[:5]
    r0, r1, lam = R.gens()[5:]
    U = PolynomialRing(R, "u")
    u = U.gen()
    F, E, J = [U(list(h)) for h in (F0, E0, J0)]
    if m == 0:
        A = sum(coefficients[i]*u**i for i in range(4))
        B = U(coefficients[4])
        leading, next_leading = coefficients[3], coefficients[4]
    else:
        A = sum(coefficients[i]*u**i for i in range(3))
        B = coefficients[3]+coefficients[4]*u
        leading, next_leading = ((coefficients[4], coefficients[2]) if m == 1
                                 else (coefficients[2], coefficients[4]))

    rhs = E*A**2+J*B**2
    inverse_R = inverse.change_ring(R)
    assert pivot.change_ring(R)*inverse_R == identity_matrix(R, 6)
    Qcoeff = inverse_R*vector(R, [rhs[i] for i in rows])
    Q = sum(Qcoeff[i]*u**i for i in range(6))
    error = F*Q.derivative()+F.derivative()*Q/2-rhs
    assert all(error[i] == 0 for i in rows)
    quadrics = [c for c in error.list() if c]
    derivative_P = 2*A*B
    P = r0+r1*u**5+sum(derivative_P[i]*u**(i+1)/k(i+1) for i in range(4))
    assert P.derivative() == derivative_P
    normalization = ([leading-1, lam-3*Q[5]] if chart == "generic"
                     else [leading, next_leading-1])
    base = R.ideal(quadrics+normalization)
    gb = base.groebner_basis()
    if gb == [R(1)]:
        status = "unit"
    else:
        Rbar = R.quotient(base, names=R.variable_names())
        V = PolynomialRing(Rbar, "u")
        AA, BB, EE, JJ, PP, QQ = [V(h) for h in (A, B, E, J, P, Q)]
        lambda_value = Rbar(lam)
        N = EE*AA**2-JJ*BB**2
        if (m == 1 and chart == "generic") or (m in (0, 2) and chart == "infinity"):
            N = -N
        assert N.is_monic() and N.degree() == (6 if chart == "generic" else 5)

        # Form derivatives before reducing modulo the norm polynomial.
        C1 = JJ*BB.derivative()+JJ.derivative()*BB/2
        G1 = EE*AA.derivative()+EE.derivative()*AA/2
        C2 = JJ*G1.derivative()+JJ.derivative()*G1/2
        G2 = EE*C1.derivative()+EE.derivative()*C1/2
        L1 = (PP*EE**2*pow(C1, 5, N)+JJ**3*QQ*pow(G1, 5, N)
              -lambda_value*EE**2*pow(C2, 5, N)) % N
        L2 = (PP*JJ**2*pow(G1, 5, N)+EE**3*QQ*pow(C1, 5, N)
              -lambda_value*JJ**2*pow(G2, 5, N)) % N
        residuals = [(EE*AA*L1-JJ*BB*L2) % N, (AA*L2-BB*L1) % N]
        equations = [R(c.lift()) for h in residuals for c in h.list() if c]
        ideal = R.ideal(list(gb)+equations)
        answer = ideal.groebner_basis()
        if answer == [R(1)]:
            status = "unit"
        else:
            assert lam.reduce(answer) == 0, (twist, chart, answer)
            status = "zero_lambda"
    if args.verbose:
        print("PASS", "E="+str(E0), chart, status,
              "seconds="+str(round(time.monotonic()-started, 3)), flush=True)
    return status

indices = range(16) if args.twist is None else [args.twist]
charts = ("generic", "infinity") if args.chart == "all" else (args.chart,)
results = {(i,c): run_chart(i,c) for i in indices for c in charts}
for key, status in results.items():
    assert status == ("zero_lambda" if key == (5, "infinity") else "unit")
print("PASS:", len(results), "charts;",
      sum(s == "unit" for s in results.values()), "unit ideals;",
      sum(s == "zero_lambda" for s in results.values()), "forced zero lambda.")
