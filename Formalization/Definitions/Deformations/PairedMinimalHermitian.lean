import Definitions.Deformations.MinimalComplex
import Definitions.Deformations.TruncatedSubstitution
import Solutions.Deformations.TruncatedReflection
import Definitions.Deformations.TruncatedResidueSymmetry

namespace Litt3.Deformations

variable {k ι : Type*} [CommRing k] [Fintype ι] [DecidableEq ι]

noncomputable def truncatedMatrixReflection (N : ℕ)
    (A : Matrix ι ι (TruncatedCoefficientRing k N)) :=
  A.map (truncatedReflection k N)

noncomputable def strictMixedPairing [Invertible (2 : k)] (N : ℕ)
    (H J : Matrix ι ι (TruncatedCoefficientRing k N)) :=
  letI := truncatedInvertibleTwo (k := k) N
  (⅟ (2 : TruncatedCoefficientRing k N)) • (H - J.conjTranspose)

/-- Actual homotopy-equivalence components and the actual
matrix homotopy expressing skew symmetry of a minimal
two-term pairing. No Hermitian differential is assumed. -/
structure MinimalSkewPairingData (N : ℕ) (positive : 0 < N)
    (A : Matrix ι ι (TruncatedCoefficientRing k N)) where
  equivalence : MinimalTwoTermHomotopyEquivalence N positive A (-A.conjTranspose)
  skew_homotopy : Matrix ι ι (TruncatedCoefficientRing k N)
  skew_zero_homotopy : equivalence.f₀.transpose + equivalence.f₁.transpose.conjTranspose =
    A.transpose * skew_homotopy

end Litt3.Deformations
