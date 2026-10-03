import Definitions.Deformations.TruncatedCoefficientRing

namespace Litt3.Deformations

variable {k : Type*} [Field k]

/-- A genuine algebra endomorphism whose actual parameter image
is a unit times the actual parameter. -/
def IsTruncatedCoordinateChange (N : ℕ)
    (φ : TruncatedCoefficientRing k N →ₐ[k] TruncatedCoefficientRing k N) : Prop :=
  ∃ v : (TruncatedCoefficientRing k N)ˣ,
    φ (truncatedParameter k N) = truncatedParameter k N * v

end Litt3.Deformations
