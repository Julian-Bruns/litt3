import Definitions.Deformations.FormalCyclicPresentation
import Solutions.Deformations.PreparedCyclicNormClass
import Solutions.Deformations.CommutingCokernels
import Solutions.Deformations.QuotientIntegralNorm

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

theorem coefficient_series_constant_as_section (n : ℕ) (eta : K) :
    coefficientSeriesConstant (R := R) eta =
      coefficientSeriesPrefixSection (R := R) (n + 1) (Fin.cons eta 0) := by
  funext m
  cases m with
  | zero => simp [coefficientSeriesConstant, coefficientSeriesPrefixSection]
  | succ m =>
    by_cases bound : m + 1 < n + 1
    · have smaller : m < n := by omega
      dsimp [coefficientSeriesConstant, coefficientSeriesPrefixSection]
      simp only [bound, dite_true]
      change 0 = (Fin.cons eta 0 : Fin (n + 1) → K) (⟨m, smaller⟩ : Fin n).succ
      rfl
    · simp [coefficientSeriesConstant, coefficientSeriesPrefixSection, bound]

theorem formal_cyclic_relation_quotient (h p a : ℕ)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute (preparedSeriesOperator h (p : R) correction)
      (coefficientSeriesShift 1)) :
    commutingRangeQuotientEnd (preparedSeriesOperator h (p : R) correction)
        (formalCyclicRelation (R := R) (K := K) p a)
        (cyclic_relation_commute _ _ commute (p ^ a)) =
      preparedSeriesCyclicRelation h p a correction commute :=
  commuting_quotient_cyclic_relation _ _ commute (p ^ a)

/-- The original full cyclic relation is quotiented first; the
resulting actual prepared-operator cokernel has the complete stated
constant and positive scalar-torsion coordinates. -/
noncomputable def formalSeriesCyclicCokernelEquiv (p a n : ℕ) [Fact p.Prime]
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (vanish : (p : R) ^ (a + 1) = 0)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute correction (coefficientSeriesShift 1)) :
    ((CoefficientSeries (K := K) ⧸ LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)) ⧸
      LinearMap.range (commutingRangeQuotientEnd (formalCyclicRelation (R := R) (K := K) p a)
        (preparedSeriesOperator (n + 1) (p : R) correction)
        (cyclic_relation_commute _ _
          (prepared_series_operator_commute_shift (n + 1) (p : R) correction commute) (p ^ a)).symm)) ≃ₗ[R]
      K × (Fin n → K ⧸ coefficientScalarRange ((p : R) ^ a)) :=
  (commutingCokernelsEquiv _ _
    (cyclic_relation_commute _ _
      (prepared_series_operator_commute_shift (n + 1) (p : R) correction commute) (p ^ a))).trans
    ((Submodule.quotEquivOfEq _ _ (congrArg LinearMap.range
      (formal_cyclic_relation_quotient (n + 1) p a correction _))).trans
      (preparedSeriesCyclicCokernelEquiv p a n characteristic bound vanish correction commute))

theorem formal_cyclic_norm_constant_class (p a n : ℕ) [Fact p.Prime]
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (vanish : (p : R) ^ (a + 1) = 0)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute correction (coefficientSeriesShift 1)) (eta : K) :
    formalSeriesCyclicCokernelEquiv p a n characteristic bound vanish correction commute
      ((LinearMap.range (commutingRangeQuotientEnd (formalCyclicRelation (R := R) (K := K) p a)
        (preparedSeriesOperator (n + 1) (p : R) correction)
        (cyclic_relation_commute _ _
          (prepared_series_operator_commute_shift (n + 1) (p : R) correction commute) (p ^ a)).symm)).mkQ
          ((LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ
            (formalCyclicNorm (R := R) p a (coefficientSeriesConstant (R := R) eta)))) =
      ((p : R) ^ a • eta, 0) := by
  change preparedSeriesCyclicCokernelEquiv p a n characteristic bound vanish correction commute
    ((LinearMap.range (preparedSeriesCyclicRelation (n + 1) p a correction
      (prepared_series_operator_commute_shift (n + 1) (p : R) correction commute))).mkQ
      ((LinearMap.range (preparedSeriesOperator (n + 1) (p : R) correction)).mkQ
        (formalCyclicNorm (R := R) p a (coefficientSeriesConstant (R := R) eta)))) = _
  unfold formalCyclicNorm
  rw [commuting_quotient_integral_norm_apply _ _
    (prepared_series_operator_commute_shift (n + 1) (p : R) correction commute) p a,
    coefficient_series_constant_as_section n eta]
  exact prepared_cyclic_norm_constant_class p a n characteristic bound vanish correction commute eta

end Litt3.Deformations
