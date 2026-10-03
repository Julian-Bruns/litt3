import Solutions.Deformations.GroupAlgebraProducts
import Mathlib.Algebra.Group.Equiv.TypeTags

namespace Litt3.Deformations

open scoped MonoidAlgebra TensorProduct

variable {R G H : Type*} [CommSemiring R] [AddMonoid G] [AddMonoid H]

@[simp] theorem add_group_algebra_to_multiplicative_single (g : G) (r : R) :
    (AddMonoidAlgebra.toMultiplicativeAlgEquiv (R := R) R G)
      (AddMonoidAlgebra.single g r) = MonoidAlgebra.single (Multiplicative.ofAdd g) r :=
  Finsupp.equivMapDomain_single _ _ _

/-- The actual group-algebra tensor presentation for product additive
groups. The equivalence preserves each original group element. -/
noncomputable def addGroupAlgebraProductTensorEquiv :
    (AddMonoidAlgebra R G ⊗[R] AddMonoidAlgebra R H) ≃ₐ[R] AddMonoidAlgebra R (G × H) :=
  ((Algebra.TensorProduct.congr
      (AddMonoidAlgebra.toMultiplicativeAlgEquiv (R := R) R G)
      (AddMonoidAlgebra.toMultiplicativeAlgEquiv (R := R) R H)).trans
    (groupAlgebraProductTensorEquiv (k := R) (G := Multiplicative G) (H := Multiplicative H))).trans
      ((MonoidAlgebra.domCongr R R (MulEquiv.prodMultiplicative (G := G) (H := H)).symm).trans
        (AddMonoidAlgebra.toMultiplicativeAlgEquiv (R := R) R (G × H)).symm)

@[simp] theorem add_group_algebra_product_tensor_single (g : G) (h : H) :
    addGroupAlgebraProductTensorEquiv (R := R)
      (AddMonoidAlgebra.single g 1 ⊗ₜ[R] AddMonoidAlgebra.single h 1) =
        AddMonoidAlgebra.single (g, h) 1 := by
  change (AddMonoidAlgebra.toMultiplicativeAlgEquiv (R := R) R (G × H)).symm
    (MonoidAlgebra.domCongr R R (MulEquiv.prodMultiplicative (G := G) (H := H)).symm
      (groupAlgebraProductTensorEquiv (k := R)
        ((AddMonoidAlgebra.toMultiplicativeAlgEquiv (R := R) R G) (AddMonoidAlgebra.single g 1) ⊗ₜ[R]
          (AddMonoidAlgebra.toMultiplicativeAlgEquiv (R := R) R H) (AddMonoidAlgebra.single h 1)))) = _
  rw [add_group_algebra_to_multiplicative_single, add_group_algebra_to_multiplicative_single]
  change (AddMonoidAlgebra.toMultiplicativeAlgEquiv (R := R) R (G × H)).symm
    (MonoidAlgebra.domCongr R R (MulEquiv.prodMultiplicative (G := G) (H := H)).symm
      (groupAlgebraProductTensorEquiv (k := R)
        (MonoidAlgebra.of R (Multiplicative G) (Multiplicative.ofAdd g) ⊗ₜ[R]
          MonoidAlgebra.of R (Multiplicative H) (Multiplicative.ofAdd h)))) = _
  have image : groupAlgebraProductTensorEquiv (k := R)
      (MonoidAlgebra.of R (Multiplicative G) (Multiplicative.ofAdd g) ⊗ₜ[R]
        MonoidAlgebra.of R (Multiplicative H) (Multiplicative.ofAdd h)) =
      MonoidAlgebra.of R (Multiplicative G × Multiplicative H)
        (Multiplicative.ofAdd g, Multiplicative.ofAdd h) :=
    group_algebra_product_tensor_map_of _ _
  rw [image, MonoidAlgebra.of_apply, MonoidAlgebra.domCongr_single]
  apply (AddMonoidAlgebra.toMultiplicativeAlgEquiv (R := R) R (G × H)).injective
  rw [AlgEquiv.apply_symm_apply, add_group_algebra_to_multiplicative_single]
  rfl

noncomputable def addGroupAlgebraLeftProductMap :
    AddMonoidAlgebra R G →ₐ[R] AddMonoidAlgebra R (G × H) :=
  AddMonoidAlgebra.mapDomainAlgHom R R (AddMonoidHom.inl G H)

noncomputable def addGroupAlgebraRightProductMap :
    AddMonoidAlgebra R H →ₐ[R] AddMonoidAlgebra R (G × H) :=
  AddMonoidAlgebra.mapDomainAlgHom R R (AddMonoidHom.inr G H)

@[simp] theorem add_group_algebra_left_product_single (g : G) (r : R) :
    addGroupAlgebraLeftProductMap (R := R) (H := H) (AddMonoidAlgebra.single g r) =
      AddMonoidAlgebra.single (g, 0) r := by
  simp [addGroupAlgebraLeftProductMap, AddMonoidAlgebra.mapDomainAlgHom,
    AddMonoidAlgebra.mapDomainRingHom]

@[simp] theorem add_group_algebra_right_product_single (h : H) (r : R) :
    addGroupAlgebraRightProductMap (R := R) (G := G) (AddMonoidAlgebra.single h r) =
      AddMonoidAlgebra.single (0, h) r := by
  simp [addGroupAlgebraRightProductMap, AddMonoidAlgebra.mapDomainAlgHom,
    AddMonoidAlgebra.mapDomainRingHom]

/-- The full actual tensor map is multiplication of the two original
coordinate inclusions, not merely a dimension identification. -/
theorem add_group_algebra_product_tensor_tmul (x : AddMonoidAlgebra R G)
    (y : AddMonoidAlgebra R H) :
    addGroupAlgebraProductTensorEquiv (R := R) (x ⊗ₜ[R] y) =
      addGroupAlgebraLeftProductMap (R := R) x * addGroupAlgebraRightProductMap (R := R) y := by
  induction x using AddMonoidAlgebra.induction_on with
  | hM g =>
    induction y using AddMonoidAlgebra.induction_on with
    | hM h =>
      change addGroupAlgebraProductTensorEquiv (R := R)
        (AddMonoidAlgebra.single g 1 ⊗ₜ[R] AddMonoidAlgebra.single h 1) =
        addGroupAlgebraLeftProductMap (R := R) (AddMonoidAlgebra.single g 1) *
          addGroupAlgebraRightProductMap (R := R) (AddMonoidAlgebra.single h 1)
      rw [add_group_algebra_product_tensor_single, add_group_algebra_left_product_single,
        add_group_algebra_right_product_single, AddMonoidAlgebra.single_mul_single]
      simp
    | hadd y z hy hz => simp only [TensorProduct.tmul_add, map_add, mul_add, hy, hz]
    | hsmul r y hy => simp only [TensorProduct.tmul_smul, map_smul, mul_smul_comm, hy]
  | hadd x z hx hz => simp only [TensorProduct.add_tmul, map_add, add_mul, hx, hz]
  | hsmul r x hx =>
    rw [← TensorProduct.smul_tmul', map_smul, hx, map_smul, smul_mul_assoc]

end Litt3.Deformations
