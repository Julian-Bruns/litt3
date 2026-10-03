import Definitions.Deformations.TruncatedMonomialSeries
import Solutions.Deformations.TruncatedMonomialCoefficients

namespace Litt3.Deformations

variable (R I : Type*) [CommRing R] [Fintype I]

theorem original_truncation_rectangle_bound (q : I → ℕ) (positive : ∀ i, 0 < q i)
    (a : I →₀ ℕ) : a ≤ originalTruncationRectangle I q ↔ ∀ i, a i < q i := by
  change (∀ i, a i ≤ q i - 1) ↔ _
  exact forall_congr' (fun i => by have := positive i; omega)

/-- The literal formal-series finite projection is a genuine ring map:
actual multiplication respects every surviving original coefficient. -/
noncomputable def truncatedMonomialSeriesProjection (q : I → ℕ) (positive : ∀ i, 0 < q i) :
    MvPowerSeries I R →+* TruncatedMonomialAlgebra R I q where
  toFun := truncatedMonomialSeriesProjectionFun R I q
  map_zero' := by simp [truncatedMonomialSeriesProjectionFun]
  map_one' := by simp [truncatedMonomialSeriesProjectionFun]
  map_add' f g := by simp [truncatedMonomialSeriesProjectionFun]
  map_mul' f g := by
    classical
    change Ideal.Quotient.mk _ (MvPowerSeries.trunc' R (originalTruncationRectangle I q) (f * g)) =
      Ideal.Quotient.mk _ (MvPowerSeries.trunc' R (originalTruncationRectangle I q) f) *
        Ideal.Quotient.mk _ (MvPowerSeries.trunc' R (originalTruncationRectangle I q) g)
    rw [← map_mul]
    apply (truncated_monomial_quotient_eq_iff R I q _ _).mpr
    intro a survives
    have bound := (original_truncation_rectangle_bound I q positive a).mpr survives
    rw [MvPowerSeries.coeff_trunc', if_pos bound]
    exact MvPowerSeries.coeff_mul_eq_coeff_trunc'_mul_trunc' _ f g bound

/-- Its full kernel retains exactly the genuinely surviving original
formal-series coefficients, rather than an assumed quotient basis. -/
theorem truncated_monomial_series_projection_zero_iff (q : I → ℕ) (positive : ∀ i, 0 < q i)
    (f : MvPowerSeries I R) :
    truncatedMonomialSeriesProjection R I q positive f = 0 ↔
      ∀ a : I →₀ ℕ, (∀ i, a i < q i) → MvPowerSeries.coeff a f = 0 := by
  classical
  change Ideal.Quotient.mk _ (MvPowerSeries.trunc' R (originalTruncationRectangle I q) f) = 0 ↔ _
  rw [← map_zero (Ideal.Quotient.mk (truncatedMonomialIdeal R I q)),
    truncated_monomial_quotient_eq_iff]
  apply forall_congr'
  intro a
  apply imp_congr_right
  intro survives
  rw [MvPowerSeries.coeff_trunc',
    if_pos ((original_truncation_rectangle_bound I q positive a).mpr survives), MvPolynomial.coeff_zero]

end Litt3.Deformations
