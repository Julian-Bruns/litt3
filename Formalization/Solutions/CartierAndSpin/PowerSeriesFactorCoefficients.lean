import Solutions.CartierAndSpin.PowerSeriesJets
import Mathlib.Algebra.Polynomial.Coeff

namespace Litt3.CartierAndSpin

open Polynomial

variable {k : Type*} [Field k]

theorem power_series_product_low_coefficient_zero (f g : PowerSeries k) (m : ℕ)
    (hf : ∀ j < m, PowerSeries.coeff j f = 0) (r : ℕ) (hr : r < m) :
    PowerSeries.coeff r (f * g) = 0 := by
  classical
  rw [PowerSeries.coeff_mul]
  apply Finset.sum_eq_zero
  intro x hx
  have hxsum : x.1 + x.2 = r := Finset.mem_antidiagonal.mp hx
  rw [hf x.1 (by omega), zero_mul]

theorem power_series_factor_low_coefficient_zero (f g : PowerSeries k) (m : ℕ)
    (hg : PowerSeries.constantCoeff g ≠ 0)
    (hfg : ∀ j < m, PowerSeries.coeff j (f * g) = 0) :
    ∀ j < m, PowerSeries.coeff j f = 0 := by
  intro j
  induction j using Nat.strong_induction_on with
  | h j ih =>
    intro hj
    have h := hfg j hj
    rw [power_series_leading_product_coefficient f g j (by
      intro i hi
      exact ih i hi (by omega))] at h
    exact (mul_eq_zero.mp h).resolve_right hg

/-- A triangular polynomial product coefficient can be read modulo any
parameter power without expanding a chosen finite-degree source. -/
theorem power_series_polynomial_product_coefficient_mod (B G : (PowerSeries k)[X])
    (n m : ℕ) (hB : ∀ j < n, ∀ l < m, PowerSeries.coeff l (B.coeff j) = 0)
    (r : ℕ) (hr : r < m) :
    PowerSeries.coeff r ((B * G).coeff n) =
      PowerSeries.coeff r (B.coeff n * G.coeff 0) := by
  classical
  rw [Polynomial.coeff_mul, map_sum]
  refine Finset.sum_eq_single (n, 0) ?_ ?_
  · intro x hx hxn
    have hxsum : x.1 + x.2 = n := Finset.mem_antidiagonal.mp hx
    have hlt : x.1 < n := by
      by_contra h
      have hx1 : x.1 = n := by omega
      have hx2 : x.2 = 0 := by omega
      exact hxn (Prod.ext hx1 hx2)
    exact power_series_product_low_coefficient_zero _ _ m (hB x.1 hlt) r hr
  · simp

theorem power_series_polynomial_factor_coefficient_low_zero (B G : (PowerSeries k)[X])
    (n m : ℕ) (hg : PowerSeries.constantCoeff (G.coeff 0) ≠ 0)
    (hB : ∀ j < n, ∀ l < m, PowerSeries.coeff l (B.coeff j) = 0)
    (hF : ∀ l < m, PowerSeries.coeff l ((B * G).coeff n) = 0) :
    ∀ l < m, PowerSeries.coeff l (B.coeff n) = 0 := by
  apply power_series_factor_low_coefficient_zero _ _ m hg
  intro l hl
  rw [← power_series_polynomial_product_coefficient_mod B G n m hB l hl]
  exact hF l hl

end Litt3.CartierAndSpin
