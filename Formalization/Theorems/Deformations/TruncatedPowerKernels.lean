import Definitions.Deformations.TruncatedPowerKernels

namespace Litt3.Deformations.Specifications

variable {k : Type*} [CommRing k]

def TruncatedKernelPowerShape (N j : ℕ) : Prop :=
  LinearMap.ker (truncatedPowerMultiplication k N j) =
    LinearMap.range (truncatedPowerMultiplication k N (N - j))

end Litt3.Deformations.Specifications
