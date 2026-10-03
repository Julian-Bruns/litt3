import Definitions.Deformations.TruncatedSymmetry

namespace Litt3.Deformations.Specifications

variable {k : Type*} [CommRing k]

def TruncatedPowerCancellation (N e : ℕ) : Prop :=
  ∀ x y : TruncatedCoefficientRing k N,
    truncatedParameter k N ^ e * x = truncatedParameter k N ^ e * y →
      truncatedRestriction k N (N - e) (Nat.sub_le _ _) x =
        truncatedRestriction k N (N - e) (Nat.sub_le _ _) y

end Litt3.Deformations.Specifications
