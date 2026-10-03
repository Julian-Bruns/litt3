import Solutions.CartierAndSpin.AffineSourceRemainder

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

theorem affine_source_remainder_scale (a : K) (N p : ℕ) (ha : a ≠ 0) (hp : 1 ≤ p) :
    a ^ N / a ^ p * a⁻¹ ^ (p - 1) = a ^ N * a / (a ^ p) ^ 2 := by
  have hpower : a ^ p = a ^ (p - 1) * a := by
    rw [← pow_succ, Nat.sub_add_cancel hp]
  have hinverse : a⁻¹ ^ (p - 1) = a / a ^ p := by
    rw [inv_pow, hpower]
    field_simp
  rw [hinverse]
  ring

/-- Exact top and next coefficient weights in the actual transformed
source remainder, including both coefficient-zero boundaries. -/
theorem affine_source_remainder_coefficient_weights (p : ℕ) [CharP K p] (hp : 2 ≤ p)
    (H : K[X]) (a b q : K) (N : ℕ) (ha : a ≠ 0) :
    let S := H %ₘ (X ^ p + C q)
    let S' := (C (a ^ N / a ^ p) * H.comp (C a⁻¹ * (X - C b))) %ₘ
      (X ^ p + C (a ^ p * q - b ^ p))
    let lambda := a ^ N * a / (a ^ p) ^ 2
    S'.coeff (p - 1) = lambda * S.coeff (p - 1) ∧
      S'.coeff (p - 2) = lambda * (a * S.coeff (p - 2) + b * S.coeff (p - 1)) := by
  dsimp only
  rw [affine_source_remainder p hp H a b q (a ^ N / a ^ p) ha]
  have hnonone : (X ^ p + C q : K[X]) ≠ 1 := by
    intro h
    have := congrArg natDegree h
    simp only [natDegree_X_pow_add_C, natDegree_one] at this
    omega
  have hsmall : (H %ₘ (X ^ p + C q)).natDegree < p := by
    simpa only [natDegree_X_pow_add_C] using
      natDegree_modByMonic_lt H (monic_X_pow_add_C q (by omega : p ≠ 0)) hnonone
  have h := affine_characteristic_remainder_coefficients p hp _ hsmall a b (a ^ N / a ^ p) ha
  simpa only [affine_source_remainder_scale a N p ha (by omega)] using h

theorem affine_cleared_energy_zpow_weight (a : K) (N p : ℕ) (ha : a ≠ 0) :
    (a ^ N * a / (a ^ p) ^ 2) * a ^ 2 / a ^ p =
      a ^ ((N : ℤ) - 3 * (p : ℤ) + 3) := by
  have hexponent : (N : ℤ) - 3 * (p : ℤ) + 3 =
      ((N + 3 : ℕ) : ℤ) - ((p * 3 : ℕ) : ℤ) := by push_cast; ring
  rw [hexponent, zpow_sub₀ ha, zpow_natCast, zpow_natCast, pow_add, pow_mul]
  field_simp

end Litt3.CartierAndSpin
