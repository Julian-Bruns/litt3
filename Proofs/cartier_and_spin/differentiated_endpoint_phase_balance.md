# Two trace coefficients recover all phase multiplicities modulo five

27 September2026. Use the comparison normal form and conventions of
the [direct-source trace theorem](direct_common_source_trace.md).
Write the four roots of A as alpha_i, choose rho_i^3=P(alpha_i),
and label the three cubic sheets by rho_i*zeta^s, where zeta=[11].
The phases lie in mu29; fix a primitive xi. Norm invariance gives
the SAME number m_i of branches on each sheet over alpha_i.

## The constant coefficient and the small-fibre anchor

For a branch with phase xi^j, its x-coordinate begins
x=alpha+a_i*xi^(4j)t+b_i*xi^(8j)t^2+O(t^3).
The established universal two-jet formula gives
\[
B_i=\left(3A'(\alpha_i)^3P(\alpha_i)^2/[13]^3\right)^{29^{-1}},
\quad a_i=[13]B_i^4/A'(\alpha_i),
\]
\[
b_i=\frac{4[13]B_i^3c(\alpha_i)-A''(\alpha_i)a_i^2/2}{A'(\alpha_i)},
\quad c=(22,7,9,23).
\]
Here29^-1 is taken modulo5^8-1, and all these constants belong to
F_(5^8). This formula is independent of the geometric scalar and
the cubic sheet. It follows by substituting Z=B_i+c(alpha_i)t+...
into A(x)=t*[13]Z^4+O(t^4); the free resonant coefficient is later.

Put S_(i,s)(r)=sum xi^(rj) over the actual m_i phases on sheet s.
Tracing the regular forms x^j dx/y^2,0<=j<=5, gives zero regular
forms on P1. Their constant coefficients, by Vandermonde rank, give
\[
S_{i,0}(4)+\zeta S_{i,1}(4)+\zeta^2S_{i,2}(4)=0
\tag{1}
\]
at each root separately. The three forms x^j dx/y,0<=j<=2, give
a three-by-four Vandermonde system for the other Fourier sums.
Its one-dimensional kernel has all four coordinates nonzero.

At a root with m_i=0, both sums vanish. For m_i=1, independence of
three distinct phases over F25 makes(1) force equal phases. For
m_i=2, the complete small certificate below proves the same integer
equality of the three two-label multisets. Thus at the specified
anchor root the second Fourier sum also vanishes. Since its kernel
has no zero coordinate, it vanishes at ALL roots. Inverting the
cubic Fourier transform proves equality of the three S_(i,s)(4).

## The linear coefficient gives the complementary phase moment

For k=1,2, the linear coefficient of x^j dx/y^k on a branch is
\[
\rho_i^{-k}\zeta^{-ks}a_i^2\xi^{8j_{phase}}
\left(\alpha_i^j r_k(\alpha_i)+j\alpha_i^{j-1}\right),
\qquad r_k=2b_i/a_i^2-\frac{kP'(\alpha_i)}{3P(\alpha_i)}.
\tag{2}
\]
The term j*alpha^(j-1) is zero when j=0. The sheet-independent
nonzero factors rho_i^-k*a_i^2 can be absorbed into the columns.
The exact6-by4 matrix in(2), for k=2 and0<=j<=5, has rank four.
The exact3-by4 matrix for k=1 and0<=j<=2 has rank three, and EVERY
three-column minor is nonzero. These fixed small calculations are
recorded with all entries and nonzero minor values in the certificate.

Consequently the first cubic Fourier sum of the eighth phase powers
vanishes at each root. The second sums lie in a one-dimensional
kernel with no zero coordinate. At the same anchor root, integer
phase balance was already proved, so this second sum is zero there,
and hence everywhere. Thus all three S_(i,s)(8) also agree.

For two sheets at one root, let D(X) in F5[X], degree<=28, be their
phase multiplicity difference. We now know D(xi^4)=D(xi^8)=0.
The exponent4 and exponent8 Frobenius orbits under multiplication
by5 are disjoint, have length14, and exhaust1,...,28. Therefore
Phi29 divides D. Since both sheets have the same integer cardinality,
D(1)=0, whereas Phi29(1)=29=4 in F5. Hence D=0. This proves complete
multiplicity agreement modulo five, not merely equality of one sum.

If m<=11 and all four roots are occupied, one has m_i<=2. An absent
root is itself an anchor. Thus this bound guarantees the hypothesis.

## The integer lift for m<=9

Once multiplicities agree modulo five, choose their common residues
in0,...,4. On each sheet their sum at a root is at most m_i. As
m<=9, any discrepancy is a single fivefold phase block on each
sheet, at at most one root. All remaining m-5 phase labels match
as integers, root by root. If there is no block, balance is proved.

At the opposite endpoint the leading residues of t^-1 have polynomial
\[
\prod_{s=0}^2(W-d_s)^5\,J(W^3),\qquad\deg J=m-5.
\]
The residues d_s equal a common nonzero factor times
zeta^(2s)*xi_s^-10. The coefficient of index five is exactly
-(d_0+d_1+d_2)^5: J(W^3) contributes only index multiples of three.
This statement also holds for the FULL norm polynomial of degree n,
whose leading residue polynomial has the extra factor W^(n-3m).
Its index-five coefficient lies in L(5O)=span(1,x) and has no pole
of order five. Thus d_0+d_1+d_2=0. Independence of at most three
phases over F25 forces the three xi_s to coincide. The fivefold
blocks balance as integers too. Endpoint interchange proves the
same statement on the other leg.

This last step is asserted only for m<=9. Multiple fivefold blocks
in higher degree can cancel in the index-five norm coefficient.

## Small exact certificate

Run [the source](../../scripts/arithmetic/differentiated_endpoint_phase_certificate.py)
with Sage and an external output path. It reconstructs the fields,
the branch two-jets, the two derivative matrices and their nonzero
minors. Independently of the earlier six-phase relation analysis,
it enumerates the435 unordered pairs of29 phases. Every one of the
435^2 choices for the first two sheets determines the third sum;
exactly435 resulting sums are again pairs, and ALL435 have the
same pair on every sheet. Repetitions are retained.

The executed result is PASS in
[differentiated_endpoint_phases.json](../../../litt3-computation-data/prime_field_phases_20260927/differentiated_endpoint_phases.json).
The source also checks that the two exponent Frobenius orbits exhaust
all nontrivial phases. These are exact calculations of fixed endpoint
constants, not a search over unknown curve coefficients. Trace of
regular differentials remains regular through wild ramification, so
no tame hypothesis or cubic quotient has entered either coefficient.

The fresh bounded independent audit by /root/audit_direct_source_trace
passed on27September2026. It replayed the complete small certificate,
matched all four second jets against the independent established e-row,
and checked all36 matrix entries by literal differential expansion.
It also checked the complementary-orbit argument, the anchor scope,
and the full norm coefficient for the integer lift. Its scope is the
nonconstant actual comparison, not the unmarked existence problem.
