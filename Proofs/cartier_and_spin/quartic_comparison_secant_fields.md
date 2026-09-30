# Proof: the six quartic secants are distinct

25 September2026. Retain the [exact hypotheses](../../Theorems/cartier_and_spin/quartic_comparison_secant_fields.md).
The normal closure is used for field-theoretic labels only. Its
maps to the endpoints are not presumed etale.

## Local endpoint inputs do not require a Galois source

In a completion over t=0 write B=t^3v/epsilon. The two actual
identities give
\[
u=U_\alpha(t,B)
=\alpha+tC_\alpha B^4+t^2D_\alpha B^8+O(t^3),
\quad C_\alpha=[13]/A'(\alpha),\quad
D_\alpha=-A''(\alpha)C_\alpha^2/(2A'(\alpha)).
\]
Its leading label b is nonzero and satisfies
b^{29}=3P(alpha)^2/C_alpha^3. Implicit differentiation of the
second endpoint identity gives a regular scalar equation
tB'=F_alpha,b(t,B), with
\[
F_B(0,b)=2,\qquad F_{BB}(0,b)=0.
\]
The scalar equation can be obtained by setting Z=tB' in
\[
(2B+Z)^3P(U_\alpha)^2-
 \{\,\epsilon^{-10}t^{30}P(\epsilon t^{-3}B)\,\}^2
 \{(U_\alpha)_t+(U_\alpha)_B Z/t\}^3=0.
\]
Its Z-derivative at (0,b,0) is nonzero, so formal solving is
legitimate. The returned formal certificate verifies these
derivatives with indeterminate local constants.

The exact four-branch analysis in Sections4--5 of the incoming
[secant report](../../../litt3-computation-data/nonzero_pivot_secant_replies_20260925/secant/klein_four_secants/REPORT.md)
shows: if two opposite secants agree, all four leading labels
must coincide. Its proof uses only the four individual local
series, their endpoint identities and their pairwise distinctness.
The V4 labels in that report are a way to obtain those four
series; no group action enters its divided-difference equations
(5.1)--(5.6). In particular, the result applies to the four
embeddings of any separable quartic L/K under the local
hypotheses here.

For clarity, the exhaustive alternatives are: a homogeneous-root
pair and a heterogeneous-root pair have different orders; two
heterogeneous pairs with at least three roots are separated by
the120 full-rank certificates; two different-root repeated pairs
are excluded by174 transverse coefficients and the arbitrary-order
contact lemma. With one root, the435 confluent divided differences
force the same unordered pair of labels; the two-distinct-label
case is excluded by the displayed nonzero transverse determinant.
Only four identical labels remain. All those exact checks passed
locally, over the finite fields FORCED by the leading-label
equations, without bounding the higher coefficients.

The next lemma excludes this final case and is independent of
quartic Galois theory.

## An all-orders local lemma

Work over any field of characteristic5. Suppose four distinct series
B_1,...,B_4 in k[[t]] have the same nonzero constant b0 and satisfy
\[
tB_l'=F(t,B_l),\quad F(0,b0)=0,\quad
F_B(0,b0)=2,\quad F_{BB}(0,b0)=0.
\]
Suppose also that
\[
U(t,B)=\alpha+tC B^4+O(t^2),\qquad C\ne0.
\]
Then their opposite secants cannot agree:
\[
\frac{U(t,B_1)-U(t,B_2)}{B_1-B_2}
\ne
\frac{U(t,B_3)-U(t,B_4)}{B_3-B_4}.
\]
Only distinctness of the series is required, not distinct leading or
second coefficients. Formal substitution is taken near B=b0.

Write their four Fourier coordinates as
\[
B_1=m+a+b+c,\quad B_2=m+a-b-c,\quad
B_3=m-a+b-c,\quad B_4=m-a-b+c.
\]
Here m(0)=b0 and a,b,c vanish at t=0. Every solution has the same
coefficient of t: if B=b0+dt+..., its equation gives
d=F_t(0,b0)+2d. Thus a,b,c belong to t^2 k[[t]].

The symmetric divided difference
\[
T(t,z,d)=\frac{U(t,z+d)-U(t,z-d)}{2d}
\]
is regular, even in d, and divisible by t. This is a polynomial
divided-difference identity, valid also at d=0; no inverse of a
vanishing series is required. The asserted equality would give
T(t,m+a,b+c)=T(t,m-a,b-c).

At t=0 the difference after division by t is exactly
\[
4C\{m^2a+2a^3-mbc+2a(b^2+c^2)\}.
\]
Indeed the quartic symmetric divided difference is 4C(z^3+zd^2).
The derivative in a at (t,m,a,b,c)=(0,b0,0,0,0) is the unit 4Cb0^2.
Formal implicit solving gives a unique a=A(t,m,b,c). When b=0,
a=0 solves the equation because T is even in its last argument;
the same holds when c=0. Uniqueness implies that A is divisible by
bc, with first coefficient determined by the displayed identity:
\[
a=bc R(t,m,b,c),\qquad R(0,b0,0,0)=b0^{-1}.
\]
If b or c were zero, a would be zero too and two B_l would coincide.
Thus b,c are nonzero, R is a unit on the actual series, and
\[
\operatorname{ord}_t a=\operatorname{ord}_t b+\operatorname{ord}_t c.
\]

Project the four differential equations into the same sign coordinates.
For the a-coordinate the linear and quadratic terms are exactly
F_B(t,m)a+F_{BB}(t,m)bc. The remaining terms are combinations of
a times positive even powers of a,b,c, or bc times positive even
powers of them. The a character occurs only with exponent parities
(1,0,0) or (0,1,1). After a=bcR every remaining term has order
strictly greater than ord(a). This is an all-orders parity argument,
without division by higher factorials. Since F_{BB}(0,b0)=0,
\[
ta'=2a+O(t^{\operatorname{ord}a+1}).
\]
In the b and c coordinates the same substitution makes every
nonlinear term strictly higher than its first-order term:
\[
tb'=2b+O(t^{\operatorname{ord}b+1}),\qquad
tc'=2c+O(t^{\operatorname{ord}c+1}).
\]
All three orders must therefore be congruent to2 modulo5, whereas
their additive relation would give 2=2+2 modulo5. This contradiction
proves the lemma for arbitrary contact orders and coefficient fields.

The small polynomial identity and resonance mismatch are independently
checked by
[klein_four_coalesced_secant.py](../../scripts/arithmetic/klein_four_coalesced_secant.py).
Its finite monomial diagnostic does not replace the parity proof.

## Distinctness and exact stabilizers

Apply the lemma to four embeddings at a place of the normal
closure above0. Their completions embed in k((t)): the quartic
polynomial already splits there because all four places of L
are unramified with algebraically closed residue field. The
primitive value v distinguishes all four series. The repeated-
label reduction and the lemma show that the slopes for disjoint
pairs cannot be equal.

Suppose slopes for adjacent pairs were equal. Three conjugate
points (u_a,v_a) would be collinear. G acts transitively on the
four embeddings, hence on the complements of the triples.
A conjugate gives a different collinear triple. The two triples
have two common points with distinct u-values, so their lines
coincide and all four points are collinear. Opposite slopes
would then be equal, already excluded. Thus no adjacent
slopes coincide either, and all six are distinct.

For g in G, g(rho_ab)=rho_{g(a)g(b)}. Distinctness proves that
g fixes rho_ab if and only if it stabilizes the unordered pair
{a,b}. Galois correspondence gives the exact fixed field and
the orbit-degree formula. The orbit sizes quoted in the
statement are the elementary actions of V4,D4,A4,S4 and C4
on the six two-element subsets of a four-element set.

This generalization supplies new primitive comparison functions
in the D4 and S4 branches. It does not solve their simultaneous
nonlinear identities, and it does not justify replacing two
actual etale maps by a normal closure.
