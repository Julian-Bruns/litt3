#!/usr/bin/env python3
"""Exact certificate for the degree-one Lagrangian locus.

Run with Python 3 and SymPy:  python verify.py
All computations use polynomial arithmetic over F_5, retaining alpha as
an indeterminate t with the equation t^3+t+1. No finite-field search,
extension-field sampling, floating point, or precomputed equation list is used.
"""
from itertools import product
from sympy.polys.rings import ring
from sympy.polys.domains import GF
from sympy.polys.groebnertools import groebner


def coefficients(poly, variable):
    """Coefficients, still represented in the same polynomial ring."""
    i = poly.ring.gens.index(variable)
    out = {}
    for monomial, value in poly.items():
        exponent = monomial[i]
        reduced_monomial = monomial[:i] + (0,) + monomial[i + 1:]
        out.setdefault(exponent, poly.ring.zero)[reduced_monomial] = value
    return out


def recurrence(R, u, Delta, A0, C0, B0, f, reduce):
    """N_n=(X_n+Y_n/v)/Delta^n for N_{n+1}=N_n'+tau*N_n."""
    X, Y = R.one, R.zero
    for n in range(4):
        X, Y = (
            reduce(Delta * X.diff(u) + (A0 - n * Delta.diff(u))*X + B0*Y),
            reduce(Delta * Y.diff(u) + (C0 - n * Delta.diff(u))*Y + B0*f*X),
        )
    return X, Y


def monic_divide(poly, factors, reduce):
    for factor, exponent in factors:
        for _ in range(exponent):
            quotient, remainder = poly.div(factor)
            assert not reduce(remainder), "Claimed structural factor is absent"
            poly = reduce(quotient)
    return poly


def verify_functions():
    R, v, x, t = ring('v,x,t', GF(5))
    S = t + 1
    f = (x**4 - 1)*(x - S)
    moduli = [v**2 - f, t**3 + t + 1]
    red = lambda p: p.rem(moduli)
    s0 = t**2 - 2
    invS = t**2 + 4*t + 2
    assert not red(s0**2 + S)
    assert red(S*invS) == R.one
    # The cubic defining k0 is irreducible because it has no F5 root.
    assert all((a**3 + a + 1) % 5 for a in range(5))

    def D(p):
        return red(v*p.diff(x) + 3*f.diff(x)*p.diff(v))

    for sign in (1, -1):
        s = sign*s0
        h = 2*x**5 + S*x**4 + 2*S + s*v*x**2
        h_conjugate = 2*x**5 + S*x**4 + 2*S - s*v*x**2
        assert not red(D(h) - s*x*h)
        assert not red(h*h_conjugate - 4*(x**5 - S)**2)
        q0 = 2*h**2*(s*x**2 - v)
        qx = (2*s*invS)*h**2  # 1/(2s)=2s/S, since s^2=-S.
        assert not red(D(q0) - h**2)
        assert not red(D(qx) - x*h**2)

        # P_sign=(t^25, sign*t^5) in u=x-1 coordinates.
        xp = red(t**25 + 1)
        vp = red(sign*t**5)
        evaluate_P = lambda p: red(p.compose(x, xp).compose(v, vp))
        assert not evaluate_P(v**2-f)
        assert not evaluate_P(h)
        assert evaluate_P(h_conjugate)
        assert not red(xp**5-S)
        assert not red((xp-1)**5-t)
        assert not red(vp**5-sign*t**25)
        assert evaluate_P(v)  # P_sign is not a branch point.

        # Frobenius image R_sign=(t, sign*t^25) lies on C.
        fC_at_R = t*(t-1)*(t-2)*(t-3)*(t-t**5)
        assert not red((sign*t**25)**2-fC_at_R)
    print('PASS: both h_s, their divisors, Frobenius images, and exact primitives')


