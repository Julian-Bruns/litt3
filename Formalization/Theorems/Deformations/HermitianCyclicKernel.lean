import Definitions.Deformations.HermitianCyclicKernel

namespace Litt3.Deformations.Specifications

variable {k : Type*} [Field k]

def HermitianCyclicKernel (N d : ℕ)
    (A : Matrix (Fin d) (Fin d) (TruncatedCoefficientRing k N)) : Prop :=
  Nonempty (HermitianCyclicKernelData N d A)

end Litt3.Deformations.Specifications
