import Solutions.Deformations.BalancedPreparedMonomialSocle
import Solutions.Deformations.PreparedQuadraticCoefficientIdeals

set_option maxHeartbeats 800000
set_option synthInstance.maxHeartbeats 100000

namespace Litt3.Deformations

variable (K : Type*) [Field K] (Q : ℕ)
  [IsLocalRing (TruncatedMonomialAlgebra K (Fin 1) (fun _ => Q))]

/-- Genuine unit-factor preparation preserves the ORIGINAL quadratic
parameter times unit, with its actual unchanged constant coefficient. -/
theorem balanced_prepared_constant_unit_factor
    (g : PowerSeries (TruncatedMonomialAlgebra K (Fin 1) (fun _ => Q)))
    (f : Polynomial (TruncatedMonomialAlgebra K (Fin 1) (fun _ => Q)))
    (h : PowerSeries (TruncatedMonomialAlgebra K (Fin 1) (fun _ => Q)))
    (unit : IsUnit h) (equation : g = (f : PowerSeries _) * h)
    (u : (TruncatedMonomialAlgebra K (Fin 1) (fun _ => Q))ˣ)
    (original : PowerSeries.constantCoeff g =
      truncatedMonomialParameter K (Fin 1) (fun _ => Q) 0 ^ 2 * (u : _)) :
    ∃ v : (TruncatedMonomialAlgebra K (Fin 1) (fun _ => Q))ˣ,
      f.coeff 0 = truncatedMonomialParameter K (Fin 1) (fun _ => Q) 0 ^ 2 * (v : _) := by
  obtain ⟨w, hw⟩ := PowerSeries.isUnit_iff_constantCoeff.mp unit
  have coefficient : PowerSeries.constantCoeff g = f.coeff 0 * (w : _) := by
    rw [equation, map_mul, hw]
    rfl
  refine ⟨u * w⁻¹, ?_⟩
  have multiplied := congrArg (fun a : TruncatedMonomialAlgebra K (Fin 1) (fun _ => Q) =>
    a * ((w⁻¹ : (TruncatedMonomialAlgebra K (Fin 1) (fun _ => Q))ˣ) : _)) coefficient
  dsimp only at multiplied
  rw [mul_assoc, Units.mul_inv, mul_one, original] at multiplied
  simpa only [Units.val_mul, mul_assoc] using multiplied.symm

/-- Completing the square retains a nonzero quadratic leading lower
coefficient: the actual new multiplier is a unit minus a nilpotent
lower term. The original linear coefficient lies in the whole square. -/
theorem balanced_prepared_square_completed_unit_factor (positive : 0 < Q)
    (t : TruncatedMonomialAlgebra K (Fin 1) (fun _ => Q))
    (tMember : t ∈ truncatedMonomialAugmentationIdeal K (Fin 1) (fun _ => Q) ^ 2)
    (u : (TruncatedMonomialAlgebra K (Fin 1) (fun _ => Q))ˣ) :
    ∃ v : (TruncatedMonomialAlgebra K (Fin 1) (fun _ => Q))ˣ,
      truncatedMonomialParameter K (Fin 1) (fun _ => Q) 0 ^ 2 * (u : _) - t ^ 2 =
        truncatedMonomialParameter K (Fin 1) (fun _ => Q) 0 ^ 2 * (v : _) := by
  let A := TruncatedMonomialAlgebra K (Fin 1) (fun _ => Q)
  let y := truncatedMonomialParameter K (Fin 1) (fun _ => Q) 0
  let J := truncatedMonomialAugmentationIdeal K (Fin 1) (fun _ => Q)
  have tFactor : ∃ a : A, t = y ^ 2 * a := by
    rw [balanced_prepared_one_parameter_augmentation K Q, Ideal.span_singleton_pow] at tMember
    obtain ⟨a, ha⟩ := Ideal.mem_span_singleton'.mp tMember
    exact ⟨a, ha.symm.trans (mul_comm _ _)⟩
  obtain ⟨a, ha⟩ := tFactor
  have yMember : y ∈ J := Ideal.subset_span (Set.mem_range_self 0)
  have lower : y ^ 2 * a ^ 2 ∈ J := by
    rw [pow_two]
    exact J.mul_mem_right _ (J.mul_mem_left _ yMember)
  have multiplierUnit : IsUnit ((u : A) - y ^ 2 * a ^ 2) := by
    apply IsLocalRing.notMem_maximalIdeal.mp
    rw [← truncated_monomial_augmentation_eq_maximal K (Fin 1) (fun _ => Q) (fun _ => positive)]
    intro member
    have impossible : (u : A) ∈ J := by
      simpa only [sub_add_cancel] using J.add_mem member lower
    exact (IsLocalRing.notMem_maximalIdeal.mpr u.isUnit)
      (by rwa [← truncated_monomial_augmentation_eq_maximal K (Fin 1) (fun _ => Q)
        (fun _ => positive)])
  obtain ⟨v, hv⟩ := multiplierUnit
  refine ⟨v, ?_⟩
  change y ^ 2 * (u : A) - t ^ 2 = y ^ 2 * (v : A)
  rw [hv, ha]
  ring

end Litt3.Deformations
