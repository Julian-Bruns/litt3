import Definitions.Deformations.PGroupInvariants

namespace Litt3.Deformations.Specifications

variable {k D U : Type*} [Field k] [AddCommGroup D] [Module k D]
    [AddCommGroup U] [Module k U]

def ZeroSectionPreservation : Prop :=
  Module.finrank k D = 0 ↔ Module.finrank k U = 0

end Litt3.Deformations.Specifications
