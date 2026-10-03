import Theorems.Deformations.OriginalToricFormalTypeLengths
import Solutions.Deformations.OriginalToricFormalTypeClosedLengths

namespace Litt3.Deformations

section General

variable (K : Type*) [Field K] (p : ℕ) [Fact p.Prime] [CharP K p]

/-- The WHOLE balanced formal-type source clause, with both sum and
floor/remainder formulas for the unchanged original series quotient. -/
theorem original_balanced_toric_formal_type_length (n s : ℕ) (quadratic : 2 ≤ s) :
    Specifications.OriginalBalancedToricFormalTypeLength K p n s := by
  intro f formalType
  obtain ⟨e, u, equation⟩ := formalType
  have positiveQ : 0 < p ^ n := pow_pos (Fact.out (p := p.Prime)).pos n
  have actual := balanced_toric_hypersurface_length_of_positive_formal_change K p
    n s (by omega) e f u equation
  refine ⟨actual, ?_⟩
  have literal := toric_hypersurface_series_finrank K (p ^ n) (p ^ n) s
    positiveQ positiveQ le_rfl (by omega)
  rw [actual.trans literal.symm]
  simpa [pow_two, mul_assoc] using
    toric_hypersurface_series_length_floor K (p ^ n) (p ^ n) s
      positiveQ le_rfl quadratic

end General

section Five

variable (K : Type*) [Field K] [CharP K 5]

/-- The exact p=5,s=2 unequal formula after an ACTUAL compatible
positive-sign formal change. Every original power, including one, remains. -/
theorem unequal_toric_hypersurface_five_two_length_of_positive_formal_change
    (n a : ℕ) (below : 5 ^ a ≤ 5 ^ n)
    (e : MvPowerSeries (Fin 3) K ≃ₐ[K] MvPowerSeries (Fin 3) K)
    (f : MvPowerSeries (Fin 3) K) (u : (MvPowerSeries (Fin 3) K)ˣ)
    (lower : 5 ^ a ≠ 5 ^ n → ∃ v : (MvPowerSeries (Fin 3) K)ˣ,
      e (MvPowerSeries.X 2) = (v : MvPowerSeries (Fin 3) K) * MvPowerSeries.X 2)
    (equation : e f = (u : MvPowerSeries (Fin 3) K) *
      (MvPowerSeries.X 0 * MvPowerSeries.X 1 + MvPowerSeries.X 2 ^ 2)) :
    Module.finrank K (MvPowerSeries (Fin 3) K ⧸
      (seriesVariablePowerIdeal K 3 (toricHypersurfacePowers (5 ^ n) (5 ^ a)) ⊔
        Ideal.span ({f} : Set _))) =
      2 * 5 ^ n * 5 ^ a - ((5 ^ a) ^ 2 + 1) / 2 := by
  letI : Fact (Nat.Prime 5) := ⟨by decide⟩
  have positiveQ : 0 < 5 ^ n := pow_pos (by decide) n
  have positiveT : 0 < 5 ^ a := pow_pos (by decide) a
  have actual := unequal_toric_hypersurface_length_of_positive_formal_change K 5
    n (5 ^ a) 2 positiveT below (by decide) e f u lower equation
  have literal := toric_hypersurface_series_finrank K (5 ^ n) (5 ^ a) 2
    positiveQ positiveT below (by decide)
  rw [actual.trans literal.symm]
  exact toric_hypersurface_series_length_five_two K (5 ^ n) a below

/-- The exact p=5,s=4 unequal formula after an ACTUAL compatible
positive-sign formal change, without assuming a quotient dimension. -/
theorem unequal_toric_hypersurface_five_four_length_of_positive_formal_change
    (n a : ℕ) (below : 5 ^ a ≤ 5 ^ n)
    (e : MvPowerSeries (Fin 3) K ≃ₐ[K] MvPowerSeries (Fin 3) K)
    (f : MvPowerSeries (Fin 3) K) (u : (MvPowerSeries (Fin 3) K)ˣ)
    (lower : 5 ^ a ≠ 5 ^ n → ∃ v : (MvPowerSeries (Fin 3) K)ˣ,
      e (MvPowerSeries.X 2) = (v : MvPowerSeries (Fin 3) K) * MvPowerSeries.X 2)
    (equation : e f = (u : MvPowerSeries (Fin 3) K) *
      (MvPowerSeries.X 0 * MvPowerSeries.X 1 + MvPowerSeries.X 2 ^ 4)) :
    Module.finrank K (MvPowerSeries (Fin 3) K ⧸
      (seriesVariablePowerIdeal K 3 (toricHypersurfacePowers (5 ^ n) (5 ^ a)) ⊔
        Ideal.span ({f} : Set _))) =
      2 * 5 ^ n * 5 ^ a - ((5 ^ a) ^ 2 + 3) / 4 := by
  letI : Fact (Nat.Prime 5) := ⟨by decide⟩
  have positiveQ : 0 < 5 ^ n := pow_pos (by decide) n
  have positiveT : 0 < 5 ^ a := pow_pos (by decide) a
  have actual := unequal_toric_hypersurface_length_of_positive_formal_change K 5
    n (5 ^ a) 4 positiveT below (by decide) e f u lower equation
  have literal := toric_hypersurface_series_finrank K (5 ^ n) (5 ^ a) 4
    positiveQ positiveT below (by decide)
  rw [actual.trans literal.symm]
  exact toric_hypersurface_series_length_five_four K (5 ^ n) a below

end Five

end Litt3.Deformations
