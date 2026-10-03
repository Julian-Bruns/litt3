import Solutions.Deformations.WeightedRootPolynomialFunctionEvaluation
import Solutions.Deformations.ElementaryNormalCharacterSupport

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (k : Type*) [Field k] [Fact (Nat.Prime 5)]

/-- The literal original normal coefficients give an explicit
homogeneous lift, with the parameter sign restored coefficientwise. -/
noncomputable def elementaryHomogeneousNormalLift (r d : ℕ)
    (c : (Fin r → Fin 5) → k) :
    weightedRootProduct (Polynomial k) 5 Polynomial.X r :=
  ∑ alpha : Fin r → Fin 5,
    ((-1 : k) ^ ((d - ∑ i, (alpha i).val) / 4) * c alpha) •
      weightedRootPolynomialBasis k 5 (by omega) r
        ((d - ∑ i, (alpha i).val) / 4, alpha)

theorem elementary_homogeneous_normal_lift_member (r d : ℕ)
    (c : (Fin r → Fin 5) → k)
    (support : ∀ alpha, c alpha ≠ 0 →
      (∑ i, (alpha i).val) ≤ d ∧ (∑ i, (alpha i).val) % 4 = d % 4) :
    elementaryHomogeneousNormalLift k r d c ∈
      weightedRootHomogeneousComponent k 5 (by omega) r d := by
  classical
  unfold elementaryHomogeneousNormalLift
  apply Submodule.sum_mem
  intro alpha _
  by_cases zero : c alpha = 0
  · simp only [zero, mul_zero, zero_smul]
    exact Submodule.zero_mem _
  · apply Submodule.smul_mem
    have conditions := support alpha zero
    have weight : rootPolynomialWeight 5 r
        ((d - ∑ i, (alpha i).val) / 4, alpha) = d := by
      dsimp [rootPolynomialWeight]
      omega
    simpa only [weight] using weighted_root_homogeneous_basis_member k 5 (by omega) r
      ((d - ∑ i, (alpha i).val) / 4, alpha)

theorem elementary_homogeneous_normal_lift_evaluation (ψ : ZMod 5 →+* k)
    (r d : ℕ) (c : (Fin r → Fin 5) → k) (a : Fin r → ZMod 5) :
    weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r
      (elementaryHomogeneousNormalLift k r d c) a =
      finiteFieldNormalFunctionCoordinates (I := Fin r) (ZMod 5) k ψ c a := by
  classical
  unfold elementaryHomogeneousNormalLift
  change weightedRootPolynomialFunctionLinear (ZMod 5) k ψ r (∑ alpha : Fin r → Fin 5,
    ((-1 : k) ^ ((d - ∑ i, (alpha i).val) / 4) * c alpha) •
      weightedRootPolynomialBasis k 5 (by omega) r
        ((d - ∑ i, (alpha i).val) / 4, alpha)) a = _
  rw [map_sum, finite_field_normal_function_coordinates_apply]
  simp only [Finset.sum_apply, map_smul, Pi.smul_apply, smul_eq_mul]
  apply Finset.sum_congr rfl
  intro alpha _
  change ((-1 : k) ^ ((d - ∑ i, (alpha i).val) / 4) * c alpha) *
    weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r
      (weightedRootPolynomialBasis k 5 (by omega) r
        ((d - ∑ i, (alpha i).val) / 4, alpha)) a = _
  have evaluation : weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r
      (weightedRootPolynomialBasis k 5 (by omega) r
        ((d - ∑ i, (alpha i).val) / 4, alpha)) a =
      (-1 : k) ^ ((d - ∑ i, (alpha i).val) / 4) *
        ∏ i, ψ (a i) ^ (alpha i).val := by
    simpa only [ZMod.card] using weighted_root_polynomial_function_basis (ZMod 5) k ψ r
      ((d - ∑ i, (alpha i).val) / 4) alpha a
  rw [evaluation]
  have sign : (-1 : k) ^ ((d - ∑ i, (alpha i).val) / 4) *
      (-1 : k) ^ ((d - ∑ i, (alpha i).val) / 4) = 1 := by
    rw [← pow_add, ← two_mul, pow_mul]
    simp
  calc
    _ = ((-1 : k) ^ ((d - ∑ i, (alpha i).val) / 4) *
      (-1 : k) ^ ((d - ∑ i, (alpha i).val) / 4)) *
      (c alpha * ∏ i, ψ (a i) ^ (alpha i).val) := by ring
    _ = _ := by rw [sign, one_mul]

end Litt3.Deformations
