import Theorems.Deformations.PairedMinimalHermitian

namespace Litt3.Deformations.Specifications

variable {k ι : Type*} [CommRing k] [Fintype ι] [DecidableEq ι]

def MixedHermitianModel (N : ℕ) (A H : Matrix ι ι (TruncatedCoefficientRing k N)) : Prop :=
  H * truncatedMatrixReflection N A = A.transpose * H.conjTranspose →
    IsUnit H → PairedMinimalHermitianModel N A

end Litt3.Deformations.Specifications
