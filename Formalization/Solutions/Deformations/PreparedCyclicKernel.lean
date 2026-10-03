import Solutions.Deformations.PreparedCyclicCokernel
import Solutions.Deformations.QuotientIntegralNorm

namespace Litt3.Deformations

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

/-- A scalar times an actual unit has the literal scalar kernel. -/
theorem linear_endomorphism_scalar_unit_zero (r : R) (U : Module.End R M)
    (unit : IsUnit U) (v : M) : (r • U) v = 0 ↔ r • v = 0 := by
  have injective := ((Module.End.isUnit_iff U).mp unit).1
  rw [LinearMap.smul_apply, ← map_smul]
  exact injective.eq_iff' (U.map_zero)

variable {K : Type*} [AddCommGroup K] [Module R K]

/-- The literal full cyclic relation on the actual prepared quotient
has precisely the last-scalar augmentation kernel. The full norm
unit is constructed and used injectively, with no counting argument. -/
theorem prepared_cyclic_relation_zero_iff (p a h : ℕ) [Fact p.Prime]
    (positive : 0 < h) (characteristic : 2 * h < p) (bound : h ≤ p ^ a)
    (vanish : (p : R) ^ (a + 1) = 0)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute correction (coefficientSeriesShift 1))
    (v : CoefficientSeries (K := K) ⧸ LinearMap.range
      (preparedSeriesOperator h (p : R) correction)) :
    preparedSeriesCyclicRelation h p a correction
      (prepared_series_operator_commute_shift h (p : R) correction commute) v = 0 ↔
      (p : R) ^ a • preparedSeriesQuotientAugmentation h (p : R) correction
        (prepared_series_operator_commute_shift h (p : R) correction commute) v = 0 := by
  let E := preparedSeriesQuotientAugmentation h (p : R) correction
    (prepared_series_operator_commute_shift h (p : R) correction commute)
  have normal := prepared_series_quotient_cyclic_log_norm p a h positive characteristic bound
    vanish correction commute
  change ((1 + E) ^ (p ^ a) - 1) v = 0 ↔ _
  rw [integral_cyclic_relation_norm (R := R)]
  have central := integral_cyclic_norm_commute E E (Commute.refl E) p a
  rw [central.eq, normal.1, Module.End.mul_apply]
  exact linear_endomorphism_scalar_unit_zero ((p : R) ^ a) _ normal.2 (E v)

/-- The entire actual full-relation kernel is transported to the
literal last-scalar finite shift, retaining each actual coefficient. -/
theorem prepared_cyclic_relation_zero_coordinates (p a h : ℕ) [Fact p.Prime]
    (positive : 0 < h) (characteristic : 2 * h < p) (bound : h ≤ p ^ a)
    (vanish : (p : R) ^ (a + 1) = 0)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute correction (coefficientSeriesShift 1))
    (v : CoefficientSeries (K := K) ⧸ LinearMap.range
      (preparedSeriesOperator h (p : R) correction)) :
    preparedSeriesCyclicRelation h p a correction
      (prepared_series_operator_commute_shift h (p : R) correction commute) v = 0 ↔
      ((p : R) ^ a • finiteCoefficientShift (R := R) (K := K) h)
        (preparedSeriesQuotientEquiv h (p : R) ⟨a + 1, vanish⟩ correction v) = 0 := by
  rw [prepared_cyclic_relation_zero_iff p a h positive characteristic bound vanish correction commute]
  let e := preparedSeriesQuotientEquiv h (p : R) ⟨a + 1, vanish⟩ correction
  have point := LinearMap.congr_fun
    (prepared_quotient_last_scalar_conjugate h a (p : R) vanish correction
      (prepared_series_operator_commute_shift h (p : R) correction commute)) (e v)
  rw [LinearEquiv.conj_apply_apply, LinearEquiv.symm_apply_apply] at point
  change e (((p : R) ^ a • preparedSeriesQuotientAugmentation h (p : R) correction _) v) =
    ((p : R) ^ a • finiteCoefficientShift (R := R) (K := K) h) (e v) at point
  rw [← point]
  exact e.map_eq_zero_iff.symm

end Litt3.Deformations
