import Solutions.Deformations.WeightedRootHomogeneousComponents
import Solutions.Deformations.WeightedRootOriginCoordinates
import Solutions.Deformations.WeightedRootTruncation

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (k : Type*) [CommRing k] [Nontrivial k]

/-- At or below the first killed parameter weight, an actual
homogeneous element in the actual truncation kernel and with zero
original augmentation value is already zero before truncation. -/
theorem weighted_root_homogeneous_truncation_low_zero (q : ℕ) (large : 1 < q)
    (r m d : ℕ) (positive : 0 < m) (small : d ≤ (q - 1) * m)
    (x : weightedRootProduct (Polynomial k) q Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k q large r d)
    (truncated : weightedRootTruncation k q m positive r x = 0)
    (origin : weightedRootOrigin q (by omega) Polynomial.X r x = 0) : x = 0 := by
  classical
  have divisibility := (weighted_root_truncation_kernel k q large m positive r x).mp truncated
  apply (weightedRootProductBasis q large (Polynomial.X : Polynomial k) r).repr.injective
  ext alpha j
  rw [map_zero, Finsupp.zero_apply, Polynomial.coeff_zero]
  by_contra nonzero
  by_cases below : j < m
  · exact nonzero (Polynomial.X_pow_dvd_iff.mp (divisibility alpha) j below)
  · have originalCoordinate : (weightedRootPolynomialBasis k q large r).repr x (j, alpha) ≠ 0 := by
      rw [weighted_root_polynomial_basis_coordinate]
      exact nonzero
    have degree := (weighted_root_homogeneous_membership k q large r d x).mp homogeneous
      (j, alpha) originalCoordinate
    change (q - 1) * j + (∑ i, (alpha i).val) = d at degree
    have lower : (q - 1) * m ≤ (q - 1) * j := Nat.mul_le_mul_left _ (Nat.le_of_not_gt below)
    have sumZero : (∑ i, (alpha i).val) = 0 := by omega
    have zeroTuple : alpha = (fun _ => ⟨0, by omega⟩) := by
      funext i
      apply Fin.ext
      exact (Finset.sum_eq_zero_iff.mp sumZero) i (Finset.mem_univ i)
    apply nonzero
    rw [zeroTuple, weighted_root_origin_normal_coordinate, origin, Polynomial.coeff_zero]

end Litt3.Deformations
