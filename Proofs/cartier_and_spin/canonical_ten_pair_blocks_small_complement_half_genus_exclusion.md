# Proof: small pair kernels give an actual block field, large kernels give a conductor gap

Version1, 3 October 2026. [Independent whole audit PASS](../../Research/audits/OCT03_PAIR_BLOCKS_SMALL_COMPLEMENT_HALF_GENUS_WHOLE_AUDIT_2026_10_03.md), with no required corrections. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_pair_blocks_small_complement_half_genus_exclusion.md).

## The actual ten-orbit forces an alternating block group

Take only the normal closure L/F of the SINGLE actual E/F extension. Let M=Gal(L/F), acting transitively and faithfully on2b sheets in b pairs, and let H=Gal(LA/A)⊂M. The ACTUAL connected component T/A selects an H-orbit Δ of size ten and full induced S10 action. Intersections of Δ with the pairs form an H-invariant partition. S10 primitivity and pair size less than ten imply that Δ is a partial transversal, occupying exactly ten pairs, with one selected sheet in each.

Let G be the induced group on the b pairs and Hbar the image of H. On the ten selected pairs Hbar induces S10, while preserving the remaining b−10<10 pairs. The kernel of the latter action injects into S10, has normal image there, and is nontrivial: otherwise Hbar would embed in S_(b−10), though it surjects onto S10. Its image thus contains A10 supported on the selected ten pair-indices and fixing all other indices.

The supported-alternating-group argument of the [arbitrary-base proof](canonical_ten_small_complement_arbitrary_base_exclusion.md) now applies verbatim to G. Any two ten-element supports among b≤19 indices meet; supported alternating groups on intersecting supports generate the alternating group of their union. Transitivity and conjugation therefore give
\[
A_b\subset G\subset S_b.
\]
This step uses no finite-group catalog and no presumption that an abstract alternating quotient is supported.

Identify pair-flips with W=F2^b and write M⊂W⋊S_b. Its block kernel V=M∩W is an A_b-invariant subspace. Let C be the constant line and U the augmentation hyperplane. The only possibilities are
\[
V=0,\quad C,\quad U,\quad W.
\]
Indeed for any nonconstant binary vector, choose three coordinates with two equal and the third unequal. Subtract its cyclic permutation on those coordinates; this gives a coordinate-pair difference. A_b-transitivity on pairs yields every such difference, which span U. A vector outside U then gives W. This reasoning also covers odd b, where C is not contained in U.

## Small kernels normalize to a global flip character

Suppose V=0 orC. We prove a genuine ordinary A_b section, without assuming a split symmetric-group lift or using a Schur multiplier classification.

Use the presentation of A_b on
\[
t_i=(i\ b-1\ b),\quad i=1,\ldots,b-2,
\qquad t_i^3=1,\quad(t_it_j)^2=1\quad(i\ne j).
\]
This is Carmichael's presentation, stated in the [primary presentation reference](https://ems.press/content/serial-article-files/31768), page397 equation(3.1); it is the same standard presentation used in the audited triple-block kernel proof. Choose a lift of every t_i. Its cube is in V. If that cube is the nontrivial global flip, multiply the lift by that flip; centrality and odd order three make the corrected cube trivial. Thus each lift has order three.

On every coordinate fixed by t_i, an order-three permutation of a two-element fiber is trivial. Each corrected lift is consequently supported on its three moved pairs. The square of a product of two such lifts projects to(t_it_j)²=1, so belongs to V, and is supported on at most four coordinates. Since b>4, it cannot be a nontrivial constant flip. It is the identity. The presentation therefore gives a section A_b→M mapping isomorphically onto A_b.

This section can be relabeled to the ordinary permutation action on the pair-indices. The stabilizer of one index in A_b is A_(b−1), which is perfect; its action on that two-element fiber must be trivial. Transport one choice of label along A_b. Stabilizer triviality makes this well-defined, and in these labels all section elements have zero flip vector. Relabeling does not change the constant flip subgroup.

For any m=(v,p)∈M, conjugate the ordinary section by m. Above each a∈A_b, comparison with the same ordinary section gives
\[
v-av\in V\subset C.
\]
For a three-cycle, the left side is supported on at most three coordinates; b>3 makes a nonzero constant impossible. Hence v is fixed by every three-cycle and is constant. We have proved
\[
M\subset C\times S_b
\]
in the normalized sheet action. Its global flip character ε:M→C2 is surjective: if it were zero, the two sets of all label-zero and all label-one sheets would be separate orbits, contrary to M-transitivity.

The E-sheet stabilizer Mp has ε=0, because a global flip cannot fix a sheet. Also ε|H=0. To see the latter with arbitrary selected labels in Δ, the kernel of H's action on the ten selected indices fixes a selected sheet and so has ε=0. Thus ε factors through that S10 action. Every selected transposition has eight fixed selected indices, so every lift of it in H has ε=0. Transpositions generate S10, proving the assertion. This does not require Δ to have been labeled as a constant-sign set in advance.

