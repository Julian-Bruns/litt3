import Mathlib.Algebra.CharP.Lemmas
import Mathlib.Tactic

namespace Litt3.Deformations

variable {A : Type*} [CommRing A]

/-- For positive congruence depth, actual pth powers improve every
prime-power congruence by one. This permits arbitrary coefficient
torsion and uses integral prime binomial divisibility. -/
theorem prime_power_difference_improves (p : ℕ) (prime : p.Prime)
    (n : ℕ) (positive : 0 < n) (x y : A)
    (difference : ∃ z : A, x - y = (p : A) ^ n * z) :
    ∃ z : A, x ^ p - y ^ p = (p : A) ^ (n + 1) * z := by
  obtain ⟨z, relation⟩ := difference
  have source : x = y + (p : A) ^ n * z := by linear_combination relation
  rw [source]
  obtain ⟨r, expansion⟩ := exists_add_pow_prime_eq prime y ((p : A) ^ n * z)
  have exponentBound : n + 1 ≤ n * p := by
    have := prime.two_le
    nlinarith
  refine ⟨(p : A) ^ (n * p - (n + 1)) * z ^ p + y * z * r, ?_⟩
  rw [expansion, mul_pow, ← pow_mul]
  have exponent : n * p = n + 1 + (n * p - (n + 1)) := by omega
  have scalarPower : (p : A) ^ (n * p) =
      (p : A) ^ (n + 1) * (p : A) ^ (n * p - (n + 1)) := by
    rw [← pow_add, ← exponent]
  rw [scalarPower, pow_succ]
  ring

end Litt3.Deformations
