import Theorems.Deformations.PreparedCyclicCokernel
import Solutions.Deformations.PreparedQuotientCoordinates
import Solutions.Deformations.IntegralCyclicRelation
import Solutions.Deformations.FiniteShiftCokernel
import Solutions.Deformations.LinearEndomorphismRanges

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The full cyclic relation has exactly the image of the last scalar
power times actual augmentation. The logarithmic unit is constructed. -/
theorem prepared_cyclic_relation_range (p a h : ℕ) [Fact p.Prime]
    (positive : 0 < h) (characteristic : 2 * h < p) (bound : h ≤ p ^ a)
    (vanish : (p : R) ^ (a + 1) = 0)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute correction (coefficientSeriesShift 1)) :
    LinearMap.range (preparedSeriesCyclicRelation h p a correction
        (prepared_series_operator_commute_shift h (p : R) correction commute)) =
      LinearMap.range ((p : R) ^ a • preparedSeriesQuotientAugmentation h (p : R) correction
        (prepared_series_operator_commute_shift h (p : R) correction commute)) := by
  have norm := prepared_series_quotient_cyclic_log_norm p a h positive characteristic bound
    vanish correction commute
  unfold preparedSeriesCyclicRelation
  rw [integral_cyclic_relation_norm (R := R), norm.1, mul_smul_comm, ← smul_mul_assoc]
  exact linear_endomorphism_range_mul_unit _ _ norm.2

/-- The original low-coordinate equivalence sends the full actual
cyclic relation image to the literal scalar-times-shift image. -/
theorem prepared_cyclic_relation_range_coordinates (p a h : ℕ) [Fact p.Prime]
    (positive : 0 < h) (characteristic : 2 * h < p) (bound : h ≤ p ^ a)
    (vanish : (p : R) ^ (a + 1) = 0)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute correction (coefficientSeriesShift 1)) :
    (LinearMap.range (preparedSeriesCyclicRelation h p a correction
        (prepared_series_operator_commute_shift h (p : R) correction commute))).map
        (preparedSeriesQuotientEquiv h (p : R) ⟨a + 1, vanish⟩ correction).toLinearMap =
      LinearMap.range ((p : R) ^ a • finiteCoefficientShift (R := R) (K := K) h) := by
  rw [prepared_cyclic_relation_range p a h positive characteristic bound vanish correction commute,
    linear_equiv_map_range_conjugate,
    prepared_quotient_last_scalar_conjugate h a (p : R) vanish correction _]

/-- The complete actual prepared cyclic cokernel is constructed at
arbitrary coefficient rank, with one full constant coordinate and all
positive coordinates modulo the literal highest scalar-power image. -/
noncomputable def preparedSeriesCyclicCokernelEquiv (p a n : ℕ) [Fact p.Prime]
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (vanish : (p : R) ^ (a + 1) = 0)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute correction (coefficientSeriesShift 1)) :
    ((CoefficientSeries (K := K) ⧸ LinearMap.range
      (preparedSeriesOperator (n + 1) (p : R) correction)) ⧸
        LinearMap.range (preparedSeriesCyclicRelation (n + 1) p a correction
          (prepared_series_operator_commute_shift (n + 1) (p : R) correction commute))) ≃ₗ[R]
      K × (Fin n → K ⧸ coefficientScalarRange ((p : R) ^ a)) :=
  (Submodule.Quotient.equiv _ _
    (preparedSeriesQuotientEquiv (n + 1) (p : R) ⟨a + 1, vanish⟩ correction)
    (prepared_cyclic_relation_range_coordinates p a (n + 1) (Nat.zero_lt_succ n)
      characteristic bound vanish correction commute)).trans
    (finiteShiftCokernelEquiv n ((p : R) ^ a))

theorem prepared_cyclic_cokernel (p a n : ℕ) [Fact p.Prime]
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (vanish : (p : R) ^ (a + 1) = 0)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute correction (coefficientSeriesShift 1)) :
    Specifications.PreparedSeriesCyclicCokernel p a n correction
      (prepared_series_operator_commute_shift (n + 1) (p : R) correction commute) :=
  ⟨preparedSeriesCyclicCokernelEquiv p a n characteristic bound vanish correction commute⟩


end Litt3.Deformations
