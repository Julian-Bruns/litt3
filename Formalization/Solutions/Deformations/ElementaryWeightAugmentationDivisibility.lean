import Solutions.Deformations.ActualAdditiveGroupAugmentation
import Solutions.Deformations.ElementaryWeightCoordinates

namespace Litt3.Deformations

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- Literal augmentation retains the exact original coefficient weight:
its prime-power divisibility is derived from the zero normal coordinate. -/
theorem elementary_weight_augmentation_divisibility (q : ℕ) (large : 1 < q)
    (r d : ℕ) (x : AddMonoidAlgebra R (Fin r → ZMod q))
    (member : x ∈ elementaryNormalWeightFiltration R q (by omega) r d) :
    (q : R) ^ basisWeightExponent (q - 1) d 0 ∣ additiveGroupAlgebraAugmentation x := by
  classical
  let alpha := elementaryZeroNormalExponent q (by omega) r
  have degree : (∑ i, (alpha i).val) = 0 := by
    simp [alpha, elementaryZeroNormalExponent]
  have coefficient := (elementary_normal_weight_coordinate_iff (R := R)
    q (by omega) large r d x).mp member alpha
  rw [degree] at coefficient
  rwa [elementary_augmentation_normal_coordinate q (by omega) r x]

end Litt3.Deformations
