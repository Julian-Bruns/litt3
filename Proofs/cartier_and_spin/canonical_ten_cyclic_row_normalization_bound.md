# Proof: determinant-root trivialization and the odd actual atlas

Version1. [Statement](../../Theorems/cartier_and_spin/canonical_ten_cyclic_row_normalization_bound.md). PASS by [whole root review](../../Research/audits/CANONICAL_TEN_ROW_IDENTITY_AND_KERNEL_AUDIT_2026_10_03.md). This generalizes the degree bound from the accepted normal-abelian row argument; it does not use that now excluded subgroup premise or its balanced involutions.

Work first on the Cartier bases C^(1),D^(1), retaining the equivariant actual maps. The [étale row descent](positive_finite_coefficient_row_geometry.md) gives the genuine embedded bundle J_D. Put
\[
\chi=(\det J_D)^2\otimes\omega_{D^{(1)}}^{-1}.
\]
It is a genuine R-linearized degree-ZERO line. Its pullback to C^(1) is trivial by the [exact coefficient determinant identity](canonical_degree_ten_prime_to_five_quotients.md), P⁸=ω_C. The group R has no nontrivial character: a character has finite image of order prime to FIVE, whereas R has no such quotient. Therefore any global trivialization of φ*χ is R-invariant.

The line χ has finite prime-to-FIVE order because it is killed by the actual finite étale pullback. Its canonical connected cyclic étale trivializer D′→D embeds in C using that chosen trivialization; both C→D′ and D′→D are actual étale maps. The invariant trivialization gives an actual R action on D′, still faithful, and a genuinely R-equivariant equality
\[
(\det J_{D'})^2=\omega_{D'^{(1)}}.
\]
An involution fixing a smooth point of D′ has tangent character −ONE. The square of its character on detJ_D′ is +ONE, contradicting this equality with the canonical fiber. Thus all involutions of R act freely on D′, and every point stabilizer has odd order.

Write |R|=2^s m with m odd, and ℓ=deg(C→D′). The genus identity from the actual R-torsor C→Y and étale Hurwitz is
\[
|R|=\ell(g(D')-1).
\]
A Sylow-TWO subgroup of order2^s acts freely on D′, so the right side is divisible by2^sℓ. Hence ℓ divides m and is odd.

The quotient map gives the actual representable finite étale atlas Y=[C/R]→[D′/R] of degree ℓ. Its coarse finite map has COMPLETE uniform fibers and one identical Galois completed local extension type throughout each branch fiber: the completed source charts over D′ are étale, hence isomorphic over the algebraically closed residue field, and inertia acts freely on each chart fiber. In particular every local inertia order divides ℓ. These are exactly the hypotheses of the accepted [odd uniform genus-two atlas exclusion](../quotient_geometry/endpoint_exclusions/odd_uniform_genus_two_atlas_exclusion.md), independently audited [PASS](../../Research/audits/ODD_UNIFORM_GENUS_TWO_ATLAS_AUDIT_2026_10_03.md). It forces ℓ=ONE. Thus D′=C and [D′/R]=Y.

Consequently C→D itself is the canonical cyclic trivializer of χ. Its deck S commutes with R, because it acts by constant root-of-unity multiplications on that trivializer and the R-invariant trivialization is retained. Its induced action on Y is faithful: an element trivial on Y is in the deck group R of C→Y, while S∩R acts trivially on D and is trivial by the faithful R action on D. The selected Aut(Y)=C₂ therefore gives |S|=ONE orTWO.

In the latter case write σ for its nonidentity element. It is free on C and induces the hyperelliptic involution ι of Y. Then
\[
D/R=C/(R\times\langle\sigma\rangle)=Y/\langle\iota\rangle=\mathbf P^1.
\]
At every Weierstrass point W of Y and every c∈C over it, there is a unique r∈R with σc=rc. Commutation gives r²=ONE, and freeness of σ gives r≠ONE. The point stabilizer in R on D has order precisely TWO: its lifts in C must send c either to c or to σc, and R acts freely on C. These are the SIX branch values of D/R. Away from them all stabilizers are trivial. In particular FIVE-elements act freely on D. For |S|=ONE the whole R action on D=C is already free. Untwisting yields the asserted actual curve maps; no original X descent is used.
