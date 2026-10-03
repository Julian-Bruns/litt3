import Definitions.Deformations.CyclicBlockBounds

namespace Litt3.Deformations

/-- Arithmetic consequence once nonfree odd-block parity is supplied. -/
def CyclicOrderBound (N : ℕ) (multiplicity : ℕ → ℕ) : Prop :=
  Odd (cyclicBlockDimension N multiplicity) →
    N ≤ cyclicBlockDimension N multiplicity

end Litt3.Deformations
