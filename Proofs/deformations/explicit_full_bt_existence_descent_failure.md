# Proof: the exceptional dihedral cover has a full prolongation

[Statement](../../Theorems/deformations/explicit_full_bt_existence_descent_failure.md).
21 September2026, version2. The new argument combines a complete actual fourth
tuple with a surjective late response. The
[support and prolongation audit](../../Research/audits/EXCEPTIONAL_DIHEDRAL_FOURTH_SUPPORT_AND_FULL_EXTENSION_AUDIT_2026_09_21.md)
and the independent
[geometry/effectivity audit](../../Research/audits/EXCEPTIONAL_DIHEDRAL_FULL_EXISTENCE_DESCENT_AUDIT_2026_09_21.md)
check the two theoretical implications. Their listed finite conditions
are verified by the exact certificate below.

## 1. The actual diagram and its original first datum

Set $k_0=\mathbf F_{625}=\mathbf F_5[\tau]$
with $\tau^4+4\tau^3+\tau^2+4\tau+3=0$, and write
$F=u(u-1)(u-2)(u-3)(u-\tau)$. The curve $C:v^2=F$ carries the
specified admissible active oper and actual BT1 $H_C$ of
[the finite-level counterexample](etale_p_witt_obstruction.md).
Its actual BT2 obstruction is nonzero. Retain its first periodic
datum, smooth marked $C_2$, flat periodicity line and finite determinant.

Let $D$ have functions $\kappa^2=u-\tau$, $\ell^2=F/(u-\tau)$,
$v=\kappa\ell$. This is the actual etale double of $C$, of genus three.
The elliptic quotient $E:\ell^2=u(u-1)(u-2)(u-3)$ is ordinary. Pull
its connected etale Verschiebung cover back to $D$. The result is
the actual connected cyclic-five cover $W\to D$, and its composite
to $C$ has group $D_{10}$. A reflection quotient $T$ has genus six
and is etale of degree five over $C$. These assertions, the actual
maps and the flat squareclass are proved in
[the dihedral construction](cyclic_descent/explicit_non_galois_neutral_five.md).

This is its exceptional pair $\{\tau,\infty\}$. The full primary
operator on $H^1(T,T_T)$ has dimension fifteen and rank eleven.
Its kernel and obstruction space both have dimension four, each
split as two plus two under the hyperelliptic involution. The retained
original map and flat squareclass are checked in the
[model audit](../../../litt3-computation-data/legacy_workspace_computations/dihedral5_family_model_independent_audit.json).
Unlike the fourteen neutral rows, that exceptional historical row
alone did not certify the entire first comparison. The new actual
runs additionally verify the first FL connection, full first-Frobenius
rank fifteen, the original twisted jet, and the complete W2 jet
transition. Thus the fixed initial datum is retained in the new work.

## 2. Universal support of the complete fourth class

Choose the fixed particular third repair $\chi_0$ and all four actual
kernel directions $\nu_i$. Write
$\chi(x)=\chi_0+\sum_{i=0}^3x_i\nu_i$, $y_i=x_i^5$. The original
source gluing is $\exp((5\xi-25\chi)D)$ modulo625. The first normal
cochain is solved completely on both charts. Its whole regular
primitives are affine-linear in $y$. Normalize the corrected Hodge
generators by their Wronskians in the actual current connection.

For the formal parameter $z$, put $j=z^{g(T)-1}=z^5$. The complete
next normal cocycle, including the preceding potential, weighted jet
and cubic Taylor term, is
\[
\rho_4=j\bigl((I_O^{(2)})^{-1}G_3\phi(I_U^{(2)})\bigr)_{12}/25
\pmod5.
\]
Its full four-dimensional primary quotient is $E(x)$.
The audited integral weight calculation proves
\[
E(x)=C+Ax+Ly+Q(y),\qquad y=x^{[5]},
\tag{1}
\]
with $Q$ homogeneous quadratic. In particular this support is not
inferred from a finite sample. To see the essential point, use
universal coefficient variables $X_i$ with $\sigma(X_i)=X_i^5$.
An un-Frobenius $X_i$ first enters the normal numerator with weight25;
$X_i^5$ may enter with weight5. Modulo125, products can therefore
be quadratic only in the latter variables. Whole primary cancellation
is coefficientwise. Changing an integral coefficient section adds
a terminal primary direction or a regular boundary, both killed by
the final quotient. This also explains why the ordinary linear term
$Ax$ must be retained; it is nonzero in this example.

The support in (1) has nineteen monomials. The exact evaluation
matrix at the baseline, the eight points $y=\pm e_i$, the six
$y=e_i+e_j$, and the four $y=\tau e_i$ has determinant $3\ne0$.
These are nineteen actual full integral comparisons, in the actual
$x=y^{[1/5]}$ coordinates. Six further comparisons, including two
with all four parameters outside the prime field, agree. The
[calibration certificate](../../../litt3-computation-data/bt_obstruction_transport_20260921/exceptional_dihedral5_certificate.json)
checks all twenty-five values, all source/output hashes, direct
residue normalizations and the five-part normal-cochain decompositions.
The original sample source is retained byte-for-byte in the external
source-snapshot directory. No interpolation assumption remains after
the support theorem and invertible calibration matrix are combined.

