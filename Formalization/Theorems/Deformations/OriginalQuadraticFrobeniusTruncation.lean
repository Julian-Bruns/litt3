import Definitions.Deformations.SeriesVariablePowerIdeal
import Mathlib.RingTheory.MvPowerSeries.Inverse
import Mathlib.RingTheory.LocalRing.MaximalIdeal.Basic
import Mathlib.LinearAlgebra.Dimension.Finrank

namespace Litt3.Deformations.Specifications

variable (K : Type*) [Field K] (d p n : ℕ) (q : Fin d → ℕ)

/-- Exact selected-quadratic clause for the ORIGINAL arbitrary formal
hypersurface with all unchanged unequal variable powers. Its order and
quadratic coefficient are actual original-series inputs. -/
def OriginalQuadraticFrobeniusTruncationLength : Prop :=
  ∀ f : MvPowerSeries (Fin (d + 1)) K,
    f ∈ IsLocalRing.maximalIdeal (MvPowerSeries (Fin (d + 1)) K) ^ 2 →
    MvPowerSeries.coeff (Finsupp.single 0 2) f ≠ 0 →
    Module.finrank K (MvPowerSeries (Fin (d + 1)) K ⧸
      (seriesVariablePowerIdeal K (d + 1) (Fin.cons (p ^ n) q) ⊔ Ideal.span ({f} : Set _))) =
        2 * ∏ i, q i

end Litt3.Deformations.Specifications
