import Mathlib.GroupTheory.GroupAction.Quotient

/-! Ordinary finite group actions used on geometric fibers. These are
actual group actions, not a replacement definition of an étale cover. -/

namespace Litt3.QuotientGeometry

/-- Every nonidentity group element acts without fixed points. -/
def FixedPointFreeAction (G A : Type*) [Group G] [MulAction G A] : Prop :=
  ∀ g : G, ∀ a : A, g • a = a → g = 1

end Litt3.QuotientGeometry
