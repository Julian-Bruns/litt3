import Definitions.Deformations.TruncatedResidueSymmetry

namespace Litt3.Deformations

variable {k ι κ : Type*} [CommRing k]

def TruncatedMatrixResidueZeroDivisible (N : ℕ) (positive : 0 < N) : Prop :=
  ∀ B : Matrix ι κ (TruncatedCoefficientRing k N),
    truncatedResidueMatrix k N positive B = 0 ↔
      ∃ B' : Matrix ι κ (TruncatedCoefficientRing k N), B = truncatedParameter k N • B'

end Litt3.Deformations
