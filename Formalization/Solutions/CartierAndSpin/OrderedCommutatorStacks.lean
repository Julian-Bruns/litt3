import Definitions.CartierAndSpin.OrderedCommutatorStacks
import Mathlib.LinearAlgebra.Matrix.Rank
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Matrix

variable {R n : Type*} [CommRing R] [Fintype n] [DecidableEq n]

theorem ordered_commutator_stack_kernel (U V : Matrix n n R) (d : ℕ) (x : n → R) :
    orderedCommutatorStack U V d *ᵥ x = 0 ↔
      ∀ a b : ℕ, a + b ≤ d → ((U * V - V * U) * U ^ a * V ^ b) *ᵥ x = 0 := by
  constructor
  · intro h a b hab
    let pair : OrderedCommutatorPairs d := ⟨⟨a, by omega⟩, ⟨b, by change b < d + 1 - a; omega⟩⟩
    funext i
    exact congrFun h (pair, i)
  · intro h
    funext i
    have hab : i.1.1.val + i.1.2.val ≤ d := by
      have ha := i.1.1.isLt
      have hb := i.1.2.isLt
      omega
    exact congrFun (h i.1.1.val i.1.2.val hab) i.2

variable {k m : Type*} [Field k] [Fintype m]

/-- Literal matrix rank defect is exactly an actual nonzero kernel
vector, including rectangular matrices and exceptional fibers. -/
theorem matrix_rank_lt_columns_iff_kernel (A : Matrix m n k) :
    A.rank < Fintype.card n ↔ ∃ x : n → k, x ≠ 0 ∧ A *ᵥ x = 0 := by
  let f := A.mulVecLin
  have hdimension := f.finrank_range_add_finrank_ker
  rw [Module.finrank_pi] at hdimension
  change A.rank + Module.finrank k (LinearMap.ker f) = Fintype.card n at hdimension
  constructor
  · intro hrank
    have hnonzero : LinearMap.ker f ≠ ⊥ := by
      intro hzero
      have hdimzero := Submodule.finrank_eq_zero.mpr hzero
      omega
    obtain ⟨x, hxmem, hx⟩ := Submodule.exists_mem_ne_zero_of_ne_bot hnonzero
    exact ⟨x, hx, hxmem⟩
  · rintro ⟨x, hx, hxker⟩
    have hnonzero : LinearMap.ker f ≠ ⊥ := by
      intro hzero
      have hmem : x ∈ LinearMap.ker f := hxker
      rw [hzero] at hmem
      exact hx hmem
    have hpositive : 0 < Module.finrank k (LinearMap.ker f) := Nat.pos_of_ne_zero
      (fun hzero => hnonzero (Submodule.finrank_eq_zero.mp hzero))
    omega

end Litt3.CartierAndSpin
