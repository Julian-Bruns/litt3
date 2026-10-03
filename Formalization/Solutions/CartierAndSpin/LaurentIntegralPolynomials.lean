import Solutions.CartierAndSpin.LaurentEndpointBounds
import Mathlib.Algebra.Polynomial.Lifts

namespace Litt3.CartierAndSpin

open Polynomial

variable {k : Type*} [Field k]

/-- The actual nonnegative Laurent-order condition is precisely
descent to the actual embedded power-series ring. -/
theorem laurent_integral_order_descends (f : LaurentSeries k)
    (hf : (0 : WithTop ℤ) ≤ f.orderTop) :
    ∃ g : PowerSeries k, (g : LaurentSeries k) = f := by
  refine ⟨PowerSeries.mk (fun n => f.coeff n), ?_⟩
  ext n
  rw [PowerSeries.coeff_coe]
  by_cases hn : n < 0
  · rw [if_pos hn]
    exact (HahnSeries.coeff_eq_zero_of_lt_orderTop
      (lt_of_lt_of_le (WithTop.coe_lt_coe.mpr hn) hf)).symm
  · rw [if_neg hn, PowerSeries.coeff_mk, Int.natCast_natAbs,
      abs_of_nonneg (le_of_not_gt hn)]

theorem powerSeries_laurent_integral_order (f : PowerSeries k) :
    (0 : WithTop ℤ) ≤ (f : LaurentSeries k).orderTop := by
  apply Litt3.QuotientGeometry.laurent_orderTop_lower_bound_of_coefficients
  intro n hn
  simp only [PowerSeries.coeff_coe, if_pos hn]

/-- Integral Laurent coefficients give a genuine polynomial over the
embedded power-series ring; no leading-coefficient unit is required. -/
theorem laurent_integral_polynomial_descends (H : (LaurentSeries k)[X])
    (hH : ∀ n, (0 : WithTop ℤ) ≤ (H.coeff n).orderTop) :
    ∃ P : (PowerSeries k)[X], P.map (HahnSeries.ofPowerSeries ℤ k) = H := by
  have hlifts : H ∈ Polynomial.lifts (HahnSeries.ofPowerSeries ℤ k) := by
    rw [Polynomial.lifts_iff_coeff_lifts]
    intro n
    exact laurent_integral_order_descends (H.coeff n) (hH n)
  exact hlifts

/-- Monic remainder formation retains integral Laurent coefficients.
Both dividend and characteristic source factor are actual polynomials. -/
theorem laurent_characteristic_remainder_integral (H : (LaurentSeries k)[X])
    (q : LaurentSeries k) (p : ℕ) (hp : 0 < p)
    (hH : ∀ n, (0 : WithTop ℤ) ≤ (H.coeff n).orderTop)
    (hq : (0 : WithTop ℤ) ≤ q.orderTop) (j : ℕ) :
    (0 : WithTop ℤ) ≤ ((H %ₘ (X ^ p + C q)).coeff j).orderTop := by
  obtain ⟨P, hP⟩ := laurent_integral_polynomial_descends H hH
  obtain ⟨Q, hQ⟩ := laurent_integral_order_descends q hq
  have hfactor : (X ^ p + C Q).map (HahnSeries.ofPowerSeries ℤ k) =
      (X ^ p + C q : (LaurentSeries k)[X]) := by
    simp only [Polynomial.map_add, Polynomial.map_pow, Polynomial.map_X,
      Polynomial.map_C]
    rw [show (HahnSeries.ofPowerSeries ℤ k) Q = q from hQ]
  rw [← hP, ← hfactor, ← Polynomial.map_modByMonic (HahnSeries.ofPowerSeries ℤ k)
    (monic_X_pow_add_C Q (Nat.ne_of_gt hp)), Polynomial.coeff_map]
  exact powerSeries_laurent_integral_order _

theorem laurent_characteristic_quotient_integral (H : (LaurentSeries k)[X])
    (q : LaurentSeries k) (p : ℕ) (hp : 0 < p)
    (hH : ∀ n, (0 : WithTop ℤ) ≤ (H.coeff n).orderTop)
    (hq : (0 : WithTop ℤ) ≤ q.orderTop) (j : ℕ) :
    (0 : WithTop ℤ) ≤ ((H /ₘ (X ^ p + C q)).coeff j).orderTop := by
  obtain ⟨P, hP⟩ := laurent_integral_polynomial_descends H hH
  obtain ⟨Q, hQ⟩ := laurent_integral_order_descends q hq
  have hfactor : (X ^ p + C Q).map (HahnSeries.ofPowerSeries ℤ k) =
      (X ^ p + C q : (LaurentSeries k)[X]) := by
    simp only [Polynomial.map_add, Polynomial.map_pow, Polynomial.map_X, Polynomial.map_C]
    rw [show (HahnSeries.ofPowerSeries ℤ k) Q = q from hQ]
  rw [← hP, ← hfactor, ← Polynomial.map_divByMonic (HahnSeries.ofPowerSeries ℤ k)
    (monic_X_pow_add_C Q (Nat.ne_of_gt hp)), Polynomial.coeff_map]
  exact powerSeries_laurent_integral_order _

theorem characteristic_remainder_low_coefficient_difference
    {K : Type*} [CommRing K] (H : K[X]) (q : K) (p j : ℕ) (hp : 0 < p) (hj : j < p) :
    H.coeff j - (H %ₘ (X ^ p + C q)).coeff j =
      q * (H /ₘ (X ^ p + C q)).coeff j := by
  have h := congrArg (fun P : K[X] => P.coeff j)
    (H.modByMonic_add_div (monic_X_pow_add_C q (Nat.ne_of_gt hp)))
  dsimp only at h
  rw [Polynomial.coeff_add, add_mul, Polynomial.coeff_add,
    Polynomial.coeff_X_pow_mul', if_neg (by omega), Polynomial.coeff_C_mul] at h
  linear_combination -h

/-- Low coefficients of H and of its monic source remainder differ
by a term of order at least the actual order of q. -/
theorem laurent_low_coefficient_difference_order
    (H : (LaurentSeries k)[X]) (q : LaurentSeries k) (p j : ℕ) (hp : 0 < p) (hj : j < p)
    (hH : ∀ n, (0 : WithTop ℤ) ≤ (H.coeff n).orderTop)
    (hq : (0 : WithTop ℤ) ≤ q.orderTop) (m : ℤ) (hqOrder : (m : WithTop ℤ) ≤ q.orderTop) :
    (m : WithTop ℤ) ≤
      (H.coeff j - (H %ₘ (X ^ p + C q)).coeff j).orderTop := by
  rw [characteristic_remainder_low_coefficient_difference H q p j hp hj]
  simpa only [add_zero] using laurent_orderTop_mul_bound q
    ((H /ₘ (X ^ p + C q)).coeff j) m 0 hqOrder
    (laurent_characteristic_quotient_integral H q p hp hH hq j)

end Litt3.CartierAndSpin
