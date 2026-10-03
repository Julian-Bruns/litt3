import Definitions.Deformations.TruncatedMatrixValuation

namespace Litt3.Deformations

variable (k : Type*) [CommRing k]

/-- The actual reflected transpose, defined directly by the
actual quotient reflection independently of a chosen star instance. -/
noncomputable def truncatedHermitianTranspose {ι κ : Type*} (N : ℕ)
    (A : Matrix ι κ (TruncatedCoefficientRing k N)) :
    Matrix κ ι (TruncatedCoefficientRing k N) :=
  (A.map (truncatedReflection k N)).transpose

end Litt3.Deformations
