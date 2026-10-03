import Mathlib.LinearAlgebra.FiniteDimensional.Basic
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

namespace Litt3.Atlases

variable {K V : Type*} [DivisionRing K] [AddCommGroup V] [Module K V]

/-- An exact consecutive rank plateau, not sampled solver progress. -/
def ExactRangePlateau (f : Module.End K V) (e : ℕ) : Prop :=
  Module.finrank K (LinearMap.range (f ^ e)) =
    Module.finrank K (LinearMap.range (f ^ (e + 1)))

end Litt3.Atlases
