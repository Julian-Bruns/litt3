import Solutions.CartierAndSpin.LaurentDerivation
import Solutions.QuotientGeometry.LaurentUnitOrders

namespace Litt3.QuotientGeometry

theorem field_derivation_nat_power_formula
    {R K : Type*} [CommRing R] [Field K] [Algebra R K]
    (D : Derivation R K K) (a : K) (h : ℕ) : D (a ^ h) = (h : K) * a ^ (h - 1) * D a := by
  simpa only [smul_eq_mul, nsmul_eq_mul, mul_assoc] using D.leibniz_pow a h

theorem field_derivation_inverse_formula
    {R K : Type*} [CommRing R] [Field K] [Algebra R K]
    (D : Derivation R K K) (a : K) : D a⁻¹ = -a⁻¹ ^ 2 * D a := by
  simpa only [smul_eq_mul] using D.leibniz_inv a

theorem laurent_derivative_nat_power
    {k : Type*} [Field k] (ψ : LaurentSeries k) (h : ℕ) :
    LaurentSeries.derivative k (ψ ^ h) = (h : LaurentSeries k) * ψ ^ (h - 1) *
      LaurentSeries.derivative k ψ := by
  exact field_derivation_nat_power_formula (Litt3.CartierAndSpin.laurentDerivation k) ψ h

theorem laurent_derivative_inverse
    {k : Type*} [Field k] (ψ : LaurentSeries k) :
    LaurentSeries.derivative k ψ⁻¹ = -ψ⁻¹ ^ 2 * LaurentSeries.derivative k ψ := by
  exact field_derivation_inverse_formula (Litt3.CartierAndSpin.laurentDerivation k) ψ

/-- Exact order of the actual derivative of the downstairs inverse
parameter; no different exponent or ramification label is presumed. -/
theorem laurent_inverse_tame_power_derivative_order
    {k : Type*} [Field k] (p h : ℕ) (hp : 0 < p) (hh : 0 < h) (hchar : (h : k) ≠ 0)
    (ψ : LaurentSeries k) (hψorder : ψ.order = -(p : ℤ))
    (hderiv : LaurentSeries.derivative k ψ ≠ 0) :
    (LaurentSeries.derivative k (ψ ^ h)⁻¹).order =
      (p * h + p : ℕ) + (LaurentSeries.derivative k ψ).order := by
  have hψ : ψ ≠ 0 := by intro hz; simp [hz] at hψorder; omega
  have hcast : (h : LaurentSeries k) = HahnSeries.C (h : k) := by simp
  have hcastne : (h : LaurentSeries k) ≠ 0 := by
    rw [hcast, HahnSeries.C_apply]
    exact HahnSeries.single_ne_zero hchar
  have hcastorder : (h : LaurentSeries k).order = 0 := by
    rw [hcast, HahnSeries.C_apply, HahnSeries.order_single hchar]
  have hpowderivne : LaurentSeries.derivative k (ψ ^ h) ≠ 0 := by
    rw [laurent_derivative_nat_power]
    exact mul_ne_zero (mul_ne_zero hcastne (pow_ne_zero _ hψ)) hderiv
  rw [laurent_derivative_inverse, HahnSeries.order_mul
    (neg_ne_zero.mpr (pow_ne_zero 2 (inv_ne_zero (pow_ne_zero h hψ)))) hpowderivne,
    HahnSeries.order_neg, HahnSeries.order_pow, laurent_order_inverse,
    HahnSeries.order_pow, laurent_derivative_nat_power,
    HahnSeries.order_mul (mul_ne_zero hcastne (pow_ne_zero _ hψ)) hderiv,
    HahnSeries.order_mul hcastne (pow_ne_zero _ hψ), hcastorder, HahnSeries.order_pow, hψorder]
  simp only [nsmul_eq_mul, Nat.cast_add, Nat.cast_mul]
  have hsub : ((h - 1 : ℕ) : ℤ) = (h : ℤ) - 1 := by omega
  rw [hsub]
  ring

theorem weak_tame_root_derivative_order_from_parameter
    {k : Type*} [Field k] (p h : ℕ) (hp : 1 < p) (hh : 0 < h) (hchar : (h : k) ≠ 0)
    (ψ : LaurentSeries k) (hψorder : ψ.order = -(p : ℤ))
    (hparameter : (LaurentSeries.derivative k (ψ ^ h)⁻¹).order =
      (p * h + p : ℕ) - 2) : (LaurentSeries.derivative k ψ).order = -2 := by
  have hderiv : LaurentSeries.derivative k ψ ≠ 0 := by
    intro hz
    rw [laurent_derivative_inverse, laurent_derivative_nat_power, hz, mul_zero, mul_zero,
      HahnSeries.order_zero] at hparameter
    have hh' : (0 : ℤ) < h := by exact_mod_cast hh
    have hp' : (1 : ℤ) < p := by exact_mod_cast hp
    push_cast at hparameter
    nlinarith
  have horder := laurent_inverse_tame_power_derivative_order p h (by omega) hh hchar ψ hψorder hderiv
  rw [hparameter] at horder
  omega

end Litt3.QuotientGeometry
