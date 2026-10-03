import Solutions.QuotientGeometry.FiniteParameterEmbedding

namespace Litt3.QuotientGeometry

/-- The actual coefficient unit is extracted from an arbitrary original
positive-order parameter, rather than supplied as additional data. -/
theorem positive_parameter_canonical_factor
    {k : Type*} [Field k] (n : ℕ) (b : PowerSeries k)
    (hb : b.order = n) :
    b = PowerSeries.X ^ n * PowerSeries.divXPowOrder b ∧
      PowerSeries.constantCoeff (PowerSeries.divXPowOrder b) ≠ 0 := by
  have hto : b.order.toNat = n := by rw [hb]; simp
  constructor
  · simpa only [hto] using (PowerSeries.X_pow_order_mul_divXPowOrder (f := b)).symm
  · rw [ne_eq, PowerSeries.constantCoeff_divXPowOrder_eq_zero_iff]
    intro hz
    rw [hz, PowerSeries.order_zero] at hb
    simp at hb

theorem positive_parameter_constant_zero
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b : PowerSeries k)
    (hb : b.order = n) : PowerSeries.constantCoeff b = 0 := by
  rw [← PowerSeries.coeff_zero_eq_constantCoeff]
  apply PowerSeries.coeff_of_lt_order
  rw [hb]
  exact_mod_cast hn

theorem tame_degree_cast_ne_zero
    {k : Type*} [Field k] (p h : ℕ) [CharP k p] [Fact p.Prime]
    (hh : 0 < h) (hdiv : h ∣ p - 1) : (h : k) ≠ 0 := by
  apply (CharP.cast_eq_zero_iff k p h).not.mpr
  apply Nat.not_dvd_of_pos_of_lt hh
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  have hle := Nat.le_of_dvd (by omega : 0 < p - 1) hdiv
  omega

end Litt3.QuotientGeometry
