import Solutions.QuotientGeometry.WeakDifferentialScalar

namespace Litt3.QuotientGeometry

/-- The literal p=5,h=4,m=7 specialization of the actual root and
differential coefficient formula. No endpoint enumeration is used. -/
theorem weak_characteristic_five_differential_scalar
    {k : Type*} [Field k] [CharP k 5]
    (u g σ : PowerSeries k) (c : k) (hc : c ≠ 0)
    (hg : PowerSeries.constantCoeff g ≠ 0) (hσ : PowerSeries.constantCoeff σ ≠ 0)
    (hroot : u ^ 4 = g ^ 7)
    (hdg : PowerSeries.derivative k g = PowerSeries.C c * PowerSeries.X ^ 3 * σ) :
    -PowerSeries.constantCoeff u / (PowerSeries.coeff 4 u) ^ 5 =
      -1 / ((2 * c) ^ 5 * (PowerSeries.constantCoeff g) ^ 2 *
        (PowerSeries.constantCoeff σ) ^ 5) := by
  have hfour : (4 : k) ≠ 0 := by
    change ((4 : ℕ) : k) ≠ 0
    rw [ne_eq, CharP.cast_eq_zero_iff k 5]
    norm_num
  have hseven : (7 : k) ≠ 0 := by
    change ((7 : ℕ) : k) ≠ 0
    rw [ne_eq, CharP.cast_eq_zero_iff k 5]
    norm_num
  have hfive : (5 : k) = 0 := CharP.cast_eq_zero k 5
  have hratio : -((7 : k) / (4 : k)) = 2 := by
    field_simp
    linear_combination -3 * hfive
  have hscalar := weak_power_root_differential_scalar 5 4 7 (by omega) (by omega)
    (by omega) (by decide) hfour hseven u g σ c hc hg hσ hroot hdg
  have hden : -(((7 : k) / (4 : k)) * c * PowerSeries.constantCoeff σ) =
      2 * c * PowerSeries.constantCoeff σ := by
    rw [← neg_mul, ← neg_mul, hratio]
  norm_num only at hscalar
  rw [hden, zpow_neg] at hscalar
  rw [hscalar]
  have htwo : (2 : k) ≠ 0 := by
    change ((2 : ℕ) : k) ≠ 0
    rw [ne_eq, CharP.cast_eq_zero_iff k 5]
    norm_num
  field_simp [hg, hσ, hc, htwo]

end Litt3.QuotientGeometry
