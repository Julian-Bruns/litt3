# Proof: genuine discrepancy character and its Abel pullback

Version1. [Statement](../../Theorems/cartier_and_spin/tame_spin_weierstrass_different_reduction.md). [Independent whole-implication review: PASS](../../Research/audits/TAME_SPIN_WEIERSTRASS_DIFFERENT_AUDIT_2026_10_03.md). Retain the SAME actual sourceT and both endpoint maps. Reuse the accepted [tame degree and signature classification](tame_ramified_spin_degree_classification.md), genuine discrepancy linearizations, and the accepted [family24/36 antecedent](../jacobians/torsion/family_twenty_four_thirty_six_abel_exclusion.md).

Write K for the projective kernel, k=|K|∈{1,3}, U=T/K, H=G/K, and S=[Γ/H]. The coarse curve B is P¹. BecauseH acts faithfully onΓ, S is the tame root stack of B at the cone values in the accepted signature. Its canonical line K_S is the genuine H-linearized ωΓ and has orbifold degree1/n.

The original discrepancy N=M^16⊗ωΓ^−1 has its genuine G-linearization. Its kth power has trivialK action, so λ=N^k descends to an actual line onS, of orbifold degree k/n. The actual U→Γ map has canonical different qUP. The canonical different section, raised to powerk, descends through the free H action onU and gives
\[
\lambda|_Y\simeq O_Y(kP).
\]
Similarly the canonical Hurwitz inclusion φ_U^*ωΓ=ωU(−qUP) is compatible with that free action and gives
\[
K_S|_Y\simeq\omega_Y(-P).
\]
These are actual line identifications onY induced by the same-source maps, including when the distinguished coarse value itself is a cone. They do not identify an arbitrary Jacobian class with the source.

Setχ=λ⊗K_S^−k. Its degree is zero. If its normalized weights are ℓi/mi, the root-stack Picard presentation has generators the coarse O(1) and the cone rootsDi, with miDi=O(1). A degree-zero line has finite order: multiply by E=lcm_i(mi/gcd(mi,ℓi)) to kill all weights, and its remaining coarse degree is zero, hence the line is trivial. In particularχ has an exact finite order dividing the exponent of the degree-zero Picard group.

The actual pullback is
\[
\chi|_Y=O_Y(2kP)\otimes\omega_Y^{-k}=O_Y(2k(P-O)),
\]
because ωY=O_Y(2O) for every Weierstrass originO. Therefore 2kE[P−O]=0.

## Complete finite-character exponents

In the root-stack presentation, normalized degree-zero weights obeyΣℓi/mi∈Z. Equivalently the finite character group has generators of ordersmi with their sum zero. Its exponent in every accepted signature is as follows:

| Signature | Degree-zero Picard exponent |
| --- | --- |
| (4,4,4), (2,4,8) | 4 |
| (2,2,2,4), (2,2,2,3), (2,4,6), (2,3,8) | 2 |
| (3,3,6), (3,3,4), (2,3,9) | 3 |
| (2,6,6), (2,3,12) | 6 |
| (2,3,7) | 1 |

These small exponents follow directly by eliminating the last generator. For example(3,3,6) leaves two order-three generators, while(2,4,6) leaves two order-two generators since6(x+y)=0 with2x=4y=0 implies2y=0. For(2,3,12) the first two generators have coprime orders two and three, hence exponent six; for(2,3,7) their sum has order dividing both six and seven, so both vanish. The four-cone cases leave independent order-two generators. No numerical group computation is used.

For k=1, 2kE divides8 or12. For k=3, it divides24 or36. Thus in all cases it divides24 or36. The accepted BACKUP W1[24] and W1[36] consist exactly of the Weierstrass classes. For MAIN the family24/36 finite-support bound supplies the same exclusion at the selected high-degree parameter. Non-WeierstrassP is therefore impossible.

The proof retains all actual source maps. It proves a Weierstrass reduction, not the exclusion of its remaining cases.
