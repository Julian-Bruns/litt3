import Solutions.CartierAndSpin.AffineSourceRemainder

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

theorem degree_two_p_source_degree (F S : K[X]) (p : ℕ) (hp : 2 ≤ p)
    (q tau kappa : K) (hkappa : kappa ≠ 0) (hS : S.natDegree ≤ p - 2)
    (hsource : F = C kappa * (X ^ p + C q) ^ 2 + (X ^ p + C q) * S + C tau) :
    F.natDegree = 2 * p := by
  have hmain : (C kappa * (X ^ p + C q) ^ 2 : K[X]).natDegree = 2 * p := by
    rw [natDegree_C_mul hkappa, natDegree_pow, natDegree_X_pow_add_C]
  have hproduct : ((X ^ p + C q) * S).natDegree ≤ p + S.natDegree := by
    have h := natDegree_mul_le (p := X ^ p + C q) (q := S)
    rw [natDegree_X_pow_add_C] at h
    exact h
  have hlower : ((X ^ p + C q) * S + C tau).natDegree <
      (C kappa * (X ^ p + C q) ^ 2).natDegree := by
    rw [hmain]
    have hadd := natDegree_add_le ((X ^ p + C q) * S) (C tau)
    simp only [natDegree_C] at hadd
    omega
  rw [hsource, add_assoc, natDegree_add_eq_left_of_natDegree_lt hlower, hmain]

theorem degree_two_p_source_remainder (S : K[X]) (p : ℕ) (hp : 2 ≤ p)
    (q kappa : K) (hS : S.natDegree ≤ p - 2) :
    (C kappa * (X ^ p + C q) + S) %ₘ (X ^ p + C q) = S := by
  exact (div_modByMonic_unique (C kappa) S (monic_X_pow_add_C q (by omega))
    ⟨by ring, by
      rw [degree_X_pow_add_C (by omega : 0 < p)]
      have hsmall : S.natDegree < p := by omega
      exact degree_le_natDegree.trans_lt (WithBot.coe_lt_coe.mpr hsmall)⟩).2

theorem degree_two_p_affine_coefficient (S : K[X]) (p : ℕ) (hp : 2 ≤ p)
    (a b : K) (ha : a ≠ 0) (hS : S.natDegree ≤ p - 2) :
    (C (a ^ p) * S.comp (C a⁻¹ * (X - C b))).coeff (p - 2) =
      a ^ 2 * S.coeff (p - 2) := by
  have hcoordinate : (C a⁻¹ * (X - C b) : K[X]) = C a⁻¹ * X + C (-a⁻¹ * b) := by
    simp only [map_neg, map_mul]
    ring
  rw [coeff_C_mul, hcoordinate, affine_comp_top_coefficient S (p - 2) a⁻¹ (-a⁻¹ * b) hS]
  have hpower : a ^ p = a ^ (p - 2) * a ^ 2 := by
    rw [← pow_add, Nat.sub_add_cancel hp]
  rw [inv_pow, hpower]
  field_simp

theorem degree_two_p_source_frame_presentation (F S : K[X]) (p : ℕ) [CharP K p]
    (hp : 2 ≤ p) (a b q tau kappa : K) (ha : a ≠ 0)
    (hsource : F = C kappa * (X ^ p + C q) ^ 2 + (X ^ p + C q) * S + C tau) :
    affineSourceFramePolynomial F a b (2 * p) =
      C kappa * (X ^ p + C (a ^ p * q - b ^ p)) ^ 2 +
        (X ^ p + C (a ^ p * q - b ^ p)) *
          (C (a ^ p) * S.comp (C a⁻¹ * (X - C b))) + C (a ^ (2 * p) * tau) := by
  have hfactor : F = (X ^ p + C q) * (C kappa * (X ^ p + C q) + S) + C tau := by
    rw [hsource]
    ring
  rw [affine_source_frame_presentation p hp F (C kappa * (X ^ p + C q) + S)
    a b q tau (2 * p) ha hfactor]
  have hscale : a ^ (2 * p) / a ^ p = a ^ p := by
    rw [Nat.mul_comm 2 p, pow_mul]
    field_simp
  have hH : C (a ^ (2 * p) / a ^ p) *
        (C kappa * (X ^ p + C q) + S).comp (C a⁻¹ * (X - C b)) =
      C kappa * (X ^ p + C (a ^ p * q - b ^ p)) +
        C (a ^ p) * S.comp (C a⁻¹ * (X - C b)) := by
    rw [hscale, add_comp, mul_comp, C_comp,
      affine_source_characteristic_factor p hp a b q ha]
    ring
  rw [hH]
  ring

end Litt3.CartierAndSpin
