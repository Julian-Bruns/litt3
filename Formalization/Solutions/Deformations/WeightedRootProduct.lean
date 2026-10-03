import Definitions.Deformations.WeightedRootProduct
import Solutions.Deformations.ElementaryAugmentationBasis

namespace Litt3.Deformations

open scoped TensorProduct BigOperators

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- Actual original normal powers form the tensor-product basis over
the unchanged coefficient ring. No function algebra is supplied. -/
noncomputable def weightedRootProductBasis (q : ℕ) (large : 1 < q) (tau : R) :
    (r : ℕ) → Module.Basis (Fin r → Fin q) R (weightedRootProduct R q tau r)
  | 0 => (Module.Basis.singleton Unit R).reindex (Equiv.ofUnique Unit (Fin 0 → Fin q))
  | r + 1 => ((weightedRootFactorBasis q large tau).tensorProduct
      (weightedRootProductBasis q large tau r)).reindex (finiteFunctionSplitEquiv (Fin q) r).symm

@[simp] theorem weighted_root_product_basis_apply (q : ℕ) (large : 1 < q) (tau : R)
    (r : ℕ) (alpha : Fin r → Fin q) :
    weightedRootProductBasis q large tau r alpha =
      ∏ i, weightedRootProductParameter R q tau r i ^ (alpha i).val := by
  induction r with
  | zero =>
    have value := (Module.Basis.singleton Unit R).reindex_apply
      (Equiv.ofUnique Unit (Fin 0 → Fin q)) alpha
    exact value.trans (by simp [Module.Basis.singleton_apply])
  | succ r induction =>
    have value := ((weightedRootFactorBasis q large tau).tensorProduct
      (weightedRootProductBasis q large tau r)).reindex_apply
        (finiteFunctionSplitEquiv (Fin q) r).symm alpha
    apply value.trans
    change ((weightedRootFactorBasis q large tau).tensorProduct
      (weightedRootProductBasis q large tau r)) (alpha 0, fun i => alpha i.succ) = _
    rw [Module.Basis.tensorProduct_apply,
      weighted_root_factor_basis_apply, induction]
    rw [Fin.prod_univ_succ]
    change (AdjoinRoot.root (weightedRootRelation q tau) ^ (alpha 0).val) ⊗ₜ[R]
      (∏ i : Fin r, weightedRootProductParameter R q tau r i ^ (alpha i.succ).val) =
      (Algebra.TensorProduct.includeLeft (AdjoinRoot.root (weightedRootRelation q tau))) ^
          (alpha 0).val *
        ∏ i : Fin r, (Algebra.TensorProduct.includeRight
          (weightedRootProductParameter R q tau r i)) ^ (alpha i.succ).val
    simp only [← map_pow]
    rw [← map_prod]
    rw [Algebra.TensorProduct.includeLeft_apply, Algebra.TensorProduct.includeRight_apply,
      Algebra.TensorProduct.tmul_mul_tmul, mul_one, one_mul]

end Litt3.Deformations
