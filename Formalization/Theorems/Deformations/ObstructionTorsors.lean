import Definitions.Deformations.ObstructionTorsors

namespace Litt3.Deformations

variable {K O A : Type*} [AddCommGroup K] [AddCommGroup O] [AddTorsor K A]

/-- Exact full-point existence criterion; it is not a graded or scalar
relaxation of the complete obstruction. -/
def ObstructionZeroCriterion (R : K →+ O) (c : A → O) (a₀ : A) : Prop :=
  (∃ a, c a = 0) ↔ ∃ x, R x = -c a₀

/-- A bijective complete response has exactly one marked zero. -/
def ObstructionUniqueZero (c : A → O) : Prop := ∃! a, c a = 0

end Litt3.Deformations
