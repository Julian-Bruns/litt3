import Solutions.Deformations.SeriesTruncatedFiniteness

namespace Litt3.Deformations

variable (R : Type*) [CommRing R] [Nontrivial R] (d : ℕ)

/-- The ORIGINAL unequal-power series quotient has exact free coefficient
rank over every nontrivial commutative ring, not only over fields. -/
theorem series_truncated_free_finrank (q : Fin d → ℕ) (positive : ∀ i, 0 < q i) :
    Module.finrank R (MvPowerSeries (Fin d) R ⧸ seriesVariablePowerIdeal R d q) =
      ∏ i, q i := by
  rw [(seriesTruncatedPolynomialEquiv R d q positive).toLinearEquiv.finrank_eq,
    truncated_monomial_finrank R (Fin d) q]

/-- Every actual quotient retaining the original variable powers has
coefficient rank bounded by their product. The finite-module foundation
is derived internally from the actual original tuple basis. -/
theorem series_quotient_finrank_le_of_variable_powers
    (q : Fin d → ℕ) (positive : ∀ i, 0 < q i)
    (I : Ideal (MvPowerSeries (Fin d) R)) (contains : seriesVariablePowerIdeal R d q ≤ I) :
    Module.finrank R (MvPowerSeries (Fin d) R ⧸ I) ≤ ∏ i, q i := by
  letI := series_truncated_finite R d q positive
  let factor := Ideal.Quotient.factorₐ R contains
  have surjective : Function.Surjective factor := by
    intro b
    obtain ⟨f, rfl⟩ := Ideal.Quotient.mk_surjective b
    exact ⟨Ideal.Quotient.mk (seriesVariablePowerIdeal R d q) f, rfl⟩
  have bound := factor.toLinearMap.finrank_range_le
  rw [LinearMap.range_eq_top.mpr
      (show Function.Surjective factor.toLinearMap from surjective), finrank_top,
    series_truncated_free_finrank R d q positive] at bound
  exact bound

/-- The unchanged original hypersurface has coefficient rank at most
the product of the original positive cutoffs, for ANY full-series f. -/
theorem series_truncated_hypersurface_finrank_le
    (q : Fin d → ℕ) (positive : ∀ i, 0 < q i) (f : MvPowerSeries (Fin d) R) :
    Module.finrank R (MvPowerSeries (Fin d) R ⧸
      (seriesVariablePowerIdeal R d q ⊔ Ideal.span ({f} : Set _))) ≤ ∏ i, q i :=
  series_quotient_finrank_le_of_variable_powers R d q positive _ le_sup_left

end Litt3.Deformations
