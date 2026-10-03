import Mathlib.GroupTheory.PGroup

namespace Litt3.Deformations

variable (G : Type*) [Group G]

def PrimePowerOrdersBounded (p m : ℕ) : Prop :=
  ∀ g : G, ∀ a : ℕ, orderOf g = p ^ a → p ^ a ≤ m

end Litt3.Deformations
