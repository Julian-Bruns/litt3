import Definitions.SharedTensors.CharacterBlocks
import Mathlib.RingTheory.Derivation.MapCoeffs

namespace Litt3.SharedTensors

open Polynomial

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

/-- The actual coefficientwise derivative of a polynomial. Finite
support is inherited through the zero-preserving linear map. -/
noncomputable def coefficientDifferential (D : K →ₗ[k] K) (F : K[X]) : K[X] :=
  Polynomial.ofFinsupp (F.toFinsupp.mapRange D D.map_zero)

/-- The original affine differential expression, with its literal
polynomial derivative and the exact weight N. -/
noncomputable def affineDifferentialPolynomial (D : K →ₗ[k] K)
    (eta beta : K) (N : ℕ) (F : K[X]) : K[X] :=
  coefficientDifferential D F + (C eta + C beta * X) * derivative F -
    C ((N : K) * beta) * F

end Litt3.SharedTensors
