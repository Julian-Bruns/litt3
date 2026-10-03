import Definitions.Deformations.TruncatedMatrixDivisibility

namespace Litt3.Deformations.Specifications

variable {k ι κ : Type*} [CommRing k]

def TruncatedMatrixDivisibility (N : ℕ) (positive : 0 < N) : Prop :=
  TruncatedMatrixResidueZeroDivisible (k := k) (ι := ι) (κ := κ) N positive

end Litt3.Deformations.Specifications
