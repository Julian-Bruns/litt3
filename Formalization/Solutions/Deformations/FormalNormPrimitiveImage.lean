import Solutions.Deformations.FormalNormPrimitiveNecessity
import Solutions.Deformations.FormalNormSocleRealization
import Solutions.Deformations.FormalCyclicCoefficientReduction
import Solutions.Deformations.FormalCyclicOperatorLift
import Solutions.Deformations.FormalCyclicSolvability

namespace Litt3.Deformations

/-- Every actual solution class of the original prepared cyclic norm
equation has precisely one possibly nonzero final coefficient mod p. -/
theorem formal_norm_solution_reduction (p a n : ℕ) [Fact p.Prime]
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ (a + 1))) K]
    [Module.Free (ZMod (p ^ (a + 1))) K]
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (C : Module.End (ZMod (p ^ (a + 1))) (CoefficientSeries (K := K)))
    (commute : Commute C (coefficientSeriesShift 1))
    (vanish : (p : ZMod (p ^ (a + 1))) ^ (a + 1) = 0) (eta : K)
    (y : FormalCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a)
    (equation : formalPreparedCyclicOperator (n + 1) p a C
      (formal_cyclic_relation_commute_prepared (n + 1) p a C commute) y =
      (LinearMap.range (formalCyclicRelation (R := ZMod (p ^ (a + 1))) (K := K) p a)).mkQ
        (formalCyclicNorm (R := ZMod (p ^ (a + 1))) p a
          (coefficientSeriesConstant (R := ZMod (p ^ (a + 1))) eta))) :
    ∃ theta : K ⧸ coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1))),
      formalCyclicCoefficientReduction (K := K) p a vanish y =
        finiteSocleCoefficient (R := ZMod (p ^ (a + 1))) (p ^ a) theta := by
  let R := ZMod (p ^ (a + 1))
  let A := preparedSeriesOperator (n + 1) (p : R) C
  let q := (LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ
  obtain ⟨w, rfl⟩ := (LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ_surjective y
  change q (A w) = q (formalCyclicNorm (R := R) p a (coefficientSeriesConstant (R := R) eta)) at equation
  have zero : q (A w - formalCyclicNorm (R := R) p a (coefficientSeriesConstant (R := R) eta)) = 0 := by
    rw [map_sub, equation, sub_self]
  obtain ⟨z, same⟩ := (Submodule.Quotient.mk_eq_zero _).mp zero
  have full : A w = formalCyclicNorm (R := R) p a (coefficientSeriesConstant (R := R) eta) +
      formalCyclicRelation (R := R) p a z := by
    rw [same]
    abel
  have low := (formal_norm_primitive_necessity p a n K characteristic bound C commute eta w z full).2
  refine ⟨(coefficientScalarRange (K := K) (p : R)).mkQ (w (p ^ a - 1)), ?_⟩
  funext j
  rw [formal_cyclic_coefficient_reduction_mk]
  change (coefficientScalarRange (K := K) (p : R)).mkQ (w j.val) =
    if j.val + 1 = p ^ a then _ else 0
  by_cases last : j.val + 1 = p ^ a
  · have index : j.val = p ^ a - 1 := by omega
    rw [if_pos last, index]
  · rw [if_neg last]
    exact low _ (by omega)

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- Every actual final coefficient mod p is reached by an actual
kernel class of the original cyclic prepared comparison. -/
theorem formal_norm_kernel_socle_reduction (p a n : ℕ) [Fact p.Prime]
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (vanish : (p : R) ^ (a + 1) = 0)
    (C : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute C (coefficientSeriesShift 1)) (theta : K) :
    ∃ y : FormalCyclicModule (R := R) (K := K) p a,
      formalPreparedCyclicOperator (n + 1) p a C
        (formal_cyclic_relation_commute_prepared (n + 1) p a C commute) y = 0 ∧
      formalCyclicCoefficientReduction (K := K) p a vanish y =
        finiteSocleCoefficient (R := R) (p ^ a)
          ((coefficientScalarRange (K := K) (p : R)).mkQ theta) := by
  obtain ⟨w, z, equation, reduction⟩ := formal_norm_socle_realization p a n characteristic bound
    vanish C commute theta
  refine ⟨(LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ w, ?_, ?_⟩
  · change (LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ
      (preparedSeriesOperator (n + 1) (p : R) C w) = 0
    rw [equation]
    exact (Submodule.Quotient.mk_eq_zero _).mpr ⟨z, rfl⟩
  · funext j
    rw [formal_cyclic_coefficient_reduction_mk]
    have point := congrFun reduction j.val
    rw [coefficient_series_shift_constant_apply] at point
    change (coefficientScalarRange (K := K) (p : R)).mkQ (w j.val) =
      (if p ^ a - 1 = j.val then (coefficientScalarRange (K := K) (p : R)).mkQ theta else 0) at point
    change (coefficientScalarRange (K := K) (p : R)).mkQ (w j.val) =
      if j.val + 1 = p ^ a then _ else 0
    rw [point]
    by_cases last : j.val + 1 = p ^ a
    · have index : p ^ a - 1 = j.val := by omega
      rw [if_pos last, if_pos index]
    · have different : p ^ a - 1 ≠ j.val := by omega
      rw [if_neg last, if_neg different]

end Litt3.Deformations
