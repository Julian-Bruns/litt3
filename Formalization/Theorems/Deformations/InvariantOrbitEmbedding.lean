import Definitions.Deformations.InvariantOrbitEmbedding

namespace Litt3.Deformations.Specifications

variable {k G V : Type*} [Field k] [Group G] [AddCommGroup V] [Module k V]

def PGroupRepresentationGrowth (ρ : Representation k G V) : Prop :=
  Module.finrank k ρ.invariants ≤ Module.finrank k V ∧
    Module.finrank k V ≤ Nat.card G * Module.finrank k ρ.invariants

end Litt3.Deformations.Specifications
