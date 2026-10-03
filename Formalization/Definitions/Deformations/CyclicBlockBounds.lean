import Mathlib.Algebra.BigOperators.Ring.Nat

namespace Litt3.Deformations

open scoped BigOperators

/-- Sum of all block dimensions, including the free block of length
`N`; length zero contributes nothing. -/
def cyclicBlockDimension (N : ℕ) (multiplicity : ℕ → ℕ) : ℕ :=
  ∑ j ∈ Finset.range (N + 1), j * multiplicity j

end Litt3.Deformations
