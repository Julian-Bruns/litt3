import Solutions.Deformations.SeriesAutomorphismAugmentation
import Solutions.Deformations.TruncatedMonomialFrobenius
import Solutions.Deformations.TruncatedMonomialAugmentation
import Solutions.Deformations.SeriesVariablePowerKernel

namespace Litt3.Deformations

variable (K : Type*) [Field K] (p : ℕ) [Fact p.Prime] [CharP K p] (d : ℕ)

/-- A literal formal automorphism fixing all lower-power variables
sends every generator of the genuine unequal Frobenius-power ideal
back into that same ideal. The unrestricted variables have the common
largest prime-power exponent. -/
theorem series_unequal_frobenius_ideal_map_le (q : Fin d → ℕ)
    (positive : ∀ i, 0 < q i) (n : ℕ) (bounds : ∀ i, q i ≤ p ^ n)
    (e : MvPowerSeries (Fin d) K ≃+* MvPowerSeries (Fin d) K)
    (fixed : ∀ i, q i ≠ p ^ n → e (MvPowerSeries.X i) = MvPowerSeries.X i) :
    (seriesVariablePowerIdeal K d q).map e.toRingHom ≤ seriesVariablePowerIdeal K d q := by
  rw [Ideal.map_le_iff_le_comap]
  apply Ideal.span_le.mpr
  rintro x ⟨i, rfl⟩
  change e (MvPowerSeries.X i ^ q i) ∈ seriesVariablePowerIdeal K d q
  rw [map_pow]
  by_cases maximal : q i = p ^ n
  · rw [series_variable_power_ideal_kernel K d q positive]
    change truncatedMonomialSeriesProjection K (Fin d) q positive
      (e (MvPowerSeries.X i) ^ q i) = 0
    rw [map_pow, maximal]
    exact truncated_monomial_augmentation_frobenius K (Fin d) p q positive n bounds _
      (truncated_monomial_series_augmentation K (Fin d) q positive _
        (series_automorphism_variable_constant_zero K (Fin d) e i))
  · rw [fixed i maximal]
    exact Ideal.subset_span (Set.mem_range_self i)

/-- The entire actual unequal Frobenius-power ideal is invariant under
every such formal automorphism, because its true inverse fixes exactly
the same lower-power original variables. -/
theorem series_unequal_frobenius_ideal_invariant (q : Fin d → ℕ)
    (positive : ∀ i, 0 < q i) (n : ℕ) (bounds : ∀ i, q i ≤ p ^ n)
    (e : MvPowerSeries (Fin d) K ≃+* MvPowerSeries (Fin d) K)
    (fixed : ∀ i, q i ≠ p ^ n → e (MvPowerSeries.X i) = MvPowerSeries.X i) :
    (seriesVariablePowerIdeal K d q).map e.toRingHom = seriesVariablePowerIdeal K d q := by
  apply le_antisymm (series_unequal_frobenius_ideal_map_le K p d q positive n bounds e fixed)
  have reverse := series_unequal_frobenius_ideal_map_le K p d q positive n bounds e.symm
    (fun i lower => by simpa only [e.symm_apply_apply] using (congrArg e.symm (fixed i lower)).symm)
  have mapped := Ideal.map_mono (f := e.toRingHom) reverse
  simpa only [Ideal.map_map, e.toRingHom_comp_symm_toRingHom, Ideal.map_id] using mapped

end Litt3.Deformations
