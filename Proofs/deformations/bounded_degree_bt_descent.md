# Proof: use the actual descent relation over the fixed endpoint

[Statement](../../Theorems/deformations/bounded_degree_bt_descent.md).
The two inputs are the established
[full-group arithmetic comparison cutoff](finite_field_full_bt_cutoff.md)
and [normalized finite-group rigidity](versal_bt_display_descent.md).
The new step is to bound fields for the actual descent relation, so
that no full group on the other endpoint is required.

## Count actual pointed self-correspondences

Fix $y_0\in Y(\mathbf F_q)$ and write $g_e=1+e(h-1)$.
The full geometric fundamental group of $Y$ has at most $2h$
generators, by lifting this ONE curve to characteristic zero and
using the [proper smooth specialization epimorphism](https://stacks.math.columbia.edu/tag/0BUQ).
The later [pointed-cover count](../curve_arithmetic/genus_two_quotient_descent.md#descent-of-the-original-first-leg)
can be used with its automorphisms retained.

Let $\mathcal T_e$ be the transitive homomorphisms $\pi_1(Y_k)\to S_e$.
Then $|\mathcal T_e|\le(e!)^{2h}$. Conjugation by the stabilizer
$S_{e-1}$ of one letter is free: a centralizer of a transitive group
fixing one letter is trivial. Thus the number of pointed connected
degree-$e$ covers is at most
\[
P_e=\frac{|\mathcal T_e|}{(e-1)!}\le e(e!)^{2h-1}.
\tag{5}
\]
For UNPOINTED cover classes $c:T'\to Y$, retain the weighted count
\[
\sum_{[c]}\frac1{|\operatorname{Deck}(c)|}
=\frac{|\mathcal T_e|}{e!}\le(e!)^{2h-1}.
\tag{6}
\]

Fix one pointed cover $(T,c_1,t_0)$, where $c_1(t_0)=y_0$. For a
second cover $c_2':T'\to Y$, pairs $(c_2,\theta_1)$ on $T$, with
\[
\theta_1:c_1^*G[5]\xrightarrow{\sim}c_2^*G[5],
\]
are represented by isomorphisms of the actual pairs
$(T,c_1^*G[5])$ and $(T',c_2'^*G[5])$. If nonempty, that isomorphism
set is a torsor under the automorphism group of the first pair.
The [versal-BT1 tame-stabilizer theorem](versal_bt_tame_automorphisms.md)
bounds its underlying curve group by $24(g_e-1)$. Its kernel is
the four actual scalar automorphisms $\mathbf F_5^\times$.
Its size is therefore at most $96e(h-1)$.

The canonical lifts of $\operatorname{Deck}(c_2')$ act FREELY on this
isomorphism set. Two representatives yield the same $(c_2,\theta_1)$
exactly when they differ by such a deck transformation, retaining its
canonical action on the pulled-back group. Combining (5) and (6)
bounds the number of entire pointed tuples
$(T,c_1,c_2,t_0,\theta_1)$ by
\[
96e(h-1)P_e\sum_{[c_2']}\frac1{|\operatorname{Deck}(c_2')|}
\le96(h-1)e^2(e!)^{4h-2}=M_{h,e}.
\tag{7}
\]
One marked point kills every automorphism of the first cover; a
complete labeling is unnecessary. No simultaneous Galois closure
is used.

## Descend the entire tuple over its orbit field

The $q$-Frobenius permutes these tuples. A tuple's orbit length
$s$ is at most $M_{h,e}$. Its automorphism group is trivial, so its
comparison with its $q^s$-twist is unique and satisfies descent.
All data have finite presentation: spread them and this comparison
to a finite extension. The composite around that extension is an
automorphism of the pointed tuple, hence the identity. Effective
finite-field descent gives the ENTIRE tuple over $\mathbf F_{q^s}$,
including both maps and the supplied $\theta_1$.

The full groups $c_1^*G,c_2^*G$ now live on this same finite-field
curve. Their determinant comparison is the Teichmuller lift of
$\det\theta_1$. Any geometric normalized higher comparison also
descends over that field by uniqueness.

For $e\le d$, write $g=g_e$ and let $l$ be the least integer with
$(q^s)^l\ge8(2g+1)$. Then
\[
g\le g_{h,d},\quad s\le M_{h,d},\quad l\le l_{h,d},\quad
4g16^g(q^s)^{5g}\le A_{q,h,d}.
\]
The sharper [full-group cutoff](finite_field_full_bt_cutoff.md),
with finite-field exponent $fs$ and test degree $16l$, is consequently
at most
\[
A_{q,h,d}(A_{q,h,d}-1)(16fs\,l_{h,d}+2)
\le N_{q,h}(d).
\tag{8}
\]
Thus a comparison at level $N_{q,h}(d)$ on ANY such degree-at-most-$d$
self-correspondence extends uniquely to the full groups, retaining
its supplied finite-level marking. No source ordinariness is used.

## Apply the bound to the original f-descent relation

Return to the actual span, and form
\[
R=Z\times_X Z,\qquad p_1,p_2:R\to Z.
\]
Each connected component T is smooth proper and geometrically
connected over k. The two maps $c_i=b p_i:T\to Y$ are finite etale.
Their degrees agree by Riemann--Hurwitz, and both are at most mn:
each projection $p_i$ has degree at most n. Thus the preceding
bound applies with $d=mn$ to EVERY component, including components
on which the two maps happen to agree. No joint-minimality assumption
is required.

The actual descent of $a^*A$ defines a normalized level-N comparison
\[
\theta_N:p_1^*b^*G[5^N]\xrightarrow{\sim}p_2^*b^*G[5^N]
\tag{9}
\]
on R, obtained from the supplied $\eta_N$. Its reduction is the
particular $\theta_1$ used in (6), and its determinant is the
Teichmuller lift of that comparison. Equation (8) upgrades (9)
component by component to a full isomorphism $\theta$.

These full isomorphisms satisfy the original descent cocycle. On
each component of $Z\times_XZ\times_XZ$, the two candidate composites
have the same BT1 marking and determinant, and are therefore equal
by normalized uniqueness. The same argument gives the identity on
the diagonal. This checks actual descent data rather than merely
pairwise isomorphism classes.

Effective fpqc descent of every finite locally free Hopf algebra
$b^*G[5^r]$, compatibly for all r, gives a full BT group $G_X/X$.
The height, dimension, normalization and versality descend through
the finite etale surjection a. At level N, the descended object is
the original A, because its descent datum is exactly (9).
The full comparison retains $\eta_N$.

Determinant normalization poses no extra restriction on existence.
If needed, normalize A by its rank-one etale determinant correction,
trivial on BT1. Its pullback correction is trivial under the supplied
comparison with the already normalized $b^*G[5^N]$. Correcting that
comparison by its unique scalar square root retains the BT1 marking.
Once normalized, (9) has the required determinant cocycle. No
independent adjustments on components are made.

## Consequence for the two candidate pairs

Compatible full everywhere-versal height-two groups on the original
span supply the compatible crystal and oper line of
[crystalline oper lifting](crystalline_oper_lifting.md), so the two
ORIGINAL maps lift together. The main candidate excludes this by the
established liftable-coreless theorem. The backup now excludes it by
[the complete arithmetic reduction theorem](../curve_arithmetic/backup_arithmetic_reduction_exclusion.md).
Both already exclude cored spans.

For the fixed genus-nine/genus-two endpoints, $m=8n$; substituting
$d=8n^2$ proves (3). This argument does not say that compatible
BT$_N$ data exist at any such height, or even at height one.
It provides an explicit degree-dependent upper bound for how far
any supplied compatible truncation of this fixed full group on Y
can descend. It does not assert a uniform bound as n grows.

## Deep self-comparisons on the backup come from automorphisms

For this paragraph take Y to be the explicit backup. By (8), the
assumed sufficiently deep self-comparison extends to the full groups.
If the self-span were coreless, crystalline oper lifting and the
characteristic-zero correspondence theorem would make Y a potentially
good reduction of a compact arithmetic genus-two curve. The new
arithmetic exclusion forbids this. Thus the self-span has a core.

In this CORED case there is an actual finite etale common refinement
W which is Galois over both endpoint copies. Let $H_1,H_2$ be the
two deck groups and $J=\langle H_1,H_2\rangle\subset\operatorname{Aut}(W)$.
The common pulled-back BT1 is preserved by J. The tame-stabilizer
theorem therefore makes $W\to D=W/J$ tame. Since $W\to W/H_i=Y_i$
is etale, each map $Y_i\to D$ has complete uniform branch fibers
with the same tame inertia as $W\to D$.

The backup has a geometrically simple Jacobian and no elliptic
quotient. Hence $g(D)=1$ is impossible. If $g(D)\ge2$,
Riemann--Hurwitz forces both maps $Y_i\to D$ to have degree one.
Their embedded fields are then equal.

If $D\simeq\mathbf P^1$, the
[complete Y-only tame-atlas exclusion](../quotient_geometry/endpoint_exclusions/backup_tame_uniform_atlases.md)
makes both maps $Y_i\to D$ quadratic hyperelliptic quotients. They
have the SAME branch support: the $H_i$ act freely on W, so every
nontrivial J-inertia group remains nontrivial in both quotients.
Two quadratic extensions of $k(\mathbf P^1)$ with that same branch
support are equal. Indeed their defining Kummer functions have a
ratio of even divisor, which is a square because
$\operatorname{Pic}^0(\mathbf P^1)=0$ and k is algebraically closed.
Again the two embedded Y-fields coincide.

In all cases the original maps satisfy $c_2=\sigma c_1$ for an
automorphism of Y. The argument allowed nonminimal T throughout;
it is the equality of the two embedded fields that proves the
claimed joint-minimal conclusion. The finite common Galois refinement
was used only after proving that this particular span has a core.
