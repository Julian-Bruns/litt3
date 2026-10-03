import Definitions.Deformations.TruncatedSchurRemainder

namespace Litt3.Deformations.Specifications

variable {k m n : Type*} [CommRing k]
variable [Fintype m] [Fintype n] [DecidableEq n]

def TruncatedSchurZeroResidue (N : ℕ) (positive : 0 < N)
    (G : Matrix m m (TruncatedCoefficientRing k N))
    (D : Matrix m n (TruncatedCoefficientRing k N))
    (F : Matrix n n (TruncatedCoefficientRing k N)) : Prop :=
  TruncatedSchurRemainderResidueZero N positive G D F

end Litt3.Deformations.Specifications
