import Solutions.QuotientGeometry.WeakCharacteristicFiveScalar

namespace Litt3.QuotientGeometry

theorem weak_laurent_power_root_differential_scalar
    {k : Type*} [Field k] (p h m : ℕ) [CharP k p]
    (hp : 1 < p) (hh : 0 < h) (hm : 0 < m) (hdiv : h ∣ p - 1)
    (hchar : (h : k) ≠ 0) (hmchar : (m : k) ≠ 0)
    (u g σ : PowerSeries k) (c : k) (hc : c ≠ 0)
    (hg : PowerSeries.constantCoeff g ≠ 0) (hσ : PowerSeries.constantCoeff σ ≠ 0)
    (hroot : u ^ h = g ^ m)
    (hdg : PowerSeries.derivative k g = PowerSeries.C c * PowerSeries.X ^ (p - 2) * σ) :
    let ψ : LaurentSeries k := HahnSeries.single (-(p : ℤ)) 1 * (u : LaurentSeries k);
    -ψ.coeff (-(p : ℤ)) / ψ.coeff (-1) ^ p =
      -(PowerSeries.constantCoeff g) ^
          ((p : ℤ) - ((m * ((p - 1) / h) : ℕ) : ℤ)) /
        (-(((m : k) / (h : k)) * c * PowerSeries.constantCoeff σ)) ^ p := by
  have hcoeff := laurent_power_root_negative_coefficients p hp u
  simp only [hcoeff.1, hcoeff.2]
  exact weak_power_root_differential_scalar p h m hp hh hm hdiv hchar hmchar
    u g σ c hc hg hσ hroot hdg

theorem weak_characteristic_five_laurent_scalar
    {k : Type*} [Field k] [CharP k 5]
    (u g σ : PowerSeries k) (c : k) (hc : c ≠ 0)
    (hg : PowerSeries.constantCoeff g ≠ 0) (hσ : PowerSeries.constantCoeff σ ≠ 0)
    (hroot : u ^ 4 = g ^ 7)
    (hdg : PowerSeries.derivative k g = PowerSeries.C c * PowerSeries.X ^ 3 * σ) :
    let ψ : LaurentSeries k := HahnSeries.single (-5) 1 * (u : LaurentSeries k);
    -ψ.coeff (-5) / ψ.coeff (-1) ^ 5 =
      -1 / ((2 * c) ^ 5 * (PowerSeries.constantCoeff g) ^ 2 *
        (PowerSeries.constantCoeff σ) ^ 5) := by
  have hcoeff := laurent_power_root_negative_coefficients 5 (by omega) u
  norm_num only at hcoeff
  simp only [hcoeff.1, hcoeff.2]
  exact weak_characteristic_five_differential_scalar u g σ c hc hg hσ hroot hdg

theorem negative_reciprocal_scaled_eq_iff
    {k : Type*} [Field k] (a x y : k) (ha : a ≠ 0) :
    -1 / (a * x) = -1 / (a * y) ↔ x = y := by
  simp only [neg_div, one_div, neg_inj, inv_inj]
  exact ⟨mul_left_cancel₀ ha, congrArg (fun z => a * z)⟩

end Litt3.QuotientGeometry
