import Solutions.CartierAndSpin.LaurentDerivation
import Mathlib.FieldTheory.IsAlgClosed.Basic

namespace Litt3.CartierAndSpin

variable {k : Type*} [Field k] [IsAlgClosed k]

/-- Over an algebraically closed residue field, the constant affine
translation removes exactly the constant coefficient of q. -/
theorem power_series_constant_translation (q : PowerSeries k) (p : ℕ) (hp : 0 < p) :
    ∃ b : k,
      q - (PowerSeries.C b) ^ p = q - PowerSeries.C (PowerSeries.constantCoeff q) ∧
      PowerSeries.constantCoeff (q - (PowerSeries.C b) ^ p) = 0 := by
  obtain ⟨b, hb⟩ := IsAlgClosed.exists_pow_nat_eq (PowerSeries.constantCoeff q) hp
  refine ⟨b, ?_, ?_⟩
  · rw [← map_pow, hb]
  · rw [map_sub, map_pow, PowerSeries.constantCoeff_C, hb, sub_self]

theorem laurent_constant_translation (q : LaurentSeries k) (p : ℕ) (hp : 0 < p) :
    ∃ b : k,
      q - (algebraMap k (LaurentSeries k) b) ^ p =
        q - algebraMap k (LaurentSeries k) (q.coeff 0) ∧
      laurentDerivation k (algebraMap k (LaurentSeries k) b) = 0 := by
  obtain ⟨b, hb⟩ := IsAlgClosed.exists_pow_nat_eq (q.coeff 0) hp
  refine ⟨b, ?_, ?_⟩
  · rw [← map_pow, hb]
  · ext n
    rw [laurentDerivation_apply, laurent_derivative_coefficient_at, LaurentSeries.algebraMap_apply]
    by_cases hn : n + 1 = 0
    · have hcast : (n : k) + 1 = 0 := by
        rw [← Int.cast_one, ← Int.cast_add, hn, Int.cast_zero]
      simp [hn, hcast]
    · simp [hn]

end Litt3.CartierAndSpin
