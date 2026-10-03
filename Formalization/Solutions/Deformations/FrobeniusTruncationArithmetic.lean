import Mathlib.Tactic

namespace Litt3.Deformations

/-- Successive allowed Frobenius powers differ by at least a factor p.
Primality is unnecessary for this purely arithmetic step. -/
theorem smaller_power_times_base_le (p a n : ℕ) (base : 1 < p) (smaller : p ^ a < p ^ n) :
    p * p ^ a ≤ p ^ n := by
  have exponents : a < n := (pow_lt_pow_iff_right₀ base).mp smaller
  calc
    p * p ^ a = p ^ (a + 1) := by rw [pow_succ, mul_comm]
    _ ≤ p ^ n := pow_le_pow_right₀ (by omega) (by omega)

/-- A unique largest Frobenius exponent yields the source's strict
dimension-independent degree bound whenever the number of lower
coordinates is at most p. This includes lower exponents equal to one. -/
theorem unique_largest_frobenius_degree_bound (I : Type*) [Fintype I]
    (p n : ℕ) (base : 1 < p) (positive : 0 < n) (a : I → ℕ)
    (smaller : ∀ i, a i < n) (dimension : Fintype.card I ≤ p) :
    (∑ i, (p ^ a i - 1)) < p ^ n - 1 := by
  have lower : ∀ i, p ^ a i ≤ p ^ (n - 1) := fun i =>
    pow_le_pow_right₀ (by omega) (by have := smaller i; omega)
  have sumBound : (∑ i, (p ^ a i - 1)) ≤ Fintype.card I * (p ^ (n - 1) - 1) := by
    calc
      (∑ i, (p ^ a i - 1)) ≤ ∑ _i : I, (p ^ (n - 1) - 1) :=
        Finset.sum_le_sum (fun i _ => Nat.sub_le_sub_right (lower i) 1)
      _ = Fintype.card I * (p ^ (n - 1) - 1) := by simp
  have bound := sumBound.trans (Nat.mul_le_mul_right (p ^ (n - 1) - 1) dimension)
  have positivePower : 0 < p ^ (n - 1) := pow_pos (by omega) _
  have factor : p * p ^ (n - 1) = p ^ n := by
    calc
      p * p ^ (n - 1) = p ^ ((n - 1) + 1) := by rw [pow_succ, mul_comm]
      _ = p ^ n := by congr 1; omega
  have subtraction : p * (p ^ (n - 1) - 1) + p = p * p ^ (n - 1) := by
    nlinarith [Nat.sub_add_cancel (show 1 ≤ p ^ (n - 1) by omega)]
  omega

/-- The p≥5 unequal-power rank-one specialization is derived from
the genuine Frobenius exponent gap, rather than enumerated ranks or jets. -/
theorem unequal_frobenius_rank_one_bound (p a n : ℕ) (base : 5 ≤ p)
    (smaller : p ^ a < p ^ n) : 4 * p ^ a < p ^ n + 3 := by
  have gap := smaller_power_times_base_le p a n (by omega) smaller
  have five : 5 * p ^ a ≤ p ^ n := (Nat.mul_le_mul_right (p ^ a) base).trans gap
  omega

end Litt3.Deformations
