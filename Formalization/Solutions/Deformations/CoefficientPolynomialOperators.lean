import Definitions.Deformations.CoefficientPolynomialOperators
import Solutions.Deformations.CoefficientSeriesMaps
import Solutions.Deformations.PolynomialCoefficientSeries
import Definitions.Deformations.FormalCyclicPresentation

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

theorem coefficient_polynomial_operator_commute_shift (q : ℕ)
    (C : Fin q → Module.End R K) (h : ℕ) :
    Commute (coefficientPolynomialOperator q C) (coefficientSeriesShift h) := by
  unfold coefficientPolynomialOperator
  apply Commute.symm
  apply Commute.sum_right
  intro j member
  apply Commute.mul_right
  · change coefficientSeriesShift h * coefficientSeriesShift j.val =
    coefficientSeriesShift j.val * coefficientSeriesShift h
    change (coefficientSeriesShift (R := R) (K := K) h).comp (coefficientSeriesShift j.val) =
      (coefficientSeriesShift j.val).comp (coefficientSeriesShift h)
    rw [coefficient_series_shift_comp, coefficient_series_shift_comp, Nat.add_comm]
  · exact (coefficient_series_map_commute_shift (C j) h).symm

theorem coefficient_series_map_preserves_polynomial (f : Module.End R K)
    (v : polynomialCoefficientSeries (R := R) (K := K)) :
    coefficientSeriesMap f (v : CoefficientSeries (K := K)) ∈
      polynomialCoefficientSeries (R := R) (K := K) := by
  obtain ⟨N, bound⟩ := v.2
  refine ⟨N, ?_⟩
  intro m high
  change f ((v : CoefficientSeries (K := K)) m) = 0
  rw [bound m high, map_zero]

/-- Every actual coefficient polynomial preserves the literal
polynomial submodule, even with noncommuting coefficient operators. -/
theorem coefficient_polynomial_operator_preserves_polynomial (q : ℕ)
    (C : Fin q → Module.End R K)
    (v : polynomialCoefficientSeries (R := R) (K := K)) :
    coefficientPolynomialOperator q C (v : CoefficientSeries (K := K)) ∈
      polynomialCoefficientSeries (R := R) (K := K) := by
  rw [coefficientPolynomialOperator, LinearMap.sum_apply]
  apply Submodule.sum_mem
  intro j member
  exact (polynomialSeriesShift (R := R) j.val
    ⟨coefficientSeriesMap (C j) (v : CoefficientSeries (K := K)),
      coefficient_series_map_preserves_polynomial (C j) v⟩).2

theorem shifted_coefficient_constant_apply (h : ℕ) (f : Module.End R K) (eta : K) (m : ℕ) :
    coefficientSeriesShift (R := R) h
      (coefficientSeriesMap f (coefficientSeriesConstant (R := R) eta)) m =
      if h = m then f eta else 0 := by
  by_cases same : h = m
  · subst m
    simp [coefficientSeriesShift, coefficientSeriesMap, coefficientSeriesConstant]
  · by_cases high : h ≤ m
    · have residual : m - h ≠ 0 := by omega
      simp [coefficientSeriesShift, coefficientSeriesMap, coefficientSeriesConstant,
        same, high, residual]
    · simp [coefficientSeriesShift, coefficientSeriesMap, same, high]

/-- The entire original finite coefficient tuple is recovered on
the literal constant coefficient, with no basis or matrix choice. -/
theorem coefficient_polynomial_operator_constant (q : ℕ)
    (C : Fin q → Module.End R K) (eta : K) :
    coefficientPolynomialOperator q C (coefficientSeriesConstant (R := R) eta) =
      coefficientSeriesPrefixSection (R := R) q (fun j => C j eta) := by
  classical
  funext m
  simp only [coefficientPolynomialOperator, LinearMap.sum_apply, Module.End.mul_apply,
    Finset.sum_apply, shifted_coefficient_constant_apply]
  by_cases bound : m < q
  · have sum : (∑ j : Fin q, if j.val = m then C j eta else 0) = C ⟨m, bound⟩ eta := by
      have equality := Finset.sum_eq_single
        (s := Finset.univ) (f := fun j : Fin q => if j.val = m then C j eta else 0)
        (⟨m, bound⟩ : Fin q) (by
          intro j member different
          have values : j.val ≠ m := by
            intro same
            exact different (Fin.ext same)
          simp [values]) (by simp)
      simpa using equality
    simpa [coefficientSeriesPrefixSection, bound] using sum
  · have zero : (∑ j : Fin q, if j.val = m then C j eta else 0) = 0 := by
      apply Finset.sum_eq_zero
      intro j member
      have different : j.val ≠ m := by omega
      simp [different]
    simpa [coefficientSeriesPrefixSection, bound] using zero

end Litt3.Deformations
