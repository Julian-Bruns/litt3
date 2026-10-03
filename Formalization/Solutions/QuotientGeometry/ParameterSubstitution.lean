import Definitions.QuotientGeometry.ParameterInverseCoefficients
import Solutions.QuotientGeometry.ParameterSubstitutionCoefficients

namespace Litt3.QuotientGeometry

theorem parameter_inverse_coefficient_recursion
    {k : Type*} [Field k] (b f : PowerSeries k) (n : ℕ) :
    parameterInverseCoeff b f n =
      (PowerSeries.coeff n f - ∑ i : Fin n,
        parameterInverseCoeff b f i.val * PowerSeries.coeff n (b ^ i.val)) /
        PowerSeries.coeff 1 b ^ n := by
  rw [parameterInverseCoeff, Nat.strongRecOn'_beta]
  rfl

/-- An actual formal parameter with a nonzero linear coefficient induces
an injective substitution map. No characteristic restriction is used. -/
theorem parameter_substitution_injective
    {k : Type*} [Field k] (b : PowerSeries k)
    (hb : PowerSeries.constantCoeff b = 0) (hlinear : PowerSeries.coeff 1 b ≠ 0) :
    Function.Injective (PowerSeries.substAlgHom
      (PowerSeries.HasSubst.of_constantCoeff_zero' hb) : PowerSeries k →ₐ[k] PowerSeries k) := by
  intro f g hfg
  have hfg' : PowerSeries.subst b f = PowerSeries.subst b g := by
    simpa only [PowerSeries.coe_substAlgHom] using hfg
  ext n
  induction n using Nat.strong_induction_on with
  | h n ih =>
    have hcoeff := congrArg (PowerSeries.coeff n) hfg'
    rw [parameter_substitution_coefficient b f hb n,
      parameter_substitution_coefficient b g hb n,
      Finset.sum_range_succ, Finset.sum_range_succ,
      parameter_power_diagonal_coefficient b hb n] at hcoeff
    have hlower : (∑ i ∈ Finset.range n, PowerSeries.coeff i f * PowerSeries.coeff n (b ^ i)) =
        ∑ i ∈ Finset.range n, PowerSeries.coeff i g * PowerSeries.coeff n (b ^ i) := by
      apply Finset.sum_congr rfl
      intro i hi
      rw [ih i (Finset.mem_range.mp hi)]
    rw [hlower] at hcoeff
    exact mul_right_cancel₀ (pow_ne_zero n hlinear) (add_left_cancel hcoeff)

theorem parameter_inverse_series_substitutes
    {k : Type*} [Field k] (b f : PowerSeries k)
    (hb : PowerSeries.constantCoeff b = 0) (hlinear : PowerSeries.coeff 1 b ≠ 0) :
    PowerSeries.subst b (parameterInverseSeries b f) = f := by
  ext n
  rw [parameter_substitution_coefficient b _ hb n, Finset.sum_range_succ,
    parameter_power_diagonal_coefficient b hb n]
  simp only [parameterInverseSeries, PowerSeries.coeff_mk]
  rw [parameter_inverse_coefficient_recursion b f n]
  have hsum : (∑ i : Fin n, parameterInverseCoeff b f i.val * PowerSeries.coeff n (b ^ i.val)) =
      ∑ i ∈ Finset.range n, parameterInverseCoeff b f i * PowerSeries.coeff n (b ^ i) := by
    exact Fin.sum_univ_eq_sum_range
      (fun i => parameterInverseCoeff b f i * PowerSeries.coeff n (b ^ i)) n
  rw [hsum, div_mul_cancel₀ _ (pow_ne_zero n hlinear)]
  ring

/-- Every actual series has an actual inverse image under substitution
by a parameter of order one. The full inverse is constructed recursively. -/
theorem parameter_substitution_surjective
    {k : Type*} [Field k] (b : PowerSeries k)
    (hb : PowerSeries.constantCoeff b = 0) (hlinear : PowerSeries.coeff 1 b ≠ 0) :
    Function.Surjective (PowerSeries.substAlgHom
      (PowerSeries.HasSubst.of_constantCoeff_zero' hb) : PowerSeries k →ₐ[k] PowerSeries k) := by
  intro f
  refine ⟨parameterInverseSeries b f, ?_⟩
  simpa only [PowerSeries.coe_substAlgHom] using
    parameter_inverse_series_substitutes b f hb hlinear

end Litt3.QuotientGeometry
