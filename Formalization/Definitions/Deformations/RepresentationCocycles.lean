import Definitions.Deformations.RegularFunctionRepresentation
import Mathlib.RepresentationTheory.Homological.GroupCohomology.LowDegree

namespace Litt3.Deformations

variable {k G V : Type*} [CommRing k] [Group G] [AddCommGroup V] [Module k V]

/-- The actual degree-one cocycle-primitive property, retaining every
group element and actual representation action. -/
def RepresentationCocyclePrimitives (ρ : Representation k G V) : Prop :=
  ∀ c : G → V, (∀ g h, c (g * h) = ρ g (c h) + c g) →
    ∃ v : V, ∀ g, ρ g v - v = c g

end Litt3.Deformations
