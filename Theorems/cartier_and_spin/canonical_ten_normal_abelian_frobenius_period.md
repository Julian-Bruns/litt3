# The even paired coefficient image gives an exact Frobenius twist

Version1,3 October2026. Scoped scalar-period identity PASS by [focused root review](../../Research/audits/CANONICAL_TEN_TAME_COEFFICIENT_GATE_AUDIT_2026_10_03.md). Both actual original endpoint maps remain unchanged.

Retain the full hypotheses of the [normal abelian coefficient reduction](canonical_ten_normal_abelian_coefficient_reduction.md). Its entire projective coefficient image R is conjugate to a subgroup of PGL₄(F₅), and every projective element has a determinant-ONE lift in SL₄(F₅). The actual determinant-ONE lift is its full central extension by μ₄; no multiplier collapse is asserted.

For the ORIGINAL rank-FOUR trace J_Y on its Cartier base, absolute Frobenius satisfies the exact bundle identity
\[
F_{\rm abs}^{*}J_Y\simeq J_Y\otimes\det J_Y
=J_Y\otimes O_Y(P).
\]
There is no residual order-FOUR line in this identity. Its iterations are
\[
F_{\rm abs}^{a*}J_Y\simeq
J_Y\otimes O_Y\big((5^a-1)P/4\big),\qquad a\ge1.
\]
Here F_abs is absolute Frobenius of the underlying Cartier-base scheme. The displayed identification uses actual étale coefficient transition frames; it does not treat t↦t⁵ as an automorphism of the selected k-curve, or assert a k-linear Frobenius symmetry of its parameter.

More generally a rank-n bundle with actual finite projective transition matrices liftable to SL_n(F_p), where n divides p−ONE, satisfies F_abs*E=E⊗(detE)^((p−1)/n). The present case is n=FOUR,p=FIVE. No conclusion about the twisted Cartier kernel, its injectivity or the common-cover problem follows from the period identity alone.

[Proof](../../Proofs/cartier_and_spin/canonical_ten_normal_abelian_frobenius_period.md).
