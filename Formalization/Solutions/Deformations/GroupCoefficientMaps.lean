import Solutions.Deformations.ElementaryAugmentationBasis

namespace Litt3.Deformations

variable {R S G : Type*} [CommRing R] [CommRing S] [AddCommMonoid G]

/-- Genuine coefficient reduction as a semilinear map on the genuine
group algebras. Original deck labels are retained. -/
noncomputable def groupCoefficientLinear (φ : R →+* S) :
    AddMonoidAlgebra R G →ₛₗ[φ] AddMonoidAlgebra S G where
  __ := (AddMonoidAlgebra.mapRangeRingHom G φ).toAddMonoidHom
  map_smul' c x := by
    change AddMonoidAlgebra.mapRangeRingHom G φ (c • x) =
      φ c • AddMonoidAlgebra.mapRangeRingHom G φ x
    ext g
    rw [AddMonoidAlgebra.mapRangeRingHom_apply]
    change φ (c * x g) = φ c * (AddMonoidAlgebra.mapRangeRingHom G φ x) g
    rw [map_mul, AddMonoidAlgebra.mapRangeRingHom_apply]

@[simp] theorem group_coefficient_linear_apply (φ : R →+* S)
    (x : AddMonoidAlgebra R G) :
    groupCoefficientLinear (G := G) φ x = AddMonoidAlgebra.mapRangeRingHom G φ x := rfl

@[simp] theorem group_coefficient_map_parameter [Nontrivial R] [Nontrivial S]
    (φ : R →+* S) (q r : ℕ) (i : Fin r) :
    AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod q) φ
      (elementaryAugmentationParameter (R := R) q r i) =
        elementaryAugmentationParameter (R := S) q r i := by
  simp only [elementaryAugmentationParameter, map_sub, map_one,
    AddMonoidAlgebra.mapRangeRingHom_single]

@[simp] theorem group_coefficient_map_augmentation_basis [Nontrivial R] [Nontrivial S]
    (φ : R →+* S) (q : ℕ) (positive : 0 < q) (r : ℕ) (alpha : Fin r → Fin q) :
    AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod q) φ
      (elementaryAugmentationBasis (R := R) q positive r alpha) =
        elementaryAugmentationBasis (R := S) q positive r alpha := by
  simp only [elementary_augmentation_basis_apply, map_prod, map_pow,
    group_coefficient_map_parameter]

end Litt3.Deformations
