import Theorems.Deformations.CyclicBlockBounds

/-!
The arithmetic consequence of the cyclic symplectic block parity
theorem. This file does not assume or formalize the geometric duality
argument that establishes the parity of nonfree odd blocks.
-/

namespace Litt3.Deformations

open scoped BigOperators

/-- Nonfree odd blocks of even multiplicity contribute even dimension,
as do all even blocks. -/
theorem nonfree_block_dimension_even (N : ℕ) (multiplicity : ℕ → ℕ)
    (parity : ∀ j, j < N → Odd j → Even (multiplicity j)) :
    Even (∑ j ∈ Finset.range N, j * multiplicity j) := by
  apply Finset.even_sum
  intro j hj
  rcases Nat.even_or_odd j with he | ho
  · exact he.mul_right _
  · exact (parity j (Finset.mem_range.mp hj) ho).mul_left _

/-- An odd total dimension requires a nonzero free block. The bound
is completely uniform in the block multiplicities and needs no
finite enumeration. -/
theorem odd_dimension_has_free_block (N : ℕ) (multiplicity : ℕ → ℕ)
    (parity : ∀ j, j < N → Odd j → Even (multiplicity j))
    (odd_dimension : Odd (cyclicBlockDimension N multiplicity)) :
    0 < multiplicity N := by
  by_contra h
  have hz : multiplicity N = 0 := by omega
  have he := nonfree_block_dimension_even N multiplicity parity
  apply Nat.not_even_iff_odd.mpr odd_dimension
  simpa [cyclicBlockDimension, Finset.sum_range_succ, hz] using he

/-- The actual cyclic deck order is at most an odd section dimension
once the nonfree block parity has been established geometrically. -/
theorem cyclic_order_le_odd_dimension (N : ℕ) (multiplicity : ℕ → ℕ)
    (parity : ∀ j, j < N → Odd j → Even (multiplicity j))
    (odd_dimension : Odd (cyclicBlockDimension N multiplicity)) :
    N ≤ cyclicBlockDimension N multiplicity := by
  have hm := odd_dimension_has_free_block N multiplicity parity odd_dimension
  have hn : N ≤ N * multiplicity N := by
    calc
      N = N * 1 := (Nat.mul_one N).symm
      _ ≤ N * multiplicity N := Nat.mul_le_mul_left N hm
  unfold cyclicBlockDimension
  rw [Finset.sum_range_succ]
  exact hn.trans (Nat.le_add_left _ _)

end Litt3.Deformations
