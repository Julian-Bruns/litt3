import Definitions.Deformations.CyclicGroupAlgebra
import Definitions.Deformations.GroupAlgebraQuotients
import Theorems.Deformations.BoundedNaturalMaximum

namespace Litt3.Deformations.Specifications

variable {k : Type*} [Field k]

def ActualCyclicRadicalWidth (p a lag : ℕ) : Prop :=
  AttainedNaturalMaximum (groupRadicalHilbertWindow (k := k)
    (G := Multiplicative (ZMod (p ^ a))) lag) (min (p ^ a) lag)

end Litt3.Deformations.Specifications
