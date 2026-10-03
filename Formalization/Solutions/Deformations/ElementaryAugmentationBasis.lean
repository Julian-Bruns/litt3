import Solutions.Deformations.IntegralCyclicBasis
import Solutions.Deformations.AddGroupAlgebraProducts
import Mathlib.LinearAlgebra.Finsupp.VectorSpace
import Mathlib.LinearAlgebra.TensorProduct.Basis
import Mathlib.Algebra.BigOperators.Fin

namespace Litt3.Deformations

open scoped TensorProduct

/-- Literal head/tail decomposition of finite tuples, retaining the
original first coordinate and all original successor coordinates. -/
def finiteFunctionSplitEquiv (X : Type*) (r : ℕ) :
    (Fin (r + 1) → X) ≃ X × (Fin r → X) where
  toFun v := (v 0, fun i => v i.succ)
  invFun v := Fin.cons v.1 v.2
  left_inv v := by ext i; exact Fin.cases rfl (fun _ => rfl) i
  right_inv v := by cases v; rfl

def finiteFunctionSplitAddEquiv (X : Type*) [Add X] (r : ℕ) :
    (Fin (r + 1) → X) ≃+ X × (Fin r → X) where
  __ := finiteFunctionSplitEquiv X r
  map_add' _ _ := rfl

variable {R : Type*} [CommRing R] [Nontrivial R]

noncomputable def elementaryAugmentationParameter (q r : ℕ) (i : Fin r) :
    AddMonoidAlgebra R (Fin r → ZMod q) :=
  AddMonoidAlgebra.single (Pi.single i (1 : ZMod q)) 1 - 1

noncomputable def elementarySplitInverse (q r : ℕ) :
    AddMonoidAlgebra R (ZMod q × (Fin r → ZMod q)) ≃ₐ[R]
      AddMonoidAlgebra R (Fin (r + 1) → ZMod q) :=
  AddMonoidAlgebra.domCongr R R (finiteFunctionSplitAddEquiv (ZMod q) r).symm

theorem finite_cons_head_single (q r : ℕ) :
    Fin.cons (α := fun _ : Fin (r + 1) => ZMod q) (1 : ZMod q) (0 : Fin r → ZMod q) =
      Pi.single (0 : Fin (r + 1)) 1 := by
  ext i
  refine Fin.cases ?_ (fun j => ?_) i
  · simp
  · simp [Pi.single_apply, Fin.succ_ne_zero]

theorem finite_cons_tail_single (q r : ℕ) (i : Fin r) :
    Fin.cons (α := fun _ : Fin (r + 1) => ZMod q) (0 : ZMod q) (Pi.single i 1) =
      Pi.single i.succ 1 := by
  ext j
  refine Fin.cases ?_ (fun j => ?_) j
  · simp [Pi.single_apply, Fin.succ_ne_zero]
  · simp [Pi.single_apply]

@[simp] theorem elementary_split_inverse_left_parameter (q r : ℕ) :
    elementarySplitInverse (R := R) q r
      (addGroupAlgebraLeftProductMap (R := R) (H := Fin r → ZMod q)
        ((cyclicGroupGenerator R q : CyclicGroupAlgebra R q) - 1)) =
      elementaryAugmentationParameter (R := R) q (r + 1) 0 := by
  rw [map_sub, map_one, map_sub, map_one]
  change elementarySplitInverse (R := R) q r
    (addGroupAlgebraLeftProductMap (R := R) (AddMonoidAlgebra.single (1 : ZMod q) 1)) - 1 = _
  rw [add_group_algebra_left_product_single]
  change AddMonoidAlgebra.domCongr R R (finiteFunctionSplitAddEquiv (ZMod q) r).symm
    (AddMonoidAlgebra.single (1, 0) 1) - 1 = _
  rw [AddMonoidAlgebra.domCongr_single]
  change AddMonoidAlgebra.single
    (Fin.cons (α := fun _ : Fin (r + 1) => ZMod q) (1 : ZMod q) 0) (1 : R) - 1 = _
  rw [finite_cons_head_single]
  rfl

