import Solutions.Deformations.ElementaryPrimeMixedRelation
import Solutions.Deformations.GroupNormalFiltration

namespace Litt3.Deformations

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- Multiplication preserves the literal original mixed weight at
every prime, rather than relying on a five-specific expansion. -/
theorem elementary_prime_normal_weight_mul (p : ℕ) (prime : p.Prime)
    (r d e : ℕ) (x y : AddMonoidAlgebra R (Fin r → ZMod p))
    (memberX : x ∈ elementaryNormalWeightFiltration R p prime.pos r d)
    (memberY : y ∈ elementaryNormalWeightFiltration R p prime.pos r e) :
    x * y ∈ elementaryNormalWeightFiltration R p prime.pos r (d + e) := by
  rw [elementary_prime_normal_weights_eq p prime] at memberX memberY ⊢
  exact weighted_generator_filtration_multiplicative _ (p - 1) _ d e x y memberX memberY

/-- The finite original normal basis and actual coefficient nilpotence
give the exact upper weight at every prime and Witt precision. -/
theorem elementary_prime_normal_weight_cutoff (p : ℕ) (prime : p.Prime)
    (r N : ℕ) (positive : 0 < N) (nilpotent : (p : R) ^ N = 0)
    (d : ℕ) (high : (p - 1) * (N - 1) + (p - 1) * r < d) :
    elementaryNormalWeightFiltration R p prime.pos r d = ⊥ := by
  rw [elementary_normal_weights_eq]
  have mapped := congrArg (algebraMap R (AddMonoidAlgebra R (Fin r → ZMod p))) nilpotent
  have vanish : (p : AddMonoidAlgebra R (Fin r → ZMod p)) ^ N = 0 := by
    simpa only [map_pow, map_natCast, map_zero] using mapped
  apply normal_generator_filtration_cutoff p N prime.pos positive _ vanish _ d
  simpa using high

end Litt3.Deformations
