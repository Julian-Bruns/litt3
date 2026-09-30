# Proof: short marked divisors exhaust all geometric coefficient vectors

Version2, 27 September2026. Use [the statement's fixed curve and coding](../../Theorems/cartier_and_spin/bounded_supported_norms.md).
The unbounded [missing-character theorem](supported_units_require_three_characters.md)
shows that every nonpolynomial supported function must contain all
three characters1,y,y^2. In particular its pole order is at least20.
We address the remaining exact poles20,...,28.

## Removing polynomial content is legitimate

Write g=U+Vy+Wy^2 with U,V,W polynomials. If all three points over a
root alpha of A are zeros, the cubic Fourier matrix is invertible,
so U(alpha)=V(alpha)=W(alpha)=0. Dividing g by x-alpha removes one
zero from each of those sheets and lowers its pole by three. Every
root of common polynomial content lies over A=0, since another root
would give a forbidden zero of g. Repeating produces a nonpolynomial
primitive supported function of no larger pole order, occupying at
most two sheets of every marked fibre. The missing-character theorem
still makes its pole at least20. It suffices to exclude these primitive
functions at the nine exact poles in the statement.

For exact pole n, use the full basis
\[
\{x^i y^j:i\ge0, 0\le j\le2, 3i+10j\le n\}
\]
of L(nO). Its dimension is n-8. The pole orders of its monomials are
distinct, so exact pole n means its unique top coefficient is nonzero.
All marked vanishing conditions are homogeneous linear equations in
these coefficients.

## Independent exhaustion by a short subdivisor

Every effective divisor of degree n contains a subdivisor of degree
n-9=dim L(nO)-1. Enumerate all such subdivisors supported on at most
two sheets of each of the four marked fibres. Arithmetic25-Frobenius
permutes the roots of A cyclically, and y->zeta*y simultaneously
rotates the sheets. Taking cyclic representatives for the four total
multiplicities and fixing the first occupied sheet therefore preserves
every possibility. The remaining sheet assignments are all retained.

Work in an explicit F_(5^24) containing the twelve marked points.
At each point, x-alpha is an etale parameter. The independent verifier
constructs the unscaled y-jet by taking the power inverse to three
modulo a sufficiently large power of five, and checks y(t)^3=P(alpha+t)
to the required precision. It then forms the matrix of all required
vanishing jets and computes its entire kernel.

If every vector in a kernel has zero top coefficient, it contains
no exact-pole function. If the kernel is polynomial, it contains no
nonpolynomial function. A one-dimensional remaining kernel fixes g
up to scalar, even after arbitrary extension of the coefficient field;
the verifier computes all twelve actual orders and checks their sum.
Every relevant nonpolynomial kernel in these runs was one-dimensional.
The196 two-dimensional kernels at pole21 were entirely polynomial.

The source also handles larger nonpolynomial kernels without an
assumption on their rank. Its common marked base divisor has degree
less than n, since a degree-zero line cannot have two independent
sections. A supported g must increase at least one of its twelve
marked orders; imposing that next-jet hyperplane decreases dimension.
This gives an exhaustive recursion. No such recursion was needed
beyond the first kernels in the executed nine cases.

| Exact pole | Short-divisor matrices | Maximum marked zeros in a tested nonpolynomial line |
| ---: | ---: | ---: |
|20|35,750|11|
|21|65,649|13|
|22|105,898|14|
|23|176,501|14|
|24|273,039|16|
|25|431,230|17|
|26|631,601|18|
|27|942,210|19|
|28|1,339,462|20|

All maxima are strictly smaller than the required pole degree. Thus
there is no primitive supported function in any case.

## Different search and reproducibility

The [first implementation](../../scripts/arithmetic/supported_primitive_jet_search.py)
instead traverses a tree of all marked multiplicity assignments,
updating kernels one jet at a time. It scales the character columns
to work over F_(5^8), constructs its jets by a different recurrence,
and stops a branch as soon as it fixes a function, whose entire
marked divisor is then checked. It independently found no survivor
at every pole20,...,28. It does not use the short-subdivisor list or
the independent verifier's kernel construction.

The [independent implementation](../../scripts/arithmetic/verify_primitive_support_by_subdivisors.py)
uses the unscaled F_(5^24) jets and the short-divisor argument above.
Both use exact field arithmetic, with assertions enabled. Their
small outputs retain field polynomials, embeddings, counts, source
scope, and deterministic transcript hashes; bulky individual kernel
lists can be regenerated and are not required as an input.

For each n in20,...,28 the executed commands were
`sage -python scripts/arithmetic/supported_primitive_jet_search.py n OUTPUT`
and
`sage -python scripts/arithmetic/verify_primitive_support_by_subdivisors.py n OUTPUT`.
Sage10.9/Python3.14.3 was used. The exact outputs are
poleN_search.json and poleN_independent.json (n<=26), or
poleN_subdivisor.json (n=27,28), in
[the evidence directory](../../../litt3-computation-data/small_supported_jets_20260927/).
Each independent result reads PASS_NO_NONPOLYNOMIAL_PRIMITIVE_FUNCTION;
both survivor lists are empty. These are complete bounded geometric
exhaustions, not finite-field sampling of the unknown g.

## Consequence and limit

The actual comparison normal form makes Norm_(h1)(t) a supported
function of exact pole delta, where div(t)=h2^*O-h1^*O and delta<=deg h_i.
The theorem forces delta to be a multiple of three whenever delta<=28.
All multiples through21 have already been excluded for actual maps,
most recently by [the complete septic theorem](pole_twenty_one_complete_exclusion.md).
Thus actual degree<=23 comparisons recognize the embedded X-field,
while the next possible pole is24. Poles22,23,25,26,28 are independently
excluded for arbitrary covering degree by their nonmultiplicity of three.

The degree bound cannot simply be deleted from this endpoint assertion.
Over an algebraic closure of a finite field, each marked divisor class
Q-O is torsion: it is a rational point of a Jacobian over some finite
field, whose group of rational points is finite. Hence some positive
multiple m(Q-O) is principal. The resulting supported function is not
in k(x), since a polynomial zero on an unramified cubic fibre occupies
all three points, whereas this function vanishes only at Q. Therefore
nonpolynomial supported functions do exist at sufficiently high poles.
Their existence does not construct an actual two-map comparison; it
shows why the norm test alone cannot settle all degrees.
