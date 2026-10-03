import Solutions.QuotientGeometry.FiniteParameterCoefficients
import Solutions.QuotientGeometry.FiniteParameterSummation
import Solutions.QuotientGeometry.ParameterSubstitutionCoefficients

namespace Litt3.QuotientGeometry

theorem weighted_parameter_substitution_coefficient
    {k : Type*} [Field k] (b f : PowerSeries k)
    (hb : PowerSeries.constantCoeff b = 0) (i m : ℕ) :
    PowerSeries.coeff m (PowerSeries.X ^ i * PowerSeries.subst b f) =
      ∑ d ∈ Finset.range (m + 1), PowerSeries.coeff d f *
        PowerSeries.coeff m (PowerSeries.X ^ i * b ^ d) := by
  classical
  by_cases him : i ≤ m
  · rw [PowerSeries.coeff_X_pow_mul', if_pos him,
      parameter_substitution_coefficient b f hb (m - i)]
    have hcoeff (d : ℕ) : PowerSeries.coeff m (PowerSeries.X ^ i * b ^ d) =
        PowerSeries.coeff (m - i) (b ^ d) := by
      rw [PowerSeries.coeff_X_pow_mul', if_pos him]
    simp_rw [hcoeff]
    apply Finset.sum_subset (Finset.range_mono (by omega))
    intro d _ hd
    rw [parameter_power_coefficient_zero b hb (m - i) d (by
      simp only [Finset.mem_range] at hd
      omega), mul_zero]
  · rw [PowerSeries.coeff_X_pow_mul', if_neg him]
    symm
    apply Finset.sum_eq_zero
    intro d _
    rw [PowerSeries.coeff_X_pow_mul', if_neg him, mul_zero]

theorem finite_parameter_basis_residue
    {k : Type*} [Field k] (n : ℕ) (b : PowerSeries k) (d : ℕ) (i : Fin n) :
    finiteParameterBasis n b (d * n + i.val) = PowerSeries.X ^ i.val * b ^ d := by
  have hmod : (d * n + i.val) % n = i.val := Nat.mul_add_mod_of_lt i.isLt
  have hdiv : (d * n + i.val) / n = d := by
    rw [Nat.mul_comm d n, Nat.mul_add_div (lt_of_le_of_lt (Nat.zero_le i.val) i.isLt),
      Nat.div_eq_of_lt i.isLt,
      add_zero]
  rw [finiteParameterBasis, hmod, hdiv]

/-- Every power series has a finite residue-class expansion over a
parameter of order `n`. This is an exact identity of the whole series. -/
theorem finite_parameter_power_series_decomposition
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b c f : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (hc : PowerSeries.constantCoeff c ≠ 0) :
    f = ∑ i : Fin n, PowerSeries.X ^ i.val *
      PowerSeries.subst b (finiteParameterComponents n b c f i) := by
  classical
  have hb0 : PowerSeries.constantCoeff b = 0 := by
    rw [hb, map_mul, map_pow, PowerSeries.constantCoeff_X, zero_pow (by omega), zero_mul]
  ext m
  rw [map_sum]
  simp_rw [weighted_parameter_substitution_coefficient b _ hb0]
  simp only [finiteParameterComponents, PowerSeries.coeff_mk]
  rw [Finset.sum_comm]
  simp_rw [← finite_parameter_basis_residue n b]
  rw [finite_parameter_residue_sum n hn m
    (fun j => finiteParameterCoeff n b c f j *
      PowerSeries.coeff m (finiteParameterBasis n b j)) (fun j hj => by
        dsimp only
        rw [finite_parameter_basis_coefficient_zero n b c hb m j hj, mul_zero])]
  exact (finite_parameter_coefficient_equation n b c f hb hc m).symm

end Litt3.QuotientGeometry
