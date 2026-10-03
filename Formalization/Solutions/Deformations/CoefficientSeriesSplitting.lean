import Definitions.Deformations.CoefficientSeriesSplitting

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

@[simp] theorem coefficient_series_tail_shift (h : ℕ) (v : CoefficientSeries (K := K)) :
    coefficientSeriesTail (R := R) h (coefficientSeriesShift (R := R) h v) = v := by
  funext n
  simp [coefficientSeriesTail, coefficientSeriesShift]

@[simp] theorem coefficient_series_prefix_section (h : ℕ) (v : Fin h → K) :
    coefficientSeriesPrefix (R := R) h (coefficientSeriesPrefixSection (R := R) h v) = v := by
  funext n
  simp [coefficientSeriesPrefix, coefficientSeriesPrefixSection, n.2]

@[simp] theorem coefficient_series_tail_prefix_section (h : ℕ) (v : Fin h → K) :
    coefficientSeriesTail (R := R) h (coefficientSeriesPrefixSection (R := R) h v) = 0 := by
  funext n
  simp [coefficientSeriesTail, coefficientSeriesPrefixSection]

@[simp] theorem coefficient_series_prefix_shift (h : ℕ) (v : CoefficientSeries (K := K)) :
    coefficientSeriesPrefix (R := R) h (coefficientSeriesShift (R := R) h v) = 0 := by
  funext n
  simp [coefficientSeriesPrefix, coefficientSeriesShift, Nat.not_le.mpr n.2]

/-- The literal prefix and tail split every formal coefficient sequence. -/
theorem coefficient_series_recompose (h : ℕ) (v : CoefficientSeries (K := K)) :
    coefficientSeriesPrefixSection (R := R) h (coefficientSeriesPrefix (R := R) h v) +
      coefficientSeriesShift (R := R) h (coefficientSeriesTail (R := R) h v) = v := by
  funext n
  by_cases bound : n < h
  · simp [coefficientSeriesPrefixSection, coefficientSeriesPrefix, coefficientSeriesShift,
      bound, Nat.not_le.mpr bound]
  · have lower : h ≤ n := Nat.le_of_not_gt bound
    simp [coefficientSeriesPrefixSection, coefficientSeriesTail, coefficientSeriesShift,
      bound, lower, Nat.sub_add_cancel lower]

theorem coefficient_series_eq_prefix_of_tail_zero (h : ℕ) (v : CoefficientSeries (K := K))
    (tail : coefficientSeriesTail (R := R) h v = 0) :
    coefficientSeriesPrefixSection (R := R) h (coefficientSeriesPrefix (R := R) h v) = v := by
  simpa only [tail, map_zero, add_zero] using coefficient_series_recompose (R := R) h v

end Litt3.Deformations
