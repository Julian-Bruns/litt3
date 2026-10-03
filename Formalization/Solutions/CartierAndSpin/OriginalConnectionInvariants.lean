import Solutions.CartierAndSpin.FrobeniusLinearDerivations
import Solutions.CartierAndSpin.RestrictedConnectionCharpoly

namespace Litt3.CartierAndSpin

open Polynomial Litt3.SharedTensors

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]
  {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The actual original R-derivation needs NO supplied Kp-linearity.
Its canonical rebasing retains the exact pointwise connection and
derives its characteristic polynomial over literal pth powers. -/
theorem original_normalized_connection_charpoly
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f : K) :
    let Dp := frobeniusLinearDerivation (p := p) D
    letI : Module.Finite (frobeniusSubfield K p) K := Module.Finite.of_basis b.basis
    (scalarDerivationConnection Dp f).charpoly =
      (X : (frobeniusSubfield K p)[X]) ^ p +
        C (actualConnectionCurvature b Dp hDt f) :=
  actual_normalized_connection_charpoly b (frobeniusLinearDerivation D) hDt f

/-- Literal original-field value of the determinant, for ANY original
constant ring and normalized derivation. No Kp-linearity is supplied. -/
theorem original_normalized_connection_det_coe
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f : K) :
    ((LinearMap.det (scalarDerivationConnection
      (frobeniusLinearDerivation (p := p) D) f) : frobeniusSubfield K p) : K) =
      -(D^[p - 1] f + f ^ p) := by
  rw [actual_normalized_connection_det b (frobeniusLinearDerivation D) hDt f]
  rfl

/-- The literal pth-power-field trace of the SAME original pointwise
connection is zero, without a supplied rebasing or scalar model. -/
theorem original_normalized_connection_trace
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f : K) :
    LinearMap.trace (frobeniusSubfield K p) K
      (scalarDerivationConnection (frobeniusLinearDerivation (p := p) D) f) = 0 :=
  actual_normalized_connection_trace b (frobeniusLinearDerivation D) hDt f

end Litt3.CartierAndSpin
