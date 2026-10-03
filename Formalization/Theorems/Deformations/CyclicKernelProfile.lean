import Definitions.Deformations.CyclicKernelProfile

namespace Litt3.Deformations.Specifications

variable {k : Type*} [Field k]

def CyclicPowerKernelDimension (N j s : ℕ) : Prop :=
  Module.finrank k (LinearMap.ker
    (truncatedModulePowerMap k N s (TruncatedCyclicModule (k := k) N j))) = min s j

end Litt3.Deformations.Specifications
