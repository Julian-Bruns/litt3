import Definitions.Deformations.SignedLeadingSplit

namespace Litt3.Deformations.Specifications

variable {k ι : Type*} [Field k] [Fintype ι] [DecidableEq ι]

def SignedLeadingSplit (N : ℕ) (positive : 0 < N) (e : ℕ)
    (B : Matrix ι ι (TruncatedCoefficientRing k N)) : Prop :=
  Nonempty (SignedLeadingSplitData N positive e B)

end Litt3.Deformations.Specifications
