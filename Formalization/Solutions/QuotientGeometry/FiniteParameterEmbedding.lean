import Solutions.QuotientGeometry.FiniteParameterDecomposition
import Mathlib.RingTheory.LaurentSeries

namespace Litt3.QuotientGeometry

theorem finite_parameter_power_coefficient_zero
    {k : Type*} [Field k] (n : ℕ) (b c : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (m d : ℕ) (hmd : m < n * d) :
    PowerSeries.coeff m (b ^ d) = 0 := by
  rw [hb, mul_pow, ← pow_mul, PowerSeries.coeff_X_pow_mul', if_neg (by omega)]

theorem finite_parameter_power_diagonal
    {k : Type*} [Field k] (n : ℕ) (b c : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (d : ℕ) :
    PowerSeries.coeff (n * d) (b ^ d) = PowerSeries.constantCoeff c ^ d := by
  rw [hb, mul_pow, ← pow_mul]
  simpa using PowerSeries.coeff_X_pow_mul (c ^ d) (n * d) 0

theorem finite_parameter_substitution_leading_coefficient
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b c f : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (d : ℕ)
    (hf : ∀ j, j < d → PowerSeries.coeff j f = 0) :
    PowerSeries.coeff (n * d) (PowerSeries.subst b f) =
      PowerSeries.coeff d f * PowerSeries.constantCoeff c ^ d := by
  classical
  have hb0 : PowerSeries.constantCoeff b = 0 := by
    rw [hb, map_mul, map_pow, PowerSeries.constantCoeff_X, zero_pow (by omega), zero_mul]
  rw [parameter_substitution_coefficient b f hb0]
  rw [Finset.sum_eq_single d]
  · rw [finite_parameter_power_diagonal n b c hb]
  · intro j _ hj
    by_cases hjd : j < d
    · rw [hf j hjd, zero_mul]
    · have hdj : d < j := by omega
      rw [finite_parameter_power_coefficient_zero n b c hb (n * d) j
        ((Nat.mul_lt_mul_left hn).mpr hdj), mul_zero]
  · intro hd
    exfalso
    apply hd
    rw [Finset.mem_range]
    have : d ≤ n * d := by
      calc
        d = 1 * d := by rw [one_mul]
        _ ≤ n * d := Nat.mul_le_mul_right _ (Nat.succ_le_iff.mpr hn)
    omega

theorem finite_parameter_substitution_injective
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b c : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (hc : PowerSeries.constantCoeff c ≠ 0) :
    Function.Injective (PowerSeries.subst b : PowerSeries k → PowerSeries k) := by
  have hb0 : PowerSeries.constantCoeff b = 0 := by
    rw [hb, map_mul, map_pow, PowerSeries.constantCoeff_X, zero_pow (by omega), zero_mul]
  have hinj : Function.Injective
      (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb0) :
        PowerSeries k → PowerSeries k) := by
    apply (injective_iff_map_eq_zero _).mpr
    intro f hf
    by_contra hf0
    have hcoeff := finite_parameter_substitution_leading_coefficient n hn b c f hb
      f.order.toNat (fun j hj => PowerSeries.coeff_of_lt_order_toNat j hj)
    have hz : PowerSeries.subst b f = 0 := by
      simpa only [PowerSeries.coe_substAlgHom] using hf
    rw [hz, map_zero] at hcoeff
    exact (mul_ne_zero (PowerSeries.coeff_order hf0) (pow_ne_zero _ hc)) hcoeff.symm
  simpa only [PowerSeries.coe_substAlgHom] using hinj

end Litt3.QuotientGeometry
