import Definitions.Deformations.CongruenceKernels

namespace Litt3.Deformations.Specifications

variable {R ι : Type*} [CommRing R] [StarRing R] [Fintype ι] [DecidableEq ι]

def CongruenceKernelEquivalent (A P : Matrix ι ι R) : Prop :=
  Nonempty (LinearMap.ker (Matrix.toLin' (hermitianCongruence A P)) ≃ₗ[R]
    LinearMap.ker (Matrix.toLin' A))

end Litt3.Deformations.Specifications
