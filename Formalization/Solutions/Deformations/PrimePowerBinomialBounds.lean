import Mathlib.Data.Nat.Choose.Factorization
import Mathlib.Tactic

namespace Litt3.Deformations

/-- The exact full p-power binomial valuation identity, including
the terminal coefficient j=p^a. -/
theorem prime_power_binomial_factorization (p a j : ℕ) (prime : p.Prime)
    (positive : 0 < j) (bound : j ≤ p ^ a) :
    ((p ^ a).choose j).factorization p + j.factorization p = a :=
  Nat.factorization_choose_prime_pow_add_factorization prime bound positive.ne'

theorem prime_power_binomial_divisibility (p a j : ℕ) (prime : p.Prime)
    (positive : 0 < j) (bound : j ≤ p ^ a) :
    p ^ (a - j.factorization p) ∣ (p ^ a).choose j := by
  rw [← Nat.factorization_choose_prime_pow prime bound positive.ne']
  exact Nat.ordProj_dvd _ _

/-- The characteristic bound p>2h dominates every positive valuation
level, without any bounded table of primes or exponents. -/
theorem prime_power_dominates_linear_order (p h s : ℕ)
    (orderPositive : 0 < h) (characteristic : 2 * h < p) (positive : 0 < s) :
    h * (s + 1) + 1 ≤ p ^ s := by
  obtain ⟨n, rfl⟩ := Nat.exists_eq_succ_of_ne_zero positive.ne'
  clear positive
  induction n with
  | zero => simp only [Nat.zero_add, Nat.succ_eq_add_one, pow_one]; omega
  | succ n induction =>
    rw [pow_succ]
    have lower : 2 ≤ p := by omega
    have doubled : 2 * (h * (n + 1 + 1) + 1) ≤ 2 * p ^ (n + 1) :=
      Nat.mul_le_mul_left 2 induction
    have scaled : 2 * p ^ (n + 1) ≤ p ^ (n + 1) * p := by
      simpa only [Nat.mul_comm] using Nat.mul_le_mul_left (p ^ (n + 1)) lower
    have first : h * (n.succ + 1 + 1) + 1 ≤ 2 * (h * (n + 1 + 1) + 1) := by nlinarith
    exact first.trans (doubled.trans scaled)

/-- The full high-degree preparation bound for the norm coefficient.
Its exponent includes the denominator valuation of the actual binomial
coefficient and applies uniformly to every j in the full group range. -/
theorem high_binomial_preparation_exponent (p a h j : ℕ)
    (orderPositive : 0 < h) (characteristic : 2 * h < p)
    (high : h + 1 ≤ j) (bound : j ≤ p ^ a) :
    a + 1 ≤ (a - j.factorization p) + (j - 1) / h := by
  have jpositive : 0 < j := by omega
  have valuation_bound : j.factorization p ≤ a := Nat.factorization_le_of_le_pow bound
  have floor_bound : j.factorization p + 1 ≤ (j - 1) / h := by
    rw [Nat.le_div_iff_mul_le orderPositive]
    by_cases zero : j.factorization p = 0
    · simp only [zero, Nat.zero_add, one_mul]
      omega
    · have growth := prime_power_dominates_linear_order p h (j.factorization p)
        orderPositive characteristic (Nat.pos_of_ne_zero zero)
      have divides : p ^ j.factorization p ∣ j := Nat.ordProj_dvd j p
      have lower := Nat.le_of_dvd jpositive divides
      rw [Nat.mul_comm]
      omega
  omega

end Litt3.Deformations
