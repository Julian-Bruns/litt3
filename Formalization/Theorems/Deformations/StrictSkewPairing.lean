import Theorems.Deformations.PairedMinimalHermitian

namespace Litt3.Deformations.Specifications

variable {k ι : Type*} [CommRing k] [Fintype ι] [DecidableEq ι]

def MinimalSkewPairingHermitian (N : ℕ) (positive : 0 < N)
    (A : Matrix ι ι (TruncatedCoefficientRing k N)) : Prop :=
  MinimalSkewPairingData N positive A → PairedMinimalHermitianModel N A

end Litt3.Deformations.Specifications
