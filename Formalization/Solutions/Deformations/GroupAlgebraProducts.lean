import Theorems.Deformations.GroupAlgebraProducts

namespace Litt3.Deformations

open scoped MonoidAlgebra TensorProduct

variable {k G H : Type*} [CommSemiring k] [Monoid G] [Monoid H]

@[simp] theorem group_algebra_left_product_of (g : G) :
    groupAlgebraLeftProductMap (k := k) (H := H) (MonoidAlgebra.of k G g) =
      MonoidAlgebra.of k (G × H) (g, 1) := by
  simp [groupAlgebraLeftProductMap, MonoidAlgebra.of_apply,
    MonoidAlgebra.mapDomainAlgHom, MonoidAlgebra.mapDomainRingHom]

@[simp] theorem group_algebra_right_product_of (h : H) :
    groupAlgebraRightProductMap (k := k) (G := G) (MonoidAlgebra.of k H h) =
      MonoidAlgebra.of k (G × H) (1, h) := by
  simp [groupAlgebraRightProductMap, MonoidAlgebra.of_apply,
    MonoidAlgebra.mapDomainAlgHom, MonoidAlgebra.mapDomainRingHom]

/-- The complete images of the two actual product inclusions
commute, even when either individual group algebra is noncommutative. -/
theorem group_algebra_product_images_commute (x : k[G]) (y : k[H]) :
    Commute (groupAlgebraLeftProductMap (k := k) (H := H) x)
      (groupAlgebraRightProductMap (k := k) (G := G) y) := by
  apply MonoidAlgebra.induction_on x
  · intro g
    apply MonoidAlgebra.induction_on y
    · intro h
      rw [group_algebra_left_product_of, group_algebra_right_product_of]
      exact (MonoidHom.commute_inl_inr g h).map (MonoidAlgebra.of k (G × H))
    · intro a b ha hb
      simpa only [map_add] using ha.add_right hb
    · intro c a ha
      have hc : Commute (algebraMap k k[G × H] c)
          (groupAlgebraLeftProductMap (k := k) (H := H) (MonoidAlgebra.of k G g)) :=
        Algebra.commutes c _
      rw [map_smul, Algebra.smul_def]
      exact hc.symm.mul_right ha
  · intro a b ha hb
    simpa only [map_add] using ha.add_left hb
  · intro c a ha
    have hc : Commute (algebraMap k k[G × H] c)
        (groupAlgebraRightProductMap (k := k) (G := G) y) := Algebra.commutes c _
    rw [map_smul, Algebra.smul_def]
    exact hc.mul_left ha

noncomputable def groupAlgebraProductTensorMap : (k[G] ⊗[k] k[H]) →ₐ[k] k[G × H] :=
  Algebra.TensorProduct.lift groupAlgebraLeftProductMap groupAlgebraRightProductMap
    group_algebra_product_images_commute

@[simp] theorem group_algebra_product_tensor_map_of (g : G) (h : H) :
    groupAlgebraProductTensorMap (k := k)
      (MonoidAlgebra.of k G g ⊗ₜ[k] MonoidAlgebra.of k H h) =
        MonoidAlgebra.of k (G × H) (g, h) := by
  change groupAlgebraLeftProductMap (k := k) (H := H) (MonoidAlgebra.of k G g) *
    groupAlgebraRightProductMap (k := k) (G := G) (MonoidAlgebra.of k H h) = _
  rw [group_algebra_left_product_of, group_algebra_right_product_of, ← map_mul]
  simp

@[simp] theorem group_algebra_product_tensor_inverse_of (g : G) (h : H) :
    groupAlgebraProductTensorInverse (k := k) (MonoidAlgebra.of k (G × H) (g, h)) =
      MonoidAlgebra.of k G g ⊗ₜ[k] MonoidAlgebra.of k H h := by
  simp [groupAlgebraProductTensorInverse, groupProductTensorMonoidHom]

/-- Actual product group-algebra presentation, over every
commutative coefficient semiring and arbitrary monoids. -/
noncomputable def groupAlgebraProductTensorEquiv : (k[G] ⊗[k] k[H]) ≃ₐ[k] k[G × H] := by
  refine AlgEquiv.ofAlgHom groupAlgebraProductTensorMap groupAlgebraProductTensorInverse ?_ ?_
  · apply MonoidAlgebra.algHom_ext
    intro gh
    change groupAlgebraProductTensorMap (k := k)
      (groupAlgebraProductTensorInverse (k := k)
        (MonoidAlgebra.of k (G × H) (gh.1, gh.2))) = MonoidAlgebra.of k (G × H) (gh.1, gh.2)
    rw [group_algebra_product_tensor_inverse_of, group_algebra_product_tensor_map_of]
  · ext : 1
    · apply MonoidAlgebra.algHom_ext
      intro g
      change groupAlgebraProductTensorInverse (k := k)
        (groupAlgebraProductTensorMap (k := k)
          (MonoidAlgebra.of k G g ⊗ₜ[k] MonoidAlgebra.of k H 1)) = _
      rw [group_algebra_product_tensor_map_of, group_algebra_product_tensor_inverse_of]
      rfl
    · apply MonoidAlgebra.algHom_ext
      intro h
      change groupAlgebraProductTensorInverse (k := k)
        (groupAlgebraProductTensorMap (k := k)
          (MonoidAlgebra.of k G 1 ⊗ₜ[k] MonoidAlgebra.of k H h)) = _
      rw [group_algebra_product_tensor_map_of, group_algebra_product_tensor_inverse_of]
      rfl

theorem genuine_group_algebra_product_presentation :
    Specifications.GenuineGroupAlgebraProductPresentation (k := k) (G := G) (H := H) := by
  refine ⟨groupAlgebraProductTensorEquiv, ?_⟩
  exact group_algebra_product_tensor_map_of

end Litt3.Deformations
