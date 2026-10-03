import Solutions.QuotientGeometry.LaurentDerivativeBounds
import Mathlib.RingTheory.HahnSeries.Valuation
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Litt3.QuotientGeometry

variable {k : Type*} [Field k]

/-- If the first possible exponent is annihilated in the coefficient
field, actual Laurent differentiation preserves the order bound. Zero
series and zero derivatives are retained by using orderTop. -/
theorem laurent_derivative_orderTop_bound_of_cast_zero
    (f : LaurentSeries k) (m : ℤ) (hf : (m : WithTop ℤ) ≤ f.orderTop)
    (hm : (m : k) = 0) :
    (m : WithTop ℤ) ≤ (LaurentSeries.derivative k f).orderTop := by
  apply laurent_orderTop_lower_bound_of_coefficients
  intro n hn
  have hformula := laurent_derivative_coefficient f (n + 1)
  simp only [add_sub_cancel_right] at hformula
  by_cases hnm : n + 1 = m
  · rw [hnm, hm, zero_mul] at hformula
    exact hformula
  · have hlt : ((n + 1 : ℤ) : WithTop ℤ) < f.orderTop :=
      lt_of_lt_of_le (WithTop.coe_lt_coe.mpr (by omega)) hf
    rw [HahnSeries.coeff_eq_zero_of_lt_orderTop hlt, mul_zero] at hformula
    exact hformula

/-- The characteristic-p specialization requires only divisibility
of the first possible order, with no exact leading-term hypothesis. -/
theorem laurent_derivative_orderTop_bound_of_characteristic_dvd
    (p : ℕ) [CharP k p] (f : LaurentSeries k) (m : ℤ)
    (hf : (m : WithTop ℤ) ≤ f.orderTop) (hm : (p : ℤ) ∣ m) :
    (m : WithTop ℤ) ≤ (LaurentSeries.derivative k f).orderTop :=
  laurent_derivative_orderTop_bound_of_cast_zero f m hf
    ((CharP.intCast_eq_zero_iff k p m).mpr hm)

/-- Formal Laurent differentiation preserves the actual power-series
order condition, in every characteristic. -/
theorem laurent_derivative_integral_order (f : LaurentSeries k)
    (hf : (0 : WithTop ℤ) ≤ f.orderTop) :
    (0 : WithTop ℤ) ≤ (LaurentSeries.derivative k f).orderTop :=
  laurent_derivative_orderTop_bound_of_cast_zero f 0 hf (by simp)

/-- The actual Laurent order of every power, including exponent zero
and the zero series, follows from its additive valuation. -/
theorem laurent_orderTop_power (f : LaurentSeries k) (n : ℕ) :
    (f ^ n).orderTop = n • f.orderTop :=
  (HahnSeries.addVal ℤ k).map_pow f n

theorem laurent_orderTop_mul_bound (f g : LaurentSeries k) (m n : ℤ)
    (hf : (m : WithTop ℤ) ≤ f.orderTop) (hg : (n : WithTop ℤ) ≤ g.orderTop) :
    ((m + n : ℤ) : WithTop ℤ) ≤ (f * g).orderTop := by
  change ((m + n : ℤ) : WithTop ℤ) ≤ (HahnSeries.addVal ℤ k) (f * g)
  rw [(HahnSeries.addVal ℤ k).map_mul, WithTop.coe_add]
  exact add_le_add hf hg

theorem laurent_orderTop_power_bound (f : LaurentSeries k) (m : ℤ) (n : ℕ)
    (hf : (m : WithTop ℤ) ≤ f.orderTop) :
    (((n : ℤ) * m : ℤ) : WithTop ℤ) ≤ (f ^ n).orderTop := by
  rw [laurent_orderTop_power]
  simpa only [← WithTop.coe_nsmul, nsmul_eq_mul] using nsmul_le_nsmul_right hf n

