import Mathlib.RingTheory.LaurentSeries
import Mathlib.Tactic

namespace Litt3.QuotientGeometry

/-- A pole of an actual Artin-Schreier coboundary has order divisible
by p. This order comparison is characteristic independent; the
Artin-Schreier interpretation specializes to characteristic p. -/
theorem laurent_power_sub_self_negative_order
    {k : Type*} [Field k] (p : ℕ) (hp : 1 < p)
    (v : LaurentSeries k) (hv : v.order < 0) :
    (v ^ p - v).order = (p : ℤ) * v.order := by
  have hvzero : v ≠ 0 := by intro h; simp [h] at hv
  have hvpow : v ^ p ≠ 0 := pow_ne_zero _ hvzero
  have hlt : (v ^ p).order < v.order := by
    rw [HahnSeries.order_pow, nsmul_eq_mul]
    nlinarith
  have hltTop : (v ^ p).orderTop < v.orderTop := by
    rw [← HahnSeries.order_eq_orderTop_of_ne_zero hvpow,
      ← HahnSeries.order_eq_orderTop_of_ne_zero hvzero]
    exact WithTop.coe_lt_coe.mpr hlt
  have htop := HahnSeries.orderTop_sub hltTop
  have hsubzero : v ^ p - v ≠ 0 := by
    intro h
    rw [h, HahnSeries.orderTop_zero] at htop
    exact (HahnSeries.orderTop_ne_top.mpr hvpow) htop.symm
  have ho : (v ^ p - v).order = (v ^ p).order := by
    apply WithTop.coe_injective
    simpa only [HahnSeries.order_eq_orderTop_of_ne_zero hsubzero,
      HahnSeries.order_eq_orderTop_of_ne_zero hvpow] using htop
  rw [ho, HahnSeries.order_pow, nsmul_eq_mul]

theorem laurent_power_sub_self_pole_order_divisible
    {k : Type*} [Field k] (p : ℕ) (hp : 1 < p)
    (v : LaurentSeries k) (hv : v.order < 0) :
    (p : ℤ) ∣ (v ^ p - v).order := by
  rw [laurent_power_sub_self_negative_order p hp v hv]
  exact dvd_mul_right _ _

theorem laurent_power_sub_self_nonnegative_order
    {k : Type*} [Field k] (p : ℕ) (v : LaurentSeries k) (hv : 0 ≤ v.order) :
    0 ≤ (v ^ p - v).order := by
  apply HahnSeries.zero_le_orderTop_iff.mp
  have hvTop : 0 ≤ v.orderTop := HahnSeries.zero_le_orderTop_iff.mpr hv
  have hvpowTop : 0 ≤ (v ^ p).orderTop := HahnSeries.zero_le_orderTop_iff.mpr (by
    rw [HahnSeries.order_pow, nsmul_eq_mul]
    positivity)
  exact (le_min hvpowTop hvTop).trans HahnSeries.min_orderTop_le_orderTop_sub

theorem laurent_power_sub_self_pole_order_divisible_of_negative
    {k : Type*} [Field k] (p : ℕ) (hp : 1 < p) (v : LaurentSeries k)
    (hnegative : (v ^ p - v).order < 0) : (p : ℤ) ∣ (v ^ p - v).order := by
  apply laurent_power_sub_self_pole_order_divisible p hp v
  by_contra hv
  have hnonnegative := laurent_power_sub_self_nonnegative_order p v (le_of_not_gt hv)
  omega

/-- No Laurent series of pole order prime to p is an Artin-Schreier
coboundary. In particular an actual pole-one series is never one. -/
theorem laurent_nondisible_pole_not_power_sub_self
    {k : Type*} [Field k] (p : ℕ) (hp : 1 < p) (f : LaurentSeries k)
    (m : ℕ) (hm : 0 < m) (horder : f.order = -(m : ℤ)) (hnotdvd : ¬p ∣ m) :
    ∀ v : LaurentSeries k, v ^ p - v ≠ f := by
  intro v h
  have hnegative : (v ^ p - v).order < 0 := by rw [h, horder]; omega
  have hdvd := laurent_power_sub_self_pole_order_divisible_of_negative p hp v hnegative
  rw [h, horder] at hdvd
  have hpdivm : p ∣ m := by
    simpa using Int.natCast_dvd.mp hdvd
  exact hnotdvd hpdivm

theorem laurent_pole_one_not_power_sub_self
    {k : Type*} [Field k] (p : ℕ) (hp : 1 < p) (f : LaurentSeries k)
    (horder : f.order = -1) : ∀ v : LaurentSeries k, v ^ p - v ≠ f :=
  laurent_nondisible_pole_not_power_sub_self p hp f 1 (by decide) horder
    (by intro h; have := Nat.le_of_dvd (by decide) h; omega)

end Litt3.QuotientGeometry
