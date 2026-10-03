import Definitions.Jacobians.ValuationDivisors
import Mathlib.Algebra.Module.Equiv.Basic

namespace Litt3.SharedTensors

open Litt3.Jacobians
open scoped WithZero

variable {F M : Type*} [Field F] [AddCommGroup M] [Module F M]

/-- The actual nonzero coefficient in a genuine rank-one linear coordinate.
The coefficient is in the ORIGINAL field, not a completed extension. -/
noncomputable def nonzeroLineCoordinateUnit
    (e : M ≃ₗ[F] F) (omega : M) (h : omega ≠ 0) : Fˣ :=
  Units.mk0 (e omega) (by
    intro he
    exact h (e.injective (he.trans (map_zero e).symm)))

/-- The normalized order of the original nonzero vector in a genuine
coordinate. Coordinate independence for an integral local frame is proved
separately; arbitrary field coordinates need not have the same order. -/
noncomputable def rationalLineOrder (v : Valuation F ℤᵐ⁰)
    (e : M ≃ₗ[F] F) (omega : M) (h : omega ≠ 0) : ℤ :=
  valuationOrder v (Additive.ofMul (nonzeroLineCoordinateUnit e omega h))

end Litt3.SharedTensors
