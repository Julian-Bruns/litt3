import Solutions.Deformations.NilpotentPerturbation
import Mathlib.Tactic

namespace Litt3.Deformations

variable {R B : Type*} [CommRing R] [Ring B] [Algebra R B]

/-- An actual h-th power divisible by a central scalar makes every
actual m-th power divisible by its floor(m/h)-th scalar power. The
algebra and coefficient corrections can be noncommutative. -/
theorem preparation_power_divisibility (x : B) (parameter : R) (correction : B)
    (h m : ℕ) (power : x ^ h = parameter • correction) :
    ∃ remainder : B, x ^ m = parameter ^ (m / h) • remainder := by
  refine ⟨correction ^ (m / h) * x ^ (m % h), ?_⟩
  calc
    x ^ m = x ^ (h * (m / h) + m % h) := by
      rw [Nat.add_comm, Nat.mod_add_div]
    _ = (x ^ h) ^ (m / h) * x ^ (m % h) := by rw [pow_add, pow_mul]
    _ = parameter ^ (m / h) • (correction ^ (m / h) * x ^ (m % h)) := by
      rw [power, smul_pow, smul_mul_assoc]

/-- A scalar coefficient and a prepared actual power vanish as soon
as their combined scalar order reaches the actual nilpotence exponent. -/
theorem prepared_power_scalar_annihilation (x : B) (parameter : R) (correction : B)
    (h m b N : ℕ) (power : x ^ h = parameter • correction)
    (nilpotent : parameter ^ N = 0) (order : N ≤ b + m / h)
    (coefficient : R) (divisible : ∃ c : R, coefficient = parameter ^ b * c) :
    coefficient • x ^ m = 0 := by
  obtain ⟨c, rfl⟩ := divisible
  obtain ⟨remainder, equation⟩ := preparation_power_divisibility x parameter correction h m power
  rw [equation, smul_smul]
  have scalar : (parameter ^ b * c) * parameter ^ (m / h) = 0 := by
    calc
      (parameter ^ b * c) * parameter ^ (m / h) = parameter ^ (b + m / h) * c := by
        rw [pow_add]
        ring
      _ = 0 := by
        rw [← Nat.add_sub_of_le order, pow_add, nilpotent, zero_mul, zero_mul]
  rw [scalar, zero_smul]

end Litt3.Deformations
