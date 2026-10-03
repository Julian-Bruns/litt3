import Solutions.Jacobians.PowerSeriesRoots
import Solutions.QuotientGeometry.LaurentUnitOrders

namespace Litt3.QuotientGeometry

/-- A prime-to-characteristic root exists in the actual Laurent field
whenever the actual order is divisible by its exponent. Its order is
the exact quotient; the entire unit tail is lifted, not truncated. -/
theorem laurent_prime_to_characteristic_root
    {k : Type*} [Field k] [IsAlgClosed k] (h : ℕ) (hh : 0 < h) (hchar : (h : k) ≠ 0)
    (β : LaurentSeries k) (hβ : β ≠ 0) (d : ℤ) (horder : β.order = (h : ℤ) * d) :
    ∃ ψ : LaurentSeries k, ψ ^ h = β ∧ ψ.order = d := by
  have hc : PowerSeries.constantCoeff β.powerSeriesPart ≠ 0 := by
    simpa only [← PowerSeries.coeff_zero_eq_constantCoeff, LaurentSeries.powerSeriesPart_coeff,
      Nat.cast_zero, add_zero] using HahnSeries.coeff_order_ne_zero hβ
  obtain ⟨w, hw, hunit⟩ := Litt3.Jacobians.power_series_unit_nth_root h hh hchar β.powerSeriesPart hc
  have hwconstant : PowerSeries.constantCoeff w ≠ 0 :=
    isUnit_iff_ne_zero.mp (hunit.map PowerSeries.constantCoeff)
  have hwne : (w : LaurentSeries k) ≠ 0 := by
    intro hz
    have hzcoeff := congrArg (fun f : LaurentSeries k => f.coeff 0) hz
    apply hwconstant
    simpa [PowerSeries.coeff_coe] using hzcoeff
  refine ⟨HahnSeries.single d 1 * (w : LaurentSeries k), ?_, ?_⟩
  · rw [mul_pow, HahnSeries.single_pow, ← PowerSeries.coe_pow, hw]
    have hsingle : (HahnSeries.single (h • d) ((1 : k) ^ h) : LaurentSeries k) =
        HahnSeries.single β.order 1 := by
      simp [horder, nsmul_eq_mul]
    rw [hsingle, LaurentSeries.single_order_mul_powerSeriesPart]
  · rw [HahnSeries.order_mul (HahnSeries.single_ne_zero one_ne_zero) hwne,
      HahnSeries.order_single one_ne_zero, power_series_coe_unit_order w hwconstant, add_zero]

end Litt3.QuotientGeometry
