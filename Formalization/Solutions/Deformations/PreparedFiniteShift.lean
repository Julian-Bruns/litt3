import Definitions.Deformations.PreparedFiniteShift
import Solutions.Deformations.NilpotentSeriesQuotient

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

theorem prepared_series_remainder_shift (h : ℕ) (parameter : R)
    (nilpotent : IsNilpotent parameter)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (v : CoefficientSeries (K := K)) :
    preparedSeriesRemainder h parameter nilpotent correction (coefficientSeriesShift (R := R) h v) =
      -parameter • preparedSeriesRemainder h parameter nilpotent correction (correction v) := by
  have relation := prepared_series_remainder_operator h parameter nilpotent correction v
  simp only [preparedSeriesOperator, LinearMap.add_apply, LinearMap.smul_apply,
    map_add, map_smul] at relation
  simpa only [neg_smul] using eq_neg_of_add_eq_zero_left relation

/-- The actual prepared augmentation in low coordinates differs from
the standard truncated shift by an explicitly divisible correction. -/
theorem prepared_series_remainder_first_shift (h : ℕ) (parameter : R)
    (nilpotent : IsNilpotent parameter)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (v : Fin h → K) :
    preparedSeriesRemainder h parameter nilpotent correction
        (coefficientSeriesShift (R := R) 1 (coefficientSeriesPrefixSection (R := R) h v)) =
      finiteCoefficientShift (R := R) h v - parameter •
        preparedSeriesRemainder h parameter nilpotent correction
          (correction (coefficientSeriesTail (R := R) h
            (coefficientSeriesShift (R := R) 1 (coefficientSeriesPrefixSection (R := R) h v)))) := by
  let w := coefficientSeriesShift (R := R) 1 (coefficientSeriesPrefixSection (R := R) h v)
  have split := coefficient_series_recompose (R := R) h w
  have identity := congrArg (preparedSeriesRemainder h parameter nilpotent correction) split
  simp only [map_add, prepared_series_remainder_section, prepared_series_remainder_shift] at identity
  simpa only [sub_eq_add_neg, neg_smul] using identity.symm

/-- Multiplication by the last surviving scalar power removes the
entire correction on the full low-coordinate module. -/
theorem prepared_series_last_scalar_shift (h a : ℕ) (parameter : R)
    (vanish : parameter ^ (a + 1) = 0)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (v : Fin h → K) :
    parameter ^ a • preparedSeriesRemainder h parameter ⟨a + 1, vanish⟩ correction
        (coefficientSeriesShift (R := R) 1 (coefficientSeriesPrefixSection (R := R) h v)) =
      parameter ^ a • finiteCoefficientShift (R := R) h v := by
  rw [prepared_series_remainder_first_shift, smul_sub, smul_smul,
    ← pow_succ, vanish, zero_smul, sub_zero]

end Litt3.Deformations
