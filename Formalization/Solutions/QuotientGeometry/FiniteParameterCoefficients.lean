import Definitions.QuotientGeometry.FiniteParameterCoefficients

namespace Litt3.QuotientGeometry

theorem finite_parameter_basis_factor
    {k : Type*} [Field k] (n : ℕ) (b c : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (j : ℕ) :
    finiteParameterBasis n b j = PowerSeries.X ^ j * c ^ (j / n) := by
  simp only [finiteParameterBasis, hb, mul_pow, ← mul_assoc, ← pow_mul, ← pow_add]
  rw [Nat.mod_add_div]

theorem finite_parameter_basis_coefficient_zero
    {k : Type*} [Field k] (n : ℕ) (b c : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (m j : ℕ) (hmj : m < j) :
    PowerSeries.coeff m (finiteParameterBasis n b j) = 0 := by
  rw [finite_parameter_basis_factor n b c hb j, PowerSeries.coeff_X_pow_mul',
    if_neg (by omega)]

theorem finite_parameter_basis_diagonal
    {k : Type*} [Field k] (n : ℕ) (b c : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (j : ℕ) :
    PowerSeries.coeff j (finiteParameterBasis n b j) = PowerSeries.constantCoeff c ^ (j / n) := by
  rw [finite_parameter_basis_factor n b c hb j]
  simpa using PowerSeries.coeff_X_pow_mul (c ^ (j / n)) j 0

theorem finite_parameter_coefficient_recursion
    {k : Type*} [Field k] (n : ℕ) (b c f : PowerSeries k) (j : ℕ) :
    finiteParameterCoeff n b c f j =
      (PowerSeries.coeff j f - ∑ i : Fin j,
        finiteParameterCoeff n b c f i.val * PowerSeries.coeff j (finiteParameterBasis n b i.val)) /
        PowerSeries.constantCoeff c ^ (j / n) := by
  rw [finiteParameterCoeff, Nat.strongRecOn'_beta]
  rfl

/-- The recursion solves every actual coefficient equation, with no
bounded truncation assumption. -/
theorem finite_parameter_coefficient_equation
    {k : Type*} [Field k] (n : ℕ) (b c f : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (hc : PowerSeries.constantCoeff c ≠ 0) (m : ℕ) :
    (∑ j ∈ Finset.range (m + 1), finiteParameterCoeff n b c f j *
      PowerSeries.coeff m (finiteParameterBasis n b j)) = PowerSeries.coeff m f := by
  rw [Finset.sum_range_succ, finite_parameter_basis_diagonal n b c hb m,
    finite_parameter_coefficient_recursion n b c f m]
  have hsum : (∑ i : Fin m, finiteParameterCoeff n b c f i.val *
      PowerSeries.coeff m (finiteParameterBasis n b i.val)) =
      ∑ i ∈ Finset.range m, finiteParameterCoeff n b c f i *
        PowerSeries.coeff m (finiteParameterBasis n b i) :=
    Fin.sum_univ_eq_sum_range
      (fun i => finiteParameterCoeff n b c f i * PowerSeries.coeff m (finiteParameterBasis n b i)) m
  rw [hsum]
  rw [div_mul_cancel₀ _ (pow_ne_zero _ hc)]
  ring

end Litt3.QuotientGeometry
