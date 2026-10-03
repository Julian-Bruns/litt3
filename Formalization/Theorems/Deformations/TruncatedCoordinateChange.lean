import Definitions.Deformations.TruncatedCoordinateChange

namespace Litt3.Deformations.Specifications

variable {k : Type*} [Field k]

def TruncatedCoordinateChangeBijective (N : ℕ) : Prop :=
  ∀ φ : TruncatedCoefficientRing k N →ₐ[k] TruncatedCoefficientRing k N,
    IsTruncatedCoordinateChange N φ → Function.Bijective φ

end Litt3.Deformations.Specifications
