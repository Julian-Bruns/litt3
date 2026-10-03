import Solutions.Deformations.WeightedRootOriginProjection
import Solutions.Deformations.WeightedRootTruncation

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (k : Type*) [CommRing k] [Nontrivial k]

/-- Actual high homogeneous augmentation values are divisible by
the required parameter power in the original polynomial ring. -/
theorem weighted_root_homogeneous_origin_divisible (q : ℕ) (large : 1 < q) (r d m : ℕ)
    (high : (q - 1) * (m - 1) < d)
    (x : weightedRootProduct (Polynomial k) q Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k q large r d) :
    (Polynomial.X : Polynomial k) ^ m ∣
      weightedRootOrigin q (by omega) (Polynomial.X : Polynomial k) r x := by
  classical
  apply Polynomial.X_pow_dvd_iff.mpr
  intro j small
  by_contra nonzero
  have coordinate : (weightedRootPolynomialBasis k q large r).repr x
      (j, fun _ => ⟨0, by omega⟩) ≠ 0 := by
    rw [weighted_root_polynomial_basis_coordinate, weighted_root_origin_normal_coordinate]
    exact nonzero
  have weight := (weighted_root_homogeneous_membership k q large r d x).mp homogeneous
    (j, fun _ => ⟨0, by omega⟩) coordinate
  have degree : (q - 1) * j = d := by simpa [rootPolynomialWeight] using weight
  have bound := Nat.mul_le_mul_left (q - 1) (show j ≤ m - 1 by omega)
  omega

/-- The actual augmentation scalar removed from a high homogeneous
target is killed by actual parameter truncation. -/
theorem weighted_root_homogeneous_origin_projection_truncates (q : ℕ) (large : 1 < q)
    (r d m : ℕ) (positive : 0 < m) (high : (q - 1) * (m - 1) < d)
    (x : weightedRootProduct (Polynomial k) q Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k q large r d) :
    weightedRootTruncation k q m positive r
      (weightedRootOriginProjection k q (by omega) r x) = 0 := by
  letI : Nontrivial (TruncatedCoefficientRing k m) := (truncatedResidue k m positive).domain_nontrivial
  change weightedRootTruncation k q m positive r
    (algebraMap (Polynomial k) _
      (weightedRootOrigin q (by omega) (Polynomial.X : Polynomial k) r x)) = 0
  change weightedRootProductBaseMap (AdjoinRoot.mk ((Polynomial.X : Polynomial k) ^ m))
    q Polynomial.X r (algebraMap (Polynomial k) _ _) = 0
  rw [weighted_root_base_map_coefficient]
  have zero : AdjoinRoot.mk ((Polynomial.X : Polynomial k) ^ m)
      (weightedRootOrigin q (by omega) (Polynomial.X : Polynomial k) r x) = 0 :=
    AdjoinRoot.mk_eq_zero.mpr (weighted_root_homogeneous_origin_divisible k q large r d m high x homogeneous)
  rw [zero, map_zero]

end Litt3.Deformations
