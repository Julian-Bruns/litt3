import Solutions.Deformations.FormalCyclicGeneration
import Solutions.Deformations.PowerGeneratorEquality
import Solutions.Deformations.ScalarDivisibleMapLift
import Solutions.Deformations.CommutingQuotientOperators
import Solutions.Deformations.PreparedSeriesAugmentation

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

theorem formal_cyclic_relation_commute_prepared (h p a : ℕ)
    (C : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute C (coefficientSeriesShift 1)) :
    Commute (formalCyclicRelation (R := R) (K := K) p a)
      (preparedSeriesOperator h (p : R) C) :=
  (cyclic_relation_commute _ _
    (prepared_series_operator_commute_shift h (p : R) C commute) (p ^ a)).symm

/-- Every actual commuting comparison operator on the original cyclic
module, congruent to the distinguished power on its coefficient
generators, has a genuine finite polynomial coefficient lift. Only
projectivity of the original coefficient module is used; arbitrary
free rank and noncommuting coefficient operators are included. -/
theorem formal_cyclic_operator_polynomial_lift (p a h : ℕ) [Fact p.Prime]
    [Module.Projective R K] (vanish : (p : R) ^ (a + 1) = 0)
    (A : Module.End R (FormalCyclicModule (R := R) (K := K) p a))
    (commute : Commute A (formalCyclicAugmentation (R := R) p a))
    (divisible : LinearMap.range ((A - formalCyclicAugmentation (R := R) p a ^ h).comp
      (formalCyclicConstant (R := R) p a)) ≤
        LinearMap.range ((p : R) • (LinearMap.id : Module.End R
          (FormalCyclicModule (R := R) (K := K) p a)))) :
    ∃ C : Fin (p ^ a) → Module.End R K,
      A = formalPreparedCyclicOperator h p a (coefficientPolynomialOperator (p ^ a) C)
        (formal_cyclic_relation_commute_prepared h p a _
          (coefficient_polynomial_operator_commute_shift (p ^ a) C 1)) := by
  classical
  let E := formalCyclicAugmentation (R := R) (K := K) p a
  let constant := formalCyclicConstant (R := R) (K := K) p a
  let coordinates := formalCyclicCoordinates (R := R) (K := K) p a vanish
  obtain ⟨D, lifted⟩ := projective_scalar_divisible_map_lift (p : R)
    ((A - E ^ h).comp constant) divisible
  let C : Fin (p ^ a) → Module.End R K := fun j =>
    (LinearMap.proj j).comp (coordinates.toLinearMap.comp D)
  let P := coefficientPolynomialOperator (p ^ a) C
  have CP : Commute P (coefficientSeriesShift 1) :=
    coefficient_polynomial_operator_commute_shift (p ^ a) C 1
  let B := formalPreparedCyclicOperator h p a P
    (formal_cyclic_relation_commute_prepared h p a P CP)
  have Bcommute : Commute B E :=
    commuting_range_quotient_operators_commute _ _ _
      (formal_cyclic_relation_commute_prepared h p a P CP)
      (formal_cyclic_relation_commute_shift p a)
      (prepared_series_operator_commute_shift h (p : R) P CP)
  have correction : ∀ eta : K,
      (LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ
        (P (coefficientSeriesConstant (R := R) eta)) = D eta := by
    intro eta
    rw [coefficient_polynomial_operator_constant]
    change (LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ
      (coefficientSeriesPrefixSection (R := R) (p ^ a) (coordinates (D eta))) = D eta
    rw [← formal_cyclic_coordinates_symm]
    exact coordinates.symm_apply_apply (D eta)
  have equalConstants : ∀ eta : K, A (constant eta) = B (constant eta) := by
    intro eta
    have difference := LinearMap.congr_fun lifted eta
    change (p : R) • D eta = A (constant eta) - (E ^ h) (constant eta) at difference
    have value : B (constant eta) = (E ^ h) (constant eta) + (p : R) • D eta := by
      change (LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ
        (preparedSeriesOperator h (p : R) P (coefficientSeriesConstant (R := R) eta)) = _
      rw [preparedSeriesOperator, LinearMap.add_apply, LinearMap.smul_apply, map_add,
        map_smul, correction, ← formal_cyclic_augmentation_power_constant]
    rw [value, difference]
    abel
  refine ⟨C, ?_⟩
  exact linear_map_eq_of_power_generators (p ^ a) constant E E
    (formal_cyclic_power_generation p a vanish) A B
    (fun v => LinearMap.congr_fun commute.eq v)
    (fun v => LinearMap.congr_fun Bcommute.eq v) equalConstants

end Litt3.Deformations
