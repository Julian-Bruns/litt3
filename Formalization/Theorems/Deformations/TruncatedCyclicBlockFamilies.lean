import Definitions.Deformations.TruncatedCyclicBlockFamilies
import Definitions.Deformations.RepresentationCocycles

namespace Litt3.Deformations.Specifications

variable {k ι : Type} [Field k] [Fintype ι]

/-- Exact actual module dimensions, invariant dimensions, full norm
rank and genuine H¹ dimensions of a specified finite cyclic block family. -/
def TruncatedCyclicBlockFamilyCounts (p a : ℕ) [Fact p.Prime] [CharP k p]
    (length : ι → ℕ) (bound : ∀ i, length i ≤ p ^ a) : Prop :=
  let ρ := truncatedCyclicBlockFamilyRepresentation (k := k) p a length bound
  Module.finrank k (∀ i, TruncatedCoefficientRing k (length i)) = ∑ i, length i ∧
    Module.finrank k ρ.invariants = Fintype.card ι ∧
    Module.finrank k (LinearMap.range ρ.norm) =
      (Finset.univ.filter fun i => length i = p ^ a).card ∧
    Module.finrank k (groupCohomology (Rep.of ρ) 1) =
      (Finset.univ.filter fun i => length i < p ^ a).card

end Litt3.Deformations.Specifications
