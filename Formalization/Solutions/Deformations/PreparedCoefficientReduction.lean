import Definitions.Deformations.FiniteCoefficientReduction
import Solutions.Deformations.PreparedQuotientCoordinates
import Solutions.Deformations.SeriesCoefficientReduction
import Solutions.Deformations.OperatorPolynomialIntertwining

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- Literal low coefficients modulo the actual scalar on the actual
prepared quotient, with its original representative formula proved. -/
noncomputable def preparedCoefficientReduction (h : ℕ) (r : R) (nilpotent : IsNilpotent r)
    (C : Module.End R (CoefficientSeries (K := K))) :
    (CoefficientSeries (K := K) ⧸ LinearMap.range (preparedSeriesOperator h r C)) →ₗ[R]
      (Fin h → K ⧸ coefficientScalarRange (K := K) r) :=
  (finiteCoefficientMap h (coefficientScalarRange (K := K) r).mkQ).comp
    (preparedSeriesQuotientEquiv h r nilpotent C).toLinearMap

theorem prepared_coefficient_reduction_mk (h : ℕ) (r : R) (nilpotent : IsNilpotent r)
    (C : Module.End R (CoefficientSeries (K := K)))
    (v : CoefficientSeries (K := K)) (j : Fin h) :
    preparedCoefficientReduction h r nilpotent C
      ((LinearMap.range (preparedSeriesOperator h r C)).mkQ v) j =
      (coefficientScalarRange (K := K) r).mkQ (v j.val) :=
  prepared_series_remainder_scalar_reduction h r nilpotent C v j

/-- Actual prepared augmentation reduces to the literal finite shift
on the actual scalar coefficient quotient. -/
theorem prepared_coefficient_reduction_augmentation (h : ℕ) (r : R)
    (nilpotent : IsNilpotent r) (C : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute C (coefficientSeriesShift 1))
    (v : CoefficientSeries (K := K) ⧸ LinearMap.range (preparedSeriesOperator h r C)) :
    preparedCoefficientReduction h r nilpotent C
      (preparedSeriesQuotientAugmentation h r C
        (prepared_series_operator_commute_shift h r C commute) v) =
      finiteCoefficientShift (R := R) h (preparedCoefficientReduction h r nilpotent C v) := by
  obtain ⟨w, rfl⟩ := (LinearMap.range (preparedSeriesOperator h r C)).mkQ_surjective v
  have coefficients : preparedCoefficientReduction h r nilpotent C
      ((LinearMap.range (preparedSeriesOperator h r C)).mkQ w) =
      (fun j : Fin h => (coefficientScalarRange (K := K) r).mkQ (w j.val)) :=
    funext (prepared_coefficient_reduction_mk h r nilpotent C w)
  funext j
  rw [preparedSeriesQuotientAugmentation, commuting_range_quotient_apply_mk,
    prepared_coefficient_reduction_mk, coefficients]
  change (coefficientScalarRange (K := K) r).mkQ
    (if 1 ≤ j.val then w (j.val - 1) else 0) =
      (if 1 ≤ j.val then
        (if low : j.val - 1 < h then
          (coefficientScalarRange (K := K) r).mkQ (w (⟨j.val - 1, low⟩ : Fin h).val) else 0) else 0)
  have low : j.val - 1 < h := lt_of_le_of_lt (Nat.sub_le _ _) j.isLt
  by_cases high : 1 ≤ j.val <;> simp [high, low]

end Litt3.Deformations
