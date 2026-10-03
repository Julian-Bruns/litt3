import Solutions.Deformations.SeriesFirstOverflowCoefficient
import Solutions.Deformations.TruncatedMonomialSeriesProjection

namespace Litt3.Deformations

variable (R : Type*) [CommRing R] (d : ℕ)

/-- Every actual formal series with zero surviving original coefficients
is a finite sum of multiples of the literal original variable powers. -/
theorem series_first_overflow_decomposition (q : Fin d → ℕ)
    (f : MvPowerSeries (Fin d) R)
    (vanishing : ∀ a : Fin d →₀ ℕ, (∀ i, a i < q i) → MvPowerSeries.coeff a f = 0) :
    f = ∑ i : Fin d, MvPowerSeries.X i ^ q i * seriesFirstOverflowFactor R d q f i := by
  classical
  apply MvPowerSeries.ext
  intro a
  simp only [map_sum, series_first_overflow_coefficient]
  by_cases someOverflow : ∃ i, q i ≤ a i
  · let s := Finset.univ.filter (fun i : Fin d => q i ≤ a i)
    have nonempty : s.Nonempty := by
      obtain ⟨i, member⟩ := someOverflow
      exact ⟨i, Finset.mem_filter.mpr ⟨Finset.mem_univ _, member⟩⟩
    let i := s.min' nonempty
    have overflows : q i ≤ a i := (Finset.mem_filter.mp (Finset.min'_mem s nonempty)).2
    have earlier : ∀ j : Fin d, j < i → a j < q j := by
      intro j small
      apply Nat.lt_of_not_ge
      intro oversized
      have inSet : j ∈ s := Finset.mem_filter.mpr ⟨Finset.mem_univ _, oversized⟩
      exact (not_le_of_gt small) (Finset.min'_le s j inSet)
    rw [Finset.sum_eq_single i]
    · exact (if_pos ⟨overflows, earlier⟩).symm
    · intro j member different
      apply if_neg
      rintro ⟨oversized, before⟩
      have first : i ≤ j := Finset.min'_le s j (Finset.mem_filter.mpr ⟨member, oversized⟩)
      have strictly : i < j := lt_of_le_of_ne first (Ne.symm different)
      exact Nat.not_le_of_lt (before i strictly) overflows
    · intro impossible
      exact (impossible (Finset.mem_univ _)).elim
  · have survives : ∀ i, a i < q i := fun i =>
      Nat.lt_of_not_ge (fun member => someOverflow ⟨i, member⟩)
    rw [vanishing a survives]
    simp only [ite_self, Finset.sum_const_zero]

/-- The actual formal variable-power ideal is exactly the full kernel
of the constructed genuine finite coefficient projection. -/
theorem series_variable_power_ideal_kernel (q : Fin d → ℕ) (positive : ∀ i, 0 < q i) :
    seriesVariablePowerIdeal R d q = RingHom.ker
      (truncatedMonomialSeriesProjection R (Fin d) q positive) := by
  classical
  apply le_antisymm
  · apply Ideal.span_le.mpr
    rintro x ⟨i, rfl⟩
    change truncatedMonomialSeriesProjection R (Fin d) q positive
      (MvPowerSeries.X i ^ q i) = 0
    apply (truncated_monomial_series_projection_zero_iff R (Fin d) q positive _).mpr
    intro a survives
    rw [MvPowerSeries.coeff_X_pow]
    apply if_neg
    intro same
    have impossible := survives i
    rw [same, Finsupp.single_eq_same] at impossible
    exact (lt_irrefl (q i)) impossible
  · intro f member
    have vanish := (truncated_monomial_series_projection_zero_iff R (Fin d) q positive f).mp member
    rw [series_first_overflow_decomposition R d q f vanish]
    apply Ideal.sum_mem
    intro i inSum
    apply Ideal.mul_mem_right
    exact Ideal.subset_span (Set.mem_range_self i)

end Litt3.Deformations
