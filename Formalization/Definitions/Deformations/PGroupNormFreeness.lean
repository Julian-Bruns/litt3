import Definitions.Deformations.InvariantOrbitEmbedding
import Mathlib.RepresentationTheory.Basic

namespace Litt3.Deformations

variable {k G V : Type*} [CommRing k] [Group G] [Fintype G]
    [AddCommGroup V] [Module k V]

def RepresentationNormCoversInvariants (ρ : Representation k G V) : Prop :=
  ∀ v, v ∈ ρ.invariants → ∃ w, ρ.norm w = v

end Litt3.Deformations

namespace Litt3.Deformations.Specifications

open scoped MonoidAlgebra

variable {k G V : Type*} [Field k] [Group G] [Fintype G]
    [AddCommGroup V] [Module k V]

def PGroupNormFreeness (ρ : Representation k G V) : Prop :=
  Module.Free k[G] ρ.asModule ↔ RepresentationNormCoversInvariants ρ

end Litt3.Deformations.Specifications
