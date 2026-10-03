import Solutions.Deformations.CoefficientSeriesShiftPowers

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The original literal shift is injective in every coefficient module. -/
theorem coefficient_series_shift_injective (h : ℕ) :
    Function.Injective (coefficientSeriesShift (R := R) (K := K) h) := by
  intro v w same
  have tail := congrArg (coefficientSeriesTail (R := R) h) same
  simpa only [coefficient_series_tail_shift] using tail

/-- Cancellation of an actual lower monomial retains the original
coefficient sequences and the exact exponent difference. -/
theorem coefficient_series_shift_equation (h q : ℕ) (bound : h ≤ q)
    (u v : CoefficientSeries (K := K))
    (same : coefficientSeriesShift (R := R) h u = coefficientSeriesShift (R := R) q v) :
    u = coefficientSeriesShift (R := R) (q - h) v := by
  apply coefficient_series_shift_injective (R := R) h
  have factor : coefficientSeriesShift (R := R) (K := K) h * coefficientSeriesShift (q - h) =
      coefficientSeriesShift q := by
    change (coefficientSeriesShift (R := R) (K := K) h).comp (coefficientSeriesShift (q - h)) = _
    rw [coefficient_series_shift_comp, Nat.add_sub_of_le bound]
  rw [← Module.End.mul_apply, factor]
  exact same

/-- A low-coordinate socle restriction of the original higher
quotient witness forces the exact original q−1 socle restriction. -/
theorem coefficient_series_shift_equation_socle (h q : ℕ) (bound : h ≤ q)
    (u v : CoefficientSeries (K := K))
    (same : coefficientSeriesShift (R := R) h u = coefficientSeriesShift (R := R) q v)
    (low : ∀ n : ℕ, n + 1 < h → v n = 0) :
    ∀ m : ℕ, m + 1 < q → u m = 0 := by
  rw [coefficient_series_shift_equation h q bound u v same]
  intro m small
  change (if q - h ≤ m then v (m - (q - h)) else 0) = 0
  by_cases high : q - h ≤ m
  · have index : m - (q - h) + 1 < h := by omega
    rw [if_pos high]
    exact low _ index
  · rw [if_neg high]

end Litt3.Deformations
