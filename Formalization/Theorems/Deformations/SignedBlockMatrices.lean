import Definitions.Deformations.SignedBlockMatrices

namespace Litt3.Deformations.Specifications

variable {R m n : Type*} [CommRing R] [StarRing R]

def SignedBlockShape (ε : R) (B : Matrix (m ⊕ n) (m ⊕ n) R) : Prop :=
  SignedBlockMatrixShape ε B

end Litt3.Deformations.Specifications
