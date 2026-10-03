import Mathlib.FieldTheory.IntermediateField.Adjoin.Basic
import Mathlib.Data.Set.Card

namespace Litt3.CartierAndSpin

variable {k L : Type*} [Field k] [Field L] [Algebra k L]

/-- The literal NONZERO weighted square support, with the canonical
parameter-minus-function sign convention. -/
def nonzeroWeightedSquareSupport (g q : L) : Set k :=
  {theta | IsSquare (g * (algebraMap k L theta - q)) ∧
    g * (algebraMap k L theta - q) ≠ 0}

end Litt3.CartierAndSpin
