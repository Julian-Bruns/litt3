import Solutions.QuotientGeometry.PowerSeriesPrincipalOrders
import Mathlib.RingTheory.PowerSeries.Inverse
import Mathlib.Algebra.Group.Irreducible.Lemmas

namespace Litt3.QuotientGeometry

theorem power_series_ring_equiv_order_X
    {k l : Type*} [Field k] [Field l] (e : PowerSeries k ≃+* PowerSeries l) :
    PowerSeries.order (e PowerSeries.X) = 1 := by
  have hirr : Irreducible (e PowerSeries.X) :=
    PowerSeries.X_irreducible.map e
  obtain ⟨u, hu⟩ := IsDiscreteValuationRing.associated_of_irreducible (PowerSeries l) hirr
    (PowerSeries.X_irreducible (R := l))
  have hord := congrArg PowerSeries.order hu
  rw [PowerSeries.order_mul, PowerSeries.order_zero_of_unit u.isUnit, add_zero,
    PowerSeries.order_X] at hord
  exact hord

/-- Arbitrary ring equivalences of the actual completed DVR preserve its
whole additive valuation; coefficientwise continuity is not an assumption. -/
theorem power_series_ring_equiv_order
    {k l : Type*} [Field k] [Field l] (e : PowerSeries k ≃+* PowerSeries l)
    (f : PowerSeries k) : PowerSeries.order (e f) = PowerSeries.order f := by
  by_cases hf : f = 0
  · simp [hf]
  have hfactor := PowerSeries.X_pow_order_mul_divXPowOrder (f := f)
  have heunit : IsUnit (e (PowerSeries.divXPowOrder f)) :=
    (PowerSeries.isUnit_divided_by_X_pow_order hf).map e
  conv_lhs => rw [← hfactor]
  rw [map_mul, map_pow, PowerSeries.order_mul, PowerSeries.order_pow,
    power_series_ring_equiv_order_X, PowerSeries.order_zero_of_unit heunit]
  simpa only [nsmul_one, add_zero] using PowerSeries.coe_toNat_order hf

theorem nonzero_power_series_coe_order
    {k : Type*} [Field k] (f : PowerSeries k) (hf : f ≠ 0) :
    (f : LaurentSeries k).order = (PowerSeries.order f).toNat := by
  let u := PowerSeries.divXPowOrder f
  have hu : IsUnit u := PowerSeries.isUnit_divided_by_X_pow_order hf
  have hcu : PowerSeries.constantCoeff u ≠ 0 :=
    isUnit_iff_ne_zero.mp (PowerSeries.isUnit_iff_constantCoeff.mp hu)
  have huL : (u : LaurentSeries k) ≠ 0 := by
    intro hz
    have hzero : u = 0 := by
      apply (HahnSeries.ofPowerSeries_injective (Γ := ℤ) (R := k))
      simpa using hz
    exact hu.ne_zero hzero
  have hfactor : (f : LaurentSeries k) =
      HahnSeries.single ((PowerSeries.order f).toNat : ℤ) 1 * (u : LaurentSeries k) := by
    conv_lhs => rw [← PowerSeries.X_pow_order_mul_divXPowOrder (f := f)]
    rw [PowerSeries.coe_mul,
      PowerSeries.coe_pow, PowerSeries.coe_X, HahnSeries.single_pow]
    simp only [one_pow, nsmul_eq_mul, mul_one]
    rfl
  rw [hfactor, HahnSeries.order_mul (HahnSeries.single_ne_zero one_ne_zero) huL,
    HahnSeries.order_single one_ne_zero, power_series_coe_unit_order u hcu, add_zero]

theorem compatible_laurent_equiv_order
    {k l : Type*} [Field k] [Field l]
    (e : PowerSeries k ≃+* PowerSeries l) (E : LaurentSeries k ≃+* LaurentSeries l)
    (hE : ∀ f : PowerSeries k, E (f : LaurentSeries k) = (e f : PowerSeries l))
    (f : LaurentSeries k) : (E f).order = f.order := by
  by_cases hf : f = 0
  · simp [hf]
  let u := LaurentSeries.powerSeriesPart f
  have hu : PowerSeries.constantCoeff u ≠ 0 := by
    simpa only [u, ← PowerSeries.coeff_zero_eq_constantCoeff,
      LaurentSeries.powerSeriesPart_coeff, Nat.cast_zero, add_zero] using
      HahnSeries.coeff_order_ne_zero hf
  have heunit : IsUnit (e u) :=
    (PowerSeries.isUnit_iff_constantCoeff.mpr (isUnit_iff_ne_zero.mpr hu)).map e
  have heu : PowerSeries.constantCoeff (e u) ≠ 0 :=
    isUnit_iff_ne_zero.mp (PowerSeries.isUnit_iff_constantCoeff.mp heunit)
  have heXL : (e PowerSeries.X : LaurentSeries l).order = 1 := by
    rw [nonzero_power_series_coe_order _ (by simpa using e.injective.ne PowerSeries.X_ne_zero),
      power_series_ring_equiv_order_X]
    rfl
  have hsingle : ∀ n : ℤ, (E (HahnSeries.single n 1)).order = n := by
    intro n
    have hxpow : (HahnSeries.single n (1 : k) : LaurentSeries k) =
        ((PowerSeries.X : PowerSeries k) : LaurentSeries k) ^ n := by
      simpa only [PowerSeries.coe_X] using RatFunc.single_zpow (F := k) n
    rw [hxpow, map_zpow₀, hE]
    have hne : (e PowerSeries.X : LaurentSeries l) ≠ 0 := by
      intro hz
      exact e.injective.ne PowerSeries.X_ne_zero
        ((HahnSeries.ofPowerSeries_injective (Γ := ℤ) (R := l)) (by simpa using hz))
    cases n with
    | ofNat m => simpa [heXL] using HahnSeries.order_pow (e PowerSeries.X : LaurentSeries l) m
    | negSucc m =>
      rw [zpow_negSucc, laurent_order_inverse, HahnSeries.order_pow, heXL]
      simp only [nsmul_eq_mul, Int.natCast_add, Int.natCast_one, mul_one]
      omega
  have heuL : (e u : LaurentSeries l) ≠ 0 := by
    intro hz
    exact heunit.ne_zero ((HahnSeries.ofPowerSeries_injective (Γ := ℤ) (R := l)) (by simpa using hz))
  conv_lhs => rw [← LaurentSeries.single_order_mul_powerSeriesPart f]
  rw [map_mul, hE]
  rw [HahnSeries.order_mul (by simpa using E.injective.ne (HahnSeries.single_ne_zero
      (g := f.order) (R := k) one_ne_zero)) heuL,
    hsingle, power_series_coe_unit_order (e u) heu, add_zero]

end Litt3.QuotientGeometry
