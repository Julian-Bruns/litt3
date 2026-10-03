import Solutions.QuotientGeometry.PowerSeriesRootDifferential
import Solutions.QuotientGeometry.WeakLaurentCoefficients

namespace Litt3.QuotientGeometry

/-- The actual differential equation determines the pole-one coefficient
of the chosen root, with the complete unit tails retained. -/
theorem weak_power_root_pole_one_coefficient
    {k : Type*} [Field k] (p h m : ℕ) [CharP k p]
    (hp : 1 < p) (hh : 0 < h) (hm : 0 < m) (hchar : (h : k) ≠ 0)
    (u g σ : PowerSeries k) (c : k) (hg : PowerSeries.constantCoeff g ≠ 0)
    (hroot : u ^ h = g ^ m)
    (hdg : PowerSeries.derivative k g = PowerSeries.C c * PowerSeries.X ^ (p - 2) * σ) :
    PowerSeries.coeff (p - 1) u =
      -(((m : k) / (h : k)) * c * PowerSeries.constantCoeff σ) *
        PowerSeries.constantCoeff u / PowerSeries.constantCoeff g := by
  have hdu := power_series_power_root_derivative u g h m hh hm hg hchar hroot
  rw [hdg] at hdu
  have hfactor : PowerSeries.derivative k u = PowerSeries.X ^ (p - 2) *
      (PowerSeries.C (((m : k) / (h : k)) * c) * u * g⁻¹ * σ) := by
    rw [hdu, map_mul]
    ring
  have hcoeff := congrArg (PowerSeries.coeff (p - 2)) hfactor
  have hindex : p - 2 + 1 = p - 1 := by omega
  have hcharp : (p : k) = 0 := CharP.cast_eq_zero k p
  have hpredcast : ((p - 1 : ℕ) : k) = -1 := by
    rw [Nat.cast_sub (by omega : 1 ≤ p), hcharp, Nat.cast_one, zero_sub]
  have hscalar : ((p - 2 : ℕ) : k) + 1 = -1 := by
    have hcast := congrArg (fun j : ℕ => (j : k)) hindex
    simpa only [Nat.cast_add, Nat.cast_one, hpredcast] using hcast
  rw [PowerSeries.coeff_derivative, hindex, hscalar] at hcoeff
  have hshift : PowerSeries.coeff (p - 2)
      (PowerSeries.X ^ (p - 2) * (PowerSeries.C (((m : k) / (h : k)) * c) * u * g⁻¹ * σ)) =
      (((m : k) / (h : k)) * c) * PowerSeries.constantCoeff u *
        (PowerSeries.constantCoeff g)⁻¹ * PowerSeries.constantCoeff σ := by
    have hs := PowerSeries.coeff_X_pow_mul
      (PowerSeries.C (((m : k) / (h : k)) * c) * u * g⁻¹ * σ) (p - 2) 0
    simpa [PowerSeries.coeff_zero_eq_constantCoeff, PowerSeries.constantCoeff_inv] using hs
  rw [hshift] at hcoeff
  simp only [div_eq_mul_inv]
  linear_combination -hcoeff

theorem weak_power_root_constant_nonzero
    {k : Type*} [Field k] (h m : ℕ) (hh : 0 < h)
    (u g : PowerSeries k) (hg : PowerSeries.constantCoeff g ≠ 0)
    (hroot : u ^ h = g ^ m) : PowerSeries.constantCoeff u ≠ 0 := by
  have hconstants := congrArg PowerSeries.constantCoeff hroot
  simp only [map_pow] at hconstants
  intro hu
  rw [hu, zero_pow hh.ne'] at hconstants
  exact (pow_ne_zero m hg) hconstants.symm

theorem weak_power_root_pole_one_coefficient_nonzero
    {k : Type*} [Field k] (p h m : ℕ) [CharP k p]
    (hp : 1 < p) (hh : 0 < h) (hm : 0 < m)
    (hchar : (h : k) ≠ 0) (hmchar : (m : k) ≠ 0)
    (u g σ : PowerSeries k) (c : k) (hc : c ≠ 0)
    (hg : PowerSeries.constantCoeff g ≠ 0) (hσ : PowerSeries.constantCoeff σ ≠ 0)
    (hroot : u ^ h = g ^ m)
    (hdg : PowerSeries.derivative k g = PowerSeries.C c * PowerSeries.X ^ (p - 2) * σ) :
    PowerSeries.coeff (p - 1) u ≠ 0 := by
  rw [weak_power_root_pole_one_coefficient p h m hp hh hm hchar u g σ c hg hroot hdg]
  exact div_ne_zero (mul_ne_zero (neg_ne_zero.mpr
    (mul_ne_zero (mul_ne_zero (div_ne_zero hmchar hchar) hc) hσ))
      (weak_power_root_constant_nonzero h m hh u g hg hroot)) hg

end Litt3.QuotientGeometry
