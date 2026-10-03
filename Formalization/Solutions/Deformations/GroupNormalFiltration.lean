import Solutions.Deformations.GroupNormalCoordinates
import Solutions.Deformations.ElementaryNormalWeights

namespace Litt3.Deformations

variable {R S : Type*} [CommRing R] [Nontrivial R] [CommRing S] [Nontrivial S]

/-- Every genuine coefficient ring map preserves the literal original
normal weighted filtration, without changing a deck generator. -/
theorem group_coefficient_map_normal_weight (φ : R →+* S)
    (q : ℕ) (positive : 0 < q) (r d : ℕ)
    (x : AddMonoidAlgebra R (Fin r → ZMod q))
    (member : x ∈ elementaryNormalWeightFiltration R q positive r d) :
    AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod q) φ x ∈
      elementaryNormalWeightFiltration S q positive r d := by
  let map := groupCoefficientLinear (G := Fin r → ZMod q) φ
  change map x ∈ _
  induction member using Submodule.span_induction with
  | mem x member =>
    obtain ⟨j, alpha, bound, rfl⟩ := member
    rw [map_smulₛₗ]
    change φ ((q : R) ^ j) •
      AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod q) φ
        (elementaryAugmentationBasis (R := R) q positive r alpha) ∈ _
    rw [map_pow, map_natCast, group_coefficient_map_augmentation_basis]
    exact Submodule.subset_span ⟨j, alpha, bound, rfl⟩
  | zero =>
    rw [map_zero]
    exact Submodule.zero_mem _
  | add x y _ _ hx hy =>
    rw [map_add]
    exact Submodule.add_mem _ hx hy
  | smul c x _ hx =>
    rw [map_smulₛₗ]
    exact Submodule.smul_mem _ (φ c) hx

end Litt3.Deformations
