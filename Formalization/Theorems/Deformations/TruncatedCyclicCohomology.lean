import Definitions.Deformations.TruncatedCyclicRepresentations
import Definitions.Deformations.RepresentationCocycles

namespace Litt3.Deformations.Specifications

variable {k : Type} [Field k]

/-- Every positive-length actual cyclic quotient block has one
invariant dimension. Its norm image and genuine H¹ distinguish exactly
the full-length free block from every shorter block. -/
def TruncatedCyclicCohomology (p a j : ℕ) [Fact p.Prime] [CharP k p]
    (bound : j ≤ p ^ a) : Prop :=
  let ρ := truncatedCyclicBlockRepresentation (k := k) p a j bound
  Module.finrank k ρ.invariants = 1 ∧
    Module.finrank k (LinearMap.range ρ.norm) = (if j = p ^ a then 1 else 0) ∧
    Module.finrank k (groupCohomology (Rep.of ρ) 1) = (if j = p ^ a then 0 else 1)

end Litt3.Deformations.Specifications
