import Solutions.Deformations.PrimeWeightedPolynomialFunction
import Solutions.Deformations.PrimeNormalFunctionCoordinates
import Mathlib.Data.Nat.ModEq

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k]

/-- The literal original normal coefficients give an explicit
homogeneous lift, with the parameter sign restored coefficientwise. -/
noncomputable def elementaryPrimeHomogeneousNormalLift (r d : ℕ)
    (c : (Fin r → Fin p) → k) :
    weightedRootProduct (Polynomial k) p Polynomial.X r :=
  ∑ alpha : Fin r → Fin p,
    ((-1 : k) ^ ((d - ∑ i, (alpha i).val) / (p - 1)) * c alpha) •
      weightedRootPolynomialBasis k p (Fact.out : p.Prime).one_lt r
        ((d - ∑ i, (alpha i).val) / (p - 1), alpha)

theorem elementary_prime_homogeneous_normal_lift_member (r d : ℕ)
    (c : (Fin r → Fin p) → k)
    (support : ∀ alpha, c alpha ≠ 0 →
      (∑ i, (alpha i).val) ≤ d ∧ (∑ i, (alpha i).val) % (p - 1) = d % (p - 1)) :
    elementaryPrimeHomogeneousNormalLift p k r d c ∈
      weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r d := by
  classical
  unfold elementaryPrimeHomogeneousNormalLift
  apply Submodule.sum_mem
  intro alpha _
  by_cases zero : c alpha = 0
  · simp only [zero, mul_zero, zero_smul]
    exact Submodule.zero_mem _
  · apply Submodule.smul_mem
    have conditions := support alpha zero
    have weight : rootPolynomialWeight p r
        ((d - ∑ i, (alpha i).val) / (p - 1), alpha) = d := by
      dsimp [rootPolynomialWeight]
      have divisible : p - 1 ∣ d - ∑ i, (alpha i).val :=
        (Nat.modEq_iff_dvd' conditions.1).mp conditions.2
      rw [Nat.mul_div_cancel' divisible]
      exact Nat.sub_add_cancel conditions.1
    simpa only [weight] using weighted_root_homogeneous_basis_member k p (Fact.out : p.Prime).one_lt r
      ((d - ∑ i, (alpha i).val) / (p - 1), alpha)

theorem elementary_prime_homogeneous_normal_lift_evaluation (ψ : ZMod p →+* k)
    (r d : ℕ) (c : (Fin r → Fin p) → k) (a : Fin r → ZMod p) :
    primeWeightedPolynomialFunction p k ψ r
      (elementaryPrimeHomogeneousNormalLift p k r d c) a =
      primeNormalFunctionCoordinates (I := Fin r) p k ψ c a := by
  classical
  unfold elementaryPrimeHomogeneousNormalLift
  change primeWeightedPolynomialFunctionLinear p k ψ r (∑ alpha : Fin r → Fin p,
    ((-1 : k) ^ ((d - ∑ i, (alpha i).val) / (p - 1)) * c alpha) •
      weightedRootPolynomialBasis k p (Fact.out : p.Prime).one_lt r
        ((d - ∑ i, (alpha i).val) / (p - 1), alpha)) a = _
  rw [map_sum, prime_normal_function_coordinates_apply]
  simp only [Finset.sum_apply, map_smul, Pi.smul_apply, smul_eq_mul]
  apply Finset.sum_congr rfl
  intro alpha _
  change ((-1 : k) ^ ((d - ∑ i, (alpha i).val) / (p - 1)) * c alpha) *
    primeWeightedPolynomialFunction p k ψ r
      (weightedRootPolynomialBasis k p (Fact.out : p.Prime).one_lt r
        ((d - ∑ i, (alpha i).val) / (p - 1), alpha)) a = _
  have evaluation : primeWeightedPolynomialFunction p k ψ r
      (weightedRootPolynomialBasis k p (Fact.out : p.Prime).one_lt r
        ((d - ∑ i, (alpha i).val) / (p - 1), alpha)) a =
      (-1 : k) ^ ((d - ∑ i, (alpha i).val) / (p - 1)) *
        ∏ i, ψ (a i) ^ (alpha i).val := by
    exact prime_weighted_polynomial_function_basis p k ψ r
      ((d - ∑ i, (alpha i).val) / (p - 1)) alpha a
  rw [evaluation]
  have sign : (-1 : k) ^ ((d - ∑ i, (alpha i).val) / (p - 1)) *
      (-1 : k) ^ ((d - ∑ i, (alpha i).val) / (p - 1)) = 1 := by
    rw [← pow_add, ← two_mul, pow_mul]
    simp
  calc
    _ = ((-1 : k) ^ ((d - ∑ i, (alpha i).val) / (p - 1)) *
      (-1 : k) ^ ((d - ∑ i, (alpha i).val) / (p - 1))) *
      (c alpha * ∏ i, ψ (a i) ^ (alpha i).val) := by ring
    _ = _ := by rw [sign, one_mul]

end Litt3.Deformations
