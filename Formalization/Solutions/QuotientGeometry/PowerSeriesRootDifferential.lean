import Solutions.QuotientGeometry.RootDifferentialIdentity

namespace Litt3.QuotientGeometry

theorem power_series_unit_inverse_coe
    {k : Type*} [Field k] (g : PowerSeries k) (hg : PowerSeries.constantCoeff g ≠ 0) :
    ((g⁻¹ : PowerSeries k) : LaurentSeries k) = (g : LaurentSeries k)⁻¹ := by
  have hgL : (g : LaurentSeries k) ≠ 0 := by
    intro hz
    have h := congrArg (fun f : LaurentSeries k => f.coeff 0) hz
    apply hg
    simpa [PowerSeries.coeff_coe] using h
  apply eq_inv_of_mul_eq_one_left
  rw [← PowerSeries.coe_mul, PowerSeries.inv_mul_cancel g hg]
  exact PowerSeries.coe_one

/-- The actual infinite-series root identity supplies its logarithmic
differential; both the entire unit inverse and derivation are literal. -/
theorem power_series_power_root_derivative
    {k : Type*} [Field k] (u g : PowerSeries k) (h m : ℕ)
    (hh : 0 < h) (hm : 0 < m) (hg : PowerSeries.constantCoeff g ≠ 0)
    (hchar : (h : k) ≠ 0) (hroot : u ^ h = g ^ m) :
    PowerSeries.derivative k u = PowerSeries.C ((m : k) / (h : k)) *
      u * g⁻¹ * PowerSeries.derivative k g := by
  have hgL : (g : LaurentSeries k) ≠ 0 := by
    intro hz
    have h := congrArg (fun f : LaurentSeries k => f.coeff 0) hz
    apply hg
    simpa [PowerSeries.coeff_coe] using h
  have hcharL : (h : LaurentSeries k) ≠ 0 := by
    have heq : (h : LaurentSeries k) = HahnSeries.C (h : k) := by simp
    rw [heq, HahnSeries.C_apply]
    exact HahnSeries.single_ne_zero hchar
  have hrootL : (u : LaurentSeries k) ^ h = (g : LaurentSeries k) ^ m := by
    rw [← PowerSeries.coe_pow, ← PowerSeries.coe_pow, hroot]
  have hD := field_derivation_power_root_identity (Litt3.CartierAndSpin.laurentDerivation k)
    (u : LaurentSeries k) (g : LaurentSeries k) h m hh hm hgL hcharL hrootL
  apply HahnSeries.ofPowerSeries_injective (Γ := ℤ) (R := k)
  rw [PowerSeries.coe_mul, PowerSeries.coe_mul, PowerSeries.coe_mul,
    PowerSeries.coe_C, power_series_unit_inverse_coe g hg]
  have hconst : HahnSeries.C ((m : k) / (h : k)) = (m : LaurentSeries k) / (h : LaurentSeries k) := by
    simp
  rw [hconst]
  simpa only [Litt3.CartierAndSpin.laurentDerivation_apply,
    Litt3.CartierAndSpin.laurent_derivative_powerSeries] using hD

end Litt3.QuotientGeometry
