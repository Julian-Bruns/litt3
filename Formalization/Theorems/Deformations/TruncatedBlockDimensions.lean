import Definitions.Deformations.TruncatedBlockDimensions

namespace Litt3.Deformations.Specifications

variable {k ι : Type*} [Field k] [Fintype ι] [DecidableEq ι]

def TruncatedUnitBlockDimension (N j : ℕ)
    (C : Matrix ι ι (TruncatedCoefficientRing k N)) : Prop :=
  Module.finrank k (LinearMap.ker (Matrix.toLin' (truncatedParameter k N ^ j • C))) =
    j * Fintype.card ι

end Litt3.Deformations.Specifications