@[simp] theorem elementary_split_inverse_right_parameter (q r : ℕ) (i : Fin r) :
    elementarySplitInverse (R := R) q r
      (addGroupAlgebraRightProductMap (R := R) (G := ZMod q)
        (elementaryAugmentationParameter (R := R) q r i)) =
      elementaryAugmentationParameter (R := R) q (r + 1) i.succ := by
  rw [elementaryAugmentationParameter, map_sub, map_one, map_sub, map_one,
    add_group_algebra_right_product_single]
  change AddMonoidAlgebra.domCongr R R (finiteFunctionSplitAddEquiv (ZMod q) r).symm
    (AddMonoidAlgebra.single (0, Pi.single i 1) 1) - 1 = _
  rw [AddMonoidAlgebra.domCongr_single]
  change AddMonoidAlgebra.single
    (Fin.cons (α := fun _ : Fin (r + 1) => ZMod q) (0 : ZMod q) (Pi.single i 1)) (1 : R) - 1 = _
  rw [finite_cons_tail_single]
  rfl

/-- The actual original augmentation normal basis on the group algebra
of an arbitrary product of equal cyclic groups. It is constructed by
actual tensor maps, with mixed-characteristic coefficients permitted. -/
noncomputable def elementaryAugmentationBasis (q : ℕ) (positive : 0 < q) :
    (r : ℕ) → Module.Basis (Fin r → Fin q) R (AddMonoidAlgebra R (Fin r → ZMod q))
  | 0 => (Finsupp.basisSingleOne : Module.Basis (Fin 0 → ZMod q) R
      (AddMonoidAlgebra R (Fin 0 → ZMod q))).reindex
        (Equiv.ofUnique (Fin 0 → ZMod q) (Fin 0 → Fin q))
  | r + 1 =>
      ((((integralCyclicAugmentationBasis (R := R) q positive).tensorProduct
          (elementaryAugmentationBasis q positive r)).map
        (addGroupAlgebraProductTensorEquiv (R := R)).toLinearEquiv).map
          (AddMonoidAlgebra.domCongr R R (finiteFunctionSplitAddEquiv (ZMod q) r).symm).toLinearEquiv).reindex
            (finiteFunctionSplitEquiv (Fin q) r).symm

/-- Each constructed basis vector is exactly the product of the
original fixed-generator augmentation powers, with no generator change. -/
@[simp] theorem elementary_augmentation_basis_apply (q : ℕ) (positive : 0 < q)
    (r : ℕ) (alpha : Fin r → Fin q) :
    elementaryAugmentationBasis (R := R) q positive r alpha =
      ∏ i, elementaryAugmentationParameter (R := R) q r i ^ (alpha i).val := by
  induction r with
  | zero =>
    rw [elementaryAugmentationBasis]
    have evaluation :=
      (Finsupp.basisSingleOne : Module.Basis (Fin 0 → ZMod q) R
        (AddMonoidAlgebra R (Fin 0 → ZMod q))).reindex_apply
        (Equiv.ofUnique (Fin 0 → ZMod q) (Fin 0 → Fin q)) alpha
    have index : (Equiv.ofUnique (Fin 0 → ZMod q) (Fin 0 → Fin q)).symm alpha = 0 :=
      Subsingleton.elim _ _
    have value : (Finsupp.basisSingleOne : Module.Basis (Fin 0 → ZMod q) R
        (AddMonoidAlgebra R (Fin 0 → ZMod q)))
        ((Equiv.ofUnique (Fin 0 → ZMod q) (Fin 0 → Fin q)).symm alpha) =
          (1 : AddMonoidAlgebra R (Fin 0 → ZMod q)) := by
      rw [index]
      change (AddMonoidAlgebra.single (0 : Fin 0 → ZMod q) (1 : R)) = 1
      rfl
    have equality := evaluation.trans value
    exact equality.trans (by simp)
  | succ r induction =>
    rw [elementaryAugmentationBasis]
    simp only [Module.Basis.reindex_apply, Module.Basis.map_apply]
    change elementarySplitInverse (R := R) q r
      (addGroupAlgebraProductTensorEquiv (R := R)
        (((integralCyclicAugmentationBasis (R := R) q positive).tensorProduct
          (elementaryAugmentationBasis q positive r))
          (alpha 0, fun i => alpha i.succ))) = _
    rw [Module.Basis.tensorProduct_apply, integral_cyclic_augmentation_basis_apply,
      induction, add_group_algebra_product_tensor_tmul, map_mul, map_pow, map_pow,
      elementary_split_inverse_left_parameter, map_prod, map_prod]
    simp_rw [map_pow, elementary_split_inverse_right_parameter]
    rw [Fin.prod_univ_succ]

end Litt3.Deformations
