import Theorems.Deformations.FiniteCyclicCohomologyDimensions
import Solutions.Deformations.FiniteCyclicCohomology
import Lean.Elab.Tactic.Omega

namespace Litt3.Deformations

universe u

section Generator

variable {k G V : Type u} [CommRing k] [Group G]
    [AddCommGroup V] [Module k V]

/-- The actual invariant submodule of a specified cyclic action is
the actual kernel of its specified generator difference. -/
theorem cyclic_difference_kernel_eq_invariants (ρ : Representation k G V) (g : G)
    (generated : ∀ x : G, x ∈ Subgroup.zpowers g) :
    LinearMap.ker (ρ g - LinearMap.id) = ρ.invariants := by
  ext v
  rw [LinearMap.mem_ker, LinearMap.sub_apply, LinearMap.id_apply, sub_eq_zero]
  exact (Representation.mem_invariants_iff_of_forall_mem_zpowers ρ g generated v).symm

end Generator

section Dimension

variable {k G V : Type u} [Field k] [CommGroup G] [Fintype G]
    [AddCommGroup V] [Module k V] [FiniteDimensional k V]

/-- Exact rank-nullity for the genuine periodic-cohomology quotient
gives the complete actual H¹ dimension. No characteristic, perfectness,
block decomposition or numerical table is assumed. -/
theorem finite_cyclic_cohomology_dimension (ρ : Representation k G V) (g : G)
    (generated : ∀ x : G, x ∈ Subgroup.zpowers g) :
    Specifications.FiniteCyclicCohomologyDimension ρ := by
  let e := finiteCyclicOneCohomologyEquiv (Rep.of ρ) g generated
  have quotient := (LinearMap.range (cyclicDifferenceToNormKernel ρ g)).finrank_quotient_add_finrank
  change Module.finrank k (CyclicOneCohomologyQuotient ρ g) +
    Module.finrank k (LinearMap.range (cyclicDifferenceToNormKernel ρ g)) =
      Module.finrank k (LinearMap.ker ρ.norm) at quotient
  have identified : Module.finrank k (groupCohomology (Rep.of ρ) 1) =
      Module.finrank k (CyclicOneCohomologyQuotient ρ g) := e.finrank_eq
  rw [← identified] at quotient
  have difference := (cyclicDifferenceToNormKernel ρ g).finrank_range_add_finrank_ker
  have kernel : LinearMap.ker (cyclicDifferenceToNormKernel ρ g) = ρ.invariants := by
    rw [cyclicDifferenceToNormKernel, LinearMap.ker_codRestrict]
    exact cyclic_difference_kernel_eq_invariants ρ g generated
  rw [kernel] at difference
  have norm := ρ.norm.finrank_range_add_finrank_ker
  unfold Specifications.FiniteCyclicCohomologyDimension
  omega

end Dimension

end Litt3.Deformations
