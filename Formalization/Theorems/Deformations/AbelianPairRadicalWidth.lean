import Theorems.Deformations.AbelianPairRadicalHilbert
import Theorems.Deformations.BoundedNaturalMaximum

namespace Litt3.Deformations.Specifications

variable {k : Type*} [Field k]

def ActualAbelianPairRadicalWidth (p a : ℕ) : Prop :=
  AttainedNaturalMaximum (groupRadicalHilbertWindow (k := k)
    (G := Multiplicative (ZMod (p ^ a)) × Multiplicative (ZMod (p ^ a))) 2)
      (2 * p ^ a - 1)

end Litt3.Deformations.Specifications
