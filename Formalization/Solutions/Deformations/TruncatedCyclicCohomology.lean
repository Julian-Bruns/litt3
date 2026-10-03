import Theorems.Deformations.TruncatedCyclicCohomology
import Solutions.Deformations.TruncatedCyclicRepresentations
import Solutions.Deformations.FiniteCyclicCohomologyDimensions

namespace Litt3.Deformations

variable {k : Type} [Field k] (p a j : ℕ) [Fact p.Prime] [CharP k p]
    (bound : j ≤ p ^ a)

theorem truncated_cyclic_invariant_finrank (positive : 0 < j) :
    Module.finrank k (truncatedCyclicBlockRepresentation (k := k) p a j bound).invariants = 1 := by
  rw [← cyclic_difference_kernel_eq_invariants
    (truncatedCyclicBlockRepresentation (k := k) p a j bound) (pPowerCyclicGenerator p a)
    (p_power_cyclic_generator_generates p a)]
  rw [show truncatedCyclicBlockRepresentation (k := k) p a j bound (pPowerCyclicGenerator p a) -
      LinearMap.id = truncatedPowerCoefficientMap k j 1 from
    truncated_cyclic_generator_difference p a j bound]
  exact truncated_power_kernel_finrank j 1 positive

/-- Actual norm rank is one exactly on the full free quotient
block, with all shorter quotient blocks killed by nilpotence. -/
theorem truncated_cyclic_norm_finrank :
    Module.finrank k (LinearMap.range
      (truncatedCyclicBlockRepresentation (k := k) p a j bound).norm) =
      (if j = p ^ a then 1 else 0) := by
  rw [truncated_cyclic_norm_action]
  by_cases full : j = p ^ a
  · subst j
    rw [if_pos rfl]
    have rank := (truncatedPowerCoefficientMap k (p ^ a) (p ^ a - 1)).finrank_range_add_finrank_ker
    rw [truncated_power_kernel_finrank (p ^ a) (p ^ a - 1) (Nat.sub_le _ _),
      truncated_coefficient_finrank] at rank
    have positive := pow_pos (Fact.out : p.Prime).pos a
    omega
  · rw [if_neg full]
    have exponent : j ≤ p ^ a - 1 := by omega
    have zero : truncatedParameter k j ^ (p ^ a - 1) = 0 :=
      pow_eq_zero_of_le exponent (truncated_parameter_pow j)
    have operator : truncatedPowerCoefficientMap k j (p ^ a - 1) = 0 := by
      apply LinearMap.ext
      intro v
      change truncatedParameter k j ^ (p ^ a - 1) * v = 0
      rw [zero, zero_mul]
    rw [operator, LinearMap.range_zero]
    simp

/-- Complete exact invariant, norm and genuine H¹ dimensions of
every positive-length actual cyclic block, including exponent zero. -/
theorem truncated_cyclic_cohomology (positive : 0 < j) :
    Specifications.TruncatedCyclicCohomology (k := k) p a j bound := by
  have invariant := truncated_cyclic_invariant_finrank (k := k) p a j bound positive
  have norm := truncated_cyclic_norm_finrank (k := k) p a j bound
  have cohomology := finite_cyclic_cohomology_dimension
    (truncatedCyclicBlockRepresentation (k := k) p a j bound) (pPowerCyclicGenerator p a)
    (p_power_cyclic_generator_generates p a)
  change Module.finrank k (groupCohomology
      (Rep.of (truncatedCyclicBlockRepresentation (k := k) p a j bound)) 1) +
    Module.finrank k (LinearMap.range
      (truncatedCyclicBlockRepresentation (k := k) p a j bound).norm) =
    Module.finrank k (truncatedCyclicBlockRepresentation (k := k) p a j bound).invariants at cohomology
  rw [invariant, norm] at cohomology
  refine ⟨invariant, norm, ?_⟩
  by_cases full : j = p ^ a <;> simp only [full, ↓reduceIte] at cohomology ⊢ <;> omega

end Litt3.Deformations