Let
\[
R=L^{\ker\varepsilon}.
\]
It is an ACTUAL field in both E=L^Mp and L^H=L∩A, with [R:F]=2 and [E:R]=b. Passing to this common base doubles both normalized genera:
\[
u_{E/R}=2u_E\ge32,\qquad
u_{A/R}=2u_A\le\tfrac12u_{E/R}.
\]
All actual compositum, étaleness and S10 monodromy data are unchanged. The general normalized-genus inequality in the [arbitrary-base small-complement theorem](canonical_ten_small_complement_arbitrary_base_exclusion.md) contradicts this: its factor η≥10/11 gives
\[
u_{A/R}\ge\eta u_{E/R}+(1-\eta)(2g(R)-2)
>\tfrac12u_{E/R}
\]
whenever u_(E/R)≥16, since g(R)≥0. This excludes both small kernels, including potentially transitive zero-kernel signed actions.

## Large kernels give a faithful actual partial-transversal resolvent

Suppose V=U orW. Let Ψ be the M-orbit of Δ. It is the set of ALL partial transversals on ten pairs:
\[
D=|\Psi|=\binom b{10}2^{10}.
\]
The block group A_b orS_b is transitive on the ten selected indices. On any chosen ten, both V=U andV=W realize every label choice: in the augmentation case, correct the parity in an omitted coordinate, which exists because b>10.

Let J=MΔ be the setwise stabilizer and Z=L^J. Since H≤J,
\[
Z\subset A,\qquad[Z:F]=D.
\]
The distinguished E-sheet p lies in Δ. The Mp-orbit of Δ consists of every partial transversal containing p. Indeed its block quotient contains the ordinary A_(b−1) orS_(b−1) action on the other indices: given a lift fixing the p-index, adjust its flip at p using V. The remaining selected label choices can again be prescribed in V with parity corrected on an omitted coordinate.

This orbit action of Mp is faithful. If a permutation fixes all these transversals, its induced block permutation fixes all nine-subsets of the other b−1 indices, hence every index. Then the choices of labels in transversals detect every flip on every other coordinate, and fixing p forbids a flip on its own coordinate. The permutation is identity. In particular there is no hidden partner-swap kernel, unlike the three-sheet-block case.

Thus the normal closure of EZ/E is exactly L/E. Since EZ⊂AE=T and T/E is actually étale, EZ/E and its normal closure are étale. Normality over F gives the same over every conjugate E-sheet. All inertia groups of L/F, and all their lower subgroups, therefore act semiregularly on the original2b sheets.

## Exact fixed-transversal counts include every wild group

If a nonidentity semiregular element g fixes a partial ten-transversal, its order e divides ten: its action on that ten-set is free. Only e2,e5,e10 need be considered.

For e2, a fixed pair-index must have its two sheets flipped, since a fixed sheet would violate freeness; it cannot be selected in an invariant transversal. A two-cycle of pair-indices contributes two invariant label choices. If a is the number of these two-cycles, then a≤floor(b/2) and
\[
f(g)=\binom a5 2^5
\le\binom{\lfloor b/2\rfloor}5 2^5.
\]
For e5, every block cycle has length five with zero total flip, because sheet orbits all have length five. An invariant ten-transversal selects two such cycles, with two choices per cycle. This can occur in the stated range only at b15, where f(g)=binom(3,2)2²=12.

For e10, block cycles have length five with nonzero total flip or length ten with zero total flip. The former admit no invariant transversal; a selected ten-cycle has two invariant label choices. Since b<20 there is at most one ten-cycle, so f(g)≤2. Every other element order has f(g)=0.

In the involution row,
\[
\frac{f(g)}D\le
\frac{\binom{\lfloor b/2\rfloor}5}{32\binom b{10}}\le\frac1{352}.
\]
For the final inequality the denominator ratio binom(b,10)/binom(floor(b/2),5) is11 at b11 and b12, and is increasing along both parity sequences. Its successive ratio for b=2a is(2a+1)/(2a−9)>1, and for b=2a+1 is(2a+3)/(2a−7)>1. The e5 and e10 rows satisfy the same bound immediately: D≥11·1024=11264, so12/D<1/352 and2/D<1/352. Consequently every nonidentity semiregular element has fixed fraction at most1/352.

For every nontrivial semiregular subgroup B, Burnside gives
\[
1-\frac{\#(\Psi/B)}D
\ge\frac{351}{352}\left(1-\frac1{|B|}\right).
\]
The second factor is the normalized orbit-codimension on the original sheets. Apply this subgroup inequality term by term to the ordinary characteristic-zero permutation Artin conductor, with its nonnegative lower-ramification weights. The different-conductor equality then gives
\[
\frac{\Delta_Z}D\ge\frac{351}{352}\frac{\Delta_E}{2b}.
\]
This includes ALL wild inertia and all lower breaks in characteristic five; no characteristic-five permutation-invariant dimension is used.

## The genus contradiction over an arbitrary base

Put v=2g(B)−2≥−2. Hurwitz and the conductor inequality yield
\[
\frac{2g(Z)-2}D
\ge\frac{351}{352}u_E+\frac v{352}.
\]
Since the ACTUAL field Z lies in A, separating Hurwitz bounds this above by uA. But
\[
\frac{351}{352}u_E+\frac v{352}-\frac12u_E
=\frac{175u_E+v}{352}
\ge\frac{2800-2}{352}>0.
\]
This contradicts uA≤uE/2, excluding the large kernels. Together with the small-kernel actual-field argument it excludes every pair-block monodromy sector in the stated range. Only the single bridge normal closure and actual fields inside the original source have been used.
