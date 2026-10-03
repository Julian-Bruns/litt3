import Definitions.Deformations.TruncatedSubstitution

namespace Litt3.Deformations.Specifications

variable {k : Type*} [Field k] [Invertible (2 : k)]

def TruncatedSkewCoordinateBijective (N : ℕ) : Prop :=
  ∀ u : (TruncatedCoefficientRing k N)ˣ,
    (u : TruncatedCoefficientRing k N) = 1 + truncatedParameter k N →
      ∀ relation : cyclicSkewCoordinate u ^ N = 0,
        Function.Bijective (truncatedSubstitution k N (cyclicSkewCoordinate u) relation)

end Litt3.Deformations.Specifications
