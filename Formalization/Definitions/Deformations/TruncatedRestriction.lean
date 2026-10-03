import Definitions.Deformations.TruncatedPowerKernels

namespace Litt3.Deformations

open Polynomial

variable (k : Type*) [CommRing k]

/-- The actual algebra quotient map from length N to length j. -/
noncomputable def truncatedRestriction (N j : ℕ) (bound : j ≤ N) :
    TruncatedCoefficientRing k N →ₐ[k] TruncatedCoefficientRing k j :=
  AdjoinRoot.algHomOfDvd k ((X : Polynomial k) ^ N) (X ^ j)
    (pow_dvd_pow X bound)

/-- Multiplication by z^j viewed as an endomorphism over the
coefficient ring, retaining the actual quotient algebra. -/
noncomputable def truncatedPowerCoefficientMap (N j : ℕ) :
    TruncatedCoefficientRing k N →ₗ[k] TruncatedCoefficientRing k N :=
  (truncatedPowerMultiplication k N j).restrictScalars k

end Litt3.Deformations
