import Definitions.Deformations.SeriesCoefficientReduction
import Solutions.Deformations.NilpotentSeriesQuotient

namespace Litt3.Deformations

variable {R K L : Type*} [CommRing R] [AddCommGroup K] [Module R K]
  [AddCommGroup L] [Module R L]

theorem coefficient_series_lift_shift (f : K →ₗ[R] L) (h : ℕ)
    (v : CoefficientSeries (K := K)) :
    coefficientSeriesLift f (coefficientSeriesShift (R := R) h v) =
      coefficientSeriesShift (R := R) h (coefficientSeriesLift f v) := by
  funext n
  by_cases bound : h ≤ n <;> simp [coefficientSeriesLift, coefficientSeriesShift, bound]

theorem scalar_coefficient_quotient_kills (scalar : R) (v : K) :
    (coefficientScalarRange (K := K) scalar).mkQ (scalar • v) = 0 :=
  (Submodule.Quotient.mk_eq_zero _).mpr ⟨v, rfl⟩

theorem scalar_coefficient_quotient_smul_zero (scalar : R)
    (v : K ⧸ coefficientScalarRange (K := K) scalar) : scalar • v = 0 := by
  obtain ⟨w, rfl⟩ := (coefficientScalarRange (K := K) scalar).mkQ_surjective v
  rw [← map_smul]
  exact scalar_coefficient_quotient_kills scalar w

theorem scalar_coefficient_reduction_kills (scalar : R)
    (v : CoefficientSeries (K := K)) :
    scalarCoefficientReduction scalar (scalar • v) = 0 := by
  funext n
  exact scalar_coefficient_quotient_kills scalar (v n)

/-- The full prepared remainder reduces to the literal original low
coefficients. The actual nilpotent correction disappears in the actual
scalar quotient; no freeness or finite rank is needed. -/
theorem prepared_series_remainder_scalar_reduction (h : ℕ) (scalar : R)
    (nilpotent : IsNilpotent scalar)
    (C : Module.End R (CoefficientSeries (K := K)))
    (v : CoefficientSeries (K := K)) (j : Fin h) :
    (coefficientScalarRange (K := K) scalar).mkQ
      (preparedSeriesRemainder h scalar nilpotent C v j) =
      (coefficientScalarRange (K := K) scalar).mkQ (v j.val) := by
  have identity := congrArg (fun w : CoefficientSeries (K := K) =>
    (coefficientScalarRange (K := K) scalar).mkQ (w j.val))
      (prepared_series_division_reconstruct h scalar nilpotent C v)
  have bound : ¬ h ≤ j.val := by omega
  simpa [coefficientSeriesPrefixSection, preparedSeriesOperator, coefficientSeriesShift,
    bound, j.isLt, map_add, preparedSeriesRemainder,
    scalar_coefficient_quotient_smul_zero] using identity

end Litt3.Deformations
