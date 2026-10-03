import Definitions.Deformations.TruncatedCongruenceLifting

namespace Litt3.Deformations.Specifications

variable {k ι : Type*} [CommRing k] [Fintype ι] [DecidableEq ι]

def TruncatedCongruenceLifting (N e : ℕ)
    (A D : Matrix ι ι (TruncatedCoefficientRing k N)) : Prop :=
  TruncatedCongruenceLifts N e A D

end Litt3.Deformations.Specifications
