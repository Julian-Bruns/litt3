# Exact certificate for file 194.  Run with:
#   sage 194_HARD_U5_BASE_RESIDUAL_VERIFY.sage

F5 = GF(5)
Rt.<t> = PolynomialRing(F5)
K.<c> = GF(25, modulus=t^2-t+1)
Rx.<x> = PolynomialRing(K)
Rz.<z> = PolynomialRing(K)
Ru.<u> = PolynomialRing(K)

d = 1-c
A = (1-z)^31
B = z^32*(z-1)^2*(z+1)

common_U = {
    33: 4 + 4*x + (c+4)*x^2,
    32: 4 + 4*c*x,
    31: 2*c+2 + 2*x,
    30: 2,
    29: (3*c+1)*x^2,
}


def equation(epsilon):
    U = dict(common_U)
    if epsilon == 0:
        U[27] = 4*c+4 + (2*c+4)*x + (c+3)*x^2
        U[22] = 2*c+1
    else:
        U[28] = 1
        U[27] = 2 + (3*c+3)*x + (c+3)*x^2
        U[22] = 4*c+2

    aa = [Rx.zero() for _ in range(36)]
    aa[0] = (x-1)^2
    for j in range(1, 34):
        aa[j] = (1-x)*K(A[j]) + x*K(B[j]) + x*(x-1)*U.get(j, 0)
    aa[34] = x^3*(x^3 + 3*(c+1)*x^2 + (1+3*c+d)*x + 3)
    aa[35] = x^4*(x^2-x+1)

    # Exact profile boundaries, the trace coefficient of file 193, and
    # the infinity degree bounds.
    assert sum(aa[j](0)*z^j for j in range(36)) == A
    assert sum(aa[j](1)*z^j for j in range(36)) == B
    assert aa[0] == (x-1)^2
    assert aa[34] == x^3*(x^3+3*(c+1)*x^2+(c*d+3*c+d)*x+3*c*d)
    assert aa[35] == x^4*(x-c)*(x-d)
    assert sum((aa[j][6] if aa[j].degree() >= 6 else 0)*z^j for j in range(36)) == z^34*(z+1)
    bounds = [2, 3, 4] + [5]*31 + [6, 6]
    assert all(aa[j].degree() <= bounds[j] for j in range(36))
    return aa


def curve_coeff(Fs, w, degree):
    ww = sum(K(w[i])*u^i for i in range(len(w)))
    phi = sum(Ru(list(F))*ww^i for i, F in enumerate(Fs))
    return phi[degree]


def solve_simple(Fs):
    w = [K.zero()]*12
    w[1] = -K.one()
    for i in range(2, 12):
        w[i] = 0
        b0 = curve_coeff(Fs, w, i+3)
        w[i] = 1
        b1 = curve_coeff(Fs, w, i+3)-b0
        assert b1 != 0
        w[i] = -b0/b1
    assert all(curve_coeff(Fs, w, n) == 0 for n in range(4, 15))
    return w


def solve_repeated(Fs, slope):
    w = [K.zero()]*12
    w[1], w[2] = K.one(), K(slope)
    for i in range(3, 12):
        w[i] = 0
        b0 = curve_coeff(Fs, w, i+5)
        w[i] = 1
        b1 = curve_coeff(Fs, w, i+5)-b0
        assert b1 != 0
        w[i] = -b0/b1
    assert all(curve_coeff(Fs, w, n) == 0 for n in range(4, 17))
    return w


def inverse_coefficients(w):
    leading = w[1]
    h = [K.one()] + [w[i]/leading for i in range(2, 12)]
    inv = [K.one()]
    for n in range(1, 11):
        inv.append(-sum(h[i]*inv[n-i] for i in range(1, n+1)))
    return {i-1: inv[i]/leading for i in range(11)}


def residual(w, m):
    zz = inverse_coefficients(w)
    return zz[m]^5-sum(zz[5*m+j] for j in range(5))


expected = {
    0: ([c+3, 4*c+4, K(3)], K(0)),
    1: ([c+2, 2*c+4, 2*c+3], K(2)),
}

for epsilon in (0, 1):
    aa = equation(epsilon)
    Fs = [aa[35-i] for i in range(17)]

    # Direct second-blowup coefficient: P_0(y)=3y(y-1)(y-2).
    Ry.<y> = PolynomialRing(K)
    PS.<v> = PowerSeriesRing(Ry, default_prec=9)
    phi = sum(sum(K(F[r])*v^r for r in range(len(F.list()))) *
              (v+v^2*y)^i for i, F in enumerate(Fs))
    assert phi[7] == 3*y*(y-1)*(y-2)

    simple = solve_simple(Fs)
    repeated = [solve_repeated(Fs, s) for s in (0, 1, 2)]
    assert residual(simple, 0) == 0
    assert [residual(w, 0) for w in repeated] == [0, 0, 0]
    assert residual(simple, 1) == 0
    values = [residual(w, 1) for w in repeated]
    assert values == expected[epsilon][0]

    # Here a=-cd=4 and gamma=2a=3.  File 193 identifies this with
    # lambda(p^{-1}b_5) after the simple solve.
    exceptional_scalar = 3*sum(values)
    assert exceptional_scalar == expected[epsilon][1]
    print(epsilon, values, exceptional_scalar)
