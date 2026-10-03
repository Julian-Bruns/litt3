import Definitions.Deformations.TruncatedValuation

namespace Litt3.Deformations.Specifications

variable {k : Type*} [Field k]

def TruncatedScalarValuation (N : ℕ) : Prop :=
  ∀ x : TruncatedCoefficientRing k N, x ≠ 0 → HasTruncatedValuation N x

end Litt3.Deformations.Specifications
