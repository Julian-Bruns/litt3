# Proof: lower-degree exclusions turn the next norm test into linear algebra

27 September2026. Let k be an algebraic closure of F5. As usual, encode
[a+5b]=a+b beta with beta^2=beta+3 and ascending coefficient rows. The
curve and marked polynomial are
\[
y^3=P(x),\quad P=(11,22,18,5,19,20,15,16,9,22,1),\qquad
A=(1,21,14,22,13).
\]
Its infinity O is unique, with pole orders3 and10 for x and y. P and A
are squarefree and coprime. Let Z be the twelve points over A=0.

## Reduction to one sheet per occupied fibre

Suppose div(g)=D-16O with D supported on Z. Regularity away from O and
the affine coordinate ring give
\[
g=U(x)+V(x)y,\qquad \deg U\le5,\quad\deg V=2.
\]
There is no cancellation between monomials of different pole orders:
the basis x^i y^j,0<=j<=2 has pairwise distinct orders3i+10j in this
range. In particular V is nonzero.

Every root of a nonconstant gcd(U,V) is a root of A, since otherwise
the whole corresponding cubic fibre would be a forbidden zero. Dividing
by one linear common factor would give a function with sole pole13O
and the same allowed zero support. That contradicts the established
[pole-thirteen theorem](pole_thirteen_norm_exclusion.md). Equivalently,
one may divide the full common factor and use poles13 and10. Thus
gcd(U,V)=1. If g vanishes anywhere above alpha_i, then V(alpha_i)!=0,
and y=-U(alpha_i)/V(alpha_i) is the unique occupied sheet there.

It is consequently enough to test every composition
m_0+...+m_3=16 and every choice of one sheet at each occupied fibre,
with vanishing to order at least m_i. We use all of L(16O), of dimension
nine, for this test; no leading-coefficient localization is needed.

## The exact linear systems

Choose alpha satisfying alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5]=0
and set alpha_i=alpha^(25^i). These are the four roots of A. Choose
y_0^3=P(alpha), set y_i=y_0^(25^i), and zeta=[11], of order three.
All these elements lie in F_(5^24), represented explicitly in the
certificate. At (alpha_i,zeta^s y_i), x-alpha_i is an etale parameter.
The unique local cubic root y(x) with this constant term has a Taylor
series to any needed order.

For each support and phase choice, take the coefficients through order
m_i-1 of the nine functions
\[
1,x,x^2,x^3,x^4,x^5,y,xy,x^2y.
\]
Stacking them gives a16x9 matrix. A putative g gives a nonzero vector
in its kernel, over k. Showing rank nine over the indicated finite
coefficient field also shows rank nine after every field extension.
This is an exhaustive geometric linear test, not a finite-field search
for the unknown coefficients.

There are969 compositions. Arithmetic25th-power conjugation rotates
their four entries and permutes the three available sheets. The245
cyclic composition representatives therefore suffice, provided every
sheet choice remains available. The global automorphism y->zeta*y
allows the first occupied sheet phase to be zero. The remaining phases
are all independently enumerated. There are exactly4,147 matrices.
Conjugation may change a phase on wrapping from alpha_3 to alpha_0;
the complete phase list includes this change, so no invariance of a
single chosen sheet is presumed.

## Certificates and independent reconstruction

The [generator](../../scripts/arithmetic/pole_sixteen_hermite_support.py)
records the irreducible degree24 field modulus, beta, alpha, y_0,
all support/phase indices, and a nonzero9x9 minor for EACH matrix.
It constructs y/y_i by raising P(alpha_i+t)/P(alpha_i) to17 modulo
t^16: three times17 is1+2*25, so this is the cubic root of that unit
at the required precision in characteristic five.

The [separate verifier](../../scripts/arithmetic/verify_pole_sixteen_hermite_support.py)
does not import the generator or use its exponent17 formula. It builds
the cubic root recursively from y(t)^3=P(alpha_i+t), dividing at each
step by3y_i^2. It verifies the resulting cubic jets, reconstructs every
specified minor, and computes its determinant by an independent
elimination, without invoking a rank or pivot selection algorithm.
It checks the field modulus, all embeddings and the exhaustive support
coverage, not only the determinants recorded in the JSON.

The [exact certificate](../../../litt3-computation-data/pole16_hermite_20260927/certificate.json)
has4,147 nonzero determinants and no survivors. The
[independent verification](../../../litt3-computation-data/pole16_hermite_20260927/verification.json)
passed every check. Sage10.9, Python3.14.3 were used. From the workspace:

`sage -python scripts/arithmetic/pole_sixteen_hermite_support.py ../litt3-computation-data/pole16_hermite_20260927/certificate.json`

`sage -python scripts/arithmetic/verify_pole_sixteen_hermite_support.py ../litt3-computation-data/pole16_hermite_20260927/certificate.json ../litt3-computation-data/pole16_hermite_20260927/verification.json`

These ranks contradict every possible g, proving the asserted geometric
nonexistence. The computation does not use the stronger endpoint
Cartier criterion or assume deg U=5.

## Actual-map consequence and limit

The established comparison reduction for two actual etale maps h_1,h_2
to X produces z with div(z)=h_2^*O-h_1^*O. Its nonconstant pole degree
delta is at most their common degree n. The norm under h_1 has its sole
pole delta O and zeros supported on Z. The preceding theorem excludes
delta=16 in every n. The Weierstrass semigroup <3,10> excludes17.
Together with the complete results for delta<=15, this gives conditional
line/tensor field recognition for n<=17, and moves the first possible
comparison pole to18. No actual sextic quotient or unmarked common-cover
decision is inferred.
