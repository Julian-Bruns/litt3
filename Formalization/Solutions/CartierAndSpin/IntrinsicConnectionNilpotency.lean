import Solutions.CartierAndSpin.OriginalConnectionNilpotency
import Solutions.CartierAndSpin.IntrinsicCartierRestrictedConnections

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k K : Type*} [CommRing k] [Field K] [Algebra k K]
  {p : ℕ} [Fact p.Prime] [CharP K p]

/-- Fixedness of the ORIGINAL universal rational form has the exact
whole-operator nilpotency exponent p, not just an upper bound or a
supplied p-curvature condition. -/
theorem p_basis_intrinsic_cartier_fixed_iff_exact_connection_nilpotency
    (C : RationalCartierOperator k K p) (b : PowerPBasis K p)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (he : e (KaehlerDifferential.D k K b.parameter) = 1)
    (omega : KaehlerDifferential k K) :
    C.toAddHom omega = omega ↔
      (scalarDerivationConnection (universalCoordinateDerivation e) (e omega)) ^ p = 0 ∧
      ∀ n : ℕ, n < p →
        (scalarDerivationConnection (universalCoordinateDerivation e) (e omega)) ^ n ≠ 0 := by
  constructor
  · intro hfixed
    exact original_normalized_connection_exact_nilpotency b
      (universalCoordinateDerivation e) he (e omega)
      ((p_basis_intrinsic_cartier_fixed_iff_restricted_curvature_zero C b e he omega).mp hfixed)
  · intro hnil
    apply (p_basis_intrinsic_cartier_fixed_iff_connection_nilpotent C b e he omega).mpr
    intro a
    simpa only [Module.End.pow_apply, LinearMap.zero_apply] using
      congrArg (fun P : Module.End k K => P a) hnil.1

end Litt3.CartierAndSpin
