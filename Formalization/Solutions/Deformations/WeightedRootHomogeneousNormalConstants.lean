import Solutions.Deformations.WeightedRootHomogeneousComponents
import Mathlib.Algebra.Polynomial.Div

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (k : Type*) [CommRing k] [Nontrivial k]

/-- An original normal monomial already at the total homogeneous
weight can have only a constant parameter coefficient. -/
theorem weighted_root_homogeneous_normal_same_weight (q : ℕ) (large : 1 < q) (r d : ℕ)
    (x : weightedRootProduct (Polynomial k) q Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k q large r d)
    (alpha : Fin r → Fin q) (degree : (∑ i, (alpha i).val) = d) :
    (weightedRootProductBasis q large Polynomial.X r).repr x alpha =
      Polynomial.C (((weightedRootProductBasis q large Polynomial.X r).repr x alpha).coeff 0) := by
  classical
  apply Polynomial.ext
  intro j
  by_cases zero : j = 0
  · subst j; simp
  · rw [Polynomial.coeff_C, if_neg zero]
    by_contra nonzero
    have coordinate : (weightedRootPolynomialBasis k q large r).repr x (j, alpha) ≠ 0 := by
      rw [weighted_root_polynomial_basis_coordinate]
      exact nonzero
    have weight := (weighted_root_homogeneous_membership k q large r d x).mp homogeneous
      (j, alpha) coordinate
    dsimp [rootPolynomialWeight] at weight
    rw [degree] at weight
    have positive : 0 < q - 1 := by omega
    have productZero : (q - 1) * j = 0 := by omega
    have := (Nat.mul_eq_zero.mp productZero).resolve_left (by omega)
    exact zero this

/-- Every original constant normal coefficient in the wrong weight
is zero, proved from the genuine parameter/normal basis. -/
theorem weighted_root_homogeneous_normal_constant_zero (q : ℕ) (large : 1 < q) (r d : ℕ)
    (x : weightedRootProduct (Polynomial k) q Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k q large r d)
    (alpha : Fin r → Fin q) (different : (∑ i, (alpha i).val) ≠ d) :
    ((weightedRootProductBasis q large Polynomial.X r).repr x alpha).coeff 0 = 0 := by
  classical
  by_contra nonzero
  have coordinate : (weightedRootPolynomialBasis k q large r).repr x (0, alpha) ≠ 0 := by
    rw [weighted_root_polynomial_basis_coordinate]
    exact nonzero
  have weight := (weighted_root_homogeneous_membership k q large r d x).mp homogeneous
    (0, alpha) coordinate
  exact different (by simpa [rootPolynomialWeight] using weight)

end Litt3.Deformations
