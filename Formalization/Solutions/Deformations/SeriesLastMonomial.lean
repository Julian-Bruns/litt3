import Solutions.Deformations.CoefficientSeriesMonomials
import Solutions.Deformations.FiniteShiftScalarKernel

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

theorem coefficient_series_monomial_as_section (h j : ℕ) (bound : j < h) (eta : K) :
    coefficientSeriesShift (R := R) j (coefficientSeriesConstant (R := R) eta) =
      coefficientSeriesPrefixSection (R := R) h (fun i : Fin h => if i.val = j then eta else 0) := by
  funext m
  rw [coefficient_series_shift_constant_apply]
  change (if j = m then eta else 0) =
    (if high : m < h then if (⟨m, high⟩ : Fin h).val = j then eta else 0 else 0)
  by_cases high : m < h
  · simp [high, eq_comm]
  · have different : j ≠ m := by omega
    simp [high, different]

/-- The literal final coefficient monomial is annihilated by the
literal finite shift. -/
theorem finite_coefficient_shift_last (n : ℕ) (eta : K) :
    finiteCoefficientShift (R := R) (n + 1)
      (fun j : Fin (n + 1) => if j.val = n then eta else 0) = 0 := by
  funext j
  refine Fin.cases ?_ (fun i => ?_) j
  · exact finite_coefficient_shift_zero n _
  · rw [finite_coefficient_shift_succ]
    change (if i.val = n then eta else 0) = 0
    rw [if_neg (by omega)]

theorem scalar_coefficient_reduction_constant (scalar : R) (eta : K) :
    scalarCoefficientReduction scalar (coefficientSeriesConstant (R := R) eta) =
      coefficientSeriesConstant (R := R)
        ((coefficientScalarRange (K := K) scalar).mkQ eta) := by
  funext m
  change (coefficientScalarRange (K := K) scalar).mkQ (if m = 0 then eta else 0) =
    if m = 0 then (coefficientScalarRange (K := K) scalar).mkQ eta else 0
  by_cases zero : m = 0 <;> simp [zero]

end Litt3.Deformations
