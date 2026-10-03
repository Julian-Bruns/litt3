import Definitions.Deformations.GroupAlgebraInvariants

namespace Litt3.Deformations.Specifications

variable {k G V : Type*} [CommRing k] [Group G] [AddCommGroup V] [Module k V]

def SimplePGroupRepresentationTrivial (ρ : Representation k G V) : Prop :=
  ∀ g x, ρ g x = x

end Litt3.Deformations.Specifications
