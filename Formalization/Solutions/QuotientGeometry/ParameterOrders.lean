import Solutions.QuotientGeometry.FiniteParameterEmbedding

namespace Litt3.QuotientGeometry

theorem parameter_substitution_constant_coefficient
    {k : Type*} [Field k] (b f : PowerSeries k)
    (hb : PowerSeries.constantCoeff b = 0) :
    PowerSeries.constantCoeff (PowerSeries.subst b f) = PowerSeries.constantCoeff f := by
  simpa using parameter_substitution_coefficient b f hb 0

theorem finite_parameter_substitution_coefficient_zero
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b c f : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (d m : ℕ)
    (hf : ∀ j, j < d → PowerSeries.coeff j f = 0) (hm : m < n * d) :
    PowerSeries.coeff m (PowerSeries.subst b f) = 0 := by
  have hb0 : PowerSeries.constantCoeff b = 0 := by
    rw [hb, map_mul, map_pow, PowerSeries.constantCoeff_X, zero_pow (by omega), zero_mul]
  rw [parameter_substitution_coefficient b f hb0]
  apply Finset.sum_eq_zero
  intro j _
  by_cases hj : j < d
  · rw [hf j hj, zero_mul]
  · rw [finite_parameter_power_coefficient_zero n b c hb m j
      (lt_of_lt_of_le hm (Nat.mul_le_mul_left n (by omega))), mul_zero]

/-- True infinite-series order, with no truncation or finite-support hypothesis. -/
theorem finite_parameter_substitution_order
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b c f : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (hc : PowerSeries.constantCoeff c ≠ 0)
    (hf : f ≠ 0) :
    PowerSeries.order (PowerSeries.subst b f) = (n * (PowerSeries.order f).toNat : ℕ) := by
  refine (PowerSeries.order_eq_nat (φ := PowerSeries.subst b f)
    (n := n * (PowerSeries.order f).toNat)).mpr ?_
  have hlow : ∀ j, j < f.order.toNat → PowerSeries.coeff j f = 0 :=
    fun j hj => PowerSeries.coeff_of_lt_order_toNat j hj
  constructor
  · rw [finite_parameter_substitution_leading_coefficient n hn b c f hb _ hlow]
    exact mul_ne_zero (PowerSeries.coeff_order hf) (pow_ne_zero _ hc)
  · intro m hm
    exact finite_parameter_substitution_coefficient_zero n hn b c f hb _ m hlow hm

end Litt3.QuotientGeometry
