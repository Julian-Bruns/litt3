import Definitions.Deformations.CyclicInversion

namespace Litt3.Deformations.Specifications

variable {k : Type*} [CommRing k]

def CyclicGroupInversionInvolutive (N : ℕ) : Prop :=
  Function.Involutive (cyclicGroupInversion k N)

end Litt3.Deformations.Specifications
