import Definitions.Deformations.MultiplicativeFiltration
import Theorems.Deformations.FiltrationWidth

namespace Litt3.Deformations.Specifications

variable {k A : Type*} [Field k] [Ring A] [Algebra k A] [FiniteDimensional k A]

/-- Actual right multiplication by a step-two filtration element
has every adjacent-layer dimension as a cokernel lower bound. -/
def MultiplicativeFiltrationWidth (F : ℕ → Submodule k A) (f : A) : Prop :=
  AdjacentFiltrationWidth (LinearMap.mulRight k f) F

end Litt3.Deformations.Specifications
