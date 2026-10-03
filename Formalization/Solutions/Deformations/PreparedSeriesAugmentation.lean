import Definitions.Deformations.PreparedSeriesAugmentation
import Solutions.Deformations.CoefficientSeriesShiftPowers
import Solutions.Deformations.CommutingRangeQuotient
import Solutions.Deformations.PreparedCyclicLogNorm

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

theorem prepared_series_operator_commute_shift (h : ℕ) (parameter : R)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute correction (coefficientSeriesShift 1)) :
    Commute (preparedSeriesOperator h parameter correction) (coefficientSeriesShift 1) := by
  unfold preparedSeriesOperator
  rw [← coefficient_series_shift_power]
  apply Commute.add_left
  · exact (Commute.refl (coefficientSeriesShift (R := R) (K := K) 1)).pow_left h
  · exact commute.smul_left parameter

theorem prepared_series_operator_commute_correction (h : ℕ) (parameter : R)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute correction (coefficientSeriesShift 1)) :
    Commute (preparedSeriesOperator h parameter correction) correction := by
  unfold preparedSeriesOperator
  rw [← coefficient_series_shift_power]
  apply Commute.add_left
  · exact commute.symm.pow_left h
  · exact (Commute.refl correction).smul_left parameter

/-- The actual augmentation action on the actual prepared cokernel
satisfies its integral distinguished relation, with its original
correction operator still present. -/
theorem prepared_series_quotient_power_relation (h : ℕ) (parameter : R)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (shiftCommute : Commute (preparedSeriesOperator h parameter correction)
      (coefficientSeriesShift 1))
    (correctionCommute : Commute (preparedSeriesOperator h parameter correction) correction) :
    preparedSeriesQuotientAugmentation h parameter correction shiftCommute ^ h =
      parameter • (-preparedSeriesQuotientCorrection h parameter correction correctionCommute) := by
  apply LinearMap.ext
  intro v
  obtain ⟨w, rfl⟩ := (LinearMap.range (preparedSeriesOperator h parameter correction)).mkQ_surjective v
  rw [preparedSeriesQuotientAugmentation, commuting_range_quotient_pow_apply_mk,
    coefficient_series_shift_power]
  have zero : (LinearMap.range (preparedSeriesOperator h parameter correction)).mkQ
      (preparedSeriesOperator h parameter correction w) = 0 := by
    exact (Submodule.Quotient.mk_eq_zero _).mpr ⟨w, rfl⟩
  have relation : (LinearMap.range (preparedSeriesOperator h parameter correction)).mkQ
      (coefficientSeriesShift (R := R) h w) + parameter •
        (LinearMap.range (preparedSeriesOperator h parameter correction)).mkQ (correction w) = 0 := by
    simpa only [preparedSeriesOperator, LinearMap.add_apply, LinearMap.smul_apply,
      map_add, map_smul] using zero
  simpa only [LinearMap.smul_apply, LinearMap.neg_apply, preparedSeriesQuotientCorrection,
    commuting_range_quotient_apply_mk, smul_neg] using eq_neg_of_add_eq_zero_left relation

/-- The complete logarithmic norm formula holds on the literal
prepared quotient, without a supplied finite-rank or Jordan model. -/
theorem prepared_series_quotient_cyclic_log_norm (p a h : ℕ) [Fact p.Prime]
    (orderPositive : 0 < h) (characteristic : 2 * h < p) (bound : h ≤ p ^ a)
    (nilpotent : (p : R) ^ (a + 1) = 0)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute correction (coefficientSeriesShift 1)) :
    Specifications.PreparedCyclicLogNorm (R := R) p a h
      (preparedSeriesQuotientAugmentation h (p : R) correction
        (prepared_series_operator_commute_shift h (p : R) correction commute)) := by
  exact prepared_cyclic_log_norm p a h orderPositive characteristic bound _
    (-preparedSeriesQuotientCorrection h (p : R) correction
      (prepared_series_operator_commute_correction h (p : R) correction commute))
    (prepared_series_quotient_power_relation h (p : R) correction _ _) nilpotent

end Litt3.Deformations
