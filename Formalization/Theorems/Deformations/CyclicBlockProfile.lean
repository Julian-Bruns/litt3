import Definitions.Deformations.CyclicBlockProfile

namespace Litt3.Deformations.Specifications

variable {k : Type*} [Field k]

def CyclicBlockProfile (N s : ℕ) (degree multiplicity : Fin s → ℕ) : Prop :=
  CyclicBlockProfileIdentity (k := k) N s degree multiplicity

end Litt3.Deformations.Specifications
