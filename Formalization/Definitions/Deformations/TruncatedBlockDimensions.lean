import Definitions.Deformations.TruncatedBlockKernels
import Definitions.Deformations.TruncatedRestriction

namespace Litt3.Deformations

variable {k : Type*} [CommRing k]

abbrev TruncatedCyclicModule (N j : ℕ) :=
  TruncatedCoefficientRing k N ⧸ LinearMap.range (truncatedPowerMultiplication k N j)

end Litt3.Deformations
