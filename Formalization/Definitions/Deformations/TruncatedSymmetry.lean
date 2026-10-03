import Definitions.Deformations.TruncatedRestriction
import Definitions.Deformations.TruncatedReflection
import Mathlib.LinearAlgebra.Matrix.ConjTranspose

namespace Litt3.Deformations

variable (k : Type*) [CommRing k]

/-- Entrywise actual reduction of a matrix over the truncated
coefficient algebra. -/
noncomputable def truncatedMatrixRestriction {ι κ : Type*}
    (N j : ℕ) (bound : j ≤ N)
    (A : Matrix ι κ (TruncatedCoefficientRing k N)) :
    Matrix ι κ (TruncatedCoefficientRing k j) :=
  A.map (truncatedRestriction k N j bound)

end Litt3.Deformations
