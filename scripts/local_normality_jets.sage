"""Exact finite-field checks for the active local-normality package.

Run: sage scripts/local_normality_jets.sage
This checks formulas and corrections, not the HKG theorem or atlas existence.
"""
set_random_seed(20260906)

# Controlled Newton correction in several characteristics and wild orders.
checks = 0
for p in [2, 3, 5, 7]:
    for e in [p, 2*p, p*p]:
        for offset in [1, p+1, 2*p+1]:
            Q = e + offset
            delta = Q-1
            N = max(delta+2, 2*delta-e+3)
            target = N+20
            R = PowerSeriesRing(GF(p), 'z', default_prec=4*target+4*delta)
            z = R.gen().add_bigoh(4*target+4*delta)
            f = z^e+z^Q
            g = f+z^N+z^(N+3)+z^(N+8)
            x = z
            for iteration in range(30):
                error = g-f(x)
                if error.valuation() >= target:
                    break
                previous = error.valuation()
                x += error/f.derivative()(x)
                assert (g-f(x)).valuation() > previous
            assert (g-f(x)).valuation() >= target
            assert (x-z).valuation() >= N-delta
            checks += 1
print('Controlled correction tests passed:', checks, flush=True)

# Hermitian models and the invariant in arbitrary source coordinates.
K = GF(5^4, 'a')
R = PowerSeriesRing(K, 'z', default_prec=3500)
z = R.gen().add_bigoh(3500)
w = z^5
for i in range(5):
    w = z^5-z^4*w^5
assert (w+z^4*w^5-z^5).valuation() >= 3500
for t in [8, 24]:
    E, A, B = 125*t, 120, 144
    F = w^(25*t)/(1-w^24)^t
    assert F.valuation() == E
    assert F.derivative().valuation() == E+B-1
    supported = [(j,F[j]) for j in range(E,E+B+1) if F[j]]
    assert supported == [(E,K(1)),(E+A,K(t)),(E+B,K(t))]
    r = 24//t
    for repetition in range(3):
        scalar = K.random_element()
        leading = K.random_element()
        while not scalar: scalar = K.random_element()
        while not leading: leading = K.random_element()
        phi = leading*z+sum(K.random_element()*z^j for j in range(2,13))
        g = scalar*F(phi)
        invariant = g[E]^r*(g[E+A]/g[E+B])^125
        assert invariant == scalar^r
        short = R(phi.polynomial().truncate(7))
        assert (F(phi)-F(short)).valuation() >= E+B+6
    print('Hermitian case:', t, 'support:', supported,
          'determinacy degree:', E+B+5, 'source degree:', 6,
          'scalar invariant and short-jet checks passed', flush=True)
