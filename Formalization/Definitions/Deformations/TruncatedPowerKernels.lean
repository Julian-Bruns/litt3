import Definitions.Deformations.TruncatedCoefficientRing
import Mathlib.Algebra.Algebra.Bilinear
import Mathlib.LinearAlgebra.Isomorphisms

namespace Litt3.Deformations

variable (k : Type*) [CommRing k]

/-- Actual multiplication by z^j on the left regular module of
the actual truncated coefficient ring. -/
noncomputable def truncatedPowerMultiplication (N j : ℕ) :
    TruncatedCoefficientRing k N →ₗ[TruncatedCoefficientRing k N]
      TruncatedCoefficientRing k N :=
  LinearMap.mulLeft (TruncatedCoefficientRing k N) (truncatedParameter k N ^ j)

end Litt3.Deformations
