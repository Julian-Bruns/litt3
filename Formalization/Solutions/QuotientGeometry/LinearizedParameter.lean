import Definitions.QuotientGeometry.LinearizedParameter
import Solutions.QuotientGeometry.ParameterLaurentImages
import Solutions.QuotientGeometry.FiniteParameterDimension
import Solutions.QuotientGeometry.LaurentPoleCoordinates

namespace Litt3.QuotientGeometry

theorem linearized_parameter_factor_constant
    {k : Type*} [Field k] (n : ℕ) (hn : 1 < n) (α γ : k) :
    PowerSeries.constantCoeff
      (PowerSeries.C α + PowerSeries.C γ * PowerSeries.X ^ (n - 1) : PowerSeries k) = α := by
  simp [zero_pow (by omega : n - 1 ≠ 0)]

theorem linearized_parameter_zero
    {k : Type*} [Field k] (n : ℕ) (hn : 1 < n) (α γ : k) :
    PowerSeries.constantCoeff (linearizedParameter n α γ) = 0 := by
  simp [linearizedParameter, zero_pow (by omega : n ≠ 0)]

theorem linearized_parameter_injective
    {k : Type*} [Field k] (n : ℕ) (hn : 1 < n) (α γ : k) (hα : α ≠ 0) :
    Function.Injective (PowerSeries.subst (linearizedParameter n α γ) :
      PowerSeries k → PowerSeries k) := by
  apply finite_parameter_substitution_injective n (by omega) (linearizedParameter n α γ)
    (PowerSeries.C α + PowerSeries.C γ * PowerSeries.X ^ (n - 1))⁻¹ rfl
  rw [PowerSeries.constantCoeff_inv, linearized_parameter_factor_constant n hn α γ]
  exact inv_ne_zero hα

theorem linearized_parameter_inverse
    {k : Type*} [Field k] (n : ℕ) (hn : 1 < n) (α γ : k) (hα : α ≠ 0) :
    (linearizedParameter n α γ : LaurentSeries k)⁻¹ =
      HahnSeries.C α * (HahnSeries.single (-1) 1) ^ n +
        HahnSeries.C γ * HahnSeries.single (-1) 1 := by
  let x : LaurentSeries k := HahnSeries.single 1 1
  have hx : x ≠ 0 := HahnSeries.single_ne_zero one_ne_zero
  have hxinv : x⁻¹ = HahnSeries.single (-1) 1 := by simp [x, HahnSeries.inv_single]
  have hpow : x ^ n = x ^ (n - 1) * x := by
    rw [← pow_succ, Nat.sub_add_cancel (by omega : 1 ≤ n)]
  have hcancel : x ^ (n - 1) * (x ^ n)⁻¹ = x⁻¹ := by
    rw [hpow, mul_inv_rev]
    calc
      x ^ (n - 1) * (x⁻¹ * (x ^ (n - 1))⁻¹) =
        x⁻¹ * (x ^ (n - 1) * (x ^ (n - 1))⁻¹) := by ring
      _ = x⁻¹ := by rw [mul_inv_cancel₀ (pow_ne_zero _ hx), mul_one]
  rw [linearizedParameter, PowerSeries.coe_mul,
    power_series_coe_inverse _ (by
      rw [linearized_parameter_factor_constant n hn α γ]
      exact hα), mul_inv_rev, inv_inv]
  simp only [PowerSeries.coe_add, PowerSeries.coe_C, PowerSeries.coe_mul,
    PowerSeries.coe_pow, PowerSeries.coe_X]
  change (HahnSeries.C α + HahnSeries.C γ * x ^ (n - 1)) * (x ^ n)⁻¹ = _
  rw [add_mul, mul_assoc, hcancel, ← inv_pow, hxinv]

theorem linearized_parameter_pole_image
    {k : Type*} [Field k] (n : ℕ) (hn : 1 < n) (α γ : k) (hα : α ≠ 0) :
    parameterLaurentMap (linearizedParameter n α γ)
      (linearized_parameter_zero n hn α γ) (linearized_parameter_injective n hn α γ hα)
      (HahnSeries.single (-1) 1) =
        HahnSeries.C α * (HahnSeries.single (-1) 1) ^ n +
          HahnSeries.C γ * HahnSeries.single (-1) 1 := by
  rw [parameter_laurent_map_pole, HahnSeries.C_one, one_mul,
    linearized_parameter_inverse n hn α γ hα]

end Litt3.QuotientGeometry
