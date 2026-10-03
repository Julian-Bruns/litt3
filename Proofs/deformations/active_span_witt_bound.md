# Proof: retain the actual first datum through the forced tower

[Statement](../../Theorems/deformations/active_span_witt_bound.md).
The later absolute extension torsor supplies the ordinary full tower.
The new finite actualization argument and pointed-cover census received
a [focused independent review](../../Research/audits/WITT_BOUND_ACTUALIZATION_AUDIT_2026_10_03.md).
The earlier [author check](../../Research/audits/ACTIVE_SPAN_WITT_BOUND_CHECK_2026_09_21.md)
is retained; neither review replays the settled arithmetic foundations.

## Fix the first periodic datum and its field

The [actual common-BT1 construction](common_admissible_bt1.md)
chooses $H_X,H_Y$ inducing the given projective opers. Use the
specified model of $H_Y/\mathbf F_q$. Their discrepancy on the
ORIGINAL $Z$ is one $\mathbf F_5^\times$-character. Its connected
trivializer $Z'\to Z$ has degree $c=1,2$ or $4$, and gives an
actual comparison
\[
(fh')^*H_X\simeq(gh')^*H_Y,\qquad h':Z'\to Z.
\tag{3}
\]
This compares the complete first crystalline periodic data,
including both arrows, Hodge line and determinant, by the
construction and full faithfulness between the existing groups.
It is not an inference from a projective bundle comparison.

Since the oper on $Y$ is indigenous-ordinary, its actual Cartier
defect is zero. The [absolute extension torsor](versal_bt_extension_torsor.md)
and [finite-field descent](common_bt_tower_rigidity.md) therefore give
the UNIQUE normalized full tower $G/Y$ over the SAME $\mathbf F_q$.
Normalize comparison determinants by the Teichmuller lift of
$\det(3)$. Fix the spin choices and their flat fourth-root corrections,
including horizontal trivializations, once. All these prime-to-five
characters lift uniquely through nilpotent curve thickenings.

## Actualize each existing forced projective tower

Suppose the ORIGINAL span has a simultaneous marked $W_M$ curve
lift, $M\ge2$. Its fixed finite etale refinement $Z'\to Z$ lifts
uniquely. Condition (J) persists on $Z'$ by negative-$H^1$ pullback
injectivity. The
[forced canonical-endpoint induction](forced_canonical_witt_endpoint.md)
supplies matching projective periodic filtered data through
$W_{M-1}$, relative to the given $W_M$ curves. Its vanishing Hodge
obstruction and unique Hodge lines retain the ENTIRE predecessor;
it constructs data on an existing diagram.

