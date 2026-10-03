import Solutions.Deformations.OriginalQuadraticSeriesOrders
import Definitions.Deformations.TruncatedMonomialSeries
import Solutions.Deformations.TruncatedMonomialSeriesProjection

namespace Litt3.Deformations

variable (K : Type*) [Field K] (I : Type*) [Fintype I] [DecidableEq I]

/-- Every surviving coefficient of the literal rectangular polynomial
retains the original maximal-square order condition. -/
theorem original_series_rectangular_quadratic_support (q : I → ℕ)
    (f : MvPowerSeries I K) (quadratic : f ∈ IsLocalRing.maximalIdeal (MvPowerSeries I K) ^ 2) :
    ∀ a ∈ (MvPowerSeries.trunc' K (originalTruncationRectangle I q) f).support,
      2 ≤ a.degree := by
  classical
  intro a ha
  have coefficient := MvPolynomial.mem_support_iff.mp ha
  rw [MvPowerSeries.coeff_trunc'] at coefficient
  split_ifs at coefficient with survives
  · have order := original_series_maximal_square_order K I f quadratic
    exact ENat.coe_le_coe.mp (order.trans (MvPowerSeries.order_le coefficient))
  · exact (coefficient rfl).elim

/-- Any ORIGINAL coefficient inside the literal rectangle is unchanged
by reduction to the actual truncated polynomial. -/
theorem original_series_rectangular_coefficient (q : I → ℕ) (positive : ∀ i, 0 < q i)
    (f : MvPowerSeries I K) (a : I →₀ ℕ) (survives : ∀ i, a i < q i) :
    MvPolynomial.coeff a (MvPowerSeries.trunc' K (originalTruncationRectangle I q) f) =
      MvPowerSeries.coeff a f := by
  rw [MvPowerSeries.coeff_trunc', if_pos]
  exact (original_truncation_rectangle_bound I q positive a).mpr survives

/-- ORIGINAL coefficient vanishings survive rectangular reduction even
when their monomials lie outside the rectangle. -/
theorem original_series_rectangular_coefficient_zero (q : I → ℕ)
    (f : MvPowerSeries I K) (a : I →₀ ℕ) (zero : MvPowerSeries.coeff a f = 0) :
    MvPolynomial.coeff a (MvPowerSeries.trunc' K (originalTruncationRectangle I q) f) = 0 := by
  rw [MvPowerSeries.coeff_trunc']
  split_ifs <;> simp_all

end Litt3.Deformations
