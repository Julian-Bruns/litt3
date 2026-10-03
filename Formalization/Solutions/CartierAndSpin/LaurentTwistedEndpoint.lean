import Solutions.CartierAndSpin.LaurentEndpointBounds

namespace Litt3.CartierAndSpin

variable {k : Type*} [Field k]

/-- The local twisted-square pole estimate is coefficientwise and
independent of the source degree, the number of small roots, and the
order of the source constant term. -/
theorem laurent_twisted_square_endpoint_bound (p r : ℕ) [CharP k p]
    (hp : p = 2 * r + 1) (hr : 1 ≤ r) (w q : LaurentSeries k)
    (hw : (0 : WithTop ℤ) ≤ w.orderTop)
    (hq : q.orderTop = (((r : ℤ) + 1 : ℤ) : WithTop ℤ)) :
    ((1 - (r : ℤ) : ℤ) : WithTop ℤ) ≤
      ((LaurentSeries.derivative k (w * (w ^ p + q) ^ (p - 2))) ^ 2 /
        (w ^ p + q) ^ (2 * p - 3)).orderTop := by
  by_cases hwzero : w = 0
  · simp [hwzero]
  have horder : 0 ≤ w.order := by
    rw [← HahnSeries.order_eq_orderTop_of_ne_zero hwzero] at hw
    exact WithTop.coe_le_coe.mp hw
  have hwp : (w ^ p).orderTop = (((p : ℤ) * w.order : ℤ) : WithTop ℤ) := by
    rw [laurent_orderTop_power, ← HahnSeries.order_eq_orderTop_of_ne_zero hwzero]
    simp only [← WithTop.coe_nsmul, nsmul_eq_mul]
  by_cases hworder : w.order = 0
  · have hphi : (w ^ p + q).orderTop = (0 : WithTop ℤ) := by
      have hlt : (w ^ p).orderTop < q.orderTop := by
        rw [hwp, hq, hworder]
        exact WithTop.coe_lt_coe.mpr (by simp)
      rw [HahnSeries.orderTop_add_eq_left hlt, hwp, hworder]
      simp
    have hphiIntegral : (0 : WithTop ℤ) ≤ (w ^ p + q).orderTop := hphi.ge
    have hpower := laurent_orderTop_power_bound (w ^ p + q) 0 (p - 2) hphiIntegral
    have hnum : (0 : WithTop ℤ) ≤ (w * (w ^ p + q) ^ (p - 2)).orderTop := by
      simpa only [mul_zero, add_zero] using
        laurent_orderTop_mul_bound w ((w ^ p + q) ^ (p - 2)) 0 0 hw hpower
    have hderiv := laurent_derivative_integral_order _ hnum
    have hbound := laurent_square_quotient_orderTop_bound
      (LaurentSeries.derivative k (w * (w ^ p + q) ^ (p - 2)))
      (w ^ p + q) 0 0 (2 * p - 3) hderiv hphi
    simp only [mul_zero, sub_zero] at hbound
    exact le_trans (WithTop.coe_le_coe.mpr (by omega)) hbound
  · have hwpositive : 1 ≤ w.order := by omega
    have hphi : (w ^ p + q).orderTop = (((r : ℤ) + 1 : ℤ) : WithTop ℤ) := by
      have hlt : q.orderTop < (w ^ p).orderTop := by
        rw [hwp, hq]
        apply WithTop.coe_lt_coe.mpr
        have hpz : (p : ℤ) = 2 * (r : ℤ) + 1 := by exact_mod_cast hp
        nlinarith
      exact (HahnSeries.orderTop_add_eq_right hlt).trans hq
    have hwone : (1 : WithTop ℤ) ≤ w.orderTop := by
      rw [← HahnSeries.order_eq_orderTop_of_ne_zero hwzero]
      exact WithTop.coe_le_coe.mpr hwpositive
    have hpower := laurent_orderTop_power_bound (w ^ p + q) ((r : ℤ) + 1)
      (p - 2) hphi.ge
    have hnum := laurent_orderTop_mul_bound w ((w ^ p + q) ^ (p - 2))
      1 (((p - 2 : ℕ) : ℤ) * ((r : ℤ) + 1)) hwone hpower
    have hindex : 1 + ((p - 2 : ℕ) : ℤ) * ((r : ℤ) + 1) =
        (p : ℤ) * (r : ℤ) := by
      rw [Nat.cast_sub (by omega), hp]
      push_cast
      ring
    rw [hindex] at hnum
    have hderiv := laurent_derivative_orderTop_bound_of_characteristic_dvd p
      (w * (w ^ p + q) ^ (p - 2)) ((p : ℤ) * (r : ℤ)) hnum
      (dvd_mul_right (p : ℤ) (r : ℤ))
    have hbound := laurent_square_quotient_orderTop_bound
      (LaurentSeries.derivative k (w * (w ^ p + q) ^ (p - 2)))
      (w ^ p + q) ((p : ℤ) * (r : ℤ)) ((r : ℤ) + 1) (2 * p - 3) hderiv hphi
    have hexponent : 2 * ((p : ℤ) * (r : ℤ)) -
        ((2 * p - 3 : ℕ) : ℤ) * ((r : ℤ) + 1) = 1 - (r : ℤ) := by
      rw [Nat.cast_sub (by omega), hp]
      push_cast
      ring
    simpa only [hexponent] using hbound

end Litt3.CartierAndSpin
