import Mathlib.Algebra.Polynomial.Taylor
import Mathlib.Algebra.Polynomial.Eval.Degree
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Polynomial

variable {R : Type*} [CommRing R]

/-- The top coefficient of a bounded-degree polynomial under an affine
substitution. No actual-degree equality or nonzero coefficient is used. -/
theorem affine_comp_top_coefficient (P : R[X]) (n : ℕ) (a b : R)
    (hdegree : P.natDegree ≤ n) :
    (P.comp (C a * X + C b)).coeff n = P.coeff n * a ^ n := by
  have hcomp : P.comp (C a * X + C b) = (P.taylor b).comp (C a * X) := by
    simp only [taylor_apply, comp_assoc, add_comp, X_comp, C_comp]
  rw [hcomp, comp_C_mul_X_coeff, taylor_coeff]
  have hzero : (hasseDeriv n P).natDegree ≤ 0 := by
    have h := natDegree_hasseDeriv_le P n
    omega
  rw [eq_C_of_natDegree_le_zero hzero, hasseDeriv_coeff]
  simp

/-- The next coefficient under affine substitution, over arbitrary
commutative rings. The formula retains every degree drop. -/
theorem affine_comp_next_coefficient (P : R[X]) (n : ℕ) (a b : R)
    (hdegree : P.natDegree ≤ n + 1) :
    (P.comp (C a * X + C b)).coeff n =
      (P.coeff n + (n + 1 : R) * b * P.coeff (n + 1)) * a ^ n := by
  have hcomp : P.comp (C a * X + C b) = (P.taylor b).comp (C a * X) := by
    simp only [taylor_apply, comp_assoc, add_comp, X_comp, C_comp]
  rw [hcomp, comp_C_mul_X_coeff, taylor_coeff]
  have hsmall : (hasseDeriv n P).natDegree < 2 := by
    have h := natDegree_hasseDeriv_le P n
    omega
  rw [(hasseDeriv n P).as_sum_range_C_mul_X_pow' hsmall]
  simp only [Finset.sum_range_succ, Finset.sum_range_zero, zero_add,
    eval_add, eval_mul, eval_C, eval_X, pow_zero, pow_one,
    mul_one, hasseDeriv_coeff, zero_add, Nat.choose_self, Nat.cast_one, one_mul]
  rw [Nat.add_comm 1 n, Nat.choose_succ_self_right, Nat.cast_add, Nat.cast_one]
  ring

/-- The two characteristic-p remainder coefficients after an actual
inverse affine substitution. The upper coefficient may vanish; the
formula retains the trace-zero and every degree-drop boundary. -/
theorem affine_characteristic_remainder_coefficients {K : Type*} [Field K]
    (p : ℕ) [CharP K p] (hp : 2 ≤ p) (S : K[X]) (hdegree : S.natDegree < p)
    (a b scale : K) (ha : a ≠ 0) :
    (C scale * S.comp (C a⁻¹ * (X - C b))).coeff (p - 1) =
        scale * a⁻¹ ^ (p - 1) * S.coeff (p - 1) ∧
    (C scale * S.comp (C a⁻¹ * (X - C b))).coeff (p - 2) =
        scale * a⁻¹ ^ (p - 1) * (a * S.coeff (p - 2) + b * S.coeff (p - 1)) := by
  have hcoordinate : (C a⁻¹ * (X - C b) : K[X]) =
      C a⁻¹ * X + C (-a⁻¹ * b) := by
    simp only [map_mul, map_neg]
    ring
  have hpminus : (p - 1 : ℕ) = (p - 2) + 1 := by omega
  have hcast : ((p - 1 : ℕ) : K) = -1 := by
    rw [Nat.cast_sub (by omega : 1 ≤ p), CharP.cast_eq_zero K p, Nat.cast_one, zero_sub]
  rw [hcoordinate]
  constructor
  · rw [coeff_C_mul, affine_comp_top_coefficient S (p - 1) a⁻¹ (-a⁻¹ * b) (by omega)]
    ring
  · rw [coeff_C_mul, affine_comp_next_coefficient S (p - 2) a⁻¹ (-a⁻¹ * b) (by omega)]
    have hindex : p - 2 + 1 = p - 1 := by omega
    have hcastnext : ((p - 2 : ℕ) : K) + 1 = -1 := by
      rw [← Nat.cast_one, ← Nat.cast_add, hindex, hcast]
      simp
    rw [hindex, hcastnext, hpminus, pow_succ]
    have hinverse : a⁻¹ * a = 1 := inv_mul_cancel₀ ha
    calc
      scale * ((S.coeff (p - 2) + -1 * (-a⁻¹ * b) * S.coeff (p - 2 + 1)) *
        a⁻¹ ^ (p - 2)) =
          scale * a⁻¹ ^ (p - 2) *
            (S.coeff (p - 2) + a⁻¹ * b * S.coeff (p - 2 + 1)) := by ring
      _ = _ := by
        linear_combination -(scale * a⁻¹ ^ (p - 2) * S.coeff (p - 2)) * hinverse

/-- Consequently the actual nonzero coefficient ratio is an affine
center, with no assumption that the next coefficient is nonzero. -/
theorem affine_characteristic_remainder_center {K : Type*} [Field K]
    (p : ℕ) [CharP K p] (hp : 2 ≤ p) (S : K[X]) (hdegree : S.natDegree < p)
    (a b scale : K) (ha : a ≠ 0) (hscale : scale ≠ 0)
    (hs : S.coeff (p - 1) ≠ 0) :
    (C scale * S.comp (C a⁻¹ * (X - C b))).coeff (p - 2) /
        (C scale * S.comp (C a⁻¹ * (X - C b))).coeff (p - 1) =
      a * (S.coeff (p - 2) / S.coeff (p - 1)) + b := by
  obtain ⟨htop, hnext⟩ := affine_characteristic_remainder_coefficients p hp S hdegree a b scale ha
  rw [hnext, htop]
  field_simp

end Litt3.CartierAndSpin
