import Theorems.Deformations.CyclicCokernelBlockCounts
import Solutions.Deformations.InvariantCokernelRank
import Solutions.Deformations.InvariantKernelPullback
import Solutions.Deformations.ActualCyclicBlockCounts

namespace Litt3.Deformations.InvariantDescentSquare

variable {k G L U DL DU ι : Type} [Field k] [Group G] [Fintype G] [Fintype ι]
    [AddCommGroup L] [Module k L] [AddCommGroup U] [Module k U]
    [AddCommGroup DL] [Module k DL] [AddCommGroup DU] [Module k DU]
    (square : InvariantDescentSquare k G L U DL DU)

/-- An actual cyclic kernel block decomposition determines the
full genuine H¹ obstruction dimension and the actual cokernel pullback
rank. All actual maps, full actions and source invariants are retained. -/
theorem cyclic_cokernel_block_counts (p a : ℕ) [Fact p.Prime] [CharP k p]
    [FiniteDimensional k DL] [FiniteDimensional k DU]
    (dimensions : Module.finrank k DL = Module.finrank k DU)
    (sourceInjective : Function.Injective square.sourcePullback)
    (primitives : RepresentationCocyclePrimitives square.sourceAction)
    (groupEquiv : G ≃* Multiplicative (ZMod (p ^ a)))
    (length : ι → ℕ) (bound : ∀ i, length i ≤ p ^ a) (positive : ∀ i, 0 < length i)
    (e : LinearMap.ker square.upperMap ≃ₗ[k] (∀ i, TruncatedCoefficientRing k (length i)))
    (equivariant : ∀ g v, e (square.kernelAction g v) =
      truncatedCyclicBlockFamilyRepresentation p a length bound (groupEquiv g) (e v)) :
    Specifications.CyclicCokernelBlockCounts square p a length := by
  obtain ⟨kernel_dimension, invariant, norm, cohomology⟩ :=
    actual_cyclic_group_block_counts p a groupEquiv square.kernelAction
      length bound positive e equivariant
  have lower_dimension : Module.finrank k (LinearMap.ker square.lowerMap) = Fintype.card ι :=
    (square.kernel_invariant_finrank_eq sourceInjective).symm.trans invariant
  have rank := square.invariant_cokernel_rank dimensions primitives
  change Module.finrank k (LinearMap.range square.cokernelPullback) +
      Module.finrank k (groupCohomology (Rep.of square.kernelAction) 1) =
    Module.finrank k (LinearMap.ker square.lowerMap) at rank
  rw [cohomology, lower_dimension] at rank
  have partition : (Finset.univ.filter fun i => length i = p ^ a).card +
      (Finset.univ.filter fun i => length i < p ^ a).card = Fintype.card ι := by
    have h : (∑ i, ((if length i = p ^ a then 1 else 0) +
        (if length i < p ^ a then 1 else 0))) = ∑ _i : ι, (1 : ℕ) := by
      apply Finset.sum_congr rfl
      intro i _
      by_cases full : length i = p ^ a
      · simp only [full, ↓reduceIte, Nat.lt_irrefl, add_zero]
      · have short : length i < p ^ a := lt_of_le_of_ne (bound i) full
        simp only [full, short, ↓reduceIte, zero_add]
    simpa [Finset.sum_add_distrib] using h
  refine ⟨lower_dimension, kernel_dimension, cohomology, ?_⟩
  omega

end Litt3.Deformations.InvariantDescentSquare
