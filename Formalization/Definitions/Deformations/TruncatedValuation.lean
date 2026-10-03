import Definitions.Deformations.TruncatedCoefficientRing
import Mathlib.Algebra.Polynomial.Degree.TrailingDegree

namespace Litt3.Deformations

variable {k : Type*} [Field k]

/-- Actual scalar normal form: a parameter power followed by an
actual unit, with its exponent strictly below the quotient length. -/
def HasTruncatedValuation (N : ℕ) (x : TruncatedCoefficientRing k N) : Prop :=
  ∃ j : ℕ, j < N ∧ ∃ u : (TruncatedCoefficientRing k N)ˣ,
    x = truncatedParameter k N ^ j * u

end Litt3.Deformations
