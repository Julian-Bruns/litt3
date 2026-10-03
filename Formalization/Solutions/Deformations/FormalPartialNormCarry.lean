import Solutions.Deformations.PreparedLogReduction
import Solutions.Deformations.FormalPreparedImages

namespace Litt3.Deformations

/-- The exact original top-scalar partial norm carry in low
coefficient coordinates, retaining the actual original relation witness.
No leading coefficient, sign or nonlinear term is silently discarded. -/
theorem formal_partial_norm_carry (p a h : ℕ) [Fact p.Prime]
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ (a + 1))) K]
    [Module.Free (ZMod (p ^ (a + 1))) K]
    (positive : 0 < h) (characteristic : 2 * h < p) (bound : h ≤ p ^ a)
    (vanish : (p : ZMod (p ^ (a + 1))) ^ (a + 1) = 0)
    (C : Module.End (ZMod (p ^ (a + 1))) (CoefficientSeries (K := K)))
    (commute : Commute C (coefficientSeriesShift 1))
    (eta : K) (w r z : CoefficientSeries (K := K))
    (equation : preparedSeriesOperator h (p : ZMod (p ^ (a + 1))) C w =
      (p : ZMod (p ^ (a + 1))) ^ a • r +
      formalCyclicNorm (R := ZMod (p ^ (a + 1))) p a
        (coefficientSeriesConstant (R := ZMod (p ^ (a + 1))) eta) +
      formalCyclicRelation (R := ZMod (p ^ (a + 1))) p a z) :
    preparedCoefficientReduction h (p : ZMod (p ^ (a + 1))) ⟨a + 1, vanish⟩ C
      ((LinearMap.range (preparedSeriesOperator h (p : ZMod (p ^ (a + 1))) C)).mkQ r) =
      -truncatedLogValue (R := ZMod (p ^ (a + 1))) h (finiteCoefficientShift (R := ZMod (p ^ (a + 1))) h)
        (preparedCoefficientReduction h (p : ZMod (p ^ (a + 1))) ⟨a + 1, vanish⟩ C
          ((LinearMap.range (preparedSeriesOperator h (p : ZMod (p ^ (a + 1))) C)).mkQ
            (coefficientSeriesConstant (R := ZMod (p ^ (a + 1))) eta)) +
          finiteCoefficientShift (R := ZMod (p ^ (a + 1))) h
            (preparedCoefficientReduction h (p : ZMod (p ^ (a + 1))) ⟨a + 1, vanish⟩ C
              ((LinearMap.range (preparedSeriesOperator h (p : ZMod (p ^ (a + 1))) C)).mkQ z))) := by
  let R := ZMod (p ^ (a + 1))
  let A := preparedSeriesOperator h (p : R) C
  let q := (LinearMap.range A).mkQ
  let E := preparedSeriesQuotientAugmentation h (p : R) C
    (prepared_series_operator_commute_shift h (p : R) C commute)
  let U := truncatedLogValue (R := R) h E
  let reduction := preparedCoefficientReduction h (p : R) ⟨a + 1, vanish⟩ C
  have norm := (prepared_series_quotient_cyclic_log_norm p a h positive characteristic bound vanish C commute).1
  have killed : q (A w) = 0 := (Submodule.Quotient.mk_eq_zero _).mpr ⟨w, rfl⟩
  have original := congrArg q equation
  rw [killed, map_add, map_add, map_smul, prepared_quotient_original_norm h p a C commute,
    prepared_quotient_original_relation h p a C commute] at original
  have scalarZero : (p : R) ^ a • (q r + U (q (coefficientSeriesConstant (R := R) eta) + E (q z))) = 0 := by
    rw [smul_add, map_add, smul_add]
    change (p : R) ^ a • q r +
      ((p : R) ^ a • U (q (coefficientSeriesConstant (R := R) eta)) + (p : R) ^ a • U (E (q z))) = 0
    have rewritten := original.symm
    rw [norm] at rewritten
    simpa only [LinearMap.smul_apply, add_assoc] using rewritten
  have reduced := prepared_last_scalar_zero_reduction p a h (Fact.out : p.Prime).pos K vanish C _ scalarZero
  rw [map_add, prepared_coefficient_reduction_log h (p : R) ⟨a + 1, vanish⟩ C commute,
    map_add, prepared_coefficient_reduction_augmentation h (p : R) ⟨a + 1, vanish⟩ C commute] at reduced
  exact eq_neg_of_add_eq_zero_left reduced

end Litt3.Deformations
