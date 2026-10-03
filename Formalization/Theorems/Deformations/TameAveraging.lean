import Definitions.Deformations.TameAveraging

namespace Litt3.Deformations

variable {G A : Type*} [Group G] [MulAction G A]

/-- Tame affine averaging produces an actual fixed point. -/
def HasFixedPoint : Prop := ∃ a : A, ∀ g : G, g • a = a

variable {O : Type*} [AddCommGroup O]

/-- A zero of the full obstruction exists exactly when an invariant
zero exists; no assertion is made about a scalar relaxation. -/
def InvariantZeroCriterion (c : A → O) : Prop :=
  (∃ a, c a = 0) ↔ ∃ a, (∀ g : G, g • a = a) ∧ c a = 0

end Litt3.Deformations
