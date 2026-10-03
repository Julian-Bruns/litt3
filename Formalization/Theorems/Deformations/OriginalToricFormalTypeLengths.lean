import Definitions.Deformations.SeriesVariablePowerIdeal
import Mathlib.RingTheory.Ideal.Quotient.Defs
import Mathlib.LinearAlgebra.Dimension.Finrank

namespace Litt3.Deformations.Specifications

variable (K : Type*) [Field K]

/-- The exact balanced source clause: an actual original formal type,
including its unit, gives both displayed length formulas. No normal-form
existence statement or numerical quotient rank is an input. -/
def OriginalBalancedToricFormalTypeLength (p n s : ℕ) : Prop :=
  ∀ f : MvPowerSeries (Fin 3) K,
    (∃ (e : MvPowerSeries (Fin 3) K ≃ₐ[K] MvPowerSeries (Fin 3) K)
      (u : (MvPowerSeries (Fin 3) K)ˣ),
      e f = (u : MvPowerSeries (Fin 3) K) *
        (MvPowerSeries.X 0 * MvPowerSeries.X 1 + MvPowerSeries.X 2 ^ s)) →
    Module.finrank K (MvPowerSeries (Fin 3) K ⧸
      (seriesVariablePowerIdeal K 3 (fun _ => p ^ n) ⊔ Ideal.span ({f} : Set _))) =
        p ^ n + 2 * ∑ j : Fin (p ^ n - 1), min (p ^ n) (s * (j.val + 1)) ∧
    Module.finrank K (MvPowerSeries (Fin 3) K ⧸
      (seriesVariablePowerIdeal K 3 (fun _ => p ^ n) ⊔ Ideal.span ({f} : Set _))) =
        2 * (p ^ n) ^ 2 - s * (p ^ n / s) ^ 2 -
          (p ^ n % s) * (2 * (p ^ n / s) + 1)

end Litt3.Deformations.Specifications
