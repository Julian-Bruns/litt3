import Solutions.Deformations.UnequalToricFormalType
import Solutions.Deformations.ToricHypersurfaceFiveLengths

namespace Litt3.Deformations

section General

variable (K : Type*) [Field K] (p : ℕ) [Fact p.Prime] [CharP K p]

/-- Exact closed floor/remainder formula for the ORIGINAL arbitrary
series with its actual compatible positive-sign toric formal change.
No numerical rank or abstract quotient is substituted for the source. -/
theorem unequal_toric_hypersurface_floor_length_of_positive_formal_change
    (n T s : ℕ) (positiveT : 0 < T) (below : T ≤ p ^ n) (quadratic : 2 ≤ s)
    (e : MvPowerSeries (Fin 3) K ≃ₐ[K] MvPowerSeries (Fin 3) K)
    (f : MvPowerSeries (Fin 3) K) (u : (MvPowerSeries (Fin 3) K)ˣ)
    (lower : T ≠ p ^ n → ∃ v : (MvPowerSeries (Fin 3) K)ˣ,
      e (MvPowerSeries.X 2) = (v : MvPowerSeries (Fin 3) K) * MvPowerSeries.X 2)
    (equation : e f = (u : MvPowerSeries (Fin 3) K) *
      (MvPowerSeries.X 0 * MvPowerSeries.X 1 + MvPowerSeries.X 2 ^ s)) :
    Module.finrank K (MvPowerSeries (Fin 3) K ⧸
      (seriesVariablePowerIdeal K 3 (toricHypersurfacePowers (p ^ n) T) ⊔
        Ideal.span ({f} : Set _))) =
      2 * p ^ n * T - s * (T / s) ^ 2 - (T % s) * (2 * (T / s) + 1) := by
  have positiveQ : 0 < p ^ n := pow_pos (Fact.out (p := p.Prime)).pos n
  have actual := unequal_toric_hypersurface_length_of_positive_formal_change K p
    n T s positiveT below (by omega) e f u lower equation
  have literal := toric_hypersurface_series_finrank K (p ^ n) T s
    positiveQ positiveT below (by omega)
  rw [actual.trans literal.symm]
  exact toric_hypersurface_series_length_floor K (p ^ n) T s positiveT below quadratic

end General

section Five

variable (K : Type*) [Field K] [CharP K 5]

/-- The source's p=5,s=2 balanced formula for the ORIGINAL arbitrary
series of actual formal type xy+z², including cutoff one. -/
theorem balanced_toric_hypersurface_five_two_length_of_positive_formal_change
    (n : ℕ) (e : MvPowerSeries (Fin 3) K ≃ₐ[K] MvPowerSeries (Fin 3) K)
    (f : MvPowerSeries (Fin 3) K) (u : (MvPowerSeries (Fin 3) K)ˣ)
    (equation : e f = (u : MvPowerSeries (Fin 3) K) *
      (MvPowerSeries.X 0 * MvPowerSeries.X 1 + MvPowerSeries.X 2 ^ 2)) :
    Module.finrank K (MvPowerSeries (Fin 3) K ⧸
      (seriesVariablePowerIdeal K 3 (fun _ => 5 ^ n) ⊔ Ideal.span ({f} : Set _))) =
        (3 * (5 ^ n) ^ 2 - 1) / 2 := by
  letI : Fact (Nat.Prime 5) := ⟨by decide⟩
  have actual := balanced_toric_hypersurface_length_of_positive_formal_change K 5 n 2
    (by decide) e f u equation
  have literal := toric_hypersurface_series_finrank K (5 ^ n) (5 ^ n) 2
    (pow_pos (by decide) _) (pow_pos (by decide) _) le_rfl (by decide)
  rw [actual.trans literal.symm]
  exact toric_hypersurface_series_balanced_length_five_two K n

/-- The source's p=5,s=4 balanced formula for the ORIGINAL arbitrary
series of actual formal type xy+z⁴, including cutoff one. -/
theorem balanced_toric_hypersurface_five_four_length_of_positive_formal_change
    (n : ℕ) (e : MvPowerSeries (Fin 3) K ≃ₐ[K] MvPowerSeries (Fin 3) K)
    (f : MvPowerSeries (Fin 3) K) (u : (MvPowerSeries (Fin 3) K)ˣ)
    (equation : e f = (u : MvPowerSeries (Fin 3) K) *
      (MvPowerSeries.X 0 * MvPowerSeries.X 1 + MvPowerSeries.X 2 ^ 4)) :
    Module.finrank K (MvPowerSeries (Fin 3) K ⧸
      (seriesVariablePowerIdeal K 3 (fun _ => 5 ^ n) ⊔ Ideal.span ({f} : Set _))) =
        (7 * (5 ^ n) ^ 2 - 3) / 4 := by
  letI : Fact (Nat.Prime 5) := ⟨by decide⟩
  have actual := balanced_toric_hypersurface_length_of_positive_formal_change K 5 n 4
    (by decide) e f u equation
  have literal := toric_hypersurface_series_finrank K (5 ^ n) (5 ^ n) 4
    (pow_pos (by decide) _) (pow_pos (by decide) _) le_rfl (by decide)
  rw [actual.trans literal.symm]
  exact toric_hypersurface_series_balanced_length_five_four K n

end Five

end Litt3.Deformations
