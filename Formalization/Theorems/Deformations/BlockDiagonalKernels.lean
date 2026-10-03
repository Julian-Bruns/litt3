import Definitions.Deformations.BlockDiagonalKernels

namespace Litt3.Deformations.Specifications

variable {R m n : Type*} [CommRing R]
variable [Fintype m] [DecidableEq m] [Fintype n] [DecidableEq n]

def BlockDiagonalKernelEquivalent (A : Matrix m m R) (B : Matrix n n R) : Prop :=
  Nonempty (LinearMap.ker (Matrix.toLin' (blockDiagonalMatrix A B)) ≃ₗ[R]
    (LinearMap.ker (Matrix.toLin' A) × LinearMap.ker (Matrix.toLin' B)))

end Litt3.Deformations.Specifications
