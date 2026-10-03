import Solutions.Deformations.CyclicNormPower

namespace Litt3.Deformations

open Polynomial

variable {k G V : Type*} [CommRing k] [Group G]
    [AddCommGroup V] [Module k V]

/-- The actual cyclic augmentation operator is globally nilpotent
to the full group exponent. Polynomial evaluation proves the identity
even when the coefficient endomorphism ring is noncommutative or zero. -/
theorem cyclic_augmentation_nilpotence (p a : ℕ) [Fact p.Prime] [CharP k p]
    (ρ : Representation k G V) (g : G) (order : orderOf g = p ^ a) :
    (ρ g - 1) ^ (p ^ a) = 0 := by
  have identity : ((X : k[X]) - 1) ^ (p ^ a) = X ^ (p ^ a) - 1 := by
    rw [sub_pow_char_pow, one_pow]
  have evaluated := congrArg (Polynomial.aeval (ρ g)) identity
  simp only [map_pow, map_sub, map_one, Polynomial.aeval_X] at evaluated
  rw [← order, ← map_pow, pow_orderOf_eq_one, map_one, sub_self] at evaluated
  simpa only [order] using evaluated

end Litt3.Deformations
