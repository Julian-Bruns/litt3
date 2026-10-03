import Solutions.Deformations.SeriesUnequalFrobeniusInvariance

namespace Litt3.Deformations

variable (K : Type*) [Field K] (p : ℕ) [Fact p.Prime] [CharP K p] (d : ℕ)

/-- An actual formal coordinate change may multiply each lower-power
variable by a genuine unit. This still preserves the literal original
unequal Frobenius ideal; the common largest coordinates are unrestricted. -/
theorem series_unequal_frobenius_unit_ideal_map_le (q : Fin d → ℕ)
    (positive : ∀ i, 0 < q i) (n : ℕ) (bounds : ∀ i, q i ≤ p ^ n)
    (e : MvPowerSeries (Fin d) K ≃+* MvPowerSeries (Fin d) K)
    (lower : ∀ i, q i ≠ p ^ n → ∃ u : (MvPowerSeries (Fin d) K)ˣ,
      e (MvPowerSeries.X i) = (u : MvPowerSeries (Fin d) K) * MvPowerSeries.X i) :
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
  · obtain ⟨u, equation⟩ := lower i maximal
    rw [equation, mul_pow]
    exact (seriesVariablePowerIdeal K d q).mul_mem_left _
      (Ideal.subset_span (Set.mem_range_self i))

/-- The true inverse of an actual unit-preserving lower-coordinate
change has the same property, proving equality of the whole original
unequal-power ideal without a presumed inverse coordinate formula. -/
theorem series_unequal_frobenius_unit_ideal_invariant (q : Fin d → ℕ)
    (positive : ∀ i, 0 < q i) (n : ℕ) (bounds : ∀ i, q i ≤ p ^ n)
    (e : MvPowerSeries (Fin d) K ≃+* MvPowerSeries (Fin d) K)
    (lower : ∀ i, q i ≠ p ^ n → ∃ u : (MvPowerSeries (Fin d) K)ˣ,
      e (MvPowerSeries.X i) = (u : MvPowerSeries (Fin d) K) * MvPowerSeries.X i) :
    (seriesVariablePowerIdeal K d q).map e.toRingHom = seriesVariablePowerIdeal K d q := by
  apply le_antisymm (series_unequal_frobenius_unit_ideal_map_le K p d q positive n bounds e lower)
  have reverse := series_unequal_frobenius_unit_ideal_map_le K p d q positive n bounds e.symm
    (by
      intro i smaller
      obtain ⟨u, equation⟩ := lower i smaller
      let v := Units.map e.symm.toMonoidHom u
      have mapped : MvPowerSeries.X i = (v : MvPowerSeries (Fin d) K) *
          e.symm (MvPowerSeries.X i) := by
        simpa only [map_mul, e.symm_apply_apply, Units.coe_map] using congrArg e.symm equation
      refine ⟨v⁻¹, ?_⟩
      calc
        e.symm (MvPowerSeries.X i) =
            ((v⁻¹ : (MvPowerSeries (Fin d) K)ˣ) : MvPowerSeries (Fin d) K) *
              ((v : MvPowerSeries (Fin d) K) * e.symm (MvPowerSeries.X i)) := by
          rw [← mul_assoc, Units.inv_mul, one_mul]
        _ = _ := congrArg
          (fun x => ((v⁻¹ : (MvPowerSeries (Fin d) K)ˣ) : MvPowerSeries (Fin d) K) * x)
          mapped.symm)
  have mapped := Ideal.map_mono (f := e.toRingHom) reverse
  simpa only [Ideal.map_map, e.toRingHom_comp_symm_toRingHom, Ideal.map_id] using mapped

end Litt3.Deformations
