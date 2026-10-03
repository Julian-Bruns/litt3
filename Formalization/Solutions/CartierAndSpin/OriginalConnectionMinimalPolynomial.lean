import Solutions.CartierAndSpin.RestrictedConnectionMinimalPolynomial
import Solutions.CartierAndSpin.FrobeniusLinearDerivations

namespace Litt3.CartierAndSpin

open Polynomial Litt3.SharedTensors

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]
  {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The true original R-derivation is canonically rebased, with exactly
the SAME field function. The full connection minimal polynomial follows
without supplying Kp-linearity or a companion matrix. -/
theorem original_normalized_connection_minpoly
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f : K) :
    let Dp := frobeniusLinearDerivation (p := p) D
    minpoly (frobeniusSubfield K p) (scalarDerivationConnection Dp f) =
      (X : (frobeniusSubfield K p)[X]) ^ p + C (actualConnectionCurvature b Dp hDt f) :=
  actual_normalized_connection_minpoly b (frobeniusLinearDerivation D) hDt f

theorem original_normalized_connection_minpoly_degree
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f : K) :
    (minpoly (frobeniusSubfield K p) (scalarDerivationConnection
      (frobeniusLinearDerivation (p := p) D) f)).natDegree = p :=
  actual_normalized_connection_minpoly_degree b (frobeniusLinearDerivation D) hDt f

end Litt3.CartierAndSpin
