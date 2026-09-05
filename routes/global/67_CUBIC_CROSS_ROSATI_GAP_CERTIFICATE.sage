"""
Exact certificate for file 67.

Run with

    sage 67_CUBIC_CROSS_ROSATI_GAP_CERTIFICATE.sage

The calculation constructs the 125-Frobenius Jacobi sum, forms the two
global coefficient ideals forced by integrality at every finite prime, and
enumerates all vectors of weighted Rosati norm less than 107.  Everything
below is exact: finite fields, number fields, fractional ideals, traces, and
the integral quadratic-form enumeration.
"""

# The 125-Frobenius Jacobi sum of Y: z^2 = 1 - t^31.
F125.<a> = GF(125)
generator = F125.multiplicative_generator()
K.<zeta> = CyclotomicField(31)
OK = K.ring_of_integers()


def chi(x):
    if x == 0:
        return K(0)
    return zeta^(ZZ(x.log(generator)) % 31)


def quadratic_character(x):
    if x == 0:
        return ZZ(0)
    return (-1)^ZZ(x.log(generator))


pi = -sum(chi(x) * quadratic_character(1 - x) for x in F125)

ZZU.<U> = PolynomialRing(ZZ)
expected_minpoly = (
    U^10 - 10*U^9 + 169*U^8 - 120*U^7 - 4750*U^6
    + 278500*U^5 - 593750*U^4 - 1875000*U^3
    + 330078125*U^2 - 2441406250*U + 30517578125
)
assert pi.minpoly().change_ring(ZZ).list() == expected_minpoly.list()
sigma = K.hom([zeta^5], K)
assert sigma(pi) == pi

# The ten primes of E above 5 become the ten primes of K displayed here;
# K/E is unramified cubic at each one.  The valuation m_P of pi is three
# times the Newton slope at that central factor.
five = OK.fractional_ideal(5)
five_primes = [P for P, exponent in five.factor()]
assert len(five_primes) == 10
assert all(P.norm() == 125 for P in five_primes)
pi_ideal = OK.fractional_ideal(pi)
valuations = [pi_ideal.valuation(P) for P in five_primes]
assert sorted(valuations) == [0, 0, 1, 1, 1, 2, 2, 2, 3, 3]

# D_{K/E} = (1-zeta)^2.  For s=1,2 the global coefficient ideal is
#
# D_{K/E}^{-1} product_{P|5} P^{-floor(s*m_P/3)}.
codifferent = OK.fractional_ideal(1 - zeta)^(-2)
coefficient_ideals = []
for s in (1, 2):
    ideal = codifferent
    for P, m in zip(five_primes, valuations):
        ideal *= P^(-(s*m // 3))
    coefficient_ideals.append(ideal)

conjugation = K.hom([zeta^-1], K)


def weighted_trace_gram(ideal, weight):
    basis = ideal.basis()
    gram = matrix(
        QQ,
        30,
        30,
        lambda i, j: weight * (basis[i] * conjugation(basis[j])).trace(),
    )
    assert gram == gram.transpose()
    assert gram.denominator() == 1
    assert gram.is_positive_definite()
    return matrix(ZZ, gram)


# The two summands xF and yF^2 have weights 5 and 25 respectively.
gram_1 = weighted_trace_gram(coefficient_ideals[0], 5)
gram_2 = weighted_trace_gram(coefficient_ideals[1], 25)


def exact_minimum_below_107(gram):
    # Sage's QuadraticForm convention is Q(v)=v^T A v/2, hence 2*gram.
    # LLL_gram returns a unimodular basis transformation and only speeds up
    # the subsequent exact PARI enumeration; it does not change the lattice.
    transform = (2 * gram).LLL_gram()
    assert abs(transform.det()) == 1
    reduced_gram = transform.transpose() * gram * transform
    form = QuadraticForm(ZZ, 2 * reduced_gram)
    vectors_by_norm = form.short_vector_list_up_to_length(107)
    nonzero_lengths = [
        n for n in range(1, len(vectors_by_norm)) if vectors_by_norm[n]
    ]
    assert nonzero_lengths == [106]
    return 106, len(vectors_by_norm[106])


minimum_1, number_1 = exact_minimum_below_107(gram_1)
minimum_2, number_2 = exact_minimum_below_107(gram_2)
assert minimum_1 == minimum_2 == 106

print("Frobenius valuations at 5:", sorted(valuations))
print("minimum of 5 Tr(x*xbar) on I_1 minus zero:", minimum_1)
print("minimum of 25 Tr(y*ybar) on I_2 minus zero:", minimum_2)
print("numbers of shortest coordinate vectors:", number_1, number_2)