def verify_affine():
    R, u, b, c, d, a, t = ring('u,b,c,d,a,t', GF(5))
    S = t+1
    f = u*(u-1)*(u-2)*(u-3)*(u-t)
    fa = a*(a-1)*(a-2)*(a-3)*(a-t)
    red = lambda p: p.rem([b*b-fa, t**3+t+1])
    Delta = (u-a)*f
    A0 = f-3*(u-a)*f.diff(u)
    C0 = f-(u-a)*f.diff(u)
    B0 = b+2*(u-a)*(c+d*u)
    X, Y = recurrence(R, u, Delta, A0, C0, B0, f, red)
    U = monic_divide(X, [(u-a, 2), (f, 2)], red)
    V = monic_divide(Y, [(u-a, 2), (f, 3)], red)
    assert U.degree(u) == 6 and V.degree(u) == 3
    assert not red(X-(u-a)**2*f**2*U)
    assert not red(Y-(u-a)**2*f**3*V)

    # The two leading coefficient equations eliminate b and a without
    # any parameter localization. Here c subsequently denotes e=c_old+a*d.
    U6 = coefficients(U, u)[6].compose(c, c-a*d)
    V3 = coefficients(V, u)[3].compose(c, c-a*d)
    assert not red(U6-(d**4+3*c*d+3*a*S+4*t**2+t+2))
    assert not red(V3-2*(b+c*(d*d+S)))
    invS = t**2+4*t+2
    a_form = ((3*d**4+4*c*d+2*t**2+3*t+1)*invS).rem([t**3+t+1])
    b_form = -c*(d*d+S)
    assert not U6.compose(a, a_form).rem([t**3+t+1])
    assert not V3.compose(b, b_form).rem([t**3+t+1])

    source_equations = []
    for p in (U, V, b*b-fa):
        p = p.compose(c, c-a*d).compose(b, b_form).compose(a, a_form)
        p = p.rem([t**3+t+1])
        source_equations.extend(q for q in coefficients(p, u).values() if q)

    R2, e, d2, t2 = ring('e,d,t', GF(5))
    generators = []
    for p in source_equations:
        assert all(m[0] == m[1] == m[4] == 0 for m in p)
        generators.append(R2.from_dict({(m[2], m[3], m[5]): v for m, v in p.items()}))
    cubic = t2**3+t2+1
    generators.append(cubic)
    generators.sort(key=lambda p: (max(map(sum, p)), len(p)))
    computed = groebner(generators, R2)
    S2 = t2+1
    E = d2**2+S2
    G1 = e**5-S2*d2*e**4-S2**2*e-S2*d2**5+(2*t2-1)*d2**3-(2*t2**2+1)*d2
    G2 = E*(e-2*d2**3+2*S2*d2)
    G3 = E**3
    expected = [G1.rem([cubic]), G2.rem([cubic]), G3.rem([cubic]), cubic]
    assert computed == expected, 'Unexpected affine Groebner basis'

    # Monic leading terms: e^5, e*d^2, d^6, t^3. Count the full quotient.
    leading = [g.LM for g in computed]
    standards = [m for m in product(range(5), range(6), range(3))
                 if not any(all(x >= y for x, y in zip(m, n)) for n in leading)]
    assert len(standards) == 42
    assert len(standards)//3 == 14  # Length over k0, not over F5.

    # This is the root classification of the ideal, not a point search.
    factored = (e-S2*d2)*(e**4-S2**2)
    assert not (G1-factored).rem([E, cubic])
    prod = R2.one
    for lam in (1, 2, 3, 4):
        prod *= e-lam*d2
    assert not (prod-(e**4-S2**2)).rem([E, cubic])
    # The five e-roots are distinct over each of the two d-roots.
    derivative = R2.from_dict({m: v for m, v in factored.diff(e).items() if v})
    assert groebner([factored, derivative, E, cubic], R2) == [R2.one]
    # None of the four F5^* ratios equals S; this also distinguishes alpha.
    assert groebner([S2**4-1, cubic], R2) == [R2.one]
    s0 = t2**2-2
    assert not (s0**2+S2).rem([cubic])

    # Verify all ten symbolic roots and their prescribed z=(a,b), c=d.
    for sign in (1, -1):
        sd = sign*s0
        for ratio in (R2.one, 2*R2.one, 3*R2.one, 4*R2.one, S2):
            evaluate = lambda p: p.compose(e, ratio*sd).compose(d2, sd).rem([cubic])
            assert all(not evaluate(g) for g in expected)
            az = ((3*d2**4+4*e*d2+2*t2**2+3*t2+1)*(t2**2+4*t2+2))
            assert not evaluate(az-(4+ratio))
            assert not evaluate(-e*E)
            assert not evaluate(e-(4+ratio)*d2-d2)
    print('PASS: affine recurrence and exact lex Groebner basis')
    print('      affine length over F125 = 14; support = 10 rational points')
    print('      four simple Weierstrass points per sign; one length-3 point per sign')
    return expected


