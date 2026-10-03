import Definitions.Deformations.InvariantOrbitEmbedding
import Definitions.Deformations.RepresentationCocycles

namespace Litt3.Deformations.Specifications

open scoped MonoidAlgebra

universe u

variable {k G V : Type u} [Field k] [Group G] [AddCommGroup V] [Module k V]

def PGroupCohomologyFreeness (ρ : Representation k G V) : Prop :=
  Module.Free k[G] ρ.asModule ↔ ∀ x : groupCohomology (Rep.of ρ) 1, x = 0

def PGroupMaximalGrowthFreeness (ρ : Representation k G V) : Prop :=
  Module.finrank k V = Nat.card G * Module.finrank k ρ.invariants ↔
    Module.Free k[G] ρ.asModule

end Litt3.Deformations.Specifications
