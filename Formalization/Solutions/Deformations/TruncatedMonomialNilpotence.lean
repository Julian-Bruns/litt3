import Definitions.Deformations.TruncatedMonomialAlgebra
import Solutions.Deformations.FiniteGeneratorNilpotence

set_option synthInstance.maxHeartbeats 100000
set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable (R I : Type*) [CommRing R]

/-- Each actual original variable satisfies its literal defining power
relation, with no positivity or reducedness hypothesis. -/
theorem truncated_monomial_parameter_pow (q : I → ℕ) (i : I) :
    truncatedMonomialParameter R I q i ^ q i = 0 := by
  rw [truncatedMonomialParameter, ← map_pow, Ideal.Quotient.eq_zero_iff_mem]
  apply Ideal.subset_span
  refine ⟨Finsupp.single i (q i), Set.mem_range_self i, ?_⟩
  exact MvPolynomial.X_pow_eq_monomial.symm

variable [Fintype I]

/-- The actual unequal-power quotient's entire augmentation ideal has
the exact sharp degree cutoff, derived only from its original relations. -/
theorem truncated_monomial_augmentation_cutoff (q : I → ℕ) (positive : ∀ i, 0 < q i) :
    truncatedMonomialAugmentationIdeal R I q ^ ((∑ i, (q i - 1)) + 1) = ⊥ :=
  finite_generator_ideal_nilpotent (truncatedMonomialParameter R I q) q positive
    (truncated_monomial_parameter_pow R I q)

end Litt3.Deformations
