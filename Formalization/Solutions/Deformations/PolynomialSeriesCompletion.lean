import Solutions.Deformations.PolynomialSeriesPreparation
import Solutions.Deformations.PreparedQuotientCoordinates

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]
    (h : ℕ) (parameter : R) (nilpotent : IsNilpotent parameter)
    (C : Module.End R (CoefficientSeries (K := K)))
    (preserve : ∀ v : polynomialCoefficientSeries (R := R) (K := K),
      C v ∈ polynomialCoefficientSeries (R := R) (K := K))

/-- Completion is the actual original inclusion of the polynomial
submodule, after imposing the actual distinguished relation. -/
def polynomialPreparedCompletionMap :
    (polynomialCoefficientSeries (R := R) (K := K) ⧸
      LinearMap.range (polynomialPreparedSeriesOperator h parameter C preserve)) →ₗ[R]
      (CoefficientSeries (K := K) ⧸ LinearMap.range (preparedSeriesOperator h parameter C)) :=
  (LinearMap.range (polynomialPreparedSeriesOperator h parameter C preserve)).mapQ
    (LinearMap.range (preparedSeriesOperator h parameter C))
    (polynomialCoefficientSeries (R := R) (K := K)).subtype (by
      rintro v ⟨w, rfl⟩
      exact ⟨(w : CoefficientSeries (K := K)), rfl⟩)

@[simp] theorem polynomial_prepared_completion_map_mk
    (v : polynomialCoefficientSeries (R := R) (K := K)) :
    polynomialPreparedCompletionMap h parameter C preserve
      ((LinearMap.range (polynomialPreparedSeriesOperator h parameter C preserve)).mkQ v) =
      (LinearMap.range (preparedSeriesOperator h parameter C)).mkQ
        (v : CoefficientSeries (K := K)) := rfl

/-- The actual polynomial and full-series divisions have exactly
the same literal remainder on every original polynomial. -/
theorem polynomial_prepared_remainder_completion
    (v : polynomialCoefficientSeries (R := R) (K := K)) :
    preparedSeriesRemainder h parameter nilpotent C (v : CoefficientSeries (K := K)) =
      polynomialPreparedRemainder h parameter nilpotent C preserve v := by
  have reconstruct := polynomial_prepared_division_reconstruct h parameter nilpotent C preserve v
  have full := congrArg
    (fun w : polynomialCoefficientSeries (R := R) (K := K) => w.val) reconstruct
  change coefficientSeriesPrefixSection (R := R) h
      (polynomialPreparedDivisionEquiv h parameter nilpotent C preserve v).1 +
    preparedSeriesOperator h parameter C
      ((polynomialPreparedDivisionEquiv h parameter nilpotent C preserve v).2 : CoefficientSeries (K := K)) =
        (v : CoefficientSeries (K := K)) at full
  have identity := congrArg (preparedSeriesRemainder h parameter nilpotent C) full
  simp only [map_add, prepared_series_remainder_section, prepared_series_remainder_operator,
    add_zero] at identity
  exact identity.symm

/-- Completion is an actual equivalence for every distinguished
nilpotent perturbation preserving actual polynomials, at arbitrary
coefficient rank. It is proved from full division, not assumed. -/
noncomputable def polynomialPreparedCompletionEquiv :
    (polynomialCoefficientSeries (R := R) (K := K) ⧸
      LinearMap.range (polynomialPreparedSeriesOperator h parameter C preserve)) ≃ₗ[R]
      (CoefficientSeries (K := K) ⧸ LinearMap.range (preparedSeriesOperator h parameter C)) :=
  (polynomialPreparedQuotientEquiv h parameter nilpotent C preserve).trans
    (preparedSeriesQuotientEquiv h parameter nilpotent C).symm

@[simp] theorem polynomial_prepared_completion_equiv_mk
    (v : polynomialCoefficientSeries (R := R) (K := K)) :
    polynomialPreparedCompletionEquiv h parameter nilpotent C preserve
      ((LinearMap.range (polynomialPreparedSeriesOperator h parameter C preserve)).mkQ v) =
      (LinearMap.range (preparedSeriesOperator h parameter C)).mkQ
        (v : CoefficientSeries (K := K)) := by
  apply (preparedSeriesQuotientEquiv h parameter nilpotent C).injective
  rw [polynomialPreparedCompletionEquiv, LinearEquiv.trans_apply,
    LinearEquiv.apply_symm_apply, prepared_series_quotient_equiv_mk]
  change polynomialPreparedRemainder h parameter nilpotent C preserve v =
    preparedSeriesRemainder h parameter nilpotent C (v : CoefficientSeries (K := K))
  exact (polynomial_prepared_remainder_completion h parameter nilpotent C preserve v).symm

theorem polynomial_prepared_completion_equiv_actual_map :
    (polynomialPreparedCompletionEquiv h parameter nilpotent C preserve).toLinearMap =
      polynomialPreparedCompletionMap h parameter C preserve := by
  apply LinearMap.ext
  intro v
  obtain ⟨w, rfl⟩ := (LinearMap.range (polynomialPreparedSeriesOperator h parameter C preserve)).mkQ_surjective v
  exact polynomial_prepared_completion_equiv_mk h parameter nilpotent C preserve w

end Litt3.Deformations
