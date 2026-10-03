import Solutions.CartierAndSpin.LaurentIntegralPolynomials
import Solutions.CartierAndSpin.PowerSeriesNodalBounds

namespace Litt3.CartierAndSpin

open Polynomial

variable {k : Type*} [Field k]

/-- The actual embedding of power series retains each nonnegative
coefficient, rather than merely an abstract valuation. -/
theorem power_series_laurent_coefficient (f : PowerSeries k) (n : ℕ) :
    (f : LaurentSeries k).coeff n = PowerSeries.coeff n f := by
  rw [PowerSeries.coeff_coe, if_neg (by omega), Int.natAbs_natCast]

/-- Exact power-series order and exact Laurent order coincide at
every nonnegative integer, including zero. -/
theorem power_series_laurent_order_iff (f : PowerSeries k) (n : ℕ) :
    (f : LaurentSeries k).orderTop = ((n : ℤ) : WithTop ℤ) ↔
      f.order = n := by
  rw [PowerSeries.order_eq_nat]
  constructor
  · intro hf
    refine ⟨?_, ?_⟩
    · simpa only [power_series_laurent_coefficient] using HahnSeries.coeff_orderTop_ne hf
    · exact fun j hj => power_series_coefficient_zero_of_laurent_order f n j hf.ge hj
  · rintro ⟨hn, hlow⟩
    apply le_antisymm
    · apply HahnSeries.orderTop_le_of_coeff_ne_zero
      simpa only [power_series_laurent_coefficient] using hn
    · exact power_series_laurent_order_lower_bound f n hlow

/-- Every actual integral Laurent series of exact order n descends to
a power series with that exact order and identical coefficients. -/
theorem laurent_exact_order_descends (f : LaurentSeries k) (n : ℕ)
    (hf : f.orderTop = ((n : ℤ) : WithTop ℤ)) :
    ∃ g : PowerSeries k, (g : LaurentSeries k) = f ∧ g.order = n := by
  obtain ⟨g, hg⟩ := laurent_integral_order_descends f
    (by rw [hf]; exact WithTop.coe_le_coe.mpr (Int.natCast_nonneg n))
  refine ⟨g, hg, (power_series_laurent_order_iff g n).mp ?_⟩
  rw [hg, hf]

/-- A unit Laurent leading coefficient descends to a polynomial whose
actual power-series leading coefficient has nonzero residue. -/
theorem laurent_polynomial_unit_leading_descends (H : (LaurentSeries k)[X])
    (hH : ∀ n, (0 : WithTop ℤ) ≤ (H.coeff n).orderTop)
    (hleading : H.leadingCoeff.orderTop = 0) :
    ∃ P : (PowerSeries k)[X],
      P.map (HahnSeries.ofPowerSeries ℤ k) = H ∧
      PowerSeries.constantCoeff P.leadingCoeff ≠ 0 := by
  obtain ⟨P, hP⟩ := laurent_integral_polynomial_descends H hH
  refine ⟨P, hP, ?_⟩
  have hmap : (P.leadingCoeff : LaurentSeries k) = H.leadingCoeff := by
    rw [← hP, Polynomial.leadingCoeff_map_of_injective HahnSeries.ofPowerSeries_injective]
  have hcoeff := HahnSeries.coeff_orderTop_ne
    (show (P.leadingCoeff : LaurentSeries k).orderTop = 0 by rw [hmap, hleading])
  simpa [PowerSeries.coeff_coe] using hcoeff

end Litt3.CartierAndSpin
