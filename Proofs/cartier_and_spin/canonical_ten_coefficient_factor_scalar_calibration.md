# Proof: quotient-level determinants and the native two-point Picard group

Version1,3 October2026. Pending focused review; see the [statement](../../Theorems/cartier_and_spin/canonical_ten_coefficient_factor_scalar_calibration.md). No computation is used.

Write α_R for the multiplier of V. Each projective composition factor has this SAME multiplier: H is scalar on the entire V, hence scalar on every subquotient, so its projectivization factors through R. Determinants of a factor of dimension m give mα_R=ZERO. Bézout therefore gives tα_R=ZERO. No semisimplicity or chosen linear finite lift is needed. The paired scalar line P has opposite multiplier.

We use a simple descent fact. If a line E on C is genuinely R-linearizable and pulls trivially to T, its pulled genuine G-action, written in a global nonzero trivialization on the proper connected T, is a character of G. The hypothesis makes it trivial. That invariant frame descends and proves E=O_C. This requires a multiplier bound ON R; triviality only after inflation would not suffice.

If t dividesEIGHT, the line P⁸ω_C⁻¹ is R-linearizable. Its pullback is L¹⁶ω_T⁻¹=O_T, because T→C is étale. The preceding fact proves P⁸=ω_C.

Suppose now t dividesFOUR. Then FOUR α_R=ZERO, and likewise FOUR times the inflated coefficient multiplier on G is zero. The spin line M on Γ has the same projective multiplier as its pullback L; comparison of lifts commutes with pullback, and the scalar differences are global constants by properness. The multiplier of M² is opposite to that of the coefficient module. Consequently M⁸ω_Γ⁻¹ is genuinely G-linearizable. It has degreeZERO. The accepted [actual two-point orbifold Picard theorem](../../Theorems/quotient_geometry/local_actions/two_point_wild_orbifold_picard_group.md) gives the linearized degree-zero group of [Γ/G] as cyclic of order gcd(FIVE,TWO)=ONE. Therefore M⁸=ω_Γ. The line-action comparison carries no residual G-character, since G has none.

On the original source the exact retained identities M¹⁶=ω_Γ² and L¹⁶=ω_T, together with étale-leg and ramified-carrier Hurwitz, give
\[
\phi^*\omega_\Gamma^2=\omega_T
=\phi^*\omega_\Gamma\otimes q^*O_Y(P_0).
\]
Canceling φ*ω_Γ yields φ*ω_Γ=q*O_Y(P₀). Hence L⁸=q*O_Y(P₀).

Finally E=P⁴⊗q_C*O_Y(−P₀) pulls trivially to T by the identity just proved. Its multiplier is FOUR times that of P and vanishes ON R. It is therefore genuinely R-linearizable and the same no-character descent fact proves E=O_C. This establishes the claimed quarter-spin calibration without any transgression ambiguity.
