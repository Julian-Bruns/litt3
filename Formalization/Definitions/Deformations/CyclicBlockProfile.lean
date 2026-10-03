import Definitions.Deformations.CyclicKernelProfile
import Definitions.Deformations.CyclicMultiplicityProfile

namespace Litt3.Deformations

variable {k : Type*} [Field k]

def CyclicBlockProfileIdentity (N s : ℕ) (degree multiplicity : Fin s → ℕ) : Prop :=
  ∀ a, Module.finrank k (LinearMap.ker (truncatedModulePowerMap k N a
    (TruncatedCyclicBlocks k N s degree multiplicity))) =
      cyclicDimensionProfile degree multiplicity a

end Litt3.Deformations
