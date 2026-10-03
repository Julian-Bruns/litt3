import Solutions.Deformations.CoefficientSeriesSplitting

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

@[simp] theorem coefficient_series_shift_zero :
    coefficientSeriesShift (R := R) (K := K) 0 = 1 := by
  apply LinearMap.ext
  intro v
  funext n
  simp [coefficientSeriesShift]

/-- Literal formal multiplication by e^h composes by addition of
orders on the full coefficient-sequence module. -/
theorem coefficient_series_shift_comp (h j : ℕ) :
    (coefficientSeriesShift (R := R) (K := K) h).comp (coefficientSeriesShift j) =
      coefficientSeriesShift (h + j) := by
  apply LinearMap.ext
  intro v
  funext n
  by_cases first : h ≤ n
  · by_cases second : j ≤ n - h
    · have total : h + j ≤ n := by omega
      simp [coefficientSeriesShift, first, second, total, Nat.sub_sub]
    · have total : ¬ h + j ≤ n := by omega
      simp [coefficientSeriesShift, first, second, total]
  · have total : ¬ h + j ≤ n := by omega
    simp [coefficientSeriesShift, first, total]

theorem coefficient_series_shift_power (h : ℕ) :
    (coefficientSeriesShift (R := R) (K := K) 1) ^ h = coefficientSeriesShift h := by
  induction h with
  | zero => simp
  | succ h induction =>
    rw [pow_succ, induction]
    exact coefficient_series_shift_comp h 1

end Litt3.Deformations
