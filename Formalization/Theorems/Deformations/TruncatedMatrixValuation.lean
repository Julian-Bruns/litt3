import Definitions.Deformations.TruncatedMatrixValuation

namespace Litt3.Deformations.Specifications

variable {k ι κ : Type*} [CommRing k]

def TruncatedMatrixValuation (N : ℕ) (positive : 0 < N) : Prop :=
  ∀ A : Matrix ι κ (TruncatedCoefficientRing k N),
    A ≠ 0 → HasTruncatedMatrixValuation N positive A

end Litt3.Deformations.Specifications
