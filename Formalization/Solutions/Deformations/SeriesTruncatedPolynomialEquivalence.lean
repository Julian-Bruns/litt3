import Solutions.Deformations.SeriesVariablePowerKernel
import Mathlib.RingTheory.Ideal.Quotient.Operations

namespace Litt3.Deformations

variable (R : Type*) [CommRing R] (d : ℕ)

/-- Actual polynomials keep every surviving original coefficient under
the literal formal-series projection. -/
theorem truncated_monomial_series_projection_polynomial (q : Fin d → ℕ)
    (positive : ∀ i, 0 < q i) (f : MvPolynomial (Fin d) R) :
    truncatedMonomialSeriesProjection R (Fin d) q positive (f : MvPowerSeries (Fin d) R) =
      Ideal.Quotient.mk (truncatedMonomialIdeal R (Fin d) q) f := by
  classical
  letI : DecidableEq (Fin d) := Classical.decEq _
  apply (truncated_monomial_quotient_eq_iff R (Fin d) q _ _).mpr
  intro a survives
  rw [MvPowerSeries.coeff_trunc',
    if_pos ((original_truncation_rectangle_bound (Fin d) q positive a).mpr survives),
    MvPolynomial.coeff_coe]

/-- Every actual original polynomial quotient class is realized by a
genuine formal power series, without a supplied completion equivalence. -/
theorem truncated_monomial_series_projection_surjective (q : Fin d → ℕ)
    (positive : ∀ i, 0 < q i) :
    Function.Surjective (truncatedMonomialSeriesProjection R (Fin d) q positive) := by
  intro x
  obtain ⟨f, rfl⟩ := Ideal.Quotient.mk_surjective x
  exact ⟨(f : MvPowerSeries (Fin d) R),
    truncated_monomial_series_projection_polynomial R d q positive f⟩

/-- The actual finite series projection preserves the coefficient
algebra maps, before constructing the genuine quotient equivalence. -/
noncomputable def truncatedMonomialSeriesProjectionAlg (q : Fin d → ℕ)
    (positive : ∀ i, 0 < q i) :
    MvPowerSeries (Fin d) R →ₐ[R] TruncatedMonomialAlgebra R (Fin d) q where
  __ := truncatedMonomialSeriesProjection R (Fin d) q positive
  commutes' r := by
    classical
    change truncatedMonomialSeriesProjectionFun R (Fin d) q (MvPowerSeries.C r) = _
    simp only [truncatedMonomialSeriesProjectionFun, MvPowerSeries.trunc'_C]
    rfl

/-- The literal multivariate formal-series quotient by the original
unequal powers is genuinely equivalent to the actual polynomial
quotient, uniformly over every commutative coefficient ring. -/
noncomputable def seriesTruncatedPolynomialEquiv (q : Fin d → ℕ) (positive : ∀ i, 0 < q i) :
    (MvPowerSeries (Fin d) R ⧸ seriesVariablePowerIdeal R d q) ≃ₐ[R]
      TruncatedMonomialAlgebra R (Fin d) q :=
  (Ideal.quotientEquivAlgOfEq R (series_variable_power_ideal_kernel R d q positive)).trans
    (Ideal.quotientKerAlgEquivOfSurjective
      (f := truncatedMonomialSeriesProjectionAlg R d q positive)
      (truncated_monomial_series_projection_surjective R d q positive))

end Litt3.Deformations
