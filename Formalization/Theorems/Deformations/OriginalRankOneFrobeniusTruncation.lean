import Theorems.Deformations.OriginalQuadraticFrobeniusTruncation

namespace Litt3.Deformations.Specifications

variable (K : Type*) [Field K] (p n T : ℕ)

/-- The ORIGINAL rank-one plane quadratic clause with arbitrary higher
terms and all three actual displayed powers. In odd characteristic a
nonzero rank-one binary quadratic has a nonzero diagonal coefficient. -/
def OriginalRankOneFrobeniusTruncationLength : Prop :=
  ∀ f : MvPowerSeries (Fin 3) K,
    f ∈ IsLocalRing.maximalIdeal (MvPowerSeries (Fin 3) K) ^ 2 →
    MvPowerSeries.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) f ^ 2 =
      4 * MvPowerSeries.coeff (Finsupp.single 0 2) f *
        MvPowerSeries.coeff (Finsupp.single 1 2) f →
    (MvPowerSeries.coeff (Finsupp.single 0 2) f ≠ 0 ∨
      MvPowerSeries.coeff (Finsupp.single 1 2) f ≠ 0) →
    Module.finrank K (MvPowerSeries (Fin 3) K ⧸
      (seriesVariablePowerIdeal K 3 (Fin.cons (p ^ n) ![p ^ n, T]) ⊔
        Ideal.span ({f} : Set _))) = 2 * p ^ n * T

end Litt3.Deformations.Specifications