theorem laurent_orderTop_sum_bound {ι : Type*} (s : Finset ι)
    (f : ι → LaurentSeries k) (m : ℤ)
    (hf : ∀ i ∈ s, (m : WithTop ℤ) ≤ (f i).orderTop) :
    (m : WithTop ℤ) ≤ (∑ i ∈ s, f i).orderTop := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | @insert i s hi ih =>
    rw [Finset.sum_insert hi]
    exact le_trans (le_min (hf i (Finset.mem_insert_self i s))
      (ih fun j hj => hf j (Finset.mem_insert_of_mem hj)))
      HahnSeries.min_orderTop_le_orderTop_add

/-- A square numerator of order at least m divided by an actual
denominator of exact order e has order at least 2m−ne. A zero
numerator is included. -/
theorem laurent_square_quotient_orderTop_bound (f g : LaurentSeries k)
    (m e : ℤ) (n : ℕ) (hf : (m : WithTop ℤ) ≤ f.orderTop)
    (hg : g.orderTop = (e : WithTop ℤ)) :
    ((2 * m - (n : ℤ) * e : ℤ) : WithTop ℤ) ≤ (f ^ 2 / g ^ n).orderTop := by
  by_cases hzero : f = 0
  · simp [hzero]
  have hgzero : g ≠ 0 := by
    intro h
    simp [h] at hg
  have horder : m ≤ f.order := by
    rw [← HahnSeries.order_eq_orderTop_of_ne_zero hzero] at hf
    exact WithTop.coe_le_coe.mp hf
  have hpow : (g ^ n).orderTop = (((n : ℤ) * e : ℤ) : WithTop ℤ) := by
    rw [laurent_orderTop_power, hg]
    simp only [← WithTop.coe_nsmul, nsmul_eq_mul]
  have heval := (HahnSeries.addVal ℤ k).map_div (x := f ^ 2) (y := g ^ n)
  change (f ^ 2 / g ^ n).orderTop = (f ^ 2).orderTop - (g ^ n).orderTop at heval
  rw [heval, hpow, ← HahnSeries.order_eq_orderTop_of_ne_zero (pow_ne_zero 2 hzero),
    HahnSeries.order_pow]
  simp only [nsmul_eq_mul, ← WithTop.LinearOrderedAddCommGroup.coe_sub,
    WithTop.coe_le_coe, Nat.cast_ofNat]
  omega

theorem laurent_quotient_orderTop_bound (f g : LaurentSeries k) (m e : ℤ)
    (hf : (m : WithTop ℤ) ≤ f.orderTop) (hg : g.orderTop = (e : WithTop ℤ)) :
    ((m - e : ℤ) : WithTop ℤ) ≤ (f / g).orderTop := by
  by_cases hzero : f = 0
  · simp [hzero]
  have horder : m ≤ f.order := by
    rw [← HahnSeries.order_eq_orderTop_of_ne_zero hzero] at hf
    exact WithTop.coe_le_coe.mp hf
  have heval := (HahnSeries.addVal ℤ k).map_div (x := f) (y := g)
  change (f / g).orderTop = f.orderTop - g.orderTop at heval
  rw [heval, hg, ← HahnSeries.order_eq_orderTop_of_ne_zero hzero]
  simp only [← WithTop.LinearOrderedAddCommGroup.coe_sub, WithTop.coe_le_coe]
  omega

theorem laurent_natCast_integral_order (n : ℕ) :
    (0 : WithTop ℤ) ≤ (n : LaurentSeries k).orderTop := by
  by_cases hn : (n : LaurentSeries k) = 0
  · simp [hn]
  rw [← HahnSeries.order_eq_orderTop_of_ne_zero hn]
  have heq : (n : LaurentSeries k) = HahnSeries.C (n : k) := by
    rw [← LaurentSeries.algebraMap_apply, map_natCast]
  rw [heq, HahnSeries.order_C]
  exact le_rfl

theorem laurent_natCast_mul_order_bound (n : ℕ) (f : LaurentSeries k) (m : ℤ)
    (hf : (m : WithTop ℤ) ≤ f.orderTop) :
    (m : WithTop ℤ) ≤ ((n : LaurentSeries k) * f).orderTop := by
  simpa only [zero_add] using laurent_orderTop_mul_bound (n : LaurentSeries k) f 0 m
    (laurent_natCast_integral_order n) hf

end Litt3.CartierAndSpin
