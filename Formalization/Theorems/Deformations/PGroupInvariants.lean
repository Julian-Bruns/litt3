import Definitions.Deformations.PGroupInvariants

namespace Litt3.Deformations.Specifications

variable {p : ℕ} [Fact p.Prime] {G V : Type*} [Group G]
    [AddCommGroup V] [Module (ZMod p) V]

def NonzeroPGroupInvariants (ρ : Representation (ZMod p) G V) : Prop :=
  (∃ v : V, v ≠ 0) → ∃ w : V, w ≠ 0 ∧ ∀ g, ρ g w = w

end Litt3.Deformations.Specifications
