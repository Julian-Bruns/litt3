import Solutions.Deformations.PreparedSeriesAugmentation
import Solutions.Deformations.PreparedFiniteShift

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

@[simp] theorem prepared_series_quotient_equiv_mk (h : ℕ) (parameter : R)
    (nilpotent : IsNilpotent parameter)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (v : CoefficientSeries (K := K)) :
    preparedSeriesQuotientEquiv h parameter nilpotent correction
        ((LinearMap.range (preparedSeriesOperator h parameter correction)).mkQ v) =
      preparedSeriesRemainder h parameter nilpotent correction v := rfl

@[simp] theorem prepared_series_quotient_equiv_symm (h : ℕ) (parameter : R)
    (nilpotent : IsNilpotent parameter)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (v : Fin h → K) :
    (preparedSeriesQuotientEquiv h parameter nilpotent correction).symm v =
      (LinearMap.range (preparedSeriesOperator h parameter correction)).mkQ
        (coefficientSeriesPrefixSection (R := R) h v) := by
  apply (preparedSeriesQuotientEquiv h parameter nilpotent correction).injective
  rw [LinearEquiv.apply_symm_apply]
  change v = preparedSeriesRemainder h parameter nilpotent correction
    (coefficientSeriesPrefixSection (R := R) h v)
  exact (prepared_series_remainder_section h parameter nilpotent correction v).symm

/-- In the constructed low-coordinate equivalence, the full actual
augmentation action has precisely the last-scalar truncated shift. -/
theorem prepared_quotient_last_scalar_conjugate (h a : ℕ) (parameter : R)
    (vanish : parameter ^ (a + 1) = 0)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute (preparedSeriesOperator h parameter correction)
      (coefficientSeriesShift 1)) :
    (preparedSeriesQuotientEquiv h parameter ⟨a + 1, vanish⟩ correction).conj
        (parameter ^ a • preparedSeriesQuotientAugmentation h parameter correction commute) =
      parameter ^ a • finiteCoefficientShift (R := R) (K := K) h := by
  apply LinearMap.ext
  intro v
  rw [LinearEquiv.conj_apply_apply, prepared_series_quotient_equiv_symm]
  simp only [LinearMap.smul_apply, map_smul, preparedSeriesQuotientAugmentation,
    commuting_range_quotient_apply_mk, prepared_series_quotient_equiv_mk]
  exact prepared_series_last_scalar_shift h a parameter vanish correction v

end Litt3.Deformations
