import Solutions.CartierAndSpin.LaurentEndpointBounds
import Mathlib.RingTheory.PowerSeries.Inverse

namespace Litt3.CartierAndSpin

open Polynomial

variable {k : Type*} [Field k]

/-- Nonnegative literal Laurent order is exactly membership in the
original power-series ring. Zero series and infinite order are included. -/
theorem laurent_regular_iff_power_series (f : LaurentSeries k) :
    (0 : WithTop ℤ) ≤ f.orderTop ↔
      ∃ a : PowerSeries k, algebraMap (PowerSeries k) (LaurentSeries k) a = f := by
  constructor
  · intro hf
    by_cases hzero : f = 0
    · exact ⟨0, by simp [hzero]⟩
    have horder : 0 ≤ f.order := by
      apply WithTop.coe_le_coe.mp
      simpa only [HahnSeries.order_eq_orderTop_of_ne_zero hzero] using hf
    refine ⟨PowerSeries.X ^ f.order.toNat * f.powerSeriesPart, ?_⟩
    exact LaurentSeries.X_order_mul_powerSeriesPart (by omega)
  · rintro ⟨a, rfl⟩
    apply Litt3.QuotientGeometry.laurent_orderTop_lower_bound_of_coefficients
    intro n hn
    change ((a : PowerSeries k) : LaurentSeries k).coeff n = 0
    simp only [PowerSeries.coeff_coe, if_pos hn]

/-- A polynomial whose actual Laurent coefficients are all regular is
literally the image of a polynomial over the original power-series ring. -/
theorem laurent_regular_polynomial_descends (P : (LaurentSeries k)[X])
    (hP : ∀ j : ℕ, (0 : WithTop ℤ) ≤ (P.coeff j).orderTop) :
    ∃ P0 : (PowerSeries k)[X],
      P0.map (algebraMap (PowerSeries k) (LaurentSeries k)) = P := by
  classical
  choose a ha using fun j => (laurent_regular_iff_power_series (P.coeff j)).mp (hP j)
  refine ⟨∑ j ∈ P.support, C (a j) * X ^ j, ?_⟩
  simp only [Polynomial.map_sum, Polynomial.map_mul, Polynomial.map_C,
    Polynomial.map_pow, Polynomial.map_X, ha]
  exact P.sum_C_mul_X_pow_eq

/-- A coefficient of exact Laurent order zero is a unit in the original
power-series ring, so it can certify primitive content without being the
leading coefficient. -/
theorem power_series_isUnit_of_laurent_order_zero (a : PowerSeries k)
    (horder : (algebraMap (PowerSeries k) (LaurentSeries k) a).orderTop =
      (0 : WithTop ℤ)) : IsUnit a := by
  apply PowerSeries.isUnit_iff_constantCoeff.mpr
  apply isUnit_iff_ne_zero.mpr
  have hnonzero : algebraMap (PowerSeries k) (LaurentSeries k) a ≠ 0 := by
    intro hz
    simp only [hz, HahnSeries.orderTop_zero] at horder
    exact WithTop.top_ne_coe horder
  have hzeroorder : (algebraMap (PowerSeries k) (LaurentSeries k) a).order = 0 := by
    apply WithTop.coe_eq_coe.mp
    exact (HahnSeries.order_eq_orderTop_of_ne_zero hnonzero).trans horder
  have hcoef := HahnSeries.coeff_order_ne_zero hnonzero
  rw [hzeroorder] at hcoef
  change ((a : PowerSeries k) : LaurentSeries k).coeff 0 ≠ 0 at hcoef
  have hcoefficient : ((a : PowerSeries k) : LaurentSeries k).coeff 0 =
      PowerSeries.coeff 0 a := by
    simpa only [Nat.cast_zero] using LaurentSeries.coeff_coe_powerSeries a 0
  rw [hcoefficient] at hcoef
  simpa only [PowerSeries.coeff_zero_eq_constantCoeff] using hcoef

end Litt3.CartierAndSpin
