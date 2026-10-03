import Solutions.Deformations.CoefficientPolynomialOperators

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

theorem coefficient_series_shift_constant_apply (h : ℕ) (eta : K) (m : ℕ) :
    coefficientSeriesShift (R := R) h (coefficientSeriesConstant (R := R) eta) m =
      if h = m then eta else 0 := by
  simpa only [coefficient_series_map_one, Module.End.one_apply] using
    shifted_coefficient_constant_apply h (1 : Module.End R K) eta m

/-- Every literal finite coefficient vector is the full sum of its
original shifted constant monomials, in arbitrary coefficient rank. -/
theorem coefficient_series_section_sum (q : ℕ) (c : Fin q → K) :
    coefficientSeriesPrefixSection (R := R) q c =
      ∑ j : Fin q, coefficientSeriesShift (R := R) j.val
        (coefficientSeriesConstant (R := R) (c j)) := by
  classical
  funext m
  simp only [Finset.sum_apply, coefficient_series_shift_constant_apply]
  by_cases bound : m < q
  · have equality := Finset.sum_eq_single
      (s := Finset.univ) (f := fun j : Fin q => if j.val = m then c j else 0)
      (⟨m, bound⟩ : Fin q) (by
        intro j member different
        have values : j.val ≠ m := by
          intro same
          exact different (Fin.ext same)
        simp [values]) (by simp)
    simpa [coefficientSeriesPrefixSection, bound] using equality.symm
  · have equality : (∑ j : Fin q, if j.val = m then c j else 0) = 0 := by
      apply Finset.sum_eq_zero
      intro j member
      have values : j.val ≠ m := by omega
      simp [values]
    simpa [coefficientSeriesPrefixSection, bound] using equality.symm

end Litt3.Deformations
