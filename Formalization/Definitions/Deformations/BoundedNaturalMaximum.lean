import Mathlib.Data.Nat.Find

namespace Litt3.Deformations

/-- The least actual natural upper bound of a bounded family.
Attainment is proved separately, including infinite index types. -/
noncomputable def boundedNaturalMaximum {ι : Type*} (f : ι → ℕ)
    (bounded : ∃ n, ∀ i, f i ≤ n) : ℕ := by
  classical
  exact Nat.find bounded

end Litt3.Deformations
