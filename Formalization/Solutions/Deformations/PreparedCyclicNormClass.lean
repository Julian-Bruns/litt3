import Solutions.Deformations.PreparedCyclicCokernel

namespace Litt3.Deformations

variable {R B : Type*} [CommRing R] [Ring B] [Algebra R B]

/-- The exact logarithmic polynomial retains its constant one and
its literal divisible-by-augmentation tail over the original ring. -/
theorem truncated_log_value_one_add (h : ℕ) (positive : 0 < h) (x : B) :
    truncatedLogValue (R := R) h x =
      1 + x * Polynomial.aeval x (truncatedLogPolynomial (R := R) h).divX := by
  have identity := congrArg (Polynomial.aeval x)
    (Polynomial.X_mul_divX_add (truncatedLogPolynomial (R := R) h))
  simp only [map_add, map_mul, Polynomial.aeval_X,
    truncated_log_polynomial_constant h positive, map_one] at identity
  rw [truncated_log_value_aeval]
  exact identity.symm.trans (add_comm _ _)

variable {K : Type*} [AddCommGroup K] [Module R K]

/-- The full norm class on the actual prepared cyclic cokernel is
the exact highest scalar power of the original representative. -/
theorem prepared_cyclic_norm_class (p a h : ℕ) [Fact p.Prime]
    (positive : 0 < h) (characteristic : 2 * h < p) (bound : h ≤ p ^ a)
    (vanish : (p : R) ^ (a + 1) = 0)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute correction (coefficientSeriesShift 1))
    (v : CoefficientSeries (K := K) ⧸ LinearMap.range (preparedSeriesOperator h (p : R) correction)) :
    (LinearMap.range (preparedSeriesCyclicRelation h p a correction
      (prepared_series_operator_commute_shift h (p : R) correction commute))).mkQ
        (integralCyclicNormValue (R := R) p a
          (preparedSeriesQuotientAugmentation h (p : R) correction
            (prepared_series_operator_commute_shift h (p : R) correction commute)) v) =
      (LinearMap.range (preparedSeriesCyclicRelation h p a correction
        (prepared_series_operator_commute_shift h (p : R) correction commute))).mkQ
          ((p : R) ^ a • v) := by
  let E := preparedSeriesQuotientAugmentation h (p : R) correction
    (prepared_series_operator_commute_shift h (p : R) correction commute)
  let W := Polynomial.aeval E (truncatedLogPolynomial (R := R) h).divX
  let q := (LinearMap.range (preparedSeriesCyclicRelation h p a correction
    (prepared_series_operator_commute_shift h (p : R) correction commute))).mkQ
  have norm := (prepared_series_quotient_cyclic_log_norm p a h positive characteristic bound
    vanish correction commute).1
  have identity : integralCyclicNormValue (R := R) p a E =
      (p : R) ^ a • 1 + ((p : R) ^ a • E) * W := by
    rw [norm, truncated_log_value_one_add h positive, smul_add, ← smul_mul_assoc]
  have killed : (LinearMap.range (preparedSeriesCyclicRelation h p a correction
      (prepared_series_operator_commute_shift h (p : R) correction commute))).mkQ
        (((p : R) ^ a • E) (W v)) = 0 := by
    apply (Submodule.Quotient.mk_eq_zero _).mpr
    rw [prepared_cyclic_relation_range p a h positive characteristic bound vanish correction commute]
    exact ⟨W v, rfl⟩
  change q (integralCyclicNormValue (R := R) p a E v) = q ((p : R) ^ a • v)
  rw [identity, LinearMap.add_apply, Module.End.mul_apply, map_add, killed, add_zero,
    LinearMap.smul_apply, Module.End.one_apply]

@[simp] theorem prepared_cyclic_cokernel_equiv_mk (p a n : ℕ) [Fact p.Prime]
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (vanish : (p : R) ^ (a + 1) = 0)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute correction (coefficientSeriesShift 1))
    (v : CoefficientSeries (K := K)) :
    preparedSeriesCyclicCokernelEquiv p a n characteristic bound vanish correction commute
      ((LinearMap.range (preparedSeriesCyclicRelation (n + 1) p a correction
        (prepared_series_operator_commute_shift (n + 1) (p : R) correction commute))).mkQ
        ((LinearMap.range (preparedSeriesOperator (n + 1) (p : R) correction)).mkQ v)) =
      finiteShiftCokernelMap n ((p : R) ^ a)
        (preparedSeriesRemainder (n + 1) (p : R) ⟨a + 1, vanish⟩ correction v) := rfl

/-- The literal constant coefficient norm has exactly the source
normal-form coordinate (p^a eta, 0,...,0). -/
theorem prepared_cyclic_norm_constant_class (p a n : ℕ) [Fact p.Prime]
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (vanish : (p : R) ^ (a + 1) = 0)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute correction (coefficientSeriesShift 1)) (eta : K) :
    preparedSeriesCyclicCokernelEquiv p a n characteristic bound vanish correction commute
      ((LinearMap.range (preparedSeriesCyclicRelation (n + 1) p a correction
        (prepared_series_operator_commute_shift (n + 1) (p : R) correction commute))).mkQ
        (integralCyclicNormValue (R := R) p a
          (preparedSeriesQuotientAugmentation (n + 1) (p : R) correction
            (prepared_series_operator_commute_shift (n + 1) (p : R) correction commute))
          ((LinearMap.range (preparedSeriesOperator (n + 1) (p : R) correction)).mkQ
            (coefficientSeriesPrefixSection (R := R) (n + 1) (Fin.cons eta 0))))) =
      ((p : R) ^ a • eta, 0) := by
  rw [prepared_cyclic_norm_class p a (n + 1) (Nat.zero_lt_succ n) characteristic bound
    vanish correction commute, ← map_smul, prepared_cyclic_cokernel_equiv_mk,
    map_smul, prepared_series_remainder_section]
  apply Prod.ext
  · simp [finiteShiftCokernelMap]
  · funext i
    simp [finiteShiftCokernelMap]

end Litt3.Deformations
