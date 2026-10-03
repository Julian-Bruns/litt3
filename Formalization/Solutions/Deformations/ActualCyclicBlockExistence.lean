import Theorems.Deformations.ActualCyclicBlockExistence
import Solutions.Deformations.NilpotentPositiveBlocks
import Solutions.Deformations.CyclicAugmentationNilpotence
import Solutions.Deformations.CyclicGeneratorIntertwining
import Solutions.Deformations.ActualCyclicBlockCounts

namespace Litt3.Deformations

variable {k G V : Type} [Field k] [Group G] [Fintype G]
    [AddCommGroup V] [Module k V] [FiniteDimensional k V]

/-- Every actual finite-dimensional representation of every actual
cyclic p-power group over every characteristic-p field admits its
full equivariant positive quotient-block decomposition. All exact
cohomology counts follow without a decomposition hypothesis. -/
theorem actual_cyclic_block_existence (p a : ℕ) [Fact p.Prime] [CharP k p]
    (groupEquiv : G ≃* Multiplicative (ZMod (p ^ a)))
    (ρ : Representation k G V) :
    Specifications.ActualCyclicBlockExistence p a groupEquiv ρ := by
  let g := groupEquiv.symm (pPowerCyclicGenerator p a)
  have generated : ∀ x : G, x ∈ Subgroup.zpowers g := by
    intro x
    obtain ⟨n, hn⟩ := p_power_cyclic_generator_generates p a (groupEquiv x)
    refine ⟨n, groupEquiv.injective ?_⟩
    change groupEquiv (groupEquiv.symm (pPowerCyclicGenerator p a) ^ n) = groupEquiv x
    rw [map_zpow, groupEquiv.apply_symm_apply]
    exact hn
  have order : orderOf g = p ^ a := by
    rw [← groupEquiv.orderOf_eq g]
    change orderOf (groupEquiv (groupEquiv.symm (pPowerCyclicGenerator p a))) = p ^ a
    rw [groupEquiv.apply_symm_apply]
    exact p_power_cyclic_generator_order p a
  obtain ⟨d, length, positive, bound, e, operator⟩ :=
    nilpotent_positive_blocks (ρ g - 1) (p ^ a)
      (cyclic_augmentation_nilpotence p a ρ g order)
  let model := truncatedCyclicBlockFamilyRepresentation (k := k) p a length bound
  let restricted : Representation k G (∀ i, TruncatedCoefficientRing k (length i)) :=
    model.comp groupEquiv.toMonoidHom
  have generator : ∀ v, e (ρ g v) = restricted g (e v) := by
    intro v
    funext i
    have h := operator v i
    change e (ρ g v - v) i = truncatedParameter k (length i) * e v i at h
    rw [map_sub, Pi.sub_apply] at h
    change e (ρ g v) i = model (groupEquiv g) (e v) i
    have gimage : groupEquiv g = pPowerCyclicGenerator p a := groupEquiv.apply_symm_apply _
    rw [gimage]
    change e (ρ g v) i = truncatedCyclicBlockRepresentation p a (length i) (bound i)
      (pPowerCyclicGenerator p a) (e v i)
    rw [truncated_cyclic_generator_action, add_mul, one_mul]
    exact (sub_eq_iff_eq_add.mp h).trans (add_comm _ _)
  have equivariant : ∀ x v, e (ρ x v) = model (groupEquiv x) (e v) :=
    cyclic_generator_intertwining ρ restricted e.toLinearMap g generated generator
  exact ⟨d, length, bound, positive, e, equivariant,
    actual_cyclic_group_block_counts p a groupEquiv ρ length bound positive e equivariant⟩

end Litt3.Deformations
