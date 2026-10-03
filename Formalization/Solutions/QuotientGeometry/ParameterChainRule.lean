import Solutions.QuotientGeometry.ParameterSubstitutionCoefficients
import Mathlib.RingTheory.PowerSeries.Derivative

namespace Litt3.QuotientGeometry

theorem parameter_substitution_coefficient_congr
    {R : Type*} [CommRing R] (b f g : PowerSeries R)
    (hb : PowerSeries.constantCoeff b = 0) (n : ℕ)
    (hfg : ∀ i, i ≤ n → PowerSeries.coeff i f = PowerSeries.coeff i g) :
    PowerSeries.coeff n (PowerSeries.subst b f) =
      PowerSeries.coeff n (PowerSeries.subst b g) := by
  rw [parameter_substitution_coefficient b f hb,
    parameter_substitution_coefficient b g hb]
  apply Finset.sum_congr rfl
  intro i hi
  rw [hfg i (Nat.le_of_lt_succ (Finset.mem_range.mp hi))]

theorem power_series_mul_coefficient_congr
    {R : Type*} [CommRing R] (f g h : PowerSeries R) (n : ℕ)
    (hfg : ∀ i, i ≤ n → PowerSeries.coeff i f = PowerSeries.coeff i g) :
    PowerSeries.coeff n (f * h) = PowerSeries.coeff n (g * h) := by
  rw [PowerSeries.coeff_mul, PowerSeries.coeff_mul]
  apply Finset.sum_congr rfl
  intro i hi
  rw [hfg i.1 (Finset.antidiagonal.fst_le hi)]

/-- The formal chain rule for literal infinite-series substitution. The
proof compares each coefficient with a sufficiently long polynomial
truncation; the conclusion concerns the entire series. -/
theorem parameter_substitution_derivative
    {R : Type*} [CommRing R] (b f : PowerSeries R)
    (hb : PowerSeries.constantCoeff b = 0) :
    PowerSeries.derivative R (PowerSeries.subst b f) =
      PowerSeries.subst b (PowerSeries.derivative R f) * PowerSeries.derivative R b := by
  let hs := PowerSeries.HasSubst.of_constantCoeff_zero' hb
  apply PowerSeries.ext
  intro n
  let p := PowerSeries.trunc (n + 2) f
  have hp (i : ℕ) (hi : i ≤ n + 1) :
      PowerSeries.coeff i f = PowerSeries.coeff i (p : PowerSeries R) := by
    symm
    exact PowerSeries.coeff_coe_trunc_of_lt (by omega)
  have hleft : PowerSeries.coeff n
      (PowerSeries.derivative R (PowerSeries.subst b f)) =
      PowerSeries.coeff n (PowerSeries.derivative R (Polynomial.aeval b p)) := by
    rw [PowerSeries.coeff_derivative, PowerSeries.coeff_derivative]
    rw [← PowerSeries.subst_coe hs p]
    rw [parameter_substitution_coefficient_congr b f (p : PowerSeries R) hb (n + 1) hp]
  have hderivative (i : ℕ) (hi : i ≤ n) :
      PowerSeries.coeff i (PowerSeries.derivative R f) =
      PowerSeries.coeff i (Polynomial.derivative p : PowerSeries R) := by
    rw [PowerSeries.coeff_derivative, Polynomial.coeff_coe, Polynomial.coeff_derivative]
    congr 1
    simpa only [Polynomial.coeff_coe] using hp (i + 1) (by omega)
  have hright : PowerSeries.coeff n
      (PowerSeries.subst b (PowerSeries.derivative R f) * PowerSeries.derivative R b) =
      PowerSeries.coeff n (Polynomial.aeval b (Polynomial.derivative p) *
        PowerSeries.derivative R b) := by
    rw [← PowerSeries.subst_coe hs (Polynomial.derivative p)]
    apply power_series_mul_coefficient_congr
    intro i hi
    apply parameter_substitution_coefficient_congr b _ _ hb
    intro j hj
    exact hderivative j (hj.trans hi)
  rw [hleft, hright, Derivation.map_aeval, smul_eq_mul]

end Litt3.QuotientGeometry
