import Solutions.Deformations.ActualAdditiveGroupAugmentation
import Solutions.Deformations.ElementaryWeightCoordinates

namespace Litt3.Deformations

open scoped BigOperators

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- Once the original weight exceeds every possible surviving coefficient
constant, literal coefficient-sum augmentation vanishes. -/
theorem elementary_weight_augmentation_zero (q N : ℕ) (large : 1 < q)
    (positive : 0 < N) (nilpotent : (q : R) ^ N = 0) (r d : ℕ)
    (high : (q - 1) * (N - 1) < d)
    (x : AddMonoidAlgebra R (Fin r → ZMod q))
    (member : x ∈ elementaryNormalWeightFiltration R q (by omega) r d) :
    additiveGroupAlgebraAugmentation x = 0 := by
  let zeroExponent := elementaryZeroNormalExponent q (by omega) r
  have degree : (∑ i, (zeroExponent i).val) = 0 := by
    simp [zeroExponent, elementaryZeroNormalExponent]
  have coordinate := (elementary_normal_weight_coordinate_iff (R := R)
    q (by omega) large r d x).mp member zeroExponent
  rw [degree] at coordinate
  have exponent : N ≤ basisWeightExponent (q - 1) d 0 := by
    by_contra small
    have bound := (basis_weight_exponent_le (q - 1) d 0 (N - 1) (by omega)).mp
      (by omega : basisWeightExponent (q - 1) d 0 ≤ N - 1)
    omega
  have zero : (q : R) ^ basisWeightExponent (q - 1) d 0 = 0 :=
    pow_eq_zero_of_le exponent nilpotent
  rw [zero, zero_dvd_iff] at coordinate
  exact (elementary_augmentation_normal_coordinate q (by omega) r x).trans coordinate

end Litt3.Deformations