## 3. The two blocks and an actual fourth tuple

For coefficients use the shorthand $abcd=a+b\tau+c\tau^2+d\tau^3$.
The complete calibrated map has the block form
\[
E_+(x)=F(y_0,y_1)+Q_{--}(y_2,y_3),\qquad
E_-(x)=A_-\binom{x_2}{x_3}
+(B_0+y_0B_1+y_1B_2)\binom{y_2}{y_3}.
\tag{2}
\]
All entries of the omitted blocks are included and checked in the
certificate. Only their displayed support is needed below. In the
monomial order $1,y_0,y_1,y_0^2,y_0y_1,y_1^2$, the two rows of $F$ are
\[
(0034,3101,3212,4342,0230,0104),\qquad
(3341,1033,3140,4142,1442,4110).
\]
The ordinary linear block is
\[
A_-=\begin{pmatrix}4131&2120\\3432&2113\end{pmatrix},
\qquad \det A_-=2302\ne0.
\tag{3}
\]
The positive ideal $F=0$ has the exact Groebner basis
\[
y_0+(2\tau^2-\tau)y_1^2
+(2\tau^3-\tau^2-\tau-1)y_1-2\tau^3+2\tau-1,
\]
\[
p(y_1)=y_1^3+(\tau^3+\tau^2)y_1^2
+(2\tau^3+\tau^2+\tau+1)y_1+2\tau^3-\tau^2.
\tag{4}
\]
The cubic $p$ is irreducible and separable over $k_0$. In
$K=k_0[\lambda]/p$, choose
\[
y_1=\lambda,\quad
y_0=(1+3\tau+2\tau^3)
+(1+\tau+\tau^2+3\tau^3)\lambda
+(\tau+3\tau^2)\lambda^2,
\quad y_2=y_3=0.
\tag{5}
\]
At (5) the positive Jacobian determinant is
\[
4411+0211\lambda+1441\lambda^2\ne0.
\tag{6}
\]

Existence is also checked without relying on this polynomial root.
The actual integral comparison at $x=y^{[1/5]}$ gives all four
fourth components zero. It solves the full fifteen-coordinate
terminal primary equation of rank eleven, constructs the affine and
regular formal graph corrections, normalizes the next DS frames,
and checks their entire filtered/graded transition modulo125.
The [complete fourth tuple](../../../litt3-computation-data/bt_obstruction_transport_20260921/exceptional_dihedral5_cubic_w4_p3500/genus6_w4_tuple.json)
is an actual compatible $W_4$ curve and $W_3$ filtered/graded object,
not just a zero of a necessary scalar test.

This whole construction passes at Laurent precisions3500 and3800,
and at3800 with a changed regular affine Frobenius lift. The latter
two [full receipts](../../../litt3-computation-data/bt_obstruction_transport_20260921/exceptional_dihedral5_cubic_replays.json)
also retain the actual connection gluing and an independently iterated
p-connection Taylor calculation. The coefficient arithmetic uses the
cubic UNRAMIFIED TOWER over the original F625 coefficient ring, so
the base lifts and reference are unchanged. A separate
[nested-polynomial check](../../../litt3-computation-data/bt_obstruction_transport_20260921/exceptional_dihedral5_tower_check.json)
verifies multiplication, inversion and the complete twelve-step
coefficient Frobenius modulo625.

## 4. Surjectivity of the complete late response

Fix the actual third point $x^*$ of (5). The accepted
[integral polarization identity](integral_oper_calculus.md) and
[late-response theorem](late_relative_hodge_response.md) give the
same complete additive response at every later reached prefix:
\[
R_{x^*}(v)=Av+(L+dQ_{y^*})v^{[5]}.
\tag{7}
\]
This is a statement about actual allowed primary directions and
their WHOLE graph repairs. It is not differentiation of the
Frobenius-thickened equations in the $x$ coordinates.

Because $x_-^*=0$, (2) makes (7) block diagonal:
\[
R_+(v_+)=J_+v_+^{[5]},\qquad
R_-(v_-)=A_-v_-+B_-v_-^{[5]}.
\tag{8}
\]
Equation (6) makes the positive block bijective on geometric points.
Equation (3) makes the differential of the negative additive map
invertible. Its image contains an open subset of $\mathbf A^2$;
an additive subgroup containing an open subset is the whole vector
group, since that open subset meets each of its translates. Thus
the negative block is surjective over $k$, regardless of $B_-$.
The COMPLETE four-component response is surjective.

