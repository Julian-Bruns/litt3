import Mathlib.RingTheory.LaurentSeries
import Mathlib.Tactic

namespace Litt3.QuotientGeometry

theorem power_series_coe_order_nonnegative
    {k : Type*} [Field k] (f : PowerSeries k) : (0 : ℤ) ≤ (f : LaurentSeries k).order := by
  by_cases hf : (f : LaurentSeries k) = 0
  · simp [hf]
  · by_contra h
    have hnegative : (f : LaurentSeries k).order < 0 := by omega
    have hz : (f : LaurentSeries k).coeff (f : LaurentSeries k).order = 0 := by
      simp [PowerSeries.coeff_coe, hnegative]
    exact HahnSeries.coeff_order_ne_zero hf hz

theorem power_series_coe_unit_order
    {k : Type*} [Field k] (f : PowerSeries k) (hf : PowerSeries.constantCoeff f ≠ 0) :
    (f : LaurentSeries k).order = 0 := by
  apply le_antisymm
  · apply HahnSeries.order_le_of_coeff_ne_zero
    simpa [PowerSeries.coeff_coe] using hf
  · exact power_series_coe_order_nonnegative f

theorem laurent_order_inverse
    {k : Type*} [Field k] (f : LaurentSeries k) : f⁻¹.order = -f.order := by
  by_cases hf : f = 0
  · simp [hf]
  · have h := HahnSeries.order_mul hf (inv_ne_zero hf)
    rw [mul_inv_cancel₀ hf, HahnSeries.order_one] at h
    omega

theorem power_series_zero_constant_of_positive_laurent_order
    {k : Type*} [Field k] (f : PowerSeries k)
    (hf : 0 < (f : LaurentSeries k).order) : PowerSeries.constantCoeff f = 0 := by
  by_contra h
  rw [power_series_coe_unit_order f h] at hf
  exact lt_irrefl _ hf

theorem completed_map_parameter_zero_constant
    {k : Type*} [Field k] (φ : PowerSeries k →ₐ[k] PowerSeries k)
    (Ψ : LaurentSeries k →+* LaurentSeries k)
    (hΨ : ∀ r : PowerSeries k, Ψ (r : LaurentSeries k) = (φ r : PowerSeries k))
    (hnegative : (Ψ (HahnSeries.single (-1) 1)).order < 0) :
    PowerSeries.constantCoeff (φ PowerSeries.X) = 0 := by
  have hx : (φ PowerSeries.X : PowerSeries k) =
      (Ψ (HahnSeries.single (-1) 1))⁻¹ := by
    rw [← hΨ, PowerSeries.coe_X]
    have hsingle : (HahnSeries.single 1 (1 : k) : LaurentSeries k) =
        (HahnSeries.single (-1) 1)⁻¹ := by simp [HahnSeries.inv_single]
    rw [hsingle, map_inv₀]
  apply power_series_zero_constant_of_positive_laurent_order
  rw [hx, laurent_order_inverse]
  omega

end Litt3.QuotientGeometry
