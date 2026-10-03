import Solutions.Deformations.WeightedRootProduct

namespace Litt3.Deformations

open scoped TensorProduct

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- Every original coordinate of the actual tensor quotient satisfies
its literal mixed graded relation over the same base ring. -/
theorem weighted_root_product_coordinate_relation (q : ℕ) (tau : R) (r : ℕ) (i : Fin r) :
    weightedRootProductParameter R q tau r i ^ q =
      -algebraMap R (weightedRootProduct R q tau r) tau * weightedRootProductParameter R q tau r i := by
  induction r with
  | zero => exact Fin.elim0 i
  | succ r induction =>
    refine Fin.cases ?_ (fun j => ?_) i
    · let inclusion := (Algebra.TensorProduct.includeLeft : WeightedRootFactor R q tau →ₐ[R]
        WeightedRootFactor R q tau ⊗[R] weightedRootProduct R q tau r)
      have relation := congrArg inclusion (weighted_root_factor_relation q tau)
      simp only [map_pow, map_mul, map_neg, AlgHom.commutes] at relation
      exact relation
    · let inclusion := (Algebra.TensorProduct.includeRight : weightedRootProduct R q tau r →ₐ[R]
        WeightedRootFactor R q tau ⊗[R] weightedRootProduct R q tau r)
      have relation := congrArg inclusion (induction j)
      simp only [map_pow, map_mul, map_neg, AlgHom.commutes] at relation
      exact relation

end Litt3.Deformations