Here every reached prefix has the same source modulo125 and the
same current frames and connection modulo25 as the fixed first
repair. Later graph/source changes begin beyond these precisions.
Their genuine preceding potentials retain the required predecessor;
changes of those potentials acquire the extra factor25 in the
comparison. These are precisely the hypotheses of the late-response
theorem, independently of the later chosen digits.

Starting from the actual fourth tuple, surjectivity allows its
fourth digit to be adjusted to admit a fifth. Then a fifth digit can
be adjusted over that retained fourth to admit a sixth, and so on.
After each cancellation, the full normal vector lies in the original
primary image; a whole primary preimage and regular primitives give
the next genuine tuple. The
[delayed-extension argument](marked_obstruction_torsors.md) produces
one compatible tower with stabilized earlier prefixes. It retains
the third point, but need not retain the initially displayed fourth
digit.

There is a stronger arithmetic conclusion. Over $K=\mathbf F_{5^{12}}$
use the basis $\tau^i\lambda^j$, $0\le i<4$, $0\le j<3$.
The [arithmetic certificate](../../../litt3-computation-data/bt_obstruction_transport_20260921/exceptional_dihedral5_arithmetic.json)
constructs the restriction-of-scalars matrix of
$v\mapsto A_-v+B_-v^{[5]}$ on $K^2$. This is a24-by24 matrix over
$\mathbf F_5$ with determinant1. Its supplied inverse is checked in
both orders, also by a separate ordinary-integer modular multiplication.
The positive block in (8) is already bijective over $K$.
Thus the COMPLETE response is bijective on $K^4$, not merely
surjective on geometric points.

Starting with the actual $K$-rational fourth tuple, every later
obstruction and comparison is over $K$. Its unique response correction
is over $K$ by this bijectivity. A complete primary vector lying in
the image over $k$ already has a preimage over $K$ by linear algebra;
the coefficient Frobenius is an automorphism of $K$. The fixed regular
primitive choices and normalization likewise remain over $K$.
Any coefficient-Frobenius conjugate response is bijective over the
same field. Induction in the preceding delayed-extension construction
therefore gives the compatible full Hodge tower over $W(K)$.

## 5. Actual groups and failure of potential descent

The [all-height actual dictionary](all_height_bt_hodge_dictionary.md)
turns that compatible marked tower into a full group on $T$, retaining
its first periodic datum and finite determinant. The original
square-trivial line is already retained in the model. Pull the chosen
fourth-root correction from $C$ to the SPECIAL FIBER $T$ once; then
lift that prime-to-five torsion line and its marking uniquely on each
$T_n$. No higher map $T_n\to C_n$ is used. Alternatively,
the accepted finite-character classification of realizations of the
same projective oper compares the resulting first truncation with
the ACTUAL $H_C|_T$. Twisting the full group by the corresponding
Teichmuller character makes them isomorphic on $T$ itself. This uses
no new cover and no assumption that an arbitrary rational lattice is
effective. Normalize the determinant if necessary by its permitted
rank-one etale twist trivial at level one.

All initial tame line, root, determinant and BT1-marking data are
finite data over $k$ and hence descend to one finite extension of
$K$. The prime-to-five line and its trivializations lift uniquely
through the marked thickenings. The complete Hodge tower is already
over $W(K)$; scalar extension to this ONE field therefore suffices
for actual full effectivity with the exact prescribed first marking.
No assertion that every chosen original realization is defined over
$K$ itself is needed.

Thus $G_T[5]\simeq H_C|_T$ for an actual full $G_T$. Pull it to
$W$ and put $H_D=H_C|_D$. If $H_D$ had a BT2, prime-to-five
existence descent for the ACTUAL double $D\to C$ would give a BT2
of $H_C$, contrary to its evaluated obstruction. Nevertheless
$G_T|_W$ is a full prolongation of $H_D|_W$. This proves cyclic-five
failure of potential full-existence descent, as well as degree-five
non-Galois failure directly on $T\to C$.

The two maps in the dihedral diagram factor through the known $C$.
This example does not provide either requested unmarked common cover
or its exclusion. It removes another one-map descent route to that
problem.

## Reproduction

The source scripts are
[preparation](../../scripts/deformations/cyclic/prepare_exceptional_dihedral5.py),
[actual comparison](../../scripts/deformations/cyclic/exceptional_dihedral5_w4.py),
[whole fourth repair](../../scripts/deformations/cyclic/verify_exceptional_dihedral5_w4_point.py),
the [finite certificate checker](../../scripts/deformations/cyclic/certify_exceptional_dihedral5.py),
and [finite-field response checker](../../scripts/deformations/cyclic/certify_exceptional_dihedral5_arithmetic.py).
The checked certificate records all nineteen calibration labels,
six further comparisons, source snapshots, exact file hashes and the
two complete higher-precision replay receipts. Generated data remain
outside the research workspace under
`../litt3-computation-data/bt_obstruction_transport_20260921/`.
