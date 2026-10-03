import Solutions.Deformations.FormalPartialNormCarry
import Solutions.Deformations.FormalCyclicReduction
import Solutions.Deformations.FormalCyclicPresentation
import Solutions.Deformations.SeriesPartialNormWitness
import Solutions.Deformations.SeriesCoefficientSections

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

theorem scalar_coefficient_reduction_positive_power_kills (r : R) (a : ℕ) (positive : 0 < a)
    (v : CoefficientSeries (K := K)) : scalarCoefficientReduction r (r ^ a • v) = 0 := by
  have exponent : a - 1 + 1 = a := by omega
  rw [← exponent, pow_succ', mul_smul]
  exact scalar_coefficient_reduction_kills r _

set_option maxRecDepth 2048 in
/-- Exact terminal carry from the original prescribed leading
coefficients. The final D_h coordinate is discarded precisely by the
literal finite shift, while the full sign and logarithmic unit remain. -/
theorem formal_leading_norm_carry (p a n : ℕ) [Fact p.Prime]
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ (a + 1))) K]
    [Module.Free (ZMod (p ^ (a + 1))) K]
    (aPositive : 0 < a) (characteristic : 2 * (n + 1) < p)
    (vanish : (p : ZMod (p ^ (a + 1))) ^ (a + 1) = 0)
    (C : Module.End (ZMod (p ^ (a + 1))) (CoefficientSeries (K := K)))
    (commute : Commute C (coefficientSeriesShift 1)) (eta : K)
    (constant : K ⧸ coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1))))
    (D : Fin (n + 1) → K ⧸ coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1))))
    (w r z : CoefficientSeries (K := K))
    (equation : preparedSeriesOperator (n + 1) (p : ZMod (p ^ (a + 1))) C w =
      (p : ZMod (p ^ (a + 1))) ^ a • r +
      formalCyclicNorm (R := ZMod (p ^ (a + 1))) p a
        (coefficientSeriesConstant (R := ZMod (p ^ (a + 1))) eta) +
      formalCyclicRelation (R := ZMod (p ^ (a + 1))) p a z)
    (etaReduction : (coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1)))).mkQ eta = constant)
    (pattern : scalarCoefficientReduction (p : ZMod (p ^ (a + 1))) w =
      coefficientSeriesShift (R := ZMod (p ^ (a + 1))) (p ^ a - (n + 1) - 1)
        (coefficientSeriesConstant (R := ZMod (p ^ (a + 1))) constant) +
      coefficientSeriesShift (R := ZMod (p ^ (a + 1))) (p ^ a - (n + 1))
        (coefficientSeriesPrefixSection (R := ZMod (p ^ (a + 1))) (n + 1) D)) :
    ∀ j : Fin (n + 1), (coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1)))).mkQ (r j.val) =
      (-truncatedLogValue (R := ZMod (p ^ (a + 1))) (n + 1)
        (finiteCoefficientShift (R := ZMod (p ^ (a + 1))) (n + 1))
        ((Fin.cons constant 0 : Fin (n + 1) → K ⧸ coefficientScalarRange (K := K)
          (p : ZMod (p ^ (a + 1)))) +
          finiteCoefficientShift (R := ZMod (p ^ (a + 1))) (n + 1) D)) j := by
  let R := ZMod (p ^ (a + 1))
  have prime := (Fact.out : p.Prime)
  have pBound : p ≤ p ^ a := le_self_pow (by omega) (Nat.ne_of_gt aPositive)
  have strict : n + 1 < p ^ a := by omega
  have reduced := congrArg (scalarCoefficientReduction (p : R)) equation
  simp only [preparedSeriesOperator, LinearMap.add_apply, LinearMap.smul_apply, map_add,
    scalar_coefficient_reduction_kills, add_zero, scalar_coefficient_reduction_shift,
    scalar_coefficient_reduction_positive_power_kills _ a aPositive,
    formal_cyclic_norm_scalar_reduction, formal_cyclic_relation_scalar_reduction,
    zero_add, scalar_coefficient_reduction_constant, etaReduction] at reduced
  have witness := series_partial_norm_witness (R := R) (n + 1) (p ^ a) strict constant D _ _ reduced pattern
  let q := (LinearMap.range (preparedSeriesOperator (n + 1) (p : R) C)).mkQ
  let reduction := preparedCoefficientReduction (n + 1) (p : R) ⟨a + 1, vanish⟩ C
  have witnessCoefficients : reduction (q z) = D := by
    funext j
    rw [prepared_coefficient_reduction_mk]
    have point := congrFun witness j.val
    change (coefficientScalarRange (K := K) (p : R)).mkQ (z j.val) =
      coefficientSeriesPrefixSection (R := R) (n + 1) D j.val at point
    simpa [coefficientSeriesPrefixSection, j.isLt] using point
  have constantCoefficients : reduction (q (coefficientSeriesConstant (R := R) eta)) =
      (Fin.cons constant 0 : Fin (n + 1) → K ⧸ coefficientScalarRange (K := K) (p : R)) := by
    rw [coefficient_series_constant_as_section n eta]
    funext j
    rw [prepared_coefficient_reduction_mk]
    change (coefficientScalarRange (K := K) (p : R)).mkQ
      (coefficientSeriesPrefixSection (R := R) (n + 1) (Fin.cons eta 0) j.val) = _
    simp [coefficientSeriesPrefixSection, j.isLt]
    refine Fin.cases ?_ (fun i => ?_) j
    · simpa only [Fin.cons_zero] using etaReduction
    · simp
  have carry := formal_partial_norm_carry p a (n + 1) K (Nat.zero_lt_succ n) characteristic
    (Nat.le_of_lt strict) vanish C commute eta w r z equation
  change reduction (q r) = _ at carry
  rw [witnessCoefficients, constantCoefficients] at carry
  intro j
  have point := congrFun carry j
  rw [prepared_coefficient_reduction_mk] at point
  exact point

end Litt3.Deformations
