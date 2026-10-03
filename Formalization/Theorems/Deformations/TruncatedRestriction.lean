import Definitions.Deformations.TruncatedRestriction

namespace Litt3.Deformations.Specifications

variable {k : Type*} [CommRing k]

def TruncatedRestrictionKernel (N j : ℕ) (bound : j ≤ N) : Prop :=
  LinearMap.ker (truncatedRestriction k N j bound).toLinearMap =
    LinearMap.range (truncatedPowerCoefficientMap k N j)

end Litt3.Deformations.Specifications
