import Solutions.Deformations.SeriesPowerCancellation
import Definitions.Deformations.FormalCyclicPresentation

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The stated original leading-coefficient pattern determines the
entire actual relation witness modulo the scalar: its coefficients
are exactly D₁,…,D_h, with the original sign retained. -/
theorem series_partial_norm_witness (h q : ℕ) (bound : h < q) (constant : K)
    (D : Fin h → K) (y z : CoefficientSeries (K := K))
    (equation : coefficientSeriesShift (R := R) h y =
      coefficientSeriesShift (R := R) (q - 1) (coefficientSeriesConstant (R := R) constant) +
      coefficientSeriesShift (R := R) q z)
    (pattern : y = coefficientSeriesShift (R := R) (q - h - 1)
      (coefficientSeriesConstant (R := R) constant) +
      coefficientSeriesShift (R := R) (q - h) (coefficientSeriesPrefixSection (R := R) h D)) :
    z = coefficientSeriesPrefixSection (R := R) h D := by
  have first : coefficientSeriesShift (R := R) h
      (coefficientSeriesShift (R := R) (q - h - 1) (coefficientSeriesConstant (R := R) constant)) =
      coefficientSeriesShift (R := R) (q - 1) (coefficientSeriesConstant (R := R) constant) := by
    change ((coefficientSeriesShift (R := R) h).comp (coefficientSeriesShift (q - h - 1))) _ = _
    rw [coefficient_series_shift_comp]
    have exponent : h + (q - h - 1) = q - 1 := by omega
    rw [exponent]
  have second : coefficientSeriesShift (R := R) h
      (coefficientSeriesShift (R := R) (q - h) (coefficientSeriesPrefixSection (R := R) h D)) =
      coefficientSeriesShift (R := R) q (coefficientSeriesPrefixSection (R := R) h D) := by
    change ((coefficientSeriesShift (R := R) h).comp (coefficientSeriesShift (q - h))) _ = _
    rw [coefficient_series_shift_comp, Nat.add_sub_of_le (Nat.le_of_lt bound)]
  rw [pattern, map_add, first, second] at equation
  exact (coefficient_series_shift_injective (R := R) q (add_left_cancel equation)).symm

end Litt3.Deformations
