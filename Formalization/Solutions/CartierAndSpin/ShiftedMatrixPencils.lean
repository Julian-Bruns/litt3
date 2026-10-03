import Definitions.CartierAndSpin.ShiftedMatrixPencils
import Solutions.CartierAndSpin.MatrixCommutatorCriterion

namespace Litt3.CartierAndSpin

open Matrix

variable {R n : Type*} [CommRing R] [Fintype n] [DecidableEq n]

theorem shifted_pencil_stack_kernel (U V : Matrix n n R) (a b : R) (x : n → R) :
    shiftedPencilStack U V a b *ᵥ x = 0 ↔
      U *ᵥ x = (-a) • x ∧ V *ᵥ x = (-b) • x := by
  have hblocks : shiftedPencilStack U V a b *ᵥ x = 0 ↔
      (a • 1 + U) *ᵥ x = 0 ∧ (b • 1 + V) *ᵥ x = 0 := by
    constructor
    · intro h
      constructor
      · funext i
        exact congrFun h (Sum.inl i)
      · funext i
        exact congrFun h (Sum.inr i)
    · rintro ⟨hU, hV⟩
      funext i
      cases i with
      | inl i => exact congrFun hU i
      | inr i => exact congrFun hV i
  rw [hblocks]
  simp only [Matrix.add_mulVec, Matrix.smul_mulVec, Matrix.one_mulVec]
  constructor
  · rintro ⟨hU, hV⟩
    exact ⟨by simpa only [neg_smul] using eq_neg_of_add_eq_zero_right hU,
      by simpa only [neg_smul] using eq_neg_of_add_eq_zero_right hV⟩
  · rintro ⟨hU, hV⟩
    simp [hU, hV]

theorem shifted_pencil_kernel_iff_common_eigenvector (U V : Matrix n n R) :
    (∃ a b : R, ∃ x : n → R, x ≠ 0 ∧ shiftedPencilStack U V a b *ᵥ x = 0) ↔
      ∃ a b : R, ∃ x : n → R, x ≠ 0 ∧ U *ᵥ x = a • x ∧ V *ᵥ x = b • x := by
  constructor
  · rintro ⟨a, b, x, hx, hstack⟩
    exact ⟨-a, -b, x, hx, (shifted_pencil_stack_kernel U V a b x).mp hstack⟩
  · rintro ⟨a, b, x, hx, hU, hV⟩
    refine ⟨-a, -b, x, hx, (shifted_pencil_stack_kernel U V (-a) (-b) x).mpr ?_⟩
    simpa only [neg_neg] using And.intro hU hV

variable {k : Type*} [Field k] [IsAlgClosed k] [Nonempty n]

/-- At every literal fiber, existence of the two scalar pencil
coordinates is exactly rank failure of the ordered commutator stack. -/
theorem shifted_pencil_exists_iff_ordered_rank (U V : Matrix n n k) :
    (∃ a b : k, ∃ x : n → k, x ≠ 0 ∧ shiftedPencilStack U V a b *ᵥ x = 0) ↔
      (orderedCommutatorStack U V (Fintype.card n - 1)).rank < Fintype.card n := by
  rw [shifted_pencil_kernel_iff_common_eigenvector,
    matrix_ordered_commutator_rank_criterion]

omit [IsAlgClosed k] in
/-- The excluded zero fiber: the zero matrix pencil has a nonzero
kernel only when both scalar coordinates vanish. -/
theorem zero_shifted_pencil_kernel_iff (a b : k) :
    (∃ x : n → k, x ≠ 0 ∧ shiftedPencilStack 0 0 a b *ᵥ x = 0) ↔ a = 0 ∧ b = 0 := by
  constructor
  · rintro ⟨x, hx, h⟩
    obtain ⟨ha, hb⟩ := (shifted_pencil_stack_kernel 0 0 a b x).mp h
    simp only [Matrix.zero_mulVec] at ha hb
    exact ⟨neg_eq_zero.mp ((smul_eq_zero.mp ha.symm).resolve_right hx),
      neg_eq_zero.mp ((smul_eq_zero.mp hb.symm).resolve_right hx)⟩
  · rintro ⟨rfl, rfl⟩
    obtain ⟨x, hx⟩ := exists_ne (0 : n → k)
    exact ⟨x, hx, by simp [shiftedPencilStack]⟩

end Litt3.CartierAndSpin
