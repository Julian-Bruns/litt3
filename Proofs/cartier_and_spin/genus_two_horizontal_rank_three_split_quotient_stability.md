# Proof: a destabilizing subbundle would split a forbidden connection summand

Version1, 3 October2026. [Statement](../../Theorems/cartier_and_spin/genus_two_horizontal_rank_three_split_quotient_stability.md); [independent five-point static review: PASS](../../Research/audits/OCT03_GRAM_FOUR_DEGREE_ONE_HORIZONTAL_STABILITY_STATIC_REVIEW.md). No computation is used.

## Regular connections and ordinary direct summands

A line with a regular algebraic connection has degree zero modulo five. For a nonzero rational section s, write it in a regular local frame as f times that frame. The meromorphic differential ∇s/s has residue ord(f) in the field: the regular frame's connection form contributes no residue. Summing residues on the projective curve gives deg(divs)=0 in characteristic five. This proves the assertion without requiring zero p-curvature.

If a bundle with a regular connection splits ordinarily as S⊕T, inclusion, connection and projection compose to a regular connection on S. The Leibniz rule holds because projection after inclusion is the identity. Its determinant has the induced regular line connection. Thus an ordinary degree-two line summand or rank-two degree-four summand is impossible here; no horizontal invariance of the summand is presumed.

## Bound all line subbundles

Let S⊂E be saturated of rank one. If degS>2, both maps S→Qi vanish by degree. Then S injects into B, contradicting degB=1.

If degS=2, its quotient map S→Q1⊕Q2 is nonzero. Some component S→Qi is an isomorphism because these two lines have equal degree. The inverse of that component, composed with E→Qi, is a regular left inverse to S⊂E. Equivalently its image is a graph summand in Q1⊕Q2; if the Qi are nonisomorphic the other component is zero, and if they are isomorphic it is a constant multiple. Thus S is an ordinary degree-two direct summand of E. The projected connection contradicts the residue argument. Therefore every line subbundle has degree at most one.

## Bound all rank-two subbundles

Let S⊂E be saturated of rank two. If its intersection with B has rank one, the intersection line has degree at most one and the quotient image in Q1⊕Q2 is a line of degree at most two. A line mapping into the direct sum has a nonzero component into some Qi, so this latter degree bound is immediate. Hence degS≤3.

If its intersection with B has rank zero, its map into Q1⊕Q2 is an injection of full-rank bundles. Consequently degS≤4. At equality its torsion cokernel has length zero, so S maps isomorphically onto the entire quotient and splits the original extension. The ordinary summand S then has a projected regular connection, whose determinant has degree four, again impossible. Hence degS≤3 in this case too.

At slope μ(E)=5/3, line degree≤1 and rank-two degree≤3 are exactly the strict stability inequalities. This proves stability.

## The trivial marked class has one ordinary middle bundle

When B=O(P), Q1=Q2=ωY and ωY=O(2P), the extension is encoded by two vectors in
\[
\operatorname{Ext}^1(\omega_Y,O(P))
=H^1(O(-P)).
\]
Riemann–Roch and negative-degree H0 vanishing give dimension two. If the two vectors are dependent, some nonzero constant quotient direction has zero extension class. After changing the two quotient coordinates, the original extension splits a degree-two ωY summand. Its projected regular connection is forbidden. Thus the two vectors are independent.

The group GL2(k) of the two identical quotient lines acts transitively on ordered bases of this two-dimensional extension space. It follows that every such extension has the same ordinary middle-bundle isomorphism class, the universal extension with independent classes. This does not fix the supplied quotient basis, its marked evaluation, or its regular connection. Nor does it classify zero-p-curvature connections or their relative-Frobenius roots.

For the actual source corollary, the [proved original splitting](canonical_ten_gram_four_original_kernel_quotient_splitting.md) has Q1=H/B and Q2=ωY. Both have degree two when degB=1, and E=F_Y*K carries the canonical regular connection independently of whether the original inclusion K⊂B1,Y was saturated. The reusable lemma applies directly. On the stated charts B=O(P), and the trivial marked quotient makes Q1=ωY, giving the universal extension. Every original map, marking and scalar comparison remains in place.
