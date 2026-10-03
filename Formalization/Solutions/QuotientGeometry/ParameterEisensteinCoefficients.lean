import Solutions.QuotientGeometry.ParameterEmbeddingRegularity
import Mathlib.Algebra.Polynomial.Expand

namespace Litt3.QuotientGeometry

theorem finite_parameter_substitution_small_coefficient
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b c f : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (m : ℕ) (hm : m < n) :
    PowerSeries.coeff m (PowerSeries.subst b f) =
      if m = 0 then PowerSeries.constantCoeff f else 0 := by
  classical
  have hb0 : PowerSeries.constantCoeff b = 0 := by
    rw [hb, map_mul, map_pow, PowerSeries.constantCoeff_X, zero_pow (by omega), zero_mul]
  by_cases hm0 : m = 0
  · subst m
    simpa using parameter_substitution_constant_coefficient b f hb0
  · rw [if_neg hm0, parameter_substitution_coefficient b f hb0]
    apply Finset.sum_eq_zero
    intro d _
    by_cases hd : d = 0
    · subst d
      simp [PowerSeries.coeff_one, hm0]
    · rw [finite_parameter_power_coefficient_zero n b c hb m d
        (lt_of_lt_of_le hm (by simpa using Nat.mul_le_mul_left n (show 1 ≤ d by omega))),
        mul_zero]

