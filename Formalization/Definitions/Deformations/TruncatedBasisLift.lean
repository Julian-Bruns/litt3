import Definitions.Deformations.TruncatedCoefficientRing
import Definitions.Deformations.RectangularCongruenceKernels
import Definitions.Deformations.TruncatedResidueSymmetry
import Mathlib.LinearAlgebra.Matrix.Basis

namespace Litt3.Deformations

open Module

variable {k V m n : Type*} [CommRing k] [AddCommGroup V] [Module k V]
variable [Fintype m] [DecidableEq m] [Fintype n] [DecidableEq n]

/-- The actual constant lift of the complete transition matrix
between two genuine bases, retaining their different index types. -/
noncomputable def truncatedBasisMatrix (N : ℕ) (b : Basis m k V) (c : Basis n k V) :
    Matrix m n (TruncatedCoefficientRing k N) :=
  (b.toMatrix c).map (algebraMap k (TruncatedCoefficientRing k N))

end Litt3.Deformations
