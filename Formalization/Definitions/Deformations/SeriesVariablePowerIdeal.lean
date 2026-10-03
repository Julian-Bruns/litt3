import Mathlib.RingTheory.MvPowerSeries.Basic
import Mathlib.RingTheory.Ideal.Operations

namespace Litt3.Deformations

variable (R : Type*) [CommRing R] (d : ℕ)

/-- The literal unequal original variable-power ideal in the genuine
multivariate formal power-series ring. -/
noncomputable def seriesVariablePowerIdeal (q : Fin d → ℕ) :
    Ideal (MvPowerSeries (Fin d) R) :=
  Ideal.span (Set.range (fun i => MvPowerSeries.X i ^ q i))

/-- The actual formal factor assigning each removed original monomial
to its first overflowing coordinate. This is a coefficient construction,
not an assumed membership or decomposition statement. -/
noncomputable def seriesFirstOverflowFactor (q : Fin d → ℕ)
    (f : MvPowerSeries (Fin d) R) (i : Fin d) : MvPowerSeries (Fin d) R := by
  classical
  exact fun a => if ∀ j : Fin d, j < i → a j < q j then
    MvPowerSeries.coeff (a + Finsupp.single i (q i)) f else 0

end Litt3.Deformations
