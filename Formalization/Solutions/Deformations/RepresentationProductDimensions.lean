import Solutions.Deformations.RepresentationProducts
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

namespace Litt3.Deformations

universe u

variable {k G ι : Type u} {V : ι → Type u} [Field k] [Group G]
    [Fintype G] [Fintype ι] [∀ i, AddCommGroup (V i)] [∀ i, Module k (V i)]
    [∀ i, FiniteDimensional k (V i)] (ρ : ∀ i, Representation k G (V i))

omit [Fintype G] in
theorem representation_pi_invariant_finrank :
    Module.finrank k (representationPi ρ).invariants =
      ∑ i, Module.finrank k (ρ i).invariants := by
  rw [(representationPiInvariantEquiv ρ).finrank_eq, Module.finrank_pi_fintype]

theorem representation_pi_norm_range_finrank :
    Module.finrank k (LinearMap.range (representationPi ρ).norm) =
      ∑ i, Module.finrank k (LinearMap.range (ρ i).norm) := by
  rw [(representationPiNormRangeEquiv ρ).finrank_eq, Module.finrank_pi_fintype]

end Litt3.Deformations
