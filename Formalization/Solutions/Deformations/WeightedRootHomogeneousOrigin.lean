import Solutions.Deformations.WeightedRootHomogeneousComponents
import Solutions.Deformations.WeightedRootOriginCoordinates

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (k : Type*) [CommRing k] [Nontrivial k]

/-- A nontrivial parameter-degree residue excludes the original
augmentation origin, directly from the actual homogeneous coordinates. -/
theorem weighted_root_homogeneous_origin_zero (q : ℕ) (large : 1 < q) (r d : ℕ)
    (residue : d % (q - 1) ≠ 0)
    (x : weightedRootProduct (Polynomial k) q Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k q large r d) :
    weightedRootOrigin q (by omega) (Polynomial.X : Polynomial k) r x = 0 := by
  classical
  rw [← weighted_root_origin_normal_coordinate q large Polynomial.X r x]
  apply Polynomial.ext
  intro j
  rw [Polynomial.coeff_zero]
  by_contra nonzero
  have coordinate : (weightedRootPolynomialBasis k q large r).repr x
      (j, fun _ => ⟨0, by omega⟩) ≠ 0 := by
    rw [weighted_root_polynomial_basis_coordinate]
    exact nonzero
  have weight := (weighted_root_homogeneous_membership k q large r d x).mp homogeneous
    (j, fun _ => ⟨0, by omega⟩) coordinate
  have degree : (q - 1) * j = d := by simpa [rootPolynomialWeight] using weight
  apply residue
  rw [← degree, Nat.mul_mod_right]

end Litt3.Deformations
