# Proof: the actual cyclic upper bridge and partial transversals

Version1, 3 October2026. [Fresh independent seven-check whole audit PASS](../../Research/audits/CANONICAL_TEN_UPPER_CYCLIC_TRIPLES_SIX_THROUGH_NINE_AUDIT_2026_10_03.md), with no required mathematical corrections. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_upper_cyclic_triples_six_through_nine_exclusion.md).

## Keep the upper source and its degree identities

Put A=k(Γ), b=2r′∈{12,14,16,18}. The actual extension E/F has degree3b and its intermediate B′ gives b triples. The original T→C0 is étale because it is an intermediate factor of either original finite étale endpoint map. Thus the displayed intermediate T/E is genuinely étale, whereas T/B′ need not be. Both original endpoint maps remain on T.

The exact degrees in the statement give
\[
u_E=\frac{2g(E)-2}{[E:F]}=\frac{32d}{6r'}\ge16,
\qquad
u_A=\frac{2g(\Gamma)-2}{[A:F]}=u_E/2.
\tag{1}
\]
These are normalized over F. Over any common intermediate base the same half-ratio follows by multiplying both expressions by its degree over F. No common-divisor degree calibration or lower endpoint map is substituted for (1).

Let L/F be the normal closure of the SINGLE separating extension E/F, and M its faithful transitive group on its3b sheets. Let H=Gal(LA/A) under its natural identification with a subgroup of M. The actual compositum AE=T and the full S10 monodromy of T/A give an H-orbit Δ of ten sheets with induced permutation group S10. Its intersections with the b triples form a partition invariant under that primitive ten-point action. Δ cannot lie in one triple; hence it meets ten distinct triples once.

## The block image and the cyclic orientations

Let G be the block image of M and V its block kernel. The block action is primitive. Indeed a proper block partition either meets Δ in singletons, which requires at least ten blocks each of size at least two and therefore b≥20, or contains all ten points in one block, which is impossible for a proper block of size at most b/2<10.

The H-action on the complementary b−10≤8 triples has trivial restriction on the alternating subgroup A10 of its ten-orbit image. To make this precise, the image of H in S10×S_(b−10) projects onto S10. Its intersection with S10×1 is normal in S10. If it did not contain A10, the simple group A10 would occur as a subquotient of S_(b−10), impossible since |A10|>(b−10)!. Thus G contains a supported A10 and in particular a supported three-cycle. The elementary primitive-group argument in the [arbitrary-base small-complement proof](canonical_ten_small_complement_arbitrary_base_exclusion.md), under exactly 11≤b≤19, gives G=A_b or S_b. Only its primitive ten-orbit/three-cycle lemma is used here.

Because E/B′ is Galois cyclic three, the FULL stabilizer in M of a triple acts on that triple as C3. Choose labels F3 on one triple and transport them to every other triple by chosen elements of M. For an element of M carrying triple i to triple j, comparison with the two chosen transporters is an element of the first triple stabilizer. Its coordinate action is a translation, with linear coefficient+1. Consequently
\[
M\subset W\rtimes G,\qquad W=\mathbf F_3^b,
\tag{2}
\]
with G acting by ordinary coordinate permutations. There is no signed coordinate action and no presumed complement.

Every coordinate projection of V is nonzero. Otherwise its normal image in the full C3 triple stabilizer would be trivial, so that C3 would be a quotient of the block point stabilizer A_(b−1) or S_(b−1). Those groups have no C3 quotient: their alternating subgroup is perfect and their remaining quotient has order at most two. Thus V is a subspace of W with nonzero coordinates, invariant under the ordinary A_b.

Let C=F3·1 and U={w:Σw_i=0}. Then
\[
V=C,\ U,\text{ or }W.
\tag{3}
\]
For completeness, if V contains a nonconstant w, choose w_i≠w_j and two other equal coordinates w_k=w_l; the latter exist because b−2≥10 and there are only three values. The difference under (i j)(k l) is a nonzero multiple of e_i−e_j. Ordered-pair transitivity gives every coordinate difference and therefore U⊂V. Since U has codimension one, (3) follows. The modular cases b12 and18, where C⊂U, are included.

## A constant kernel gives an actual large-block bridge

Suppose V=C. The translation part of (2), modulo C, is a cocycle c:G→W/C. It is a coboundary. Here is the needed argument, which works for all four b.

Restrict to A_b and then to R=A_(b−1), fixing coordinate b. Represent each class in W/C by its vector with coordinate b zero. As an R-module it is the ordinary permutation module on the other b−1 coordinates. The stabilizer A_(b−2) is perfect, so the permutation-module cocycle identity kills c|R after one coboundary adjustment: its chosen coordinate on the stabilizer is an additive character, hence zero, and transporting coordinates reconstructs that coboundary.

Take a three-cycle t containing b and put J=R∩tRt^−1. Since c|R=0, c(t) is J-invariant. A representative therefore differs from a constant by a e_b+d e_(t(b)). The equation (1+t+t²)c(t)=0 and any coordinate outside t force a+d=0. Subtracting the coboundary of a e_b kills c(t) without changing c|R. The group R together with t generates A_b, so c|A_b=0. Finally (W/C)^(A_b)=0: a three-cycle changes a fixed representative by a constant, and a coordinate outside that cycle forces that constant zero; all three-cycles then make the representative constant. Comparing c(ag) and c(g(g^−1ag)) kills c(g) for every g∈G. This proves the assertion without requiring division by b.

After translation relabeling, every actual element of M has a global translation and its ordinary block permutation. Thus M preserves the three horizontal label sets, each of size b. Since Δ has primitive ten-point H-action and there are only three such blocks, Δ lies in one of them. The distinguished large-block field R0 is consequently an ACTUAL subfield of E∩A, with
\[
[E:R_0]=b,\qquad AE=T,
\quad T/E\text{ étale},\quad[T:A]=10\text{ with full }S_{10}.
\]
Apply the [arbitrary-base small-complement theorem](canonical_ten_small_complement_arbitrary_base_exclusion.md) over R0. Its n is b∈{12,14,16,18}, its actual two compositum fields are E and A, and (1) gives the same-base half-genus relation. Moreover
\[
\frac{2g(E)-2}{[E:R_0]}=\frac{32d}{2r'}\ge48>16.
\]
All its hypotheses are supplied, so this case is excluded for every genus of R0.

## A large kernel gives a faithful actual étale resolvent

Suppose V=U or W. The M-orbit Ψ of Δ is the set of all ten-element partial transversals of the b triples. Indeed G=A_b or S_b is transitive on ten-subsets, and U projects onto arbitrary assignments on any chosen ten coordinates because at least two coordinates are omitted. Hence
\[
D=|\Psi|=\binom b{10}3^{10}.
\tag{4}
\]
Let R=L^(M_Δ). Since H fixes Δ, R⊂A and ER⊂AE=T.

For the distinguished E-sheet p∈Δ, the M_p-action on its orbit of Δ is faithful. Its orbit contains all partial transversals through p. The block stabilizer A_(b−1) or S_(b−1) is transitive on the chosen nine other triples, every lift can be adjusted by V to fix p, and V with p-coordinate zero projects freely onto the other nine selected labels. For every sheet q outside p's triple, the intersection of these transversals containing q is exactly {p,q}: any further coordinate can be omitted or varied, with unused coordinates compensating the augmentation sum. An element in the action kernel must therefore fix every such q. Its only possible support lies in p's own triple, but its action there belongs to C3 and fixes p, hence is identity.

The normal closure of ER/E inside L is therefore EXACTLY L/E. The actual ER⊂T and T/E étale imply that ER/E, and then its normal closure L/E, are étale. Conjugation gives L/E_q étale for every E-sheet q. Thus every inertia subgroup of L/F intersects every point stabilizer trivially. All inertia groups and all their lower ramification groups act semiregularly on the3b sheets. This is proved from the actual étale upper maps, not assumed from a permutation model.

## The conductor gap includes every wild lower group

Let g be a nonidentity inertia element of order e. Semiregularity makes all its sheet cycles have length e. If a g-fixed partial transversal selects a cycle of triples of length ℓ, its chosen sheet is fixed by the return map g^ℓ and has orbit length ℓ. Therefore ℓ=e. Selecting exactly ten triples forces e|10, while semiregularity on3b sheets gives e|3b. For b12,14,16,18 this permits ONLY e2.

A semiregular involution cannot fix an odd triple; its block permutation has b/2 two-cycles. It fixes at most
\[
\binom{b/2}{5}3^5
\]
partial transversals. Dividing by (4), this fraction is at most1/2673 (its maximum occurs at b12), and in particular at most1/81. All other nonidentity inertia elements fix no point of Ψ.

Burnside's formula consequently gives, for EVERY inertia or lower ramification subgroup J,
\[
1-\frac{\#(\Psi/J)}D\ge
\frac{80}{81}\left(1-\frac1{|J|}\right).
\]
The corresponding normalized orbit codimension on the original sheet set is exactly1−1/|J|. Apply the inequality term by term to characteristic-zero permutation Artin conductors, with nonnegative lower-ramification weights. The conductor–different identity yields
\[
\frac{\deg\operatorname{Diff}(R/F)}D\ge
\frac{80}{81}\frac{\deg\operatorname{Diff}(E/F)}{3b}.
\]
Since F is rational, (1) then gives
\[
\frac{2g(R)-2}D\ge
\frac{80}{81}u_E-\frac2{81}
>\frac{u_E}{2},\qquad u_E\ge16.
\]
But the actual separating inclusion R⊂A bounds this ratio above by uA=uE/2. This contradiction excludes V=U,W, including every possible wild ramification group.

All alternatives (3) are impossible. The two original endpoint maps remain finite étale on their SAME T throughout. The result is a retained upper-cubic exclusion, not an extraction of the comparison packet from an arbitrary common cover.
