import Definitions.Deformations.HermitianValuationStep

namespace Litt3.Deformations.Specifications

variable {k ι : Type*} [Field k] [Fintype ι] [DecidableEq ι]

def HermitianValuationStep (N : ℕ)
    (A : Matrix ι ι (TruncatedCoefficientRing k N)) : Prop :=
  Nonempty (HermitianValuationStepData N A)

end Litt3.Deformations.Specifications
