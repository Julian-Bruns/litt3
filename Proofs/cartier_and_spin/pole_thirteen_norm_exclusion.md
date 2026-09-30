# Proof: a univariate cube test at the next comparison pole

25 September2026. This is a local continuation after integrating the
quartic reply. It reuses the lower-degree norm method while retaining
an unrestricted geometric parameter.

## Complete reduction

The affine coordinate ring of X is k[x,y]/(y^3-P). Since x,y have
poles3,10 at O, every function of exact pole order thirteen has form
U(x)+(c x+b)y, with deg U<=4 and c!=0. Divide by c, so the function
is U(x)+(x+b)y. The cyclic cubic norm to k(x) is
\[
U(x)^3+P(x)(x+b)^3.
\]
It is monic of degree thirteen. If all zeros of the original function
lie above the four distinct roots alpha_i of A, then its norm is
\[
S_{\mathbf m}(x)=\prod_{i=0}^3(x-\alpha_i)^{m_i},\qquad
m_i\ge0,\quad\sum m_i=13.
\tag{1}
\]
There are exactly560 compositions. This includes every multiplicity
and every allowed distribution among the three sheets. It suffices
to show that
\[
G_{\mathbf m,b}(x)=S_{\mathbf m}(x)-P(x)(x+b)^3
\tag{2}
\]
is not a cube for any geometric b, for each composition.

All alpha_i lie in the explicit degree-four extension of F25 used by
the quartic theorem. The unknown b remains an indeterminate, not an
element of that finite field. The coefficient ell(b) of x^12 in(2)
is m-independent in its linear term: ell=S_12-P_9-3b. Thus it has
one simple zero b_0. Treat this boundary separately.

When ell!=0, a geometric cube root of ell always exists. Divide any
putative U by its leading coefficient. The resulting monic quartic
\[
W=x^4+q_3x^3+q_2x^2+q_1x+q_0
\]
must satisfy W^3=G/ell. Its four coefficients are uniquely recovered
from degrees11,10,9,8, since3 is invertible. Write q_j=n_j/ell^(4-j).
The following formulas are identities in the polynomial ring in b:
\[
\begin{aligned}
3n_3&=G_{11},\\
3n_2&=\ell G_{10}-3n_3^2,\\
3n_1&=\ell^2G_9-6n_3n_2-n_3^3,\\
3n_0&=\ell^3G_8-6n_3n_1-3n_2^2-3n_3^2n_2.
\end{aligned}
\tag{3}
\]
Therefore with
V=n_0+ell n_1x+ell^2n_2x^2+ell^3n_3x^3+ell^4x^4,
the residual polynomial is ell^11 G-V^3. Its degrees8..12 vanish
identically. Any cube would make its eight lower coefficients vanish.

## The exact certificates

For each of560 compositions the
[Sage generator](../../scripts/arithmetic/pole_thirteen_norm_support.py)
computes the normalized residuals over the rational function field in
b. It supplies at most two nonzero residual numerators r_j(b), with
polynomials a_j(b) satisfying sum a_j r_j=1. This identity excludes
every b away from ell=0, not only rational points. At b=b_0 the
polynomial G has degree ELEVEN in every one of560 cases, so is not
a cube there either.

The complete evidence is in
[the certificate](../../../litt3-computation-data/quartic_quotient_trace_replies_20260925/local_checks/pole_thirteen_norm_support.json).
An independent
[standard-library verifier](../../scripts/arithmetic/verify_pole_thirteen_norm_support.py)
uses flat base25 finite-field arithmetic, reconstructs S and G, and
uses the division-free formulas(3). It checks all vanished top
coefficients, removes only powers of the known linear denominator
from each raw residual, compares the resulting polynomial to the
claimed numerator up to a nonzero scalar, and multiplies out every
Bezout identity. It independently checks every b_0 and degree-eleven
boundary. It does not invoke Sage, rational-function normalization,
root finding, or a gcd algorithm to trust the claimed unit identity.

The generator completed all560 patterns with no survivors. The
independent verifier passed every pattern. Its execution log is
[retained here](../../../litt3-computation-data/quartic_quotient_trace_replies_20260925/local_checks/pole13_independent.log).
Run from the workspace root:

`python3 -B scripts/arithmetic/verify_pole_thirteen_norm_support.py ../litt3-computation-data/quartic_quotient_trace_replies_20260925/local_checks/pole_thirteen_norm_support.json`

The method is the same normalized cube recovery used at pole ten,
but now a free linear y-coefficient is retained and excluded by a
univariate ideal identity. A scalar cube-root choice never restricts
the geometric field. Formula(2) having no cube proves the theorem.

## Consequence for the actual maps

In an actual jointly minimal comparison of the specified Cartier
lines, the canonical comparison z has div z=D_2-D_1 and pole degree
delta<=n, where n is the degree of each etale map. Its norm under
the first map has only its pole delta O and zeros in the finite
part of R_X. The older complete results exclude delta=3,6,9,10;
the semigroup <3,10> excludes the other positive values below12.
The present theorem excludes delta=13. For n<=13, only delta=12
remains, and the quartic trace theorem excludes its n=12 and n=13
cases. Hence the two endpoint fields agree for n<=13.

For n>=14 the pole-twelve profile can still survive. Neither this
norm theorem nor the conditional comparison theorem supplies a
shared tensor on an arbitrary unmarked common cover.
