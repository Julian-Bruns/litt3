import Definitions.Deformations.TruncatedReflection

namespace Litt3.Deformations.Specifications

variable {k : Type*} [CommRing k]

def TruncatedReflectionInvolution (N : ℕ) : Prop :=
  Function.Involutive (truncatedReflection k N)

end Litt3.Deformations.Specifications
