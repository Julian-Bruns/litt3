import Solutions.Deformations.PreparedCyclicKernel
import Definitions.Deformations.FormalCyclicPresentation

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The full original norm retains its actual image on the actual
prepared quotient, without passing to a second quotient. -/
theorem prepared_quotient_original_norm (h p a : ℕ)
    (C : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute C (coefficientSeriesShift 1)) (v : CoefficientSeries (K := K)) :
    (LinearMap.range (preparedSeriesOperator h (p : R) C)).mkQ
      (formalCyclicNorm (R := R) p a v) =
      integralCyclicNormValue (R := R) p a
        (preparedSeriesQuotientAugmentation h (p : R) C
          (prepared_series_operator_commute_shift h (p : R) C commute))
        ((LinearMap.range (preparedSeriesOperator h (p : R) C)).mkQ v) :=
  commuting_quotient_integral_norm_apply _ _
    (prepared_series_operator_commute_shift h (p : R) C commute) p a v

/-- The full original relation is the actual full norm of the actual
augmentation image on the actual prepared quotient. -/
theorem prepared_quotient_original_relation (h p a : ℕ)
    (C : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute C (coefficientSeriesShift 1)) (v : CoefficientSeries (K := K)) :
    (LinearMap.range (preparedSeriesOperator h (p : R) C)).mkQ
      (formalCyclicRelation (R := R) p a v) =
      integralCyclicNormValue (R := R) p a
        (preparedSeriesQuotientAugmentation h (p : R) C
          (prepared_series_operator_commute_shift h (p : R) C commute))
        (preparedSeriesQuotientAugmentation h (p : R) C
          (prepared_series_operator_commute_shift h (p : R) C commute)
          ((LinearMap.range (preparedSeriesOperator h (p : R) C)).mkQ v)) := by
  rw [formalCyclicRelation, integral_cyclic_relation_norm (R := R)]
  have central := integral_cyclic_norm_commute
    (coefficientSeriesShift (R := R) (K := K) 1) _ (Commute.refl _) p a
  rw [central.eq, Module.End.mul_apply]
  change (LinearMap.range (preparedSeriesOperator h (p : R) C)).mkQ
    (formalCyclicNorm (R := R) p a (coefficientSeriesShift (R := R) 1 v)) = _
  rw [prepared_quotient_original_norm h p a C commute]
  rfl

end Litt3.Deformations