theorem finite_parameter_polynomial_small_coefficient
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b c : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (hb0 : PowerSeries.constantCoeff b = 0)
    (q : Polynomial (CompletedPowerSeriesBase k)) (m : ℕ) (hm : m < n) :
    PowerSeries.coeff m (q.eval₂ (liftedCompletedEmbedding b hb0) PowerSeries.X) =
      PowerSeries.constantCoeff (q.coeff m).down := by
  classical
  induction q using Polynomial.induction_on' with
  | add q r hq hr =>
    simp only [Polynomial.eval₂_add, map_add, hq, hr, Polynomial.coeff_add]
    change PowerSeries.constantCoeff (q.coeff m).down + PowerSeries.constantCoeff (r.coeff m).down =
      PowerSeries.constantCoeff ((q.coeff m).down + (r.coeff m).down)
    exact (map_add _ _ _).symm
  | monomial j a =>
    rw [Polynomial.eval₂_monomial, PowerSeries.coeff_mul_X_pow', lifted_completed_embedding_apply]
    by_cases hj : j ≤ m
    · rw [if_pos hj, finite_parameter_substitution_small_coefficient n hn b c a.down hb
        (m - j) (lt_of_le_of_lt (Nat.sub_le m j) hm)]
      by_cases heq : m = j
      · subst m
        simp
      · have hsub : m - j ≠ 0 := by omega
        simp [Polynomial.coeff_monomial, heq, hsub, Ne.symm heq]
    · simp [hj, Polynomial.coeff_monomial, show j ≠ m by omega]

/-- All lower coefficients of any degree-n monic relation for the actual
uniformizer vanish modulo the downstairs parameter. -/
theorem finite_parameter_relation_lower_constants
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b c : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (hb0 : PowerSeries.constantCoeff b = 0)
    (q : Polynomial (CompletedPowerSeriesBase k))
    (hq : q.eval₂ (liftedCompletedEmbedding b hb0) PowerSeries.X = 0) :
    ∀ m, m < n → PowerSeries.constantCoeff (q.coeff m).down = 0 := by
  intro m hm
  have hcoeff := congrArg (PowerSeries.coeff m) hq
  rw [finite_parameter_polynomial_small_coefficient n hn b c hb hb0 q m hm,
    map_zero] at hcoeff
  exact hcoeff

/-- The constant coefficient of a genuine monic degree-n relation has
downstairs order exactly one. This is obtained from the actual coefficient
of X^n, rather than supplied as an Eisenstein assumption. -/
theorem finite_parameter_relation_constant_first_coefficient
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b c : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (hb0 : PowerSeries.constantCoeff b = 0)
    (q : Polynomial (CompletedPowerSeriesBase k)) (hmonic : q.Monic)
    (hdegree : q.natDegree = n)
    (hq : q.eval₂ (liftedCompletedEmbedding b hb0) PowerSeries.X = 0) :
    PowerSeries.coeff 1 (q.coeff 0).down * PowerSeries.constantCoeff c = -1 := by
  classical
  have hlow := finite_parameter_relation_lower_constants n hn b c hb hb0 q hq
  have hzero : ∀ j, j < 1 → PowerSeries.coeff j (q.coeff 0).down = 0 := by
    intro j hj
    have hj0 : j = 0 := by omega
    subst j
    simpa only [PowerSeries.coeff_zero_eq_constantCoeff] using hlow 0 hn
  have hconstant : PowerSeries.coeff n
      (liftedCompletedEmbedding b hb0 (q.coeff 0) * PowerSeries.X ^ 0) =
      PowerSeries.coeff 1 (q.coeff 0).down * PowerSeries.constantCoeff c := by
    rw [pow_zero, mul_one, lifted_completed_embedding_apply]
    simpa using finite_parameter_substitution_leading_coefficient n hn b c
      (q.coeff 0).down hb 1 hzero
  have hother (i : ℕ) (hi : i ∈ Finset.range n) (hi0 : i ≠ 0) :
      PowerSeries.coeff n (liftedCompletedEmbedding b hb0 (q.coeff i) * PowerSeries.X ^ i) = 0 := by
    have hin : i < n := Finset.mem_range.mp hi
    rw [PowerSeries.coeff_mul_X_pow', if_pos (by omega), lifted_completed_embedding_apply]
    apply finite_parameter_substitution_coefficient_zero n hn b c (q.coeff i).down hb 1
    · intro j hj
      have hj0 : j = 0 := by omega
      subst j
      simpa only [PowerSeries.coeff_zero_eq_constantCoeff] using hlow i hin
    · simpa using (show n - i < n by omega)
  have hleading : PowerSeries.coeff n
      (liftedCompletedEmbedding b hb0 (q.coeff n) * PowerSeries.X ^ n) = 1 := by
    have hcq : q.coeff n = 1 := hdegree ▸ hmonic.coeff_natDegree
    simp [hcq, PowerSeries.coeff_X_pow]
  have hsum : (∑ i ∈ Finset.range n, PowerSeries.coeff n
      (liftedCompletedEmbedding b hb0 (q.coeff i) * PowerSeries.X ^ i)) =
      PowerSeries.coeff 1 (q.coeff 0).down * PowerSeries.constantCoeff c := by
    rw [Finset.sum_eq_single 0]
    · exact hconstant
    · exact hother
    · simp [hn.ne']
  have hcoeff := congrArg (PowerSeries.coeff n) hq
  rw [Polynomial.eval₂_eq_sum_range, hdegree, map_sum, Finset.sum_range_succ,
    hleading, hsum, map_zero] at hcoeff
  exact eq_neg_of_add_eq_zero_left hcoeff

theorem finite_parameter_relation_constant_order_one
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b c : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (hb0 : PowerSeries.constantCoeff b = 0)
    (q : Polynomial (CompletedPowerSeriesBase k)) (hmonic : q.Monic)
    (hdegree : q.natDegree = n)
    (hq : q.eval₂ (liftedCompletedEmbedding b hb0) PowerSeries.X = 0) :
    PowerSeries.order (q.coeff 0).down = 1 := by
  apply PowerSeries.order_eq_nat.mpr
  constructor
  · intro hz
    have heq := finite_parameter_relation_constant_first_coefficient n hn b c hb hb0 q
      hmonic hdegree hq
    rw [hz, zero_mul] at heq
    exact one_ne_zero (neg_eq_zero.mp heq.symm)
  · intro j hj
    have hj0 : j = 0 := by omega
    subst j
    simpa only [PowerSeries.coeff_zero_eq_constantCoeff] using
      finite_parameter_relation_lower_constants n hn b c hb hb0 q hq 0 hn

end Litt3.QuotientGeometry
