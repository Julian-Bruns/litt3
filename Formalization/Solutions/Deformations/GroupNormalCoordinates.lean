import Solutions.Deformations.GroupCoefficientMaps

namespace Litt3.Deformations

open scoped BigOperators

variable {R S : Type*} [CommRing R] [Nontrivial R] [CommRing S] [Nontrivial S]

/-- Actual coefficient maps transport every unchanged original normal
coordinate through precisely their actual coefficient ring map. -/
theorem group_coefficient_map_normal_coordinate (φ : R →+* S)
    (q : ℕ) (positive : 0 < q) (r : ℕ)
    (x : AddMonoidAlgebra R (Fin r → ZMod q)) (alpha : Fin r → Fin q) :
    (elementaryAugmentationBasis (R := S) q positive r).repr
      (AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod q) φ x) alpha =
      φ ((elementaryAugmentationBasis (R := R) q positive r).repr x alpha) := by
  classical
  let map := groupCoefficientLinear (G := Fin r → ZMod q) φ
  have expansion : map x = ∑ beta,
      φ ((elementaryAugmentationBasis (R := R) q positive r).repr x beta) •
        elementaryAugmentationBasis (R := S) q positive r beta := by
    conv_lhs => rw [← (elementaryAugmentationBasis (R := R) q positive r).sum_repr x]
    rw [map_sum]
    apply Finset.sum_congr rfl
    intro beta _
    rw [map_smulₛₗ, group_coefficient_linear_apply, group_coefficient_map_augmentation_basis]
  change (elementaryAugmentationBasis (R := S) q positive r).repr (map x) alpha = _
  rw [expansion]
  rw [Module.Basis.repr_sum_self]

end Litt3.Deformations
