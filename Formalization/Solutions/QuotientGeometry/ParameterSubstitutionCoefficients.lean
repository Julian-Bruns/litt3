import Mathlib.RingTheory.PowerSeries.Substitution

namespace Litt3.QuotientGeometry

theorem parameter_power_coefficient_zero
    {R : Type*} [CommRing R] (b : PowerSeries R)
    (hb : PowerSeries.constantCoeff b = 0) (n d : ℕ) (hnd : n < d) :
    PowerSeries.coeff n (b ^ d) = 0 := by
  obtain ⟨c, hc⟩ := PowerSeries.X_dvd_iff.mpr hb
  rw [hc, mul_pow, PowerSeries.coeff_X_pow_mul', if_neg (by omega)]

theorem parameter_power_diagonal_coefficient
    {R : Type*} [CommRing R] (b : PowerSeries R)
    (hb : PowerSeries.constantCoeff b = 0) (n : ℕ) :
    PowerSeries.coeff n (b ^ n) = PowerSeries.coeff 1 b ^ n := by
  obtain ⟨c, hc⟩ := PowerSeries.X_dvd_iff.mpr hb
  have hfirst : PowerSeries.coeff 1 b = PowerSeries.constantCoeff c := by
    rw [hc]
    simpa using PowerSeries.coeff_X_pow_mul c 1 0
  rw [hc, mul_pow]
  have hd := PowerSeries.coeff_X_pow_mul (c ^ n) n 0
  simpa [hfirst] using hd

theorem parameter_substitution_coefficient
    {R : Type*} [CommRing R] (b f : PowerSeries R)
    (hb : PowerSeries.constantCoeff b = 0) (n : ℕ) :
    PowerSeries.coeff n (PowerSeries.subst b f) =
      ∑ d ∈ Finset.range (n + 1), PowerSeries.coeff d f * PowerSeries.coeff n (b ^ d) := by
  rw [PowerSeries.coeff_subst' (PowerSeries.HasSubst.of_constantCoeff_zero' hb)]
  simp only [smul_eq_mul]
  apply finsum_eq_sum_of_support_subset
  intro d hd
  change PowerSeries.coeff d f * PowerSeries.coeff n (b ^ d) ≠ 0 at hd
  change d ∈ Finset.range (n + 1)
  rw [Finset.mem_range]
  by_contra hdn
  have hnd : n < d := by omega
  exact hd (by rw [parameter_power_coefficient_zero b hb n d hnd, mul_zero])

end Litt3.QuotientGeometry
