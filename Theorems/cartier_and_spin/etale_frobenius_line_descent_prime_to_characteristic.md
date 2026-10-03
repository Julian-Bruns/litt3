# Étale Frobenius line descent from a prime-to-characteristic canonical power

Version1,3 October2026. New conceptual lemma and scoped actual-source application, pending independent whole review.

Let ρ:C→D and f:T→C be finite étale maps of smooth projective connected curves over an algebraically closed field of characteristic p. Work with the usual suppressed Frobenius twists. Let P be a line on C^(1), m prime to p, and W a line on D such that
\[
f^{(1)*}P^m\simeq\omega_{T^{(1)}},\qquad
F_C^*P\simeq\rho^*W,
\qquad p\mid\deg W.
\]
Then there is a line Q on D^(1) with actual identifications
\[
F_D^*Q\simeq W,\qquad \rho^{(1)*}Q\simeq P,
\]
and Q^m⊗ω_D⁻¹ is finite prime-to-p torsion. No choice of a simultaneous Galois closure or trivialization of p-torsion by a separable cover is used.

Apply this with p=FIVE,m=EIGHT to the ÉTALE alternative of the [rank-three projective row descent](canonical_ten_rank_three_projective_row_descent.md), using the actual original T→C, common spin L, and line P. Then P descends to Q on D^(1), and the actual bundle
\[
K_D=Q\otimes E_D\hookrightarrow B_D
\]
has rankTHREE, degree g(D)−ONE, and pulls back exactly to q_C*K. Its adjunction is induced by F_D*E_D→M and F_D*Q=ω_D⊗M⁻¹. It is integrally presented by Q⊗V, and Q⁸⊗ω_D⁻¹ is retained finite prime-to-FIVE torsion.

This is genuine scalar Cartier descent, stronger than projective descent. It does NOT assert a native determinant equality, a rank-four full-trace splitting, or an original X-map on D. The original endpoint maps remain on T and the common-cover problem stays unresolved.

[Proof](../../Proofs/cartier_and_spin/etale_frobenius_line_descent_prime_to_characteristic.md).
