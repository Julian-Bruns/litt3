# Proof: use the actual descent relation over the fixed endpoint

[Statement](../../Theorems/deformations/bounded_degree_bt_descent.md).
The two inputs are the established
[full-group arithmetic comparison cutoff](finite_field_full_bt_cutoff.md)
and [normalized finite-group rigidity](versal_bt_display_descent.md).
The new step is to bound fields for the actual descent relation, so
that no full group on the other endpoint is required.

## Count marked self-correspondences of Y

Fix a rational base point $y_0\in Y(\mathbf F_q)$. Its geometric
fundamental group has at most four topological generators. Indeed,
lift the smooth proper curve to characteristic zero; the
[proper smooth specialization epimorphism](https://stacks.math.columbia.edu/tag/0BUQ)
and the characteristic-zero surface presentation give this assertion.
This applies to ALL finite etale covers, not just covers of order
prime to five.

For a positive integer $e$, label the $e$ geometric points over
$y_0$ of a connected degree-e etale cover. Its isomorphism class is
specified by a transitive homomorphism to $S_e$. Hence the number
of such labeled covers is at most
\[
C_e=(e!)^4.
\tag{4}
\]
The labeling kills every automorphism of the cover. Write $g_e=e+1$
for its genus.

Consider geometric tuples
\[
(T,c_1,c_2,\lambda,\theta_1),
\qquad c_i:T\to Y_k\text{ finite etale of degree }e,
\tag{5}
\]
where $\lambda$ labels $c_1^{-1}(y_0)$ and
$\theta_1:c_1^*G[5]\simeq c_2^*G[5]$ is an actual isomorphism.
There are at most $C_e$ choices for the first labeled cover, and
at most $C_e$ isomorphism classes for the second cover $T'\to Y$.
To realize the second one on T with $\theta_1$, one must choose
an isomorphism of the ACTUAL pairs
\[
(T,c_1^*G[5])\simeq(T',c_2^*G[5]).
\tag{6}
\]
If nonempty, this set is a torsor under the automorphism group of
$(T,c_1^*G[5])$. Its underlying curve automorphism group has order
at most $24(g_e-1)=24e$ by
[the proper versal-BT1 tame-stabilizer theorem](versal_bt_tame_automorphisms.md).
Each underlying automorphism has at most four lifts to the pair.
Indeed, generic ordinary nonsplitting and the nonzero Kodaira--Spencer
map give scalar endomorphisms $\mathbf F_5$ over the function field,
so the actual automorphisms over the identity of this reduced curve
are $\mathbf F_5^\times$.

Thus the isomorphism set (6) has at most $96e$ elements. Different presentations of a
second cover may give the same tuple, which only decreases the count.

It follows that the finite set of tuples (5) has cardinality at most
\[
96eC_e^2=96e(e!)^8=M_e.
\tag{7}
\]
No simultaneous Galois closure has been used.

## A field bound retaining the actual BT1 comparison

The q-Frobenius permutes the set (5). Each tuple has orbit length
$s\le M_e$. Because its automorphism group is trivial, the
isomorphism from its $q^s$-twist is unique and satisfies all descent
identities. All data are of finite presentation, so effective finite
field descent gives a model of the ENTIRE tuple over
$\mathbf F_{q^s}$. In particular both maps and the supplied
comparison $\theta_1$ descend, not just the abstract curve T.

For clarity, continuity causes no extra field factor. Initially put
the tuple and the unique Frobenius comparison over one finite
extension. A power fixing that initial model is an automorphism of
the labeled tuple and hence the identity. Thus the resulting finite
cyclic descent datum is effective.

The two full groups $c_1^*G,c_2^*G$ now live on this same finite-field
curve. Their common BT1 marking is $\theta_1$. Its determinant gives
the prescribed identification of their Teichmuller determinant
characters. A normalized comparison at any higher level is unique,
so a geometric such comparison also descends to $\mathbf F_{q^s}$.

For $e\le d$ we have $g_e\le g_d$ and $s\le M_e\le M_d$. In the
arithmetic cutoff, the quantity $A$ on this finite-field curve obeys
\[
4g_e16^{g_e}(q^s)^{5g_e}\le A_d.
\]
Its least l with $(q^s)^l\ge8(2g_e+1)$ is at most $l_d$. Hence its
cutoff is at most
\[
1+4A_d^2(1+16fs l_d)\le N_q(d).
\tag{8}
\]
The established cutoff therefore upgrades every normalized
level-$N_q(d)$ comparison on ANY such actual degree-at-most-d
self-correspondence to a unique full comparison. The supplied
finite-level comparison is retained by normalized finite-level
uniqueness. Source ordinariness is never used.

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
