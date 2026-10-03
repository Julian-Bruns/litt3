import Definitions.CartierAndSpin.CommutatorWordIdeals
import Mathlib.Data.Matrix.Mul

namespace Litt3.CartierAndSpin

variable {R n : Type*} [CommRing R] [Fintype n] [DecidableEq n]

/-- Literal row module of any family of square matrices over the
original coefficient ring. -/
def matrixRowModule (S : Set (Matrix n n R)) : Submodule R (n → R) :=
  Submodule.span R {v | ∃ M ∈ S, ∃ i : n, v = M i}

/-- Matrices whose literal rows lie in a specified coefficient module
form an actual left ideal, even with arbitrary nonfield coefficients. -/
def matrixRowsIdeal (P : Submodule R (n → R)) : Ideal (Matrix n n R) where
  carrier := {M | ∀ i : n, M i ∈ P}
  zero_mem' := fun i => P.zero_mem
  add_mem' := fun hM hN i => P.add_mem (hM i) (hN i)
  smul_mem' := fun A M hM i => by
    change (A * M) i ∈ P
    have hrow : (A * M) i = ∑ j : n, A i j • M j := by
      funext k
      simp [Matrix.mul_apply, Finset.sum_apply, Pi.smul_apply, smul_eq_mul]
    rw [hrow]
    exact P.sum_mem (fun j _ => P.smul_mem (A i j) (hM j))

end Litt3.CartierAndSpin
