import Solutions.CartierAndSpin.OrderedCommutatorCriterion
import Solutions.CartierAndSpin.OrderedCommutatorStacks

namespace Litt3.CartierAndSpin

open Matrix

variable {k n : Type*} [Field k] [IsAlgClosed k]
variable [Fintype n] [DecidableEq n] [Nonempty n]

/-- The literal ordered rectangular commutator stack has rank below
the number of columns exactly when the actual two matrices have a
common geometric eigenvector. This holds in every dimension and
characteristic, at every actual fiber. -/
theorem matrix_ordered_commutator_rank_criterion (U V : Matrix n n k) :
    (orderedCommutatorStack U V (Fintype.card n - 1)).rank < Fintype.card n ↔
      ∃ (a b : k) (x : n → k), x ≠ 0 ∧ U *ᵥ x = a • x ∧ V *ᵥ x = b • x := by
  rw [matrix_rank_lt_columns_iff_kernel]
  simp_rw [ordered_commutator_stack_kernel]
  have h := ordered_commutator_common_eigenvector_criterion
    (Matrix.toLinAlgEquiv' U) (Matrix.toLinAlgEquiv' V)
  simpa only [← map_mul, ← map_sub, ← map_pow, Matrix.toLinAlgEquiv'_apply,
    Module.finrank_pi] using h

end Litt3.CartierAndSpin
