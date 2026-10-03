import Theorems.Deformations.TruncatedCyclicBlockFamilies

namespace Litt3.Deformations.Specifications

variable {k G V ι : Type} [Field k] [Group G] [Fintype G]
    [AddCommGroup V] [Module k V] [Fintype ι]

/-- Exact actual dimension, full invariant dimension, actual norm
rank and genuine H¹ dimension of an actual cyclic representation with
the specified full quotient-block decomposition. -/
def ActualCyclicBlockCounts (p a : ℕ) [Fact p.Prime] [CharP k p]
    (ρ : Representation k G V) (length : ι → ℕ) : Prop :=
  Module.finrank k V = ∑ i, length i ∧
    Module.finrank k ρ.invariants = Fintype.card ι ∧
    Module.finrank k (LinearMap.range ρ.norm) =
      (Finset.univ.filter fun i => length i = p ^ a).card ∧
    Module.finrank k (groupCohomology (Rep.of ρ) 1) =
      (Finset.univ.filter fun i => length i < p ^ a).card

end Litt3.Deformations.Specifications
