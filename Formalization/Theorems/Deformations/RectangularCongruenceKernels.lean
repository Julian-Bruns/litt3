import Definitions.Deformations.RectangularCongruenceKernels

namespace Litt3.Deformations.Specifications

variable {R m n : Type*} [CommRing R] [StarRing R]
variable [Fintype m] [DecidableEq m] [Fintype n] [DecidableEq n]

def RectangularCongruenceKernelEquivalent (A : Matrix m m R) (P : Matrix m n R) : Prop :=
  Nonempty (LinearMap.ker (Matrix.toLin' (P.conjTranspose * A * P)) ≃ₗ[R]
    LinearMap.ker (Matrix.toLin' A))

end Litt3.Deformations.Specifications
