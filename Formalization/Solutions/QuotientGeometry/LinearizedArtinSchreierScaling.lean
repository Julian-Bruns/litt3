import Mathlib.FieldTheory.IsAlgClosed.Basic
import Mathlib.Algebra.CharP.Lemmas
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.LinearCombination

namespace Litt3.QuotientGeometry

/-- Scaling a genuine separable two-term additive polynomial produces
the Artin–Schreier coefficient whose scalar is `-α/γ^p`. -/
theorem linearized_artin_schreier_scaling
    {k : Type*} [Field k] [IsAlgClosed k] (p : ℕ) [Fact p.Prime] [CharP k p]
    (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    ∃ ℓ a : k, ℓ ≠ 0 ∧ a ≠ 0 ∧
      ℓ ^ (p - 1) = -γ / α ∧
      α * ℓ ^ p = -γ * ℓ ∧
      a * (α * ℓ ^ p) = 1 ∧
      a ^ (p - 1) = -α / γ ^ p := by
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  obtain ⟨ℓ, hℓ⟩ := IsAlgClosed.exists_pow_nat_eq (-γ / α) (by omega : 0 < p - 1)
  have hℓ0 : ℓ ≠ 0 := by
    intro hz
    rw [hz, zero_pow (by omega)] at hℓ
    exact (div_ne_zero (neg_ne_zero.mpr hγ) hα) hℓ.symm
  have hlinear : α * ℓ ^ p = -γ * ℓ := by
    have hpow : ℓ ^ p = ℓ ^ (p - 1) * ℓ := by
      rw [← pow_succ, Nat.sub_add_cancel (by omega : 1 ≤ p)]
    rw [hpow, hℓ]
    field_simp
  have hsign : (-1 : k) ^ (p - 1) = 1 := by
    have h := neg_one_pow_char k p
    have hpow : (-1 : k) ^ p = (-1) ^ (p - 1) * (-1) := by
      rw [← pow_succ, Nat.sub_add_cancel (by omega : 1 ≤ p)]
    rw [hpow] at h
    linear_combination -h
  have hA : (α * ℓ ^ p) ^ (p - 1) = -γ ^ p / α := by
    rw [hlinear, mul_pow, neg_pow, hsign, one_mul, hℓ]
    have hpow : γ ^ (p - 1) * γ = γ ^ p := by
      rw [← pow_succ, Nat.sub_add_cancel (by omega : 1 ≤ p)]
    field_simp
    linear_combination -hpow
  refine ⟨ℓ, (α * ℓ ^ p)⁻¹, hℓ0, inv_ne_zero (mul_ne_zero hα (pow_ne_zero _ hℓ0)),
    hℓ, hlinear, inv_mul_cancel₀ (mul_ne_zero hα (pow_ne_zero _ hℓ0)), ?_⟩
  rw [inv_pow, hA, inv_div, div_neg]
  rw [neg_div]

end Litt3.QuotientGeometry
