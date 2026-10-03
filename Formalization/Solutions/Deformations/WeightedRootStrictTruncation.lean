import Solutions.Deformations.WeightedRootHomogeneousTruncation

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (k : Type*) [CommRing k] [Nontrivial k]

/-- Every actual homogeneous class strictly below the first killed
parameter weight is unchanged faithfully by literal truncation. -/
theorem weighted_root_homogeneous_strict_truncation_zero (q : ℕ) (large : 1 < q)
    (r N d : ℕ) (positive : 0 < N) (small : d < (q - 1) * N)
    (Z : weightedRootProduct (Polynomial k) q Polynomial.X r)
    (homogeneous : Z ∈ weightedRootHomogeneousComponent k q large r d)
    (zero : weightedRootTruncation k q N positive r Z = 0) : Z = 0 := by
  classical
  have divisible := (weighted_root_truncation_kernel k q large N positive r Z).mp zero
  apply (weightedRootProductBasis q large (Polynomial.X : Polynomial k) r).repr.injective
  ext alpha j
  rw [map_zero, Finsupp.zero_apply, Polynomial.coeff_zero]
  by_contra nonzero
  have originalCoordinate : (weightedRootPolynomialBasis k q large r).repr Z (j, alpha) ≠ 0 := by
    rw [weighted_root_polynomial_basis_coordinate]
    exact nonzero
  have degree := (weighted_root_homogeneous_membership k q large r d Z).mp homogeneous
    (j, alpha) originalCoordinate
  change (q - 1) * j + (∑ i, (alpha i).val) = d at degree
  by_cases below : j < N
  · exact nonzero (Polynomial.X_pow_dvd_iff.mp (divisible alpha) j below)
  · have lower := Nat.mul_le_mul_left (q - 1) (Nat.le_of_not_gt below)
    omega

end Litt3.Deformations
