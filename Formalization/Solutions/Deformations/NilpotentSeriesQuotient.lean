import Theorems.Deformations.NilpotentSeriesQuotient
import Solutions.Deformations.NilpotentSeriesPreparation

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]
    (h : ℕ) (parameter : R) (nilpotent : IsNilpotent parameter)
    (correction : CoefficientSeries (K := K) →ₗ[R] CoefficientSeries (K := K))

noncomputable def preparedSeriesRemainder : CoefficientSeries (K := K) →ₗ[R] (Fin h → K) :=
  (LinearMap.fst R _ _).comp (preparedSeriesDivisionEquiv h parameter nilpotent correction).toLinearMap

theorem prepared_series_division_reconstruct (v : CoefficientSeries (K := K)) :
    coefficientSeriesPrefixSection (R := R) h
      (preparedSeriesDivisionEquiv h parameter nilpotent correction v).1 +
      preparedSeriesOperator h parameter correction
        (preparedSeriesDivisionEquiv h parameter nilpotent correction v).2 = v :=
  (preparedSeriesDivisionEquiv h parameter nilpotent correction).symm_apply_apply v

theorem prepared_series_division_reconstruction (r : Fin h → K) (g : CoefficientSeries (K := K)) :
    preparedSeriesDivisionEquiv h parameter nilpotent correction
      (coefficientSeriesPrefixSection (R := R) h r + preparedSeriesOperator h parameter correction g) =
      (r, g) :=
  (preparedSeriesDivisionEquiv h parameter nilpotent correction).apply_symm_apply (r, g)

@[simp] theorem prepared_series_remainder_section (r : Fin h → K) :
    preparedSeriesRemainder h parameter nilpotent correction
      (coefficientSeriesPrefixSection (R := R) h r) = r := by
  have identity := congrArg Prod.fst (prepared_series_division_reconstruction h parameter nilpotent correction r 0)
  simpa only [map_zero, add_zero] using identity

@[simp] theorem prepared_series_remainder_operator (g : CoefficientSeries (K := K)) :
    preparedSeriesRemainder h parameter nilpotent correction
      (preparedSeriesOperator h parameter correction g) = 0 := by
  have identity := congrArg Prod.fst (prepared_series_division_reconstruction h parameter nilpotent correction 0 g)
  simpa only [map_zero, zero_add] using identity

theorem prepared_series_remainder_kernel :
    LinearMap.ker (preparedSeriesRemainder h parameter nilpotent correction) =
      LinearMap.range (preparedSeriesOperator h parameter correction) := by
  ext v
  constructor
  · intro zero
    have remainder : (preparedSeriesDivisionEquiv h parameter nilpotent correction v).1 = 0 := zero
    have identity := prepared_series_division_reconstruct h parameter nilpotent correction v
    rw [remainder, map_zero, zero_add] at identity
    exact ⟨_, identity⟩
  · rintro ⟨g, rfl⟩
    exact prepared_series_remainder_operator h parameter nilpotent correction g

theorem prepared_series_remainder_surjective :
    Function.Surjective (preparedSeriesRemainder h parameter nilpotent correction) :=
  fun r => ⟨coefficientSeriesPrefixSection (R := R) h r,
    prepared_series_remainder_section h parameter nilpotent correction r⟩

noncomputable def preparedSeriesQuotientEquiv :
    (CoefficientSeries (K := K) ⧸ LinearMap.range (preparedSeriesOperator h parameter correction)) ≃ₗ[R]
      (Fin h → K) :=
  (Submodule.quotEquivOfEq _ _ (prepared_series_remainder_kernel h parameter nilpotent correction).symm).trans
    ((preparedSeriesRemainder h parameter nilpotent correction).quotKerEquivOfSurjective
      (prepared_series_remainder_surjective h parameter nilpotent correction))

include nilpotent in
/-- The actual full formal-series preparation quotient is constructed
over every commutative coefficient ring with nilpotent parameter and
every coefficient module, including arbitrary free-module rank. -/
theorem nilpotent_series_quotient : Specifications.NilpotentSeriesQuotient h parameter correction := by
  refine ⟨?_, preparedSeriesQuotientEquiv h parameter nilpotent correction, ?_⟩
  · intro v w same
    apply (preparedSeriesTailEquiv h parameter nilpotent correction).injective
    exact congrArg (coefficientSeriesTail (R := R) h) same
  · intro r
    simp only [preparedSeriesQuotientEquiv, LinearEquiv.trans_apply, Submodule.quotEquivOfEq_mk,
      LinearMap.quotKerEquivOfSurjective_apply_mk, prepared_series_remainder_section]

end Litt3.Deformations
