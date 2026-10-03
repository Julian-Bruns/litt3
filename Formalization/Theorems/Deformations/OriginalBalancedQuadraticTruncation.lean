import Definitions.Deformations.SeriesVariablePowerIdeal
import Mathlib.RingTheory.MvPowerSeries.Inverse
import Mathlib.RingTheory.LocalRing.MaximalIdeal.Basic
import Mathlib.LinearAlgebra.Dimension.Finrank

namespace Litt3.Deformations.Specifications

variable (K : Type*) [Field K] (p n : ℕ)

/-- Exact balanced binary clause for the ORIGINAL arbitrary formal
hypersurface and its ORIGINAL nondegenerate quadratic plane. The
discriminant uses the literal xy coefficient, without a hidden factor two. -/
def OriginalBalancedQuadraticTruncationLength : Prop :=
  ∀ f : MvPowerSeries (Fin 2) K,
    f ∈ IsLocalRing.maximalIdeal (MvPowerSeries (Fin 2) K) ^ 2 →
    MvPowerSeries.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) f ^ 2 -
      4 * MvPowerSeries.coeff (Finsupp.single 0 2) f *
        MvPowerSeries.coeff (Finsupp.single 1 2) f ≠ 0 →
    Module.finrank K (MvPowerSeries (Fin 2) K ⧸
      (seriesVariablePowerIdeal K 2 (fun _ => p ^ n) ⊔ Ideal.span ({f} : Set _))) =
        2 * p ^ n - 1

end Litt3.Deformations.Specifications