Here is the finite actualization missing from a bare projective
statement. On every nilpotent thickening, the
[etale site, Stacks Lemma76.9.6](https://stacks.math.columbia.edu/tag/05ZJ)
and its $\mu_2$ cohomology are unchanged, since $2$ is invertible. Lifts
of a projective rank-two bundle with a prescribed determinant
form a gerbe banded by $\mu_2$. The supplied actual first lift
kills its obstruction, and fixing that lift fixes the compatible
higher lift. This applies on both endpoints and to their comparison
on the SAME $Z'$.

Prescribe the entire rank-one determinant periodic datum, including
its connection and the determinant periodic and graded isomorphisms
with their Hodge rescaling. It is the normalized Teichmuller datum
already fixed by (3). A projective connection or $p$-connection has
a unique rank-two lift with that determinant connection: its central
difference has trace twice itself. Flatness follows by the same
trace calculation. The Hodge flag then gives an actual subline.

A projective periodic or graded ISOMORPHISM with prescribed determinant
has a $\mu_2$-torsor of lifts. Nilpotent etale invariance extends its
preceding actual lift uniquely. Its central failure of horizontality
has zero trace and hence vanishes. Consequently all predecessor
arrows, periodic identifications and source comparisons lift
compatibly, retaining the first marking. The SAME uniquely lifted
eighth-torsion line $\mathcal N$, with
$\mathcal N^4=\mathcal Q$ and $\mathcal N^8=\mathcal O$, corrects the
square-trivial periodicity line at every precision. No additional
character cover is needed. This argument concerns invertible periodic
and graded maps; it does not lift arbitrary noninvertible BT matrices.

The [actual all-height dictionary](all_height_bt_hodge_dictionary.md)
now supplies normalized groups $A_{M-1}/X$ and $B_{M-1}/Y$ with
comparison on $Z'$. A flow through $W_{M-1}$ relative to $W_M$
corresponds to BT$_{M-1}$: $M=2$ recovers (3), and $M=3$ gives BT2.
Ordinary uniqueness on $Y$ identifies $B_{M-1}$ with
$G[5^{M-1}]$, with its first marking and normalized determinant.
Matching filtered objects, rather than arbitrary extension-torsor
origins, supplied this comparison.

## Use the original degrees

The refined maps have degrees $cn,cm$. If
\[
M-1\ge N_{q,h}(c^2nm),
\]
then [bounded-degree descent](bounded_degree_bt_descent.md) gives
a full group on the ORIGINAL $X$ and a full comparison on $Z'$.
[Compatible full-group lifting](compatible_bt_lifting.md) lifts
both refined curve maps together. The
[refinement equivalence](etale_refinement_deformations.md) gives a
full lift of the ORIGINAL span, contrary to the hypothesis.
Therefore $M-1<N_{q,h}(c^2nm)$, or $M\le N_{q,h}(c^2nm)$.

The zero-joint-tangent deformation ring is $W/(5^e)$, with $e\ge2$.
If $e=\infty$, its universal diagram is already a full lift. Otherwise
its universal $W_e$ diagram exists, so the preceding bound applies
with $M=e$. This proves (1), since $c^2\le16$.

## Remove the field choice for the selected Y

The [ordinary-oper classification](ordinary_oper_bt_effectivity.md)
gives $85$ active projective opers on either fixed selected $Y_k$;
above each, its actual BT1 realizations form a torsor under
\[
V=H^1_{\rm et}(Y_k,\mathbf Z/4)\simeq(\mathbf Z/4)^4.
\]
Let $a\le85$ be the Frobenius period of the chosen oper.
Frobenius$^a$ acts AFFINELY on its BT1 torsor. Its linear part
preserves the alternating pairing on $V$: the principal polarization
and [duality for a curve](https://www.jmilne.org/math/CourseNotes/LEC.pdf)
give this pairing, and $q_0^a\equiv1\pmod4$ fixes its value group.
Thus this affine action belongs to $\operatorname{ASp}_4(\mathbf Z/4)$.

Every element of that group has order at most $24$. Indeed reduce
modulo two and represent the affine action by its augmented
five-dimensional matrix. The symplectic linear part has odd
semisimple order $1$, $3$ or $5$: reciprocal eigenvalues exclude
irreducible order-seven and order-fifteen factors in dimension four.
If the odd order is $1$, its augmented unipotent order is at most $8$.
If it is $3$, its one-primary part has dimension at most three,
and its degree-two primary part has multiplicity at most two;
the unipotent order is at most $4$, so the total order is at most $12$.
If it is $5$, the irreducible four-dimensional part and remaining
fixed line are semisimple, so its order is $5$.
Finally the reduction kernel has exponent two, since
\[
x\longmapsto(I+2A)x+2b
\quad\Longrightarrow\quad
\bigl(x\longmapsto(I+2A)x+2b\bigr)^2=\mathrm{id}\pmod4.
\]
Hence the affine order over $\mathbf Z/4$ is at most $24$.
A BT1 class therefore has Frobenius period
\[
s\le24a\le2040,
\]
although the total number of geometric BT1 classes is still $21760$.

Put $q=q_0^s$ and choose an isomorphism from the BT1's $q$-twist to
itself. Spread the object and comparison to $\mathbf F_{q^d}$.
Its $d$-fold composite is an actual scalar in $\mathbf F_5^\times$,
so its $4d$-fold composite is the identity. Effective cyclic descent
gives the object over $\mathbf F_q$; the enlargement checks the
cocycle and does not enlarge the final field. The absolute torsor
gives its unique normalized full tower over that SAME field.

Here $m=8n$, $q\le Q_Y=q_0^{2040}$, and $N_{q,h}(d)$ is increasing
in numerical field size and degree. Thus
\[
e\le N_q(8c^2n^2)\le N_{Q_Y}(128n^2).
\]
No divisibility of $s$ into $2040$ is required. The selected pairs'
established full-lift exclusions give nonliftability, and a coreless
genus-two span gives (J). This proves (2).
