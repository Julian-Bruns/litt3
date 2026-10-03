import Solutions.QuotientGeometry.LaurentUnitOrders
import Mathlib.RingTheory.Ideal.Span

namespace Litt3.QuotientGeometry

/-- The genuine Laurent valuation of a nonzero integral power series
determines its actual integral principal ideal. -/
theorem power_series_principal_ideal_of_laurent_order
    {k : Type*} [Field k] (f : PowerSeries k) (hf : f ≠ 0) (n : ℕ)
    (horder : (f : LaurentSeries k).order = (n : ℤ)) :
    Ideal.span {f} = Ideal.span {(PowerSeries.X : PowerSeries k) ^ n} := by
  have hfL : (f : LaurentSeries k) ≠ 0 := by
    intro hz
    apply hf
    apply (HahnSeries.ofPowerSeries_injective (Γ := ℤ) (R := k))
    simpa using hz
  let u : PowerSeries k := LaurentSeries.powerSeriesPart (f : LaurentSeries k)
  have hu : PowerSeries.constantCoeff u ≠ 0 := by
    simpa only [u, ← PowerSeries.coeff_zero_eq_constantCoeff,
      LaurentSeries.powerSeriesPart_coeff, Nat.cast_zero, add_zero] using
      HahnSeries.coeff_order_ne_zero hfL
  have hpow : ((PowerSeries.X ^ n : PowerSeries k) : LaurentSeries k) =
      HahnSeries.single (n : ℤ) 1 := by
    simp only [PowerSeries.coe_pow, PowerSeries.coe_X, HahnSeries.single_pow, one_pow,
      nsmul_eq_mul, mul_one]
  have hfactor : f = PowerSeries.X ^ n * u := by
    apply (HahnSeries.ofPowerSeries_injective (Γ := ℤ) (R := k))
    rw [PowerSeries.coe_mul, hpow]
    exact (horder ▸ LaurentSeries.single_order_mul_powerSeriesPart
      (f : LaurentSeries k)).symm
  rw [hfactor]
  exact Ideal.span_singleton_mul_right_unit
    (PowerSeries.isUnit_iff_constantCoeff.mpr (isUnit_iff_ne_zero.mpr hu)) _

theorem power_series_principal_ideal_laurent_order_iff
    {k : Type*} [Field k] (f : PowerSeries k) (n : ℕ) :
    Ideal.span {f} = Ideal.span {(PowerSeries.X : PowerSeries k) ^ n} ↔
      f ≠ 0 ∧ (f : LaurentSeries k).order = (n : ℤ) := by
  constructor
  · intro hideal
    obtain ⟨u, hu⟩ := Ideal.span_singleton_eq_span_singleton.mp hideal
    have hf : f ≠ 0 := by
      intro hz
      rw [hz, zero_mul] at hu
      exact (pow_ne_zero n PowerSeries.X_ne_zero) hu.symm
    have hfL : (f : LaurentSeries k) ≠ 0 := by
      intro hz
      apply hf
      apply (HahnSeries.ofPowerSeries_injective (Γ := ℤ) (R := k))
      simpa using hz
    have hcu : PowerSeries.constantCoeff (u : PowerSeries k) ≠ 0 :=
      isUnit_iff_ne_zero.mp (PowerSeries.isUnit_iff_constantCoeff.mp u.isUnit)
    have huL : ((u : PowerSeries k) : LaurentSeries k) ≠ 0 := by
      intro hz
      have hzero : (u : PowerSeries k) = 0 := by
        apply (HahnSeries.ofPowerSeries_injective (Γ := ℤ) (R := k))
        simpa using hz
      exact u.ne_zero hzero
    have horder := HahnSeries.order_mul hfL huL
    have heq : (f : LaurentSeries k) * ((u : PowerSeries k) : LaurentSeries k) =
        HahnSeries.single (n : ℤ) 1 := by
      rw [← PowerSeries.coe_mul, hu]
      simp only [PowerSeries.coe_pow, PowerSeries.coe_X, HahnSeries.single_pow, one_pow,
        nsmul_eq_mul, mul_one]
    rw [heq, HahnSeries.order_single one_ne_zero, power_series_coe_unit_order _ hcu,
      add_zero] at horder
    exact ⟨hf, horder.symm⟩
  · rintro ⟨hf, horder⟩
    exact power_series_principal_ideal_of_laurent_order f hf n horder

end Litt3.QuotientGeometry
