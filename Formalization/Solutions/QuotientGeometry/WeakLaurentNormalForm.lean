import Mathlib.RingTheory.LaurentSeries
import Mathlib.Algebra.CharP.Basic
import Mathlib.Tactic

namespace Litt3.QuotientGeometry

open scoped LaurentSeries

theorem int_cast_ne_zero_between_negative_characteristic
    {k : Type*} [Field k] (p : ℕ) [CharP k p]
    (n : ℤ) (hn : -(p : ℤ) < n) (hneg : n < 0) : (n : k) ≠ 0 := by
  intro hzero
  have hdvd := (CharP.intCast_eq_zero_iff k p n).mp hzero
  have h := Int.eq_zero_of_dvd_of_nonneg_of_lt (m := -n) (n := (p : ℤ))
    (by omega) (by omega) (Int.dvd_neg.mpr hdvd)
  omega

theorem laurent_derivative_coefficient
    {k : Type*} [Field k] (f : LaurentSeries k) (n : ℤ) :
    (LaurentSeries.derivative k f).coeff (n - 1) = (n : k) * f.coeff n := by
  simp [LaurentSeries.derivative_apply, zsmul_eq_mul]

/-- Actual derivative and pole orders force every negative coefficient
except the pole-p and pole-one terms to vanish. -/
theorem weak_laurent_negative_coefficients
    {k : Type*} [Field k] (p : ℕ) [CharP k p] (hp : 1 < p)
    (f : LaurentSeries k) (horder : f.order = -(p : ℤ))
    (hderiv : (LaurentSeries.derivative k f).order = -2)
    (n : ℤ) (hnegative : n < 0) (hnp : n ≠ -(p : ℤ)) (hnone : n ≠ -1) :
    f.coeff n = 0 := by
  by_cases hn : n < -(p : ℤ)
  · exact HahnSeries.coeff_eq_zero_of_lt_order (by omega)
  have hnlow : -(p : ℤ) < n := by omega
  have hd : (LaurentSeries.derivative k f).coeff (n - 1) = 0 :=
    HahnSeries.coeff_eq_zero_of_lt_order (by omega)
  rw [laurent_derivative_coefficient] at hd
  exact (mul_eq_zero.mp hd).resolve_left
    (int_cast_ne_zero_between_negative_characteristic p n hnlow hnegative)

/-- The genuine Laurent expansion is the sum of its nonzero pole-p
term, its nonzero pole-one term, and an actual power-series tail. -/
theorem weak_laurent_normal_form
    {k : Type*} [Field k] (p : ℕ) [CharP k p] (hp : 1 < p)
    (f : LaurentSeries k) (horder : f.order = -(p : ℤ))
    (hderiv : (LaurentSeries.derivative k f).order = -2) :
    ∃ (α γ : k) (r : PowerSeries k), α ≠ 0 ∧ γ ≠ 0 ∧
      f = HahnSeries.single (-(p : ℤ)) α + HahnSeries.single (-1) γ +
        (r : LaurentSeries k) := by
  have hf : f ≠ 0 := by
    intro hzero
    simp only [hzero, HahnSeries.order_zero] at horder
    omega
  have hd : LaurentSeries.derivative k f ≠ 0 := by
    intro hzero
    simp only [hzero, HahnSeries.order_zero] at hderiv
    omega
  have hα : f.coeff (-(p : ℤ)) ≠ 0 := by
    simpa only [horder] using HahnSeries.coeff_order_ne_zero hf
  have hγ : f.coeff (-1) ≠ 0 := by
    have hc := HahnSeries.coeff_order_ne_zero hd
    rw [hderiv] at hc
    have he : (LaurentSeries.derivative k f).coeff (-2) = -f.coeff (-1) := by
      simpa using laurent_derivative_coefficient f (-1)
    rw [he] at hc
    exact neg_ne_zero.mp hc
  refine ⟨f.coeff (-(p : ℤ)), f.coeff (-1), PowerSeries.mk (fun n => f.coeff n), hα, hγ, ?_⟩
  ext n
  simp only [HahnSeries.coeff_add, HahnSeries.coeff_single, PowerSeries.coeff_coe,
    PowerSeries.coeff_mk]
  by_cases hneg : n < 0
  · rw [if_pos hneg]
    by_cases hnp : n = -(p : ℤ)
    · subst n
      simp only [ite_true]
      have hneq : -(p : ℤ) ≠ -1 := by omega
      simp [hneq]
    · by_cases hn1 : n = -1
      · subst n
        simp [hnp]
      · simp [hnp, hn1, weak_laurent_negative_coefficients p hp f horder hderiv n hneg hnp hn1]
  · rw [if_neg hneg]
    have hnp : n ≠ -(p : ℤ) := by omega
    have hn1 : n ≠ -1 := by omega
    simp only [if_neg hnp, if_neg hn1, zero_add]
    exact congrArg f.coeff (Int.eq_natAbs_of_nonneg (le_of_not_gt hneg))

end Litt3.QuotientGeometry
