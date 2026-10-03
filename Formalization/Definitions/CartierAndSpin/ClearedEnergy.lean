import Mathlib.RingTheory.Derivation.Basic

namespace Litt3.CartierAndSpin

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]

/-- The source-center expression with its center denominator cleared;
it is defined at every coefficient boundary. -/
def clearedDifferentialExpression (D : Derivation R K K) (energy q tau s c : K) : K :=
  s * energy - 2 * D q / tau * (s * D c - c * D s)

end Litt3.CartierAndSpin
