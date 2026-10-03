import Definitions.Deformations.DeckOrderBounds

namespace Litt3.Deformations.Specifications

variable {G : Type*} [Group G] [Finite G]

def ActualFiniteGroupPrimeTo (p m : ℕ) : Prop :=
  PrimePowerOrdersBounded G p m → m < p → Nat.Coprime p (Nat.card G)

end Litt3.Deformations.Specifications
