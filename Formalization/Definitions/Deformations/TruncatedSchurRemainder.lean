import Definitions.Deformations.TruncatedResidueSymmetry
import Definitions.Deformations.HermitianSchur

namespace Litt3.Deformations

variable {k m n : Type*} [CommRing k]
variable [Fintype m] [Fintype n] [DecidableEq n]

def TruncatedSchurRemainderResidueZero (N : ℕ) (positive : 0 < N)
    (G : Matrix m m (TruncatedCoefficientRing k N))
    (D : Matrix m n (TruncatedCoefficientRing k N))
    (F : Matrix n n (TruncatedCoefficientRing k N)) : Prop :=
  truncatedResidueMatrix k N positive (F - truncatedHermitianTranspose k N D * G * D) = 0 ∧
    truncatedResidueMatrix k N positive (F + truncatedHermitianTranspose k N D * G * D) = 0

end Litt3.Deformations
