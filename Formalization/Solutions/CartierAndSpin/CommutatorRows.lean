import Definitions.CartierAndSpin.CommutatorRows
import Solutions.CartierAndSpin.CommutatorWordCompression

namespace Litt3.CartierAndSpin

variable {R n : Type*} [CommRing R] [Fintype n] [DecidableEq n]

theorem rows_of_left_ideal_span_mem (S : Set (Matrix n n R))
    {M : Matrix n n R} (hM : M ∈ Ideal.span S) (i : n) :
    M i ∈ matrixRowModule S := by
  have hle : Ideal.span S ≤ matrixRowsIdeal (matrixRowModule S) := by
    apply Ideal.span_le.mpr
    intro N hN j
    exact Submodule.subset_span ⟨N, hN, j, rfl⟩
  exact hle hM i

/-- Equality of actual matrix left ideals gives equality of the
literal row modules over the original coefficient ring. -/
theorem matrix_row_module_eq_of_left_ideal_eq (S T : Set (Matrix n n R))
    (heq : Ideal.span S = Ideal.span T) : matrixRowModule S = matrixRowModule T := by
  apply le_antisymm
  · apply Submodule.span_le.mpr
    rintro v ⟨M, hM, i, rfl⟩
    apply rows_of_left_ideal_span_mem T
    rw [← heq]
    exact Ideal.subset_span hM
  · apply Submodule.span_le.mpr
    rintro v ⟨M, hM, i, rfl⟩
    apply rows_of_left_ideal_span_mem S
    rw [heq]
    exact Ideal.subset_span hM

/-- Exact normal ordering of all commutator rows, over every original
commutative coefficient ring. No fraction field or specialization is used. -/
theorem commutator_word_rows_eq_ordered (U V : Matrix n n R) (d : ℕ) :
    matrixRowModule {M | ∃ w : List Bool, w.length ≤ d ∧
      M = (U * V - V * U) * twoGeneratorWord U V w} =
    matrixRowModule {M | ∃ a b : ℕ, a + b ≤ d ∧
      M = (U * V - V * U) * U ^ a * V ^ b} :=
  matrix_row_module_eq_of_left_ideal_eq _ _ (commutator_word_ideal_eq_ordered U V d)

end Litt3.CartierAndSpin
