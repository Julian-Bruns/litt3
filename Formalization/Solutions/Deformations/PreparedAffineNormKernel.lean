import Solutions.Deformations.PreparedCyclicKernel
import Solutions.Deformations.FormalCyclicPresentation
import Solutions.Deformations.FiniteShiftScalarKernel

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The complete original affine norm kernel on the actual prepared
quotient has the exact constant-plus-shift scalar coordinate condition. -/
theorem prepared_affine_norm_zero_coordinates (p a n : ℕ) [Fact p.Prime]
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (vanish : (p : R) ^ (a + 1) = 0)
    (C : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute C (coefficientSeriesShift 1)) (eta : K)
    (v : CoefficientSeries (K := K) ⧸ LinearMap.range (preparedSeriesOperator (n + 1) (p : R) C)) :
    integralCyclicNormValue (R := R) p a
      (preparedSeriesQuotientAugmentation (n + 1) (p : R) C
        (prepared_series_operator_commute_shift (n + 1) (p : R) C commute))
      ((LinearMap.range (preparedSeriesOperator (n + 1) (p : R) C)).mkQ
        (coefficientSeriesConstant (R := R) eta) +
        preparedSeriesQuotientAugmentation (n + 1) (p : R) C
          (prepared_series_operator_commute_shift (n + 1) (p : R) C commute) v) = 0 ↔
      (p : R) ^ a • ((Fin.cons eta 0 : Fin (n + 1) → K) +
        finiteCoefficientShift (R := R) (n + 1)
          (preparedSeriesQuotientEquiv (n + 1) (p : R) ⟨a + 1, vanish⟩ C v)) = 0 := by
  let E := preparedSeriesQuotientAugmentation (n + 1) (p : R) C
    (prepared_series_operator_commute_shift (n + 1) (p : R) C commute)
  let e := preparedSeriesQuotientEquiv (n + 1) (p : R) ⟨a + 1, vanish⟩ C
  let q := (LinearMap.range (preparedSeriesOperator (n + 1) (p : R) C)).mkQ
  have normal := prepared_series_quotient_cyclic_log_norm p a (n + 1) (Nat.zero_lt_succ n)
    characteristic bound vanish C commute
  have constant : e (q (coefficientSeriesConstant (R := R) eta)) =
      (Fin.cons eta 0 : Fin (n + 1) → K) := by
    rw [coefficient_series_constant_as_section n eta]
    exact prepared_series_remainder_section _ _ _ _ _
  have augmentation := LinearMap.congr_fun
    (prepared_quotient_last_scalar_conjugate (n + 1) a (p : R) vanish C
      (prepared_series_operator_commute_shift (n + 1) (p : R) C commute)) (e v)
  rw [LinearEquiv.conj_apply_apply, LinearEquiv.symm_apply_apply] at augmentation
  have coordinates : e ((p : R) ^ a • (q (coefficientSeriesConstant (R := R) eta) + E v)) =
      (p : R) ^ a • ((Fin.cons eta 0 : Fin (n + 1) → K) +
        finiteCoefficientShift (R := R) (n + 1) (e v)) := by
    rw [smul_add, map_add, map_smul, constant]
    change (p : R) ^ a • (Fin.cons eta 0 : Fin (n + 1) → K) +
      e (((p : R) ^ a • E) v) = _
    rw [augmentation, smul_add]
    rfl
  change integralCyclicNormValue (R := R) p a E
    (q (coefficientSeriesConstant (R := R) eta) + E v) = 0 ↔ _
  rw [normal.1, linear_endomorphism_scalar_unit_zero _ _ normal.2]
  rw [← coordinates]
  exact e.map_eq_zero_iff.symm

end Litt3.Deformations
