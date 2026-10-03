import Definitions.Deformations.HermitianSchur

namespace Litt3.Deformations

variable {R m n : Type*} [CommRing R] [StarRing R]

def SignedBlockMatrixShape (ε : R) (B : Matrix (m ⊕ n) (m ⊕ n) R) : Prop :=
  B = Matrix.fromBlocks B.toBlocks₁₁ B.toBlocks₁₂ (ε • B.toBlocks₁₂.conjTranspose) B.toBlocks₂₂ ∧
    B.toBlocks₁₁.conjTranspose = ε • B.toBlocks₁₁ ∧
      B.toBlocks₂₂.conjTranspose = ε • B.toBlocks₂₂

end Litt3.Deformations
