import Solutions.QuotientGeometry.WeakDifferentialCoefficients
import Solutions.QuotientGeometry.CompletedAutomorphismOrders

namespace Litt3.QuotientGeometry

/-- The literal root and differential identities derive the weak pole
and derivative orders needed for classification; neither order is an
extra hypothesis. -/
theorem weak_differential_root_laurent_orders
    {k : Type*} [Field k] (p h m : ℕ) [CharP k p]
    (hp : 1 < p) (hh : 0 < h) (hm : 0 < m)
    (hchar : (h : k) ≠ 0) (hmchar : (m : k) ≠ 0)
    (u g σ : PowerSeries k) (c : k) (hc : c ≠ 0)
    (hg : PowerSeries.constantCoeff g ≠ 0) (hσ : PowerSeries.constantCoeff σ ≠ 0)
    (hroot : u ^ h = g ^ m)
    (hdg : PowerSeries.derivative k g = PowerSeries.C c * PowerSeries.X ^ (p - 2) * σ) :
    let ψ : LaurentSeries k := HahnSeries.single (-(p : ℤ)) 1 * (u : LaurentSeries k);
    ψ.order = -(p : ℤ) ∧ (LaurentSeries.derivative k ψ).order = -2 ∧
      ψ ^ h = HahnSeries.single (-((p * h : ℕ) : ℤ)) 1 * (g : LaurentSeries k) ^ m := by
  have hu := weak_power_root_constant_nonzero h m hh u g hg hroot
  have huL : (u : LaurentSeries k) ≠ 0 := by
    intro hz
    have h := congrArg (fun f : LaurentSeries k => f.coeff 0) hz
    exact hu (by simpa [PowerSeries.coeff_coe] using h)
  let w : PowerSeries k := PowerSeries.C (((m : k) / (h : k)) * c) * u * g⁻¹ * σ
  have hw : PowerSeries.constantCoeff w ≠ 0 := by
    simp only [w, map_mul, PowerSeries.constantCoeff_C, PowerSeries.constantCoeff_inv]
    exact mul_ne_zero (mul_ne_zero (mul_ne_zero (mul_ne_zero (div_ne_zero hmchar hchar) hc) hu)
      (inv_ne_zero hg)) hσ
  have hdu : PowerSeries.derivative k u = PowerSeries.X ^ (p - 2) * w := by
    rw [power_series_power_root_derivative u g h m hh hm hg hchar hroot, hdg]
    simp only [w, map_mul]
    ring
  have hduL : ((PowerSeries.derivative k u : PowerSeries k) : LaurentSeries k) =
      HahnSeries.single ((p - 2 : ℕ) : ℤ) 1 * (w : LaurentSeries k) := by
    rw [hdu, PowerSeries.coe_mul, PowerSeries.coe_pow, PowerSeries.coe_X, HahnSeries.single_pow]
    simp only [one_pow, nsmul_eq_mul, mul_one]
  have hwL : (w : LaurentSeries k) ≠ 0 := by
    intro hz
    have h := congrArg (fun f : LaurentSeries k => f.coeff 0) hz
    exact hw (by simpa [PowerSeries.coeff_coe] using h)
  have hDne : ((PowerSeries.derivative k u : PowerSeries k) : LaurentSeries k) ≠ 0 := by
    rw [hduL]
    exact mul_ne_zero (HahnSeries.single_ne_zero one_ne_zero) hwL
  have hDord : (((PowerSeries.derivative k u : PowerSeries k) : LaurentSeries k)).order =
      ((p - 2 : ℕ) : ℤ) := by
    rw [hduL, HahnSeries.order_mul (HahnSeries.single_ne_zero one_ne_zero) hwL,
      HahnSeries.order_single one_ne_zero, power_series_coe_unit_order w hw, add_zero]
  have hcharp : (p : k) = 0 := CharP.cast_eq_zero k p
  have hD : LaurentSeries.derivative k
      (HahnSeries.single (-(p : ℤ)) 1 * (u : LaurentSeries k)) =
      HahnSeries.single (-(p : ℤ)) 1 *
        ((PowerSeries.derivative k u : PowerSeries k) : LaurentSeries k) := by
    rw [Litt3.CartierAndSpin.laurent_derivative_single_mul,
      Litt3.CartierAndSpin.laurent_derivative_powerSeries]
    simp [hcharp]
  refine ⟨?_, ?_, ?_⟩
  · rw [HahnSeries.order_mul (HahnSeries.single_ne_zero one_ne_zero) huL,
      HahnSeries.order_single one_ne_zero, power_series_coe_unit_order u hu, add_zero]
  · rw [hD, HahnSeries.order_mul (HahnSeries.single_ne_zero one_ne_zero) hDne,
      HahnSeries.order_single one_ne_zero, hDord]
    omega
  · rw [mul_pow, HahnSeries.single_pow, ← PowerSeries.coe_pow, hroot, PowerSeries.coe_pow]
    simp only [one_pow, nsmul_eq_mul]
    have hi : (h : ℤ) * -(p : ℤ) = -((p * h : ℕ) : ℤ) := by push_cast; ring
    rw [hi]

end Litt3.QuotientGeometry
