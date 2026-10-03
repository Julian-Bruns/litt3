import Theorems.Deformations.ActualCyclicBlockCounts
import Solutions.Deformations.TruncatedCyclicBlockFamilies
import Solutions.Deformations.RepresentationGroupEquivalences

namespace Litt3.Deformations

variable {k V ι : Type} [Field k] [AddCommGroup V] [Module k V] [Fintype ι]

/-- Exact actual cohomology counts transport through the full
actual equivariant block equivalence, with no assumed cohomology model
or presumed match of invariant dimensions. -/
theorem actual_cyclic_block_counts (p a : ℕ) [Fact p.Prime] [CharP k p]
    (ρ : Representation k (Multiplicative (ZMod (p ^ a))) V)
    (length : ι → ℕ) (bound : ∀ i, length i ≤ p ^ a) (positive : ∀ i, 0 < length i)
    (e : V ≃ₗ[k] (∀ i, TruncatedCoefficientRing k (length i)))
    (equivariant : ∀ g v, e (ρ g v) =
      truncatedCyclicBlockFamilyRepresentation p a length bound g (e v)) :
    Specifications.ActualCyclicBlockCounts p a ρ length := by
  let model := truncatedCyclicBlockFamilyRepresentation (k := k) p a length bound
  obtain ⟨dimensions, invariant, norm, cohomology⟩ :=
    truncated_cyclic_block_family_counts (k := k) p a length bound positive
  exact ⟨e.finrank_eq.trans dimensions,
    (representationInvariantEquiv ρ model e equivariant).finrank_eq.trans invariant,
    (representationNormRangeEquiv ρ model e equivariant).finrank_eq.trans norm,
    (representationCohomologyEquiv ρ model e equivariant 1).finrank_eq.trans cohomology⟩

variable {G : Type} [Group G] [Fintype G]

/-- The same genuine counts hold for every actual cyclic deck group
identified through an actual full group isomorphism. The actual group
action and actual full block equivalence are both retained. -/
theorem actual_cyclic_group_block_counts (p a : ℕ) [Fact p.Prime] [CharP k p]
    (groupEquiv : G ≃* Multiplicative (ZMod (p ^ a)))
    (ρ : Representation k G V)
    (length : ι → ℕ) (bound : ∀ i, length i ≤ p ^ a) (positive : ∀ i, 0 < length i)
    (e : V ≃ₗ[k] (∀ i, TruncatedCoefficientRing k (length i)))
    (equivariant : ∀ g v, e (ρ g v) =
      truncatedCyclicBlockFamilyRepresentation p a length bound (groupEquiv g) (e v)) :
    Specifications.ActualCyclicBlockCounts p a ρ length := by
  letI : CommGroup G := {
    __ := inferInstanceAs (Group G)
    mul_comm x y := groupEquiv.injective (by simp only [map_mul, mul_comm]) }
  letI : FiniteDimensional k V := Module.Finite.of_injective e.toLinearMap e.injective
  let model := truncatedCyclicBlockFamilyRepresentation (k := k) p a length bound
  let restricted : Representation k G (∀ i, TruncatedCoefficientRing k (length i)) :=
    model.comp groupEquiv.toMonoidHom
  obtain ⟨dimensions, invariant, norm, cohomology⟩ :=
    truncated_cyclic_block_family_counts (k := k) p a length bound positive
  have invariant_transport : Module.finrank k ρ.invariants = Module.finrank k model.invariants := by
    have h := (representationInvariantEquiv ρ restricted e equivariant).finrank_eq
    change Module.finrank k ρ.invariants =
      Module.finrank k (Representation.invariants (model.comp groupEquiv.toMonoidHom)) at h
    rw [representation_group_equiv_invariants] at h
    exact h
  have norm_transport : Module.finrank k (LinearMap.range ρ.norm) =
      Module.finrank k (LinearMap.range model.norm) := by
    have h := (representationNormRangeEquiv ρ restricted e equivariant).finrank_eq
    change Module.finrank k (LinearMap.range ρ.norm) =
      Module.finrank k (LinearMap.range (Representation.norm (model.comp groupEquiv.toMonoidHom))) at h
    rw [representation_group_equiv_norm] at h
    exact h
  let g := groupEquiv.symm (pPowerCyclicGenerator p a)
  have generated : ∀ x : G, x ∈ Subgroup.zpowers g := by
    intro x
    obtain ⟨n, hn⟩ := p_power_cyclic_generator_generates p a (groupEquiv x)
    refine ⟨n, groupEquiv.injective ?_⟩
    change groupEquiv (groupEquiv.symm (pPowerCyclicGenerator p a) ^ n) = groupEquiv x
    rw [map_zpow, groupEquiv.apply_symm_apply]
    exact hn
  have source_dimension := finite_cyclic_cohomology_dimension ρ g generated
  change Module.finrank k (groupCohomology (Rep.of ρ) 1) +
      Module.finrank k (LinearMap.range ρ.norm) = Module.finrank k ρ.invariants at source_dimension
  have model_dimension := finite_cyclic_cohomology_dimension model (pPowerCyclicGenerator p a)
    (p_power_cyclic_generator_generates p a)
  change Module.finrank k (groupCohomology (Rep.of model) 1) +
      Module.finrank k (LinearMap.range model.norm) = Module.finrank k model.invariants at model_dimension
  rw [norm_transport, invariant_transport] at source_dimension
  have cohomology_transport : Module.finrank k (groupCohomology (Rep.of ρ) 1) =
      Module.finrank k (groupCohomology (Rep.of model) 1) :=
    Nat.add_right_cancel (source_dimension.trans model_dimension.symm)
  exact ⟨e.finrank_eq.trans dimensions, invariant_transport.trans invariant,
    norm_transport.trans norm, cohomology_transport.trans cohomology⟩

end Litt3.Deformations
