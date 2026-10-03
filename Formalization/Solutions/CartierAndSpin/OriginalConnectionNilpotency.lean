import Solutions.CartierAndSpin.RestrictedConnectionNilpotency
import Solutions.CartierAndSpin.FrobeniusLinearDerivations

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]
  {p : ℕ} [Fact p.Prime] [CharP K p]

/-- Every ORIGINAL R-linear connection power below p is nonzero. The
pointwise operator is unchanged by canonical Frobenius rebasing; no
finite-dimensionality over R or supplied Kp-derivation is needed. -/
theorem original_normalized_connection_power_ne_zero_below_characteristic
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f : K) (n : ℕ) (hn : n < p) :
    (scalarDerivationConnection D f) ^ n ≠ 0 := by
  intro hzero
  apply actual_normalized_connection_power_ne_zero_below_characteristic b
    (frobeniusLinearDerivation D) hDt f n hn
  ext a
  rw [Module.End.pow_apply]
  change (scalarDerivationConnection D f)^[n] a = 0
  simpa only [Module.End.pow_apply, LinearMap.zero_apply] using
    congrArg (fun P : Module.End R K => P a) hzero

/-- Curvature zero gives EXACT exponent p for the SAME original
connection, even when its original constant-module dimension is infinite. -/
theorem original_normalized_connection_exact_nilpotency
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f : K)
    (hcurvature : D^[p - 1] f + f ^ p = 0) :
    (scalarDerivationConnection D f) ^ p = 0 ∧
      ∀ n : ℕ, n < p → (scalarDerivationConnection D f) ^ n ≠ 0 := by
  constructor
  · ext a
    rw [Module.End.pow_apply,
      actual_normalized_derivation_restricted_connection_identity b D hDt f,
      hcurvature, neg_zero, zero_mul]
    rfl
  · exact original_normalized_connection_power_ne_zero_below_characteristic b D hDt f

end Litt3.CartierAndSpin
