import Definitions.Deformations.FiltrationWidth
import Mathlib.Algebra.Algebra.Bilinear

namespace Litt3.Deformations

variable {k A : Type*} [Field k] [Ring A] [Algebra k A]

/-- Multiplicativity of actual subspaces in a possibly
noncommutative algebra. -/
def IsMultiplicativeFiltration (F : ℕ → Submodule k A) : Prop :=
  ∀ i j x y, x ∈ F i → y ∈ F j → x * y ∈ F (i + j)

end Litt3.Deformations
