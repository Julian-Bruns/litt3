import Solutions.Deformations.SeriesTruncatedPolynomialEquivalence
import Solutions.Deformations.TruncatedMonomialDimensions

namespace Litt3.Deformations

variable (K : Type*) [Field K] (d : ℕ)

/-- The actual formal-series quotient by the original unequal variable
powers has exactly the product length, using its constructed algebra
equivalence and the genuine unchanged finite monomial basis. -/
theorem series_truncated_finrank (q : Fin d → ℕ) (positive : ∀ i, 0 < q i) :
    Module.finrank K (MvPowerSeries (Fin d) K ⧸ seriesVariablePowerIdeal K d q) =
      ∏ i, q i := by
  rw [(seriesTruncatedPolynomialEquiv K d q positive).toLinearEquiv.finrank_eq,
    truncated_monomial_finrank K (Fin d) q]

end Litt3.Deformations
