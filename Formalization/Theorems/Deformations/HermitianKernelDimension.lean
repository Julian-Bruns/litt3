import Definitions.Deformations.HermitianKernelDimension

namespace Litt3.Deformations.Specifications

variable {k : Type*} [Field k]

def HermitianOddKernelDimension (N d : ℕ)
    (A : Matrix (Fin d) (Fin d) (TruncatedCoefficientRing k N)) : Prop :=
  Odd (Module.finrank k (LinearMap.ker (Matrix.toLin' A))) →
    N ≤ Module.finrank k (LinearMap.ker (Matrix.toLin' A))

end Litt3.Deformations.Specifications
