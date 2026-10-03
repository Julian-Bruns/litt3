import Theorems.Deformations.TruncatedCyclicBlockFamilies
import Solutions.Deformations.TruncatedCyclicCohomology
import Solutions.Deformations.FiniteProductCyclicCohomology
import Solutions.Deformations.RepresentationCohomologyEquivalences

namespace Litt3.Deformations

variable {k ι : Type} [Field k] [Fintype ι]

/-- The exact count of short blocks is the dimension of genuine H¹,
and the exact count of full blocks is the actual norm rank. Every
component action and its cohomology are the actual quotient-block ones. -/
theorem truncated_cyclic_block_family_counts (p a : ℕ) [Fact p.Prime] [CharP k p]
    (length : ι → ℕ) (bound : ∀ i, length i ≤ p ^ a) (positive : ∀ i, 0 < length i) :
    Specifications.TruncatedCyclicBlockFamilyCounts (k := k) p a length bound := by
  let ρ := fun i => truncatedCyclicBlockRepresentation (k := k) p a (length i) (bound i)
  have invariant : Module.finrank k (representationPi ρ).invariants = Fintype.card ι := by
    rw [representation_pi_invariant_finrank]
    simp only [ρ, truncated_cyclic_invariant_finrank p a _ _ (positive _)]
    simp
  have norm : Module.finrank k (LinearMap.range (representationPi ρ).norm) =
      (Finset.univ.filter fun i => length i = p ^ a).card := by
    rw [representation_pi_norm_range_finrank]
    simp only [ρ, truncated_cyclic_norm_finrank]
    simp
  have cohomology : Module.finrank k (groupCohomology (Rep.of (representationPi ρ)) 1) =
      (Finset.univ.filter fun i => length i < p ^ a).card := by
    have split := finite_product_cyclic_cohomology_dimension ρ (pPowerCyclicGenerator p a)
      (p_power_cyclic_generator_generates p a)
    change Module.finrank k (groupCohomology (Rep.of (representationPi ρ)) 1) =
      ∑ i, Module.finrank k (groupCohomology (Rep.of (ρ i)) 1) at split
    rw [split]
    calc
      (∑ i, Module.finrank k (groupCohomology (Rep.of (ρ i)) 1)) =
          ∑ i, if length i < p ^ a then 1 else 0 := by
        apply Finset.sum_congr rfl
        intro i _
        have h := (truncated_cyclic_cohomology (k := k) p a (length i) (bound i) (positive i)).2.2
        change Module.finrank k (groupCohomology (Rep.of (ρ i)) 1) = _ at h
        rw [h]
        by_cases full : length i = p ^ a
        · simp only [full, ↓reduceIte, Nat.lt_irrefl]
        · have short : length i < p ^ a := lt_of_le_of_ne (bound i) full
          simp only [full, short, ↓reduceIte]
      _ = _ := by simp
  refine ⟨?_, invariant, norm, cohomology⟩
  rw [Module.finrank_pi_fintype]
  exact Finset.sum_congr rfl (fun i _ => truncated_coefficient_finrank (length i))

end Litt3.Deformations
