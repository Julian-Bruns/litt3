import Solutions.Deformations.PrimePowerBinomialBounds
import Solutions.Deformations.PreparationPowerDivisibility

namespace Litt3.Deformations

variable {R B : Type*} [CommRing R] [Ring B] [Algebra R B]

/-- Every actual high integral cyclic norm term vanishes on the
prepared quotient. The bound is uniform in the prime, height, leading
order and all noncommuting coefficient corrections. -/
theorem prepared_cyclic_norm_high_term (p a h j : ℕ) (prime : p.Prime)
    (orderPositive : 0 < h) (characteristic : 2 * h < p)
    (high : h + 1 ≤ j) (bound : j ≤ p ^ a)
    (x correction : B) (power : x ^ h = (p : R) • correction)
    (nilpotent : (p : R) ^ (a + 1) = 0) :
    (((p ^ a).choose j : ℕ) : R) • x ^ (j - 1) = 0 := by
  have positive : 0 < j := by omega
  obtain ⟨c, coefficient⟩ := prime_power_binomial_divisibility p a j prime positive bound
  apply prepared_power_scalar_annihilation x (p : R) correction h (j - 1)
    (a - j.factorization p) (a + 1) power nilpotent
    (high_binomial_preparation_exponent p a h j orderPositive characteristic high bound)
  refine ⟨(c : R), ?_⟩
  rw [coefficient, Nat.cast_mul, Nat.cast_pow]

/-- The full actual integral cyclic norm reduces to its first h terms
on the actual preparation quotient. This uses the full p-power group
range rather than a finite diagnostic range. -/
theorem prepared_cyclic_norm_truncation (p a h : ℕ) (prime : p.Prime)
    (orderPositive : 0 < h) (characteristic : 2 * h < p) (bound : h ≤ p ^ a)
    (x correction : B) (power : x ^ h = (p : R) • correction)
    (nilpotent : (p : R) ^ (a + 1) = 0) :
    (∑ j ∈ Finset.Icc 1 (p ^ a), (((p ^ a).choose j : ℕ) : R) • x ^ (j - 1)) =
      ∑ j ∈ Finset.Icc 1 h, (((p ^ a).choose j : ℕ) : R) • x ^ (j - 1) := by
  symm
  apply Finset.sum_subset
  · intro j member
    simp only [Finset.mem_Icc] at member ⊢
    omega
  · intro j member outside
    simp only [Finset.mem_Icc] at member outside
    exact prepared_cyclic_norm_high_term p a h j prime orderPositive characteristic
      (by omega) member.2 x correction power nilpotent

end Litt3.Deformations
