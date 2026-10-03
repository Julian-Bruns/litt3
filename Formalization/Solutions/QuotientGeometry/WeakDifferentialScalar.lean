import Solutions.QuotientGeometry.WeakDifferentialCoefficients
import Solutions.QuotientGeometry.WeakDifferentialScalarAlgebra

namespace Litt3.QuotientGeometry

/-- The source differential scalar formula, including negative integer
exponents, derived from actual entire root and differential identities. -/
theorem weak_power_root_differential_scalar
    {k : Type*} [Field k] (p h m : ℕ) [CharP k p]
    (hp : 1 < p) (hh : 0 < h) (hm : 0 < m) (hdiv : h ∣ p - 1)
    (hchar : (h : k) ≠ 0) (hmchar : (m : k) ≠ 0)
    (u g σ : PowerSeries k) (c : k) (hc : c ≠ 0)
    (hg : PowerSeries.constantCoeff g ≠ 0) (hσ : PowerSeries.constantCoeff σ ≠ 0)
    (hroot : u ^ h = g ^ m)
    (hdg : PowerSeries.derivative k g = PowerSeries.C c * PowerSeries.X ^ (p - 2) * σ) :
    -PowerSeries.constantCoeff u / (PowerSeries.coeff (p - 1) u) ^ p =
      -(PowerSeries.constantCoeff g) ^
          ((p : ℤ) - ((m * ((p - 1) / h) : ℕ) : ℤ)) /
        (-(((m : k) / (h : k)) * c * PowerSeries.constantCoeff σ)) ^ p := by
  let a : k := -(((m : k) / (h : k)) * c * PowerSeries.constantCoeff σ)
  have ha : a ≠ 0 := neg_ne_zero.mpr
    (mul_ne_zero (mul_ne_zero (div_ne_zero hmchar hchar) hc) hσ)
  have hu := weak_power_root_constant_nonzero h m hh u g hg hroot
  have hconstants := congrArg PowerSeries.constantCoeff hroot
  simp only [map_pow] at hconstants
  have hquot : p - 1 = h * ((p - 1) / h) := (Nat.mul_div_cancel' hdiv).symm
  have hpower := root_power_relation_of_divisible_exponent p h m ((p - 1) / h)
    (PowerSeries.constantCoeff u) (PowerSeries.constantCoeff g) hconstants hquot
  rw [weak_power_root_pole_one_coefficient p h m hp hh hm hchar u g σ c hg hroot hdg]
  exact weak_pole_scalar_power_identity p (m * ((p - 1) / h)) (by omega)
    (PowerSeries.constantCoeff u) (PowerSeries.constantCoeff g) a hu hg ha hpower

theorem laurent_power_root_negative_coefficients
    {k : Type*} [Field k] (p : ℕ) (hp : 1 < p) (u : PowerSeries k) :
    (HahnSeries.single (-(p : ℤ)) 1 * (u : LaurentSeries k)).coeff (-(p : ℤ)) =
      PowerSeries.constantCoeff u ∧
    (HahnSeries.single (-(p : ℤ)) 1 * (u : LaurentSeries k)).coeff (-1) =
      PowerSeries.coeff (p - 1) u := by
  constructor
  · have h := HahnSeries.coeff_single_mul_add (x := (u : LaurentSeries k))
      (r := (1 : k)) (a := 0) (b := (-(p : ℤ)))
    simpa [PowerSeries.coeff_coe] using h
  · have h := HahnSeries.coeff_single_mul_add (x := (u : LaurentSeries k))
      (r := (1 : k)) (a := ((p - 1 : ℕ) : ℤ)) (b := (-(p : ℤ)))
    have hindex : ((p - 1 : ℕ) : ℤ) + -(p : ℤ) = -1 := by omega
    simpa [hindex, PowerSeries.coeff_coe] using h

end Litt3.QuotientGeometry
