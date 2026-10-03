import Solutions.Deformations.WeightedRootProduct
import Mathlib.RingTheory.TensorProduct.Maps

namespace Litt3.Deformations

open scoped TensorProduct
open Polynomial

variable {R A : Type*} [CommRing R] [CommRing A] [Algebra R A]

/-- The actual universal algebra map from the tensor product of literal
quotient factors, constructed from every original coordinate relation. -/
noncomputable def weightedRootProductLift (q : ℕ) (tau : R) :
    (r : ℕ) → (e : Fin r → A) →
    (∀ i, e i ^ q = -algebraMap R A tau * e i) → weightedRootProduct R q tau r →ₐ[R] A
  | 0, _, _ => Algebra.ofId R A
  | r + 1, e, relations => Algebra.TensorProduct.lift
      (AdjoinRoot.liftAlgHom (weightedRootRelation q tau) (Algebra.ofId R A) (e 0) (by
        simp only [weightedRootRelation, eval₂_add, eval₂_pow, eval₂_X, eval₂_mul, eval₂_C]
        change e 0 ^ q + algebraMap R A tau * e 0 = 0
        rw [relations 0]
        ring))
      (weightedRootProductLift q tau r (fun i => e i.succ) (fun i => relations i.succ))
      (fun _ _ => Commute.all _ _)

@[simp] theorem weighted_root_product_lift_parameter (q : ℕ) (tau : R) (r : ℕ)
    (e : Fin r → A) (relations : ∀ i, e i ^ q = -algebraMap R A tau * e i) (i : Fin r) :
    weightedRootProductLift q tau r e relations (weightedRootProductParameter R q tau r i) = e i := by
  induction r with
  | zero => exact Fin.elim0 i
  | succ r induction =>
    refine Fin.cases ?_ (fun j => ?_) i
    · change Algebra.TensorProduct.lift _ _ _
        (AdjoinRoot.root (weightedRootRelation q tau) ⊗ₜ[R] 1) = _
      rw [Algebra.TensorProduct.lift_tmul, map_one, mul_one, AdjoinRoot.liftAlgHom_root]
    · change Algebra.TensorProduct.lift _ _ _
        (1 ⊗ₜ[R] weightedRootProductParameter R q tau r j) = _
      rw [Algebra.TensorProduct.lift_tmul, map_one, one_mul]
      exact induction (fun j => e j.succ) (fun j => relations j.succ) j

theorem weighted_root_product_lift_basis [Nontrivial R] (q : ℕ) (large : 1 < q)
    (tau : R) (r : ℕ) (e : Fin r → A)
    (relations : ∀ i, e i ^ q = -algebraMap R A tau * e i) (alpha : Fin r → Fin q) :
    weightedRootProductLift q tau r e relations (weightedRootProductBasis q large tau r alpha) =
      ∏ i, e i ^ (alpha i).val := by
  rw [weighted_root_product_basis_apply, map_prod]
  simp only [map_pow, weighted_root_product_lift_parameter]

end Litt3.Deformations
