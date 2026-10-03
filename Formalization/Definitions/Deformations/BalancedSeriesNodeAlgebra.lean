import Mathlib.RingTheory.MvPowerSeries.Basic
import Mathlib.RingTheory.Ideal.Quotient.Operations

namespace Litt3.Deformations

variable (R : Type*) [CommRing R]

/-- The literal balanced formal-series node relation ideal. -/
noncomputable def balancedSeriesNodeIdeal (Q : ℕ) : Ideal (MvPowerSeries (Fin 2) R) :=
  Ideal.span ({(MvPowerSeries.X 0 : MvPowerSeries (Fin 2) R) ^ Q,
    MvPowerSeries.X 1 ^ Q, MvPowerSeries.X 0 * MvPowerSeries.X 1} :
      Set (MvPowerSeries (Fin 2) R))

abbrev BalancedSeriesNodeAlgebra (Q : ℕ) := MvPowerSeries (Fin 2) R ⧸ balancedSeriesNodeIdeal R Q

end Litt3.Deformations
