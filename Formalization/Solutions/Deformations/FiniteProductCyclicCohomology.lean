import Theorems.Deformations.FiniteProductCyclicCohomology
import Solutions.Deformations.RepresentationProductDimensions
import Solutions.Deformations.FiniteCyclicCohomologyDimensions

namespace Litt3.Deformations

universe u

variable {k G ι : Type u} {V : ι → Type u} [Field k] [CommGroup G]
    [Fintype G] [Fintype ι] [∀ i, AddCommGroup (V i)] [∀ i, Module k (V i)]
    [∀ i, FiniteDimensional k (V i)]

/-- Genuine cyclic H¹ has the exact sum of component dimensions
on every finite product of actual finite-dimensional representations. -/
theorem finite_product_cyclic_cohomology_dimension
    (ρ : ∀ i, Representation k G (V i)) (g : G)
    (generated : ∀ x : G, x ∈ Subgroup.zpowers g) :
    Specifications.FiniteProductCyclicCohomologyDimension ρ := by
  have total := finite_cyclic_cohomology_dimension (representationPi ρ) g generated
  change Module.finrank k (groupCohomology (Rep.of (representationPi ρ)) 1) +
      Module.finrank k (LinearMap.range (representationPi ρ).norm) =
    Module.finrank k (representationPi ρ).invariants at total
  rw [representation_pi_norm_range_finrank, representation_pi_invariant_finrank] at total
  have sum_identity :
      (∑ i, Module.finrank k (groupCohomology (Rep.of (ρ i)) 1)) +
        (∑ i, Module.finrank k (LinearMap.range (ρ i).norm)) =
      ∑ i, Module.finrank k (ρ i).invariants := by
    rw [← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro i _
    exact finite_cyclic_cohomology_dimension (ρ i) g generated
  exact Nat.add_right_cancel (total.trans sum_identity.symm)

end Litt3.Deformations
