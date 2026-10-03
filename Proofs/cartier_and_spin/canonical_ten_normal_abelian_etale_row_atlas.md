# Proof: determinant roots remove all even row stabilizers

Version1. [Statement](../../Theorems/cartier_and_spin/canonical_ten_normal_abelian_etale_row_atlas.md). The complete scoped extraction passed [root whole review](../../Research/audits/CANONICAL_TEN_AFFINE_AND_NORMAL_ABELLAN_AUDIT_2026_10_03.md). Both actual original endpoint maps remain unchanged upstairs.

## A genuine equivariant degree-zero line

Use the [actual étale row extraction](positive_finite_coefficient_row_geometry.md) and the [exact determinant theorem](canonical_degree_ten_prime_to_five_quotients.md). The entire coefficient image R has no nontrivial character. Its actual coefficient cover C→Y has degree5760 and genus5761. Its étale row map φ:C→D has an equivariant embedded trace J_D=Q_D⊗V, pulled back to q_C*J_Y=P⊗V.

Work with the coefficient lines on the first Frobenius twists C^(1),D^(1); the equivariant curve maps will be untwisted at the end. Put
\[
\chi=(\det J_D)^2\otimes\omega_{D^{(1)}}^{-1}
=Q_D^8\otimes\omega_{D^{(1)}}^{-1}.
\]
This is a GENUINE R-linearized line, since detJ_D and the canonical bundle are genuinely linearized. It has degree ZERO. Its pullback to C^(1) is trivial because the accepted exact identity is P⁸=ω_{C^(1)}.

Choose a nonzero global trivializing section of φ*χ. The R-action on its one-dimensional space of sections is a genuine character of R, and is therefore trivial. Thus the pulled-back trivialization is R-INVARIANT. This is the step that converts an underlying root-line equality into an equivariant one; no arbitrary projective lift on Q_D is used.

## Its cyclic trivializer is an actual intermediate

A line killed by a finite connected étale pullback is a finite-character line of prime-to-FIVE order. Indeed its trivialization has constant descent cocycle on the finite étale fiber products; the resulting finite subgroup of k* has order prime to FIVE. Equivalently a nontrivial order-FIVE line cannot be killed by separable pullback. Let j be the order of χ.

The cyclic étale trivializer D′^(1)→D^(1) of χ embeds in C^(1), using the chosen pulled-back trivialization. Its connectedness follows from minimality of j. Both C^(1)→D′^(1) and D′^(1)→D^(1) are actual étale maps. The R-invariant trivialization makes D′ R-stable, and on D′ the canonical trivialization of χ is R-invariant. In particular
\[
(\det J_{D'})^2\simeq\omega_{D'^{(1)}}
\]
is a GENUINE equivariant isomorphism. The R-action on D′ remains faithful because its action on D was faithful.

## No involution can fix a row point

Suppose an involution r∈R fixes a point of D′. Its tangent character is −ONE: a nontrivial tame involution fixing a smooth point is formally linearizable, and tangent character ONE would make it locally, hence globally, the identity. The canonical-bundle fiber character at this point is consequently −ONE, also on the Frobenius twist.

The action on the genuine line detJ_{D′} has order dividing TWO. Its square has fiber character +ONE. This contradicts the preceding R-equivariant isomorphism with the canonical bundle. Therefore EVERY involution of R acts freely. Every even-order point stabilizer contains an involution, so ALL stabilizers of R on D′ have odd order. In particular its elementary-TWO subgroup A acts freely.

## The exact odd degree and the third actual target

Put ℓ=deg(C→D′). A Sylow-TWO subgroup of R has order128 and acts freely on D′. Let Z be its smooth quotient. Étale Hurwitz gives
\[
5760=\ell(g(D')-1)
=128\ell(g(Z)-1),
\qquad 45=\ell(g(Z)-1).
\]
Thus ℓ is a positive divisor of45. Quotienting D′ by the free A of orderSIXTEEN gives E=D′/A, and
\[
g(E)-1=(g(D')-1)/16=360/\ell.
\]
The original T→C, C→D′ and D′→E are all actual étale maps. Their composite gives the asserted third étale target while retaining the two original maps. None of these operations makes E an endpoint quotient of X or of Y.

Since A acts freely, the quotient stacks [D′/R] and [E/A₆] are naturally equivalent. The equivariant map C→D′ induces the actual representable étale atlas
\[
Y=[C/R]\longrightarrow[D'/R]=[E/A_6]
\]
of degree ℓ, whose base change along D′ is C→D′. If a stabilizer in A₆ on E had even order, its isomorphic stabilizer lift in R at any chosen point of D′ would have even order, already ruled out. Hence all A₆ stabilizers have odd order.

## The actual embedded trace descends

The A-equivariant embedded bundle J_{D′}⊂B_{D′} descends along the actual A-torsor D′→E to an embedded bundle J_E⊂B_E, because B commutes with étale pullback and its inclusion descends faithfully. It has rank FOUR and
\[
\deg J_E=\deg J_{D'}/16=(g(D')-1)/16=g(E)-1.
\]
The equivariant determinant-square isomorphism descends with it, yielding (detJ_E)²=ω_E genuinely equivariantly for A₆. Pulling along Y→[E/A₆] recovers J_Y because it already pulls back to the identical actual embedded bundle on C. Untwisting the curve maps gives all the stated actual maps from the original T. No downward original X-map is inferred.
