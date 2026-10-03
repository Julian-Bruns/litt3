import Solutions.Deformations.ElementaryDetectorFrobenius

namespace Litt3.Deformations

open scoped BigOperators

variable {I K : Type*} [Fintype I] [DecidableEq I] [Field K] [Fact (Nat.Prime 5)]

theorem finite_field_original_monomial_scale (φ : ZMod 5 →+* K) (u : (ZMod 5)ˣ)
    (a : I → ZMod 5) (alpha : I → ℕ) :
    (∏ i, φ (((u : ZMod 5) • a) i) ^ alpha i) =
      φ u ^ (∑ i, alpha i) * ∏ i, φ (a i) ^ alpha i := by
  change (∏ i, φ ((u : ZMod 5) * a i) ^ alpha i) = _
  simp only [map_mul, mul_pow, Finset.prod_mul_distrib, ← Finset.prod_pow_eq_pow_sum]

/-- Homogeneous original weights give the actual scalar character at
tau=-1, because every original nonzero rational scalar has fourth power one. -/
theorem elementary_homogeneous_evaluation_scale (φ : ZMod 5 →+* K) (N d : ℕ)
    (coefficients : Fin N → (I → Fin 5) → K)
    (homogeneous : ∀ j alpha, coefficients j alpha ≠ 0 →
      4 * j.val + (∑ i, (alpha i).val) = d)
    (u : (ZMod 5)ˣ) (a : I → ZMod 5) :
    (∑ j : Fin N, ∑ alpha : I → Fin 5, coefficients j alpha * (-1 : K) ^ j.val *
      (∏ i, φ (((u : ZMod 5) • a) i) ^ (alpha i).val)) =
    φ u ^ d * (∑ j : Fin N, ∑ alpha : I → Fin 5,
      coefficients j alpha * (-1 : K) ^ j.val * (∏ i, φ (a i) ^ (alpha i).val)) := by
  have fourth : φ (u : ZMod 5) ^ 4 = 1 := by
    have original : (u : ZMod 5) ^ 4 = 1 := ZMod.pow_card_sub_one_eq_one u.ne_zero
    simpa only [map_pow, map_one] using congrArg φ original
  simp_rw [finite_field_original_monomial_scale]
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro j _
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro alpha _
  by_cases zero : coefficients j alpha = 0
  · simp [zero]
  · have degree := homogeneous j alpha zero
    have power : φ (u : ZMod 5) ^ (∑ i, (alpha i).val) = φ u ^ d := by
      rw [← degree, pow_add, pow_mul, fourth, one_pow, one_mul]
    rw [power]
    ring

/-- At the critical source weight 4r+1 the exact character is one,
uniformly in r, without selecting projective representatives. -/
theorem elementary_critical_homogeneous_scale (φ : ZMod 5 →+* K) (N r : ℕ)
    (coefficients : Fin N → (I → Fin 5) → K)
    (homogeneous : ∀ j alpha, coefficients j alpha ≠ 0 →
      4 * j.val + (∑ i, (alpha i).val) = 4 * r + 1)
    (u : (ZMod 5)ˣ) (a : I → ZMod 5) :
    (∑ j : Fin N, ∑ alpha : I → Fin 5, coefficients j alpha * (-1 : K) ^ j.val *
      (∏ i, φ (((u : ZMod 5) • a) i) ^ (alpha i).val)) =
    φ u * (∑ j : Fin N, ∑ alpha : I → Fin 5,
      coefficients j alpha * (-1 : K) ^ j.val * (∏ i, φ (a i) ^ (alpha i).val)) := by
  rw [elementary_homogeneous_evaluation_scale φ N (4 * r + 1) coefficients homogeneous]
  have fourth : φ (u : ZMod 5) ^ 4 = 1 := by
    have original : (u : ZMod 5) ^ 4 = 1 := ZMod.pow_card_sub_one_eq_one u.ne_zero
    simpa only [map_pow, map_one] using congrArg φ original
  rw [pow_add, pow_mul, fourth, one_pow, pow_one, one_mul]

end Litt3.Deformations
