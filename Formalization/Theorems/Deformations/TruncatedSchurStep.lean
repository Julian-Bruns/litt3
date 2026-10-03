import Definitions.Deformations.TruncatedSchurStep

namespace Litt3.Deformations.Specifications

variable {k m n : Type*} [CommRing k]
variable [Fintype m] [DecidableEq m] [Fintype n] [DecidableEq n]

def TruncatedSchurHigherValuationStep (N e : ℕ)
    (A : Matrix (m ⊕ n) (m ⊕ n) (TruncatedCoefficientRing k N)) : Prop :=
  HasTruncatedSchurStep N e A

end Litt3.Deformations.Specifications
