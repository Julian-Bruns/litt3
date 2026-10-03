import Theorems.Deformations.PreparedCyclicLogNorm
import Solutions.Deformations.PreparedCyclicNormTruncation
import Solutions.Deformations.PrimePowerLowBinomialCoefficient

namespace Litt3.Deformations

open Polynomial

variable {R B : Type*} [CommRing R] [Ring B] [Algebra R B]

theorem truncated_log_value_aeval (h : ℕ) (x : B) :
    truncatedLogValue (R := R) h x = Polynomial.aeval x (truncatedLogPolynomial (R := R) h) := by
  simp only [truncatedLogValue, truncatedLogPolynomial, map_sum, map_mul, map_pow,
    Polynomial.aeval_C, Polynomial.aeval_X, Algebra.smul_def]

theorem truncated_log_polynomial_constant (h : ℕ) (positive : 0 < h) :
    (truncatedLogPolynomial (R := R) h).coeff 0 = 1 := by
  classical
  simp [truncatedLogPolynomial, Polynomial.coeff_X_pow, positive]

theorem truncated_log_value_unit (h : ℕ) (positive : 0 < h) (x : B) (nilpotent : IsNilpotent x) :
    IsUnit (truncatedLogValue (R := R) h x) := by
  let P := truncatedLogPolynomial (R := R) h
  have constant : P.coeff 0 = 1 := truncated_log_polynomial_constant h positive
  have identity := congrArg (Polynomial.aeval x) (Polynomial.X_mul_divX_add P)
  simp only [map_add, map_mul, Polynomial.aeval_X, constant,
    map_one] at identity
  have commute : Commute x (Polynomial.aeval x P.divX) := by
    have mapped := (Polynomial.commute_X P.divX).map (Polynomial.aeval x).toMonoidHom
    change Commute (Polynomial.aeval x X) (Polynomial.aeval x P.divX) at mapped
    simpa only [Polynomial.aeval_X] using mapped
  rw [truncated_log_value_aeval]
  change IsUnit (Polynomial.aeval x P)
  rw [← identity, add_comm]
  exact (commute.isNilpotent_mul_right nilpotent).isUnit_one_add

theorem truncated_log_value_interval (h : ℕ) (x : B) :
    (∑ j ∈ Finset.Icc 1 h, ((-1 : R) ^ (j - 1) * Ring.inverse (j : R)) • x ^ (j - 1)) =
      truncatedLogValue (R := R) h x := by
  classical
  unfold truncatedLogValue
  symm
  apply Finset.sum_bij (fun i _ => i + 1)
  · intro i member
    simp only [Finset.mem_range] at member
    simp only [Finset.mem_Icc]
    omega
  · intro i member j member' same
    omega
  · intro j member
    simp only [Finset.mem_Icc] at member
    exact ⟨j - 1, by simp only [Finset.mem_range]; omega, by omega⟩
  · intro i member
    simp

/-- The complete exact integral logarithmic norm formula on every
prepared operator over every p-power coefficient ring, with arbitrary
noncommuting corrections and no finite coefficient-module rank. -/
theorem prepared_cyclic_log_norm (p a h : ℕ) [Fact p.Prime]
    (orderPositive : 0 < h) (characteristic : 2 * h < p) (bound : h ≤ p ^ a)
    (x correction : B) (power : x ^ h = (p : R) • correction)
    (nilpotent : (p : R) ^ (a + 1) = 0) :
    Specifications.PreparedCyclicLogNorm (R := R) p a h x := by
  constructor
  · unfold integralCyclicNormValue
    rw [prepared_cyclic_norm_truncation p a h (Fact.out : p.Prime) orderPositive
      characteristic bound x correction power nilpotent]
    calc
      (∑ j ∈ Finset.Icc 1 h, (((p ^ a).choose j : ℕ) : R) • x ^ (j - 1)) =
          ∑ j ∈ Finset.Icc 1 h, (p : R) ^ a •
            (((-1 : R) ^ (j - 1) * Ring.inverse (j : R)) • x ^ (j - 1)) := by
        apply Finset.sum_congr rfl
        intro j member
        obtain ⟨positive, high⟩ := Finset.mem_Icc.mp member
        rw [prime_power_low_binomial_coefficient p a j positive (high.trans bound) nilpotent
          (small_denominator_unit p (a + 1) j (Fact.out : p.Prime) positive (by omega) nilpotent),
          mul_smul]
      _ = (p : R) ^ a • truncatedLogValue (R := R) h x := by
        rw [← Finset.smul_sum, truncated_log_value_interval]
  · have scalarNilpotent : IsNilpotent (p : R) := ⟨a + 1, nilpotent⟩
    have powerNilpotent : IsNilpotent (x ^ h) := by
      rw [power]
      exact nilpotent_scalar_multiple (p : R) scalarNilpotent correction
    exact truncated_log_value_unit h orderPositive x powerNilpotent.of_pow

end Litt3.Deformations
