import Definitions.Deformations.HermitianCyclicKernel
import Mathlib.LinearAlgebra.BilinearMap

namespace Litt3.Deformations

variable (k : Type*) [CommRing k]

/-- The actual parameter-power action on any module over
the actual truncated algebra. -/
noncomputable def truncatedModulePowerMap (N s : ℕ) (M : Type*)
    [AddCommGroup M] [Module (TruncatedCoefficientRing k N) M] :
    M →ₗ[TruncatedCoefficientRing k N] M :=
  LinearMap.lsmul (TruncatedCoefficientRing k N) M (truncatedParameter k N ^ s)

end Litt3.Deformations
