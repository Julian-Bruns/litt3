# Proof: invariant quadrics, hyperelliptic quotient and finite determinant

Version2,3 October2026. [Root whole-scope review PASS](../../Research/audits/ABELIAN_HUMBERT_QUADRATIC_MODEL_AND_CARTIER_GATE_AUDIT_2026_10_03.md); Version2 retains the actual spin trivialization upstairs. [Statement](../../Theorems/cartier_and_spin/abelian_humbert_row_quadratic_hyperelliptic_model.md). Use the accepted [smooth embedding and exact ideal](abelian_humbert_row_smooth_embedding.md) and the actual perfect orderFOUR coefficient pairing from the [positive image theorem](abelian_humbert_positive_coefficient_image.md). Both original étale endpoint maps remain on the original refinement; none is presumed to factor through C or E.

## The actual four invariant quadrics

The irreducible four-dimensional projective representation of A=C₄×C₄ with perfect primitive commutator can be written in Schrödinger coordinates: generators act by the diagonal matrix diag(1,i,−1,−i) and cyclic shift of the FOUR coordinates, where i²=−ONE. Dualizing or Frobenius twisting changes the chosen primitive pairing but not the following calculation. A[2] is generated projectively by the square of that diagonal matrix and simultaneous interchange of coordinatesZERO/TWO andONE/THREE. These two lifts commute and have orderTWO. Their induced action on quadratic forms is genuine.

The invariant quadratic space is exactly the FOUR-dimensional span of
\[
Q_0=X_0^2+X_2^2,\quad Q_1=X_1^2+X_3^2,
\quad Q_2=X_0X_2,\quad Q_3=X_1X_3.
\]
Indeed invariance under the diagonal square deletes cross terms between the even and odd coordinate pairs; invariance under the simultaneous interchange retains precisely the four expressions above. They have no common projective zero: Q₂=Q₀=ZERO forces X₀=X₂=ZERO, and Q₃=Q₁=ZERO forces X₁=X₃=ZERO. They therefore define a morphism τ:P³→P³ with τ*O(1)=O(2). It is finite, since a positive-dimensional fiber would contain a curve on which the ample O(2) had degreeZERO. Its degree isEIGHT by intersecting three hyperplanes. Being a finite morphism between smooth equidimensional projective spaces, it is flat.

## Clifford equality on the genuine genus-five quotient

The group A[2] acts freely on C, so E=C/A[2]→Y is an actual étale degreeFOUR cover and g(E)=FIVE. The chosen quadratic linearization descends Arow² to a line K on E of degreeSIX. All FOUR invariant quadrics descend to independent sections of K: independence follows from the absence of a quadratic equation of C. They have no common zero.

Riemann–Roch on E gives h⁰(K)=TWO+h⁰(ω_EK⁻¹). The complementary line has degreeTWO. Since h⁰(K)≥FOUR, it has at leastTWO sections; degreeTWO and positive genus force a basepoint-free hyperelliptic pencil H. It has exactlyTWO sections, and K has exactlyFOUR. Hence E is hyperelliptic, ω_E=H⁴ and K=H³. The descended invariant quadratic series is its COMPLETE H³ series and maps E by the hyperelliptic double cover followed by the complete twisted-cubic embedding of P¹.

It follows that τ(C) is a twisted cubic D and τ|C has degreeEIGHT, the degreeFOUR quotient C→E followed by that hyperelliptic double cover. Pulling back the standard Hilbert–Burch resolution of the twisted cubic through the flat τ yields
\[
0\longrightarrow\mathcal O(-6)^2\longrightarrow\mathcal O(-4)^3
\longrightarrow\mathcal I_{\tau^{-1}(D)}\longrightarrow0.
\]
Thus τ⁻¹(D) has exactly the same Hilbert series as C, already proved in the smooth-row theorem. The inclusion C⊂τ⁻¹(D) is therefore equality scheme-theoretically. The resulting two-by-three quadratic matrix is the catalecticant defining D with its four linear coordinates replaced by linear combinations of the Q_i. No arbitrary general-matrix assumption enters.

## The finite actual determinant class

Pulling K⁴=H¹²=ω_E³ through the actual étale C→E gives
\[
Arow^8\simeq\omega_C^3.
\]
Using the actual Frobenius adjunction line Arow=ω_C⊗P⁻⁵, cancellation initially gives P⁴⁰=ω_C⁵. Set χ=P⁸ω_C⁻¹, so χ⁵=O_C. But on the ACTUAL étale source T′→C, P pulls back to L² and ω_C pulls back to ω_T′. The original spin identification L¹⁶=ω_T′ therefore trivializes χ upstairs.

No nontrivial p-torsion line can be killed by a finite separable pullback. To see this here, pass to the actual étale Galois closure over C. A trivialization of the pulled-back line has constant deck character, since that connected smooth projective cover has only constant units. A p-torsion character has image in μ_p(k), which is trivial in characteristicp. Thus χ=O_C, proving P⁸=ω_C and Arow=P³.

The line P²(π*H)⁻¹ now has third powerTRIVIAL because Arow²=π*H³ and fourth powerTRIVIAL because P⁸=ω_C=π*H⁴. Coprimality of THREE andFOUR gives P²=π*H exactly.

## Sharpening the actual determinant to four-torsion

The residual group A/A[2]=V₄ acts on E freely and preserves its unique hyperelliptic pencil H. This action on H is the pullback of its projective action on the base P¹. Its projective multiplier is killed byTWO (one can lift to two-dimensional matrices and take determinants); hence H² has a genuine V₄-linearization and descends to a degreeONE line M₀ on Y. Thus
\[
f_E^*M_0=H^2,\qquad f_E^*(M_0^2\omega_Y^{-1})=\mathcal O_E.
\]
The kernel for the actual étale V₄-torsor E→Y has exponentTWO, so M₀⁴=ω_Y². Also q_C*J_Y=P⊗V4 gives P⁴=q_C*M with M=detJ_Y. Since P²=π*H, the same P⁴ equals q_C*M₀. The kernel for the actual étale A-torsor C→Y has exponentFOUR. Consequently (M/M₀)⁴=O_Y and M⁴=ω_Y². Finally ω_Y=O_Y(2W), so (M O_Y(−W))⁴=O_Y, as claimed. Every descent ambiguity was kept as an actual character line; no invariant-line degree alone was used to assert descent.

This is a finite determinant-class constraint, not a point-torsion condition. It supplies a new bounded Picard incidence for the actual positive trace without constructing any new étale X endpoint or asserting that ordinarity excludes the remaining line classes.