def verify_infinity():
    R, u, c, d, t = ring('u,c,d,t', GF(5))
    f = u*(u-1)*(u-2)*(u-3)*(u-t)
    red = lambda p: p.rem([t**3+t+1])
    X, Y = recurrence(R, u, f, -3*f.diff(u), -f.diff(u), 2*(c+d*u), f, red)
    polys = []
    for p in (X, Y):
        polys.extend(q for q in coefficients(p, u).values() if q)
    R2, cc, dd, tt = ring('c,d,t', GF(5))
    polys2 = [R2.from_dict({m[1:]: v for m, v in p.items()}) for p in polys]
    G = groebner(polys2+[tt**3+tt+1], R2)
    assert G == [cc-dd, dd**2+tt+1, tt**3+tt+1]
    print('PASS: infinity fiber has precisely c=d, d^2=-(alpha+1)')

    # A regular chart at z=O uses r=1/a, w=b/a^3 and
    # C=c-b/(2a), D=d-b/(2a^2). Its curve equation gives dr=0 at O.
    # To first order beta=(C+D*u-w*u^2/2)*du/v, hence the B0 below.
    R, u, eps, C, D, W, t = ring('u,eps,C,D,W,t', GF(5))
    f = u*(u-1)*(u-2)*(u-3)*(u-t)
    red = lambda p: p.rem([eps**2, t**3+t+1])
    determinants = []
    for sign in (1, -1):
        s = sign*(t**2-2)
        B0 = 2*((s+eps*C)+(s+eps*D)*u)-eps*W*u**2
        X, Y = recurrence(R, u, f, -3*f.diff(u), -f.diff(u), B0, f, red)
        assert not X.evaluate(eps, 0) and not Y.evaluate(eps, 0)
        rows = []
        for degree in (2, 3, 5):
            linear = R.from_dict({(0, 0)+m[2:]: v for m, v in X.items()
                                  if m[0] == degree and m[1] == 1})
            rows.append([linear.diff(q) for q in (C, D, W)])
        A = rows
        determinant = red(A[0][0]*(A[1][1]*A[2][2]-A[1][2]*A[2][1])
                          -A[0][1]*(A[1][0]*A[2][2]-A[1][2]*A[2][0])
                          +A[0][2]*(A[1][0]*A[2][1]-A[1][1]*A[2][0]))
        assert determinant
        determinants.append(str(determinant.as_expr()))
    print('PASS: both infinity points have zero Zariski tangent space')
    print('      tangent determinants:', '; '.join(determinants))


def main():
    verify_functions()
    basis = verify_affine()
    verify_infinity()
    print('\nAffine Groebner basis over F5, with alpha represented by t:')
    for g in basis:
        print(' ', g.as_expr())
    print('\nCERTIFIED RESULT: 12 geometric points, all with residue field F125.')
    print('Natural zero-norm scheme: length 16 = 10 reduced points + 2 triple points.')
    print('The triple points lie over z=(alpha,0); all other support points are reduced.')


if __name__ == '__main__':
    main()

