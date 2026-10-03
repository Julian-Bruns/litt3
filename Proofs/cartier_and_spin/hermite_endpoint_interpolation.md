# Proof: complementary codes, cross differences and common factors

30 September 2026.
[Statement](../../Theorems/cartier_and_spin/hermite_endpoint_interpolation.md).

For two monomial evaluation vectors, the ordinary pairing is
\[
\sum_{z\in\mu_N}z^{i+j}=\begin{cases}N&i+j=0\pmod N,\\0&\text{otherwise}.\end{cases}
\]
The full Fourier matrix is invertible since N is a unit. This identifies
the orthogonal code as claimed. Complementary minors of a code and its
orthogonal code agree up to a common nonzero determinant and coordinate
signs. Therefore their maximal minors vanish on complementary coordinate
sets simultaneously. Invertibility on every |I| coordinates excludes a
nonzero word with |I| zeros. Scalar extension preserves those determinants.

For S_r with r<=5, its dual exponents are
\[
\{1,\ldots,6-r\}\cup\{8,\ldots,13-r\}.
\]
Multiplying evaluation columns by the inverse node shifts these to
{0,...,s} union {7,...,7+s}, s=5-r. Every maximal minor for this
last space was exhaustively certified for 0<=s<=5. The exact source is
[fourier_checks.cpp](../../scripts/arithmetic/pro_pivot_secant_20260925/secant/previous/prior/src/fourier_checks.cpp);
the complete input proof and execution records remain in
[the retained predecessor package](../../../litt3-computation-data/nonzero_pivot_secant_replies_20260925/secant/klein_four_secants/previous/prior/),
REPORT sections 4--6. This certificate is shared with the existing
simultaneous-quotient work, and is retained. We do not replay it.
Since dim S_r=17+2r, duality gives the bound 16+2r. For r=6 the
space is all polynomials of degree<=28, so the bound is simply degree.
No endpoint-label, unused-node or numerical-genus search is required.

For quotient rigidity, let C(t),U(t) be the monic products of the stated
finite nodes. The equations at every node imply C U divides H without
inverting a denominator. Cancellation of P gives deg H<=a+2d. The
endpoint assumptions give t^ell_0 divides H and remove at least ell_inf
of its highest coefficients, so deg H<=a+2d-ell_inf. The asserted
strict divisor-degree inequality forces H=0. This equality preserves
common factors; it establishes equality of rational quotients only.

To check an endpoint hypothesis, use local normalized representatives
of the two section pairs. With unit denominators the local cross product
is their product times the quotient difference. If both components in
each pair vanish to order at least b, its cross product vanishes to
order at least 2b. The same argument applies at infinity after using the
specified section frames. A denominator zero alone supplies no bound.

For the affine-line assertion, fix r0 in A. Write v=r-r0 and w=s-r0.
Then q(v)=q(w)=q(v-w)=0, so the polar pairing of v,w is zero. The span
of all differences is therefore totally isotropic. The polar matrix
has zero diagonal and unit off-diagonal entries, determinant 2. A
totally isotropic subspace of a nondegenerate three-dimensional space
has dimension at most one. No closure of A under sums is assumed.
On the displayed quadric, an isotropic vector with a zero coordinate
is a coordinate axis; excluding such axes needs additional local data.

Finally remove the common zero divisor of a section pair on P1. Its
uniquely normalized reduced pair (f0,T0) has degrees a+r,r and no
common zero. All lifts are
\[
(f,T)=h(f_0,T_0),\qquad h\in H^0(\mathbf P^1,O(d-r)).
\]
At each endpoint at least one reduced component is a unit. Equality
of the prescribed absolute jets therefore makes h-hat h vanish to
orders ell_0,ell_inf. A nonzero difference needs d-r>=ell_0+ell_inf.
At a finite node with T nonzero, h is a unit; cancellation from
P T+f=0 is legitimate and gives P T0+f0=0. Nodes with T zero cannot
be counted by this argument. This proves the lifting statement with
all endpoint degree drops and common factors retained.

The extracted mechanisms replace the obsolete V4 genus/profile chain;
the later [all-cover pole-twelve exclusion](../../Theorems/cartier_and_spin/pole_twelve_complete_exclusion.md)
already closes every actual geometric application in that chain.
The formulas above are general algebra. Their old constants, V4 pole
partitions and degree cutoffs supply no automatic higher-pole application.
New pole-twenty-four endpoint and character constraints remain to be proved.
The extraction received independent root-agent proof review on
30 September 2026, including section frames at infinity, common factors,
all finite denominator boundaries and the limit of the pole scope.
