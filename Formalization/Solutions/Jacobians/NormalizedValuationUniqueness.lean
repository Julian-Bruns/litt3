import Solutions.SharedTensors.DivisorSectionOrders

namespace Litt3.Jacobians

open scoped WithZero

variable {K : Type*} [Field K]

/-- Equivalent actual normalized integer valuations coincide. The two
normalizations are witnessed by genuine value-one uniformizers, rather
than an unspecified rescaling of the ordered value group. -/
theorem normalized_integer_valuations_equal
    (v w : Valuation K ℤᵐ⁰) (hequiv : v.IsEquiv w)
    (hv : ∃ p : K, v p = WithZero.exp (-1 : ℤ))
    (hw : ∃ q : K, w q = WithZero.exp (-1 : ℤ)) : v = w := by
  obtain ⟨p, hp⟩ := hv
  obtain ⟨q, hq⟩ := hw
  have hp0 : p ≠ 0 := (Valuation.ne_zero_iff v).mp
    (hp.trans_ne WithZero.coe_ne_zero)
  have hq0 : q ≠ 0 := (Valuation.ne_zero_iff w).mp
    (hq.trans_ne WithZero.coe_ne_zero)
  let pu : Kˣ := Units.mk0 p hp0
  let qu : Kˣ := Units.mk0 q hq0
  let np := valuationOrder w (Additive.ofMul pu)
  let nq := valuationOrder v (Additive.ofMul qu)
  have hwp : w p = WithZero.exp (-np) :=
    Litt3.SharedTensors.valuation_value_eq_exp_neg_order w (Additive.ofMul pu)
  have hvq : v q = WithZero.exp (-nq) :=
    Litt3.SharedTensors.valuation_value_eq_exp_neg_order v (Additive.ofMul qu)
  have hpl : v p < 1 := by rw [hp, ← WithZero.exp_zero, WithZero.exp_lt_exp]; omega
  have hql : w q < 1 := by rw [hq, ← WithZero.exp_zero, WithZero.exp_lt_exp]; omega
  have hnp : 1 ≤ np := by
    have h := (hequiv.lt_one_iff_lt_one).mp hpl
    rw [hwp, ← WithZero.exp_zero, WithZero.exp_lt_exp] at h
    omega
  have hnq : 1 ≤ nq := by
    have h := (hequiv.lt_one_iff_lt_one).mpr hql
    rw [hvq, ← WithZero.exp_zero, WithZero.exp_lt_exp] at h
    omega
  have hqp : v q ≤ v p := by
    rw [hvq, hp, WithZero.exp_le_exp]
    omega
  have hnp1 : np = 1 := by
    have h := (hequiv q p).mp hqp
    rw [hq, hwp, WithZero.exp_le_exp] at h
    omega
  have horderp : valuationOrder w (Additive.ofMul pu) = 1 := hnp1
  have horderpv : valuationOrder v (Additive.ofMul pu) = 1 := by
    simpa only [neg_neg] using valuation_order_of_value_exp v (Additive.ofMul pu) (-1) hp
  apply Valuation.ext
  intro a
  by_cases ha : a = 0
  · simp [ha]
  · let au : Kˣ := Units.mk0 a ha
    let n := valuationOrder v (Additive.ofMul au)
    let b : Additive Kˣ := Additive.ofMul au - n • Additive.ofMul pu
    have hb : valuationOrder v b = 0 := by
      rw [map_sub, map_zsmul, horderpv]
      simp [n]
    have hvb : v b.toMul.val = 1 := by
      rw [Litt3.SharedTensors.valuation_value_eq_exp_neg_order, hb, neg_zero, WithZero.exp_zero]
    have hwb : w b.toMul.val = 1 := (hequiv.eq_one_iff_eq_one).mp hvb
    have hbw := valuation_order_eq_zero_of_value_one w b hwb
    have horder : valuationOrder w (Additive.ofMul au) = n := by
      change valuationOrder w (Additive.ofMul au - n • Additive.ofMul pu) = 0 at hbw
      rw [map_sub, map_zsmul, horderp] at hbw
      simpa only [zsmul_eq_mul, mul_one, sub_eq_zero] using hbw
    change v (Additive.ofMul au).toMul.val = w (Additive.ofMul au).toMul.val
    rw [Litt3.SharedTensors.valuation_value_eq_exp_neg_order v (Additive.ofMul au),
      Litt3.SharedTensors.valuation_value_eq_exp_neg_order w (Additive.ofMul au), horder]

end Litt3.Jacobians
