import Definitions.Deformations.TruncatedPowerKernels
import Mathlib.LinearAlgebra.Matrix.ToLinearEquiv
import Mathlib.LinearAlgebra.Pi

namespace Litt3.Deformations

variable (k : Type*) [CommRing k]

/-- Actual coordinatewise parameter multiplication on a full
free module over the actual truncated coefficient ring. -/
noncomputable def truncatedCoordinatePowerMap (N j : ℕ) (ι : Type*) :
    (ι → TruncatedCoefficientRing k N) →ₗ[TruncatedCoefficientRing k N]
      (ι → TruncatedCoefficientRing k N) :=
  LinearMap.pi fun i => (truncatedPowerMultiplication k N j).comp (LinearMap.proj i)

end Litt3.Deformations
