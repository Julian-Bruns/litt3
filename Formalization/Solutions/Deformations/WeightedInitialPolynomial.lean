import Solutions.Deformations.WittWeightActive
import Solutions.Deformations.WeightedRootHomogeneousComponents
import Solutions.Deformations.WeightedRootTruncation
import Mathlib.Algebra.Polynomial.Div

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (k : Type*) [CommRing k] [Nontrivial k]

/-- Literal homogeneous parameter representative of a fixed original
normal residue array, using exactly its least coefficient exponent. -/
noncomputable def weightedInitialPolynomial (q : ℕ) (large : 1 < q) (r d : ℕ)
    (c : (Fin r → Fin q) → k) : weightedRootProduct (Polynomial k) q Polynomial.X r :=
  ∑ alpha, c alpha • weightedRootPolynomialBasis k q large r
    (basisWeightExponent (q - 1) d (∑ i, (alpha i).val), alpha)

theorem weighted_initial_polynomial_coordinate (q : ℕ) (large : 1 < q) (r d : ℕ)
    (c : (Fin r → Fin q) → k) (j : ℕ) (alpha : Fin r → Fin q) :
    (weightedRootPolynomialBasis k q large r).repr (weightedInitialPolynomial k q large r d c)
      (j, alpha) =
      if j = basisWeightExponent (q - 1) d (∑ i, (alpha i).val) then c alpha else 0 := by
  classical
  simp only [weightedInitialPolynomial, map_sum, map_smul, Finsupp.finset_sum_apply,
    Finsupp.smul_apply, smul_eq_mul, Module.Basis.repr_self]
  rw [Finset.sum_eq_single alpha]
  · simp [Finsupp.single_apply, eq_comm]
  · intro beta _ different
    have indices : (basisWeightExponent (q - 1) d (∑ i, (beta i).val), beta) ≠ (j, alpha) := by
      intro same
      exact different (Prod.mk.inj same).2
    simp [Finsupp.single_apply, indices, Ne.symm indices]
  · simp

theorem weighted_initial_polynomial_homogeneous (q : ℕ) (large : 1 < q) (N r d : ℕ)
    (c : (Fin r → Fin q) → k)
    (supported : ∀ alpha, ¬ wittWeightActive (q - 1) d (∑ i, (alpha i).val) N → c alpha = 0) :
    weightedInitialPolynomial k q large r d c ∈ weightedRootHomogeneousComponent k q large r d := by
  classical
  apply Submodule.sum_mem
  intro alpha _
  by_cases zero : c alpha = 0
  · rw [zero, zero_smul]
    exact Submodule.zero_mem _
  · have active : wittWeightActive (q - 1) d (∑ i, (alpha i).val) N := by
      by_contra inactive
      exact zero (supported alpha inactive)
    apply Submodule.smul_mem
    have weight : rootPolynomialWeight q r
        (basisWeightExponent (q - 1) d (∑ i, (alpha i).val), alpha) = d := active.1
    have basisMember := weighted_root_homogeneous_basis_member k q large r
      (basisWeightExponent (q - 1) d (∑ i, (alpha i).val), alpha)
    rw [weight] at basisMember
    exact basisMember

/-- Surviving original residue arrays inject into the literal truncated
parameter algebra, without presuming its Witt identification. -/
theorem weighted_initial_polynomial_truncation_zero (q : ℕ) (large : 1 < q)
    (N : ℕ) (positive : 0 < N) (r d : ℕ)
    (c : (Fin r → Fin q) → k)
    (supported : ∀ alpha, ¬ wittWeightActive (q - 1) d (∑ i, (alpha i).val) N → c alpha = 0) :
    weightedRootTruncation k q N positive r (weightedInitialPolynomial k q large r d c) = 0 ↔ c = 0 := by
  constructor
  · intro zero
    have coefficients := (weighted_root_truncation_kernel k q large N positive r _).mp zero
    funext alpha
    by_cases active : wittWeightActive (q - 1) d (∑ i, (alpha i).val) N
    · have vanishing := (Polynomial.X_pow_dvd_iff.mp (coefficients alpha))
        (basisWeightExponent (q - 1) d (∑ i, (alpha i).val)) active.2
      rw [← weighted_root_polynomial_basis_coordinate, weighted_initial_polynomial_coordinate,
        if_pos rfl] at vanishing
      exact vanishing
    · exact supported alpha active
  · intro zero
    rw [zero]
    simp only [weightedInitialPolynomial, Pi.zero_apply, zero_smul, Finset.sum_const_zero, map_zero]

end Litt3.Deformations
